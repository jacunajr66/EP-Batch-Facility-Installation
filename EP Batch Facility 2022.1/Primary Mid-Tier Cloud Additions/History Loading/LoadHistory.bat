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
REM #     Performs an unattended fact history load when used in conjunction with the
REM #     Cloud SFTP Add-On.
REM # ==============================================================================

CD %~dp0

IF "%1" == "" (
   ECHO Usage: [cleanse/nocleanse]

   EXIT /B 1
)

CALL GlobalVariables.bat

SET CLEANSE=N
SET DATAPROCESSED=N
SET NUMCON=2

IF "%1" == "cleanse" (
   SET CLEANSE=Y
)

SET i=0

MOVE %FACTHISTORYPATH%\*.zip %INBOXPATH%

SETLOCAL ENABLEDELAYEDEXPANSION

FOR %%F IN (%FACTHISTORYPATH%\*_FACT.CON) DO (
   SET /a i=!i!+1

   MOVE %%F %INBOXPATH%

   CALL StageFacts.bat

   IF !ERRORLEVEL! NEQ 0 (
      GOTO :EXIT
   )

   if %CLEANSE% == Y (
      RunSQL %FOUNDATIONUSER% %DATASOURCE% CleanseActuals.sql

      IF !ERRORLEVEL! NEQ 9000 (
         GOTO :EXIT
      )
   )
 
   RunSQL %FOUNDATIONUSER% %DATASOURCE% ResetHighWaterMark.sql

   CALL FoundationActualsDataUpdate.bat

   IF !ERRORLEVEL! NEQ 0 (
      GOTO :EXIT
   )

   IF !i! == %NUMCON% (
      CALL ActualsCubeSync.bat
      
      IF !ERRORLEVEL! NEQ 0 (
         GOTO :EXIT
      )

      SET i=0
   )

   SET DATAPROCESSED=Y
)

IF %DATAPROCESSED%==Y (
   CALL FoundationSetTime.bat latest

   IF %ERRORLEVEL% NEQ 0 (
      GOTO :EXIT
   )

   CALL QuartzCubeSync.bat

   IF %ERRORLEVEL% NEQ 0 (
      GOTO :EXIT
   )

   ECHO HISTORY LOAD HAS SUCCEEDED
) ELSE (
   ECHO NO HISTORY FILES FOUND TO LOAD
)

EXIT /B 0

:EXIT

ECHO HISTORY LOAD HAS FAILED

EXIT /B %ERRORLEVEL%