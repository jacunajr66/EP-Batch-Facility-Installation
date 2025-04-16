@ECHO OFF

REM # 
REM #  Created by John Acuna Version 2018.4.0.0 on 10/5/2018
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Executes EKBF Command to purge aged data on a single Quartz Cube.
REM # ==============================================================================
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

CD %~dp0

IF "%1" == "" (
   ECHO Usage: [user] [quartz db]

   EXIT /B 1
)

CALL GlobalVariables.bat

QuartzRestartStatus %1 %DATASOURCE% cimdatrm

IF %ERRORLEVEL% EQU 9000 (
   cimdatrm / %2 empty=n
)
 
IF %ERRORLEVEL% EQU 9001 (
   cimdatrm / %2 empty=n restart=y
)

EXIT /B %ERRORLEVEL%