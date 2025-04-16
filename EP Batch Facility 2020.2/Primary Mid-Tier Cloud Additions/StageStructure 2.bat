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
REM #     Stages Fact data from the SFTP Inbox into Foundation Staging tables in 
REM #     the EKBF Schema.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

cscript %SFTPSUPPORTPATH%\load_to_staging.wsf S

EXIT /B %ERRORLEVEL%
