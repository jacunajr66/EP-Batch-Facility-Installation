@ECHO OFF

REM # 
REM #  Created by John Acuna Version 2022.1.0.0 on 9/14/2022
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Executes EKBF Commands to load fact data into Granite for a single Actuals 
REM #     FTF and then purges the contents of the staging table.
REM # ==============================================================================
REM #
REM # FoundationRestartStatus ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM # NO_RESTART_PENDING = 9000
REM # RESTART_PENDING = 9001
REM # PROCESS_RUNNING = 9002
REM # RESTART_PENDING_FOR_OTHER_TYPE = 9003
REM # RESTART_PENDING_FOR_BLOCKING_COMMAND = 9004
REM # RESTART_PENDING_FOR_OTHER_FACT_TABLE = 9005
REM # BLOCKING_COMMAND_RUNNING = 9006
REM # ==============================================================================
REM #
REM # RowCount ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM # ==============================================================================
REM #
REM # SCRIPT ERROR CODES
REM #
REM # FACT_DATA_INVALID = 9999
REM # ==============================================================================

IF "%1" == "" (
   ECHO Usage: [FTF] [trusted/untrusted] [retain/truncate]

   EXIT /B 1
)

CALL %~dp0GlobalVariables.bat

SET DATASTAGED=N
SET UNTRUSTED=Y
SET RETAIN=N

IF "%2" == "trusted" (
   SET UNTRUSTED=N
)

IF "%2" == "retain" (
   SET RETAIN=Y
)

IF "%3" == "retain" (
   SET RETAIN=Y
)

FOR /f %%i IN ('%~dp0GETINPUTSOURCENAME %FOUNDATIONUSER% %DATASOURCE% %1') DO SET INPUTSOURCE=%%i

%~dp0RowCount %FOUNDATIONUSER% %DATASOURCE% %INPUTSOURCE%

IF ERRORLEVEL 1 (
   SET DATASTAGED=Y
)

SET BULKLOAD=N
SET EMPTY=N
SET PURGEDATA=N

FOR %%i IN (%FORCEEMPTY%) DO (
   IF "%1" == "%%i" (
      SET EMPTY=Y
   )
)

FOR %%i IN (%FULLSTATEMENT%) DO (
   IF "%1" == "%%i" (
      SET PURGEDATA=Y
   )
)

IF "%PURGEDATA%" == "Y" (
   SET BULKLOAD=Y
)

IF "%PURGEDATA%" == "N" (
   GOTO :CONTINUE
)

%~dp0FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatrm %1 facttables

IF %ERRORLEVEL% EQU 9000 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatrm / type=facttables ftf=%1 analyze=n empty=%EMPTY%

   IF ERRORLEVEL 1 (
      GOTO :EXIT
   )

   GOTO :CONTINUE
)

IF %ERRORLEVEL% EQU 9001 (
   pkbfdatrm / type=facttables ftf=%1 analyze=n empty=%EMPTY% restart=s

   IF ERRORLEVEL 1 (
      GOTO :EXIT
   )

   GOTO :CONTINUE
)

IF %ERRORLEVEL% EQU 9002 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9003 (
   pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY% restart=s

   IF ERRORLEVEL 1 (
      GOTO :EXIT
   )

   GOTO :CONTINUE
)

IF %ERRORLEVEL% EQU 9004 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9005 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9006 (
   GOTO :EXIT
)

:CONTINUE

%~dp0FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatupd %1

IF %ERRORLEVEL% EQU 9000 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatupd / %1 continueiferrors=%UNTRUSTED% bulkloadgranite=%BULKLOAD% dropindexgranite=y

   IF NOT ERRORLEVEL 1 (
      %~dp0RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR %ALLOWED_ERROR_CODES%

      IF NOT ERRORLEVEL 1 (
         IF "%RETAIN%" == "N" (
            pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY%
         )
      ) ELSE (
         SET ERRORLEVEL=9999
      )
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9001 (
   pkbfdatupd / %1 continueiferrors=%UNTRUSTED% bulkloadgranite=%BULKLOAD% dropindexgranite=y restart=y

   IF NOT ERRORLEVEL 1 (
      %~dp0RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR %ALLOWED_ERROR_CODES%

      IF NOT ERRORLEVEL 1 (
         IF "%RETAIN%" == "N" (
            pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY%
         )
      ) ELSE (
        SET ERRORLEVEL=9999
      )
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9002 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9003 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9004 (
   %~dp0FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatrm %1 inputsources

   IF ERRORLEVEL 9002 (
      (CALL )

      GOTO :EXIT
   )

   IF ERRORLEVEL 9001 (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY% restart=s
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9005 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatupd / %1 continueiferrors=%UNTRUSTED% bulkloadgranite=%BULKLOAD% dropindexgranite=y

   %~dp0RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR %ALLOWED_ERROR_CODES%

   IF NOT ERRORLEVEL 1 (
      IF "%RETAIN%" == "N" (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY%
      )
   ) ELSE (
     SET ERRORLEVEL=9999
   )
)

:EXIT

EXIT /B %ERRORLEVEL%