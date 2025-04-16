@ECHO OFF
REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 6/11/2018
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Wrapper script to execute a cscript file
REM # ==============================================================================

CD %~dp0

CALL GlobalVariables.bat

cscript %SFTPSUPPORTPATH%\load_to_staging.wsf F

EXIT /B %ERRORLEVEL%