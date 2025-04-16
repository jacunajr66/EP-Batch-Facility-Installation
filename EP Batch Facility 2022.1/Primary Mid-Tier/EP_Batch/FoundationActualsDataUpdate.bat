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
REM #     Multithreads the execution of multiple fact data loads into Granite for
REM #     Actuals FTFs.
REM # ==============================================================================
REM #
REM # StartProcess ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002,
REM # PROCESS_START_FAILED = -9001,
REM # ALL_SUCCEEDED = 9000,
REM # ALL_FAILED = 9001,
REM # ALL_PARTIALLY_SUCCEEDED = 9002,
REM # SOME_FAILED = 9003,
REM # SOME_PARTIALLY_SUCCEEDED = 9004
REM #
REM # DumpErrors ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DUMP = -9001
REM # SUCCESSFUL_DUMP = 9000
REM # NO_ERRORS_TO_DUMP = 9001
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0StartProcess 2 ^
   "%~dp0ActualsDataUpdate.bat ACTUAL_INVBAL" ^
   "%~dp0ActualsDataUpdate.bat ACTUAL_MKDNS" ^
   "%~dp0ActualsDataUpdate.bat ACTUAL_RECEIPTS" ^
   "%~dp0ActualsDataUpdate.bat ACTUAL_SALES" ^
   "%~dp0ActualsDataUpdate.bat ACTUAL_ON_ORDER" ^
   "%~dp0ActualsDataUpdate.bat ACTUAL_OTHINV"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
) 

SET ERROR=%ERRORLEVEL%

IF %CLOUD% == Y (
   %~dp0DumpErrors %FOUNDATIONUSER% %DATASOURCE% %TYLOADERRORSPATH% actuals

   IF NOT ERRORLEVEL 9001 (
      SET ERROR=4
   ) 
)

EXIT /B %ERROR%