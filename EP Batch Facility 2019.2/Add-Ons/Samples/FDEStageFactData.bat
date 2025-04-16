@ECHO OFF

REM # 
REM #  Created by John Acuna Version 2018.4.0.0 on 3/05/2013
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Multithreads the execution of multiple fact data copies from a Subdomain
REM #     to a staging table.
REM # ==============================================================================
REM #
REM # StartProcess ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # PROCESS_START_FAILED = -9001
REM # PROCESS_COMPLETED = 9000
REM # PROCESS_FAILED = 9001
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0StartProcess ^
   "%~dp0CopyFactData %FOUNDATIONUSER% %DATASOURCE% PLAN_FDE_STCT_CA.xml pkb_actual_strcnt" ^
   "%~dp0CopyFactData %FOUNDATIONUSER% %DATASOURCE% PLAN_FDE_STCT_MX.xml pkb_actual_strcnt" ^
   "%~dp0CopyFactData %FOUNDATIONUSER% %DATASOURCE% PLAN_FDE_STCT_US.xml pkb_actual_strcnt" ^
   "%~dp0CopyFactData %FOUNDATIONUSER% %DATASOURCE% PLAN_FDE_APR_CA.xml pkb_actual_aprt" ^
   "%~dp0CopyFactData %FOUNDATIONUSER% %DATASOURCE% PLAN_FDE_APR_MX.xml pkb_actual_aprt" ^
   "%~dp0CopyFactData %FOUNDATIONUSER% %DATASOURCE% PLAN_FDE_APR_US.xml pkb_actual_aprt"

IF %ERRORLEVEL% EQU 9000 (
   EXIT /B 0
)

EXIT /B %ERRORLEVEL%