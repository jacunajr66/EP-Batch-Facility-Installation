@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 2/22/2013
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Synchronizes EKB Foundation with EKB Structure
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

CALL GlobalVariables.bat

FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfstrupd

IF %ERRORLEVEL% EQU 9000 (
   pkbfstrupd /

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9001 (
   pkbfstrupd / restart=y
)

:EXIT

EXIT /B %ERRORLEVEL%