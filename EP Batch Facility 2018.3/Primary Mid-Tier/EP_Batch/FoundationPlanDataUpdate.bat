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

CD %~dp0

StartProcess 4 ^
   "PlanDataUpdate.bat PL_BUL2" ^
   "PlanDataUpdate.bat PL_BULP" ^
   "PlanDataUpdate.bat PL_BUP1" ^
   "PlanDataUpdate.bat PL_BUP2" ^
   "PlanDataUpdate.bat PL_LL" ^
   "PlanDataUpdate.bat PL_LP" ^
   "PlanDataUpdate.bat PL_MOL2" ^
   "PlanDataUpdate.bat PL_MOLP" ^
   "PlanDataUpdate.bat PL_MOP2" ^
   "PlanDataUpdate.bat PL_MOPP" ^
   "PlanDataUpdate.bat PL_OL" ^
   "PlanDataUpdate.bat PL_OP1" ^
   "PlanDataUpdate.bat PL_RL" ^
   "PlanDataUpdate.bat PL_RP1" ^
   "PlanDataUpdate.bat PL_STP2" ^
   "PlanDataUpdate.bat PL_STPP" ^
   "PlanDataUpdate.bat PL_TDL2" ^
   "PlanDataUpdate.bat PL_TDLP" ^
   "PlanDataUpdate.bat PL_TDP1" ^
   "PlanDataUpdate.bat PL_TDP2"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%