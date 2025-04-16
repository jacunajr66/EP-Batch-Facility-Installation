@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 3/26/2014
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Multithreads the execution of multiple Quartz Cube aged data purge
REM #     processes.
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
REM # ==============================================================================

CD %~dp0

StartProcess 4 ^
   "CubePurgeAgedData.bat plan_actual PLAN_ACTUAL" ^
   "CubePurgeAgedData.bat plan_bulp PLAN_BULP" ^
   "CubePurgeAgedData.bat plan_bupp PLAN_BUPP" ^
   "CubePurgeAgedData.bat plan_molp PLAN_MOLP" ^
   "CubePurgeAgedData.bat plan_mopp PLAN_MOPP" ^
   "CubePurgeAgedData.bat plan_stpp PLAN_STPP" ^
   "CubePurgeAgedData.bat plan_tdlp PLAN_TDLP" ^
   "CubePurgeAgedData.bat plan_tdpp PLAN_TDPP"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%