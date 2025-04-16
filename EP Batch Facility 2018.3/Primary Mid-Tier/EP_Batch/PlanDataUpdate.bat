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
REM #     Executes EKBF Commands to load fact data into Granite for a single User
REM #     Plan FTF and then purges the contents of the staging table.
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

CD %~dp0

IF "%1" == "" (
   ECHO Usage: [FTF] [retain/truncate]

   EXIT /B 1
)

CALL GlobalVariables.bat

SET DATASTAGED=N
SET RETAIN=N

IF "%2" == "retain" (
   SET RETAIN=Y
)

FOR /f %%i IN ('GETINPUTSOURCENAME %FOUNDATIONUSER% %DATASOURCE% %1') DO SET INPUTSOURCE=%%i

RowCount %FOUNDATIONUSER% %DATASOURCE% %INPUTSOURCE%

IF ERRORLEVEL 1 (
   SET DATASTAGED=Y
)

FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatupd %1

IF %ERRORLEVEL% EQU 9000 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatupd / %1 dropindexgranite=y

   IF NOT ERRORLEVEL 1 (
      RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR

      IF NOT ERRORLEVEL 1 (
         IF "%RETAIN%" == "N" (
            pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s
         )
      ) ELSE (
        SET ERRORLEVEL=9999
      )
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9001 (
   pkbfdatupd / %1 dropindexgranite=y restart=y

   IF NOT ERRORLEVEL 1 (
      RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR

      IF NOT ERRORLEVEL 1 (
         IF "%RETAIN%" == "N" (
            pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s
         )
      ) ELSE (
        SET ERRORLEVEL=9999
      )
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9003 (
   FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatrm %1 stagingtables

   IF ERRORLEVEL 9001 (
      IF ERRORLEVEL 9003 (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s restart=s
      )
      IF ERRORLEVEL 9004 (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s restart=s
      )
   )

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9004 (
   FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfdatrm %1 stagingtables

   IF ERRORLEVEL 9001 (
      IF ERRORLEVEL 9003 (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s restart=s
      )
      IF ERRORLEVEL 9004 (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s restart=s
      )
   )

   GOTO :EXIT
)
IF %ERRORLEVEL% EQU 9005 (
   IF "%DATASTAGED%" == "N" (
      (CALL )

      GOTO :EXIT
   )

   pkbfdatupd / %1 dropindexgranite=y

   RowCount %FOUNDATIONUSER% %DATASOURCE% PF_DU_%1_ERR

   IF NOT ERRORLEVEL 1 (
      IF "%RETAIN%" == "N" (
         pkbfdatrm / type=inputsources ftf=%1 analyze=n empty=s
      )
   ) ELSE (
     SET ERRORLEVEL=9999
   )
)

:EXIT

EXIT /B %ERRORLEVEL%