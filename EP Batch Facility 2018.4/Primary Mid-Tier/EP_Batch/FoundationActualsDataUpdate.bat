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

CD %~dp0

CALL GlobalVariables.bat

StartProcess 2 ^
   "ActualsDataUpdate.bat ACTUAL_INVBAL" ^
   "ActualsDataUpdate.bat ACTUAL_MKDNS" ^
   "ActualsDataUpdate.bat ACTUAL_RECEIPTS" ^
   "ActualsDataUpdate.bat ACTUAL_SALES" ^
   "ActualsDataUpdate.bat ACTUAL_ON_ORDER" ^
   "ActualsDataUpdate.bat ACTUAL_OTHINV"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
) 

SET ERROR=%ERRORLEVEL%

IF %CLOUD% == Y (
   DumpErrors %FOUNDATIONUSER% %DATASOURCE% %TYLOADERRORSPATH% actuals

   IF %ERRORLEVEL% EQU 9000 (
      EXIT /B 4
   ) 
)

EXIT /B %ERROR%