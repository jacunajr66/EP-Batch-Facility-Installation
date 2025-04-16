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
REM #     Executes EKBF Command to perform a data restructure on a single Quartz 
REM #     Cube.
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

IF "%2" == "" (
   ECHO Usage: [user] [quartz db]

   EXIT /B 1
)

CALL GlobalVariables.bat

QuartzRestartStatus %1 %DATASOURCE% cimsyncpkbf data

IF %ERRORLEVEL% EQU 9000 (
   cimsyncpkbf / %2 type=data releasetype=datarestructure
)
 
IF %ERRORLEVEL% EQU 9001 (
   cimsyncpkbf / %2 type=data releasetype=datarestructure restart=y
)

EXIT /B %ERRORLEVEL%