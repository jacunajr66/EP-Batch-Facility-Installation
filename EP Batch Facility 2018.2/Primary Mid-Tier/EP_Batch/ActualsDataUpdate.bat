@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 1/19/2013
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
   ECHO Usage: [FTF] [trusted/untrusted]

   EXIT /B 1
)

CALL GlobalVariables.bat

SET DATASTAGED=N
SET UNTRUSTED=Y

IF "%2" == "trusted" (
   SET UNTRUSTED=N
)

FOR /f %%i IN ('GETINPUTSOURCENAME %FOUNDATIONUSER% %DATASOURCE% %1') DO SET INPUTSOURCE=%%i

RowCount %FOUNDATIONUSER% %DATASOURCE% %INPUTSOURCE%

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

FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatrm %1 facttables

IF %ERRORLEVEL% EQU 9000 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatrm / type=facttables ftf=%1 analyze=n empty=%EMPTY%
)

IF %ERRORLEVEL% EQU 9001 (
   pkbfdatrm / type=facttables ftf=%1 analyze=n empty=%EMPTY% restart=s
)

IF %ERRORLEVEL% EQU 9003 (
   pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY% restart=s
)

IF %ERRORLEVEL% EQU 9004 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9006 (
   GOTO :EXIT
)

IF NOT %ERRORLEVEL% EQU 0 (
   GOTO :EXIT
)

:CONTINUE

FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatupd %1

IF %ERRORLEVEL% EQU 9000 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatupd / %1 continueiferrors=%UNTRUSTED% bulkloadgranite=%BULKLOAD% dropindexgranite=y

   RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR %ALLOWED_ERROR_CODES%

   IF NOT ERRORLEVEL 1 (
      pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY%
   ) ELSE (
      SET ERRORLEVEL=9999
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9001 (
   pkbfdatupd / %1 continueiferrors=%UNTRUSTED% bulkloadgranite=%BULKLOAD% dropindexgranite=y restart=y

   RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR %ALLOWED_ERROR_CODES%

   IF NOT ERRORLEVEL 1 (
      pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY%
   ) ELSE (
     SET ERRORLEVEL=9999
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9004 (
   FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatrm %1 inputsources

   IF ERRORLEVEL 9001 (
      IF NOT ERRORLEVEL 9002 (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY% restart=s
      )
   )

   GOTO :EXIT
)


IF %ERRORLEVEL% EQU 9005 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatupd / %1 continueiferrors=%UNTRUSTED% bulkloadgranite=%BULKLOAD% dropindexgranite=y

   RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR %ALLOWED_ERROR_CODES%

   IF NOT ERRORLEVEL 1 (
      pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=%EMPTY%
   ) ELSE (
     SET ERRORLEVEL=9999
   )
)

:EXIT

EXIT /B %ERRORLEVEL%