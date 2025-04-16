@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 3/6/2013
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Multithreads the execution of multiple fact data loads into Granite for
REM #     User FTFs loaded from FDE extracts.
REM # ==============================================================================
REM #
REM # StartProcess ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # PROCESS_START_FAILED = -9001
REM # PROCESS_COMPLETED = 9000
REM # PROCESS_FAILED = 9001
REM # ==============================================================================

StartProcess ^
   "ActualsDataUpdate.bat ACTUAL_APRT" ^
   "ActualsDataUpdate.bat ACTUAL_STRCNT trusted"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%