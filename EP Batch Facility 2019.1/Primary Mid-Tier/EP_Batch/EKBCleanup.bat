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

CD %~dp0

CALL GlobalVariables.bat

pkbfdutrans / delete confirmdelete=n

ekbutil / AGEFDELOG

IF %ERRORLEVEL% EQU 4 (
   EXIT /B 0
)
