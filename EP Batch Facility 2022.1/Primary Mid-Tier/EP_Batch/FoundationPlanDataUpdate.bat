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
REM #     User Plan FTFs.
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

%~dp0StartProcess.exe 4 ^
   "%~dp0PlanDataUpdate.bat PL_BUL2" ^
   "%~dp0PlanDataUpdate.bat PL_BULP" ^
   "%~dp0PlanDataUpdate.bat PL_BUP1" ^
   "%~dp0PlanDataUpdate.bat PL_BUP2" ^
   "%~dp0PlanDataUpdate.bat PL_LL" ^
   "%~dp0PlanDataUpdate.bat PL_LP" ^
   "%~dp0PlanDataUpdate.bat PL_MOL2" ^
   "%~dp0PlanDataUpdate.bat PL_MOLP" ^
   "%~dp0PlanDataUpdate.bat PL_MOP2" ^
   "%~dp0PlanDataUpdate.bat PL_MOPP" ^
   "%~dp0PlanDataUpdate.bat PL_OL" ^
   "%~dp0PlanDataUpdate.bat PL_OP1" ^
   "%~dp0PlanDataUpdate.bat PL_RL" ^
   "%~dp0PlanDataUpdate.bat PL_RP1" ^
   "%~dp0PlanDataUpdate.bat PL_STP2" ^
   "%~dp0PlanDataUpdate.bat PL_STPP" ^
   "%~dp0PlanDataUpdate.bat PL_TDL2" ^
   "%~dp0PlanDataUpdate.bat PL_TDLP" ^
   "%~dp0PlanDataUpdate.bat PL_TDP1" ^
   "%~dp0PlanDataUpdate.bat PL_TDP2"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%