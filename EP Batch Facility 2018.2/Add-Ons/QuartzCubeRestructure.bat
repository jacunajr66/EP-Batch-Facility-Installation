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
REM #     Multithreads the execution of multiple Quartz Cube data restructure
REM #     processes.
REM # ==============================================================================
REM #
REM # StartProcess ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # PROCESS_START_FAILED = -9001
REM # PROCESS_COMPLETED = 9000
REM # PROCESS_FAILED = 9001
REM # ==============================================================================

StartProcess 4 ^
   "CubeRestructure.bat plan_actual PLAN_ACTUAL" ^
   "CubeRestructure.bat plan_bulp PLAN_BULP" ^
   "CubeRestructure.bat plan_bupp PLAN_BUPP" ^
   "CubeRestructure.bat plan_molp PLAN_MOLP" ^
   "CubeRestructure.bat plan_mopp PLAN_MOPP" ^
   "CubeRestructure.bat plan_stpp PLAN_STPP" ^
   "CubeRestructure.bat plan_tdlp PLAN_TDLP" ^
   "CubeRestructure.bat plan_tdpp PLAN_TDPP"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%