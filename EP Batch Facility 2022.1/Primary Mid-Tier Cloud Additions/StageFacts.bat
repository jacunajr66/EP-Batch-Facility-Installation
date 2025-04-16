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
REM #     Stages Structure data from the SFTP Inbox into Structure Staging tables 
REM #     in the EXT Schema.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

cscript %SFTPSUPPORTPATH%\load_to_staging.wsf F

EXIT /B %ERRORLEVEL%