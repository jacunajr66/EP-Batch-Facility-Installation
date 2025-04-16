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

%~dp0StartProcess 4 ^
   "%~dp0CubeRestructure.bat plan_actual PLAN_ACTUAL" ^
   "%~dp0CubeRestructure.bat plan_bulp PLAN_BULP" ^
   "%~dp0CubeRestructure.bat plan_bupp PLAN_BUPP" ^
   "%~dp0CubeRestructure.bat plan_molp PLAN_MOLP" ^
   "%~dp0CubeRestructure.bat plan_mopp PLAN_MOPP" ^
   "%~dp0CubeRestructure.bat plan_stpp PLAN_STPP" ^
   "%~dp0CubeRestructure.bat plan_tdlp PLAN_TDLP" ^
   "%~dp0CubeRestructure.bat plan_tdpp PLAN_TDPP"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%