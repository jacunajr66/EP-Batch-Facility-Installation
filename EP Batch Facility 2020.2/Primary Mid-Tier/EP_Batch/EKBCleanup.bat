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
REM #     Performs general cleanup activities.
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

pkbfdutrans / delete confirmdelete=n

ekbutil / AGEFDELOG

"D:\Program Files\JDA\EPMidTier\bin\PurgeMemberHistory.exe"

IF %ERRORLEVEL% EQU 4 (
   EXIT /B 0
)
