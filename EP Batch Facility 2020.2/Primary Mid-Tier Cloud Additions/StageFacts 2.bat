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
REM #     Stages Structure data from the SFTP Inbox into Structure Staging tables 
REM #     in the EXT Schema.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

cscript %SFTPSUPPORTPATH%\load_to_staging.wsf F

EXIT /B %ERRORLEVEL%