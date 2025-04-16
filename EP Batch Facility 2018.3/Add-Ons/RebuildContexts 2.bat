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
REM #     Executes EP Mid-Tier command to rebuild all Contexts
REM # ==============================================================================

CALL GlobalVariables.bat

"D:\Program Files\JDA\EPMidTierAdmin\bin\JDA.JADEAdmin.Client.Console.exe" /rebuildekbcontext:%CONTEXTNAMES%

EXIT /B %ERRORLEVEL%