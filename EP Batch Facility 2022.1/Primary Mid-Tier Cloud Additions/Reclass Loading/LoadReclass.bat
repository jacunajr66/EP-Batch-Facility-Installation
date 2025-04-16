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
REM #     Performs an unattended reclass load when used in conjunction with the
REM #     Cloud SFTP Add-On.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

SET DATAPROCESSED=N
SET NUMCON=1
SET i=0

MOVE %RECLASSPATH%\*.zip %INBOXPATH%

SETLOCAL ENABLEDELAYEDEXPANSION

FOR %%F IN (%RECLASSPATH%\*_STRUCTURE.CON) DO (
   SET /a i=!i!+1

   MOVE %%F %INBOXPATH%

   CALL %~dp0StageStructure.bat

   IF !ERRORLEVEL! NEQ 0 (
      GOTO :EXIT
   )

   CALL %~dp0JIMemberDataLoad.bat

   IF !ERRORLEVEL! NEQ 0 (
      GOTO :EXIT
   )

   IF !i! == %NUMCON% (      
      CALL %~dp0FoundationStructureUpdate.bat
      CALL %~dp0QuartzCubeSync.bat
      CALL %~dp0GatherSchemaStats.bat

      IF !ERRORLEVEL! NEQ 0 (
         GOTO :EXIT
      )

      SET i=0
   )

   SET DATAPROCESSED=Y
)

IF %DATAPROCESSED%==Y (
   CALL %~dp0FoundationStructureUpdate.bat
   CALL %~dp0QuartzCubeSync.bat
   CALL %~dp0GatherSchemaStats.bat
   CALL %~dp0RebuildContexts.bat

   IF %ERRORLEVEL% NEQ 0 (
      GOTO :EXIT
   )

   ECHO RECLASS LOAD HAS SUCCEEDED
) ELSE (
   ECHO NO RECLASS FILES FOUND TO LOAD
)

EXIT /B 0

:EXIT

ECHO RECLASS LOAD HAS FAILED

EXIT /B %ERRORLEVEL%