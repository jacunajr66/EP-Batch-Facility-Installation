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
REM #     Executes EP Mid-Tier command to rebuild all Contexts
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

"D:\Program Files\JDA\EPMTA\bin\JDA.JADEAdmin.Client.Console.exe" /rebuildekbcontext:%CONTEXTNAMES%

EXIT /B %ERRORLEVEL%