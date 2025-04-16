@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 12/10/2013
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

IF %ERRORLEVEL% EQU 4 (
   EXIT /B 0
)
