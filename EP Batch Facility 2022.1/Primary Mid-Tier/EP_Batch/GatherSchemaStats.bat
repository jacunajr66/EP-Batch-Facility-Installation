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
REM #     Performs an Oracle Gather Schema Stats based on an SQL file.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0RunSQL %FOUNDATIONUSER% %DATASOURCE% %~dp0GatherSchemaStats.sql

EXIT /B 0