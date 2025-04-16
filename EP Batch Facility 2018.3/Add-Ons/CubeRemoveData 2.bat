@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 6/24/2013
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Executes EKBF Commands to remove data from a Quartz Cube
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
   ECHO Usage: [user] [quartz db] [tables]

   EXIT /B 1
)

CALL GlobalVariables.bat

IF "%~3" == "" (
   SET ALL=y
   SET TABLES=
) ELSE (
   SET ALL=n
   SET TABLES="table=%3"
)

QuartzRestartStatus %1 %DATASOURCE% cimdatrm

IF %ERRORLEVEL% EQU 9000 (
   cimdatrm / %2 empty=y all=%ALL% confirmempty=n %TABLES%
)

IF %ERRORLEVEL% EQU 9001 (
   cimdatrm / %2 empty=y all=%ALL% confirmempty=n %TABLES% restart=y
)

EXIT /B %ERRORLEVEL%