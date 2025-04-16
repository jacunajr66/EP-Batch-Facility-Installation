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
REM #     Executes EKBF Commands to perform a structure and data sync on a single
REM #     Quartz Cube.
REM # ==============================================================================
REM #
REM # QuartzSyncStatus ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM # NO_SYNC_PENDING = 9000
REM # STRUCTURE_AND_DATA_SYNC_PENDING = 9001
REM # STRUCTURE_SYNC_PENDING = 9002
REM # DATA_SYNC_PENDING = 9003
REM #
REM # QuartzRestartStatus ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM # NO_RESTART_PENDING = 9000
REM # RESTART_PENDING = 9001
REM # PROCESS_RUNNING = 9002
REM # RESTART_PENDING_FOR_OTHER_TYPE = 9003
REM # RESTART_PENDING_FOR_BLOCKING_COMMAND = 9004
REM # BLOCKING_COMMAND_RUNNING = 9006
REM # ==============================================================================

IF "%2" == "" (
   ECHO Usage: [user] [quartz db]

   EXIT /B 1
)

CALL GlobalVariables.bat

SET DATASYNC=N
SET STRUCSYNC=N

QuartzSyncStatus %FOUNDATIONUSER% %1 %DATASOURCE% %2

IF %ERRORLEVEL% EQU -9002 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU -9001 (
   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9001 (
   SET DATASYNC=Y
   SET STRUCSYNC=Y
)

IF %ERRORLEVEL% EQU 9002 (
   SET STRUCSYNC=Y
)

IF %ERRORLEVEL% EQU 9003 (
   SET DATASYNC=Y
)

QuartzRestartStatus %1  %DATASOURCE% cimsyncpkbf structure

IF %ERRORLEVEL% EQU 9000 (
   (CALL )

   IF "%STRUCSYNC%" == "Y" (
      cimsyncpkbf / %2 type=structure
   )
)

IF %ERRORLEVEL% EQU 9001 (
   cimsyncpkbf / %2 type=structure restart=y
)

IF %ERRORLEVEL% EQU 0 (
   IF "%DATASYNC%" == "Y" (
      cimsyncpkbf / %2 type=data
   )
)

IF %ERRORLEVEL% EQU 9003 (
   cimsyncpkbf / %2 type=data restart=y
)

:EXIT

EXIT /B %ERRORLEVEL%