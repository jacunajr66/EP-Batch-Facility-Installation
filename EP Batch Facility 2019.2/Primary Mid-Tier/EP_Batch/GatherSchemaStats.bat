@ECHO OFF

REM # 
REM #  Created by John Acuna Version 2018.4.0.0 on 8/21/2019
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Performs an Oracle Gather Schema Stats on all EKB schemas.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0RunSQL %FOUNDATIONUSER% %DATASOURCE% %~dp0GatherSchemaStats.sql

EXIT /B 0