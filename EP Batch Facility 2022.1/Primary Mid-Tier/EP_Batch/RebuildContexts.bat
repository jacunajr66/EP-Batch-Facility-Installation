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
REM #     Executes EP Mid-Tier command to rebuild all Contexts
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

"D:\Program Files\JDA\EPMidTierAdmin\bin\JDA.JADEAdmin.Client.Console.exe" /rebuildekbcontext:%CONTEXTNAMES%

EXIT /B %ERRORLEVEL%