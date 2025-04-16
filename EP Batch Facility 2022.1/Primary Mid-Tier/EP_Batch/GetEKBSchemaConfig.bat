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
REM #     Executes the Mule Request to Get EKB Schema Configuration
REM # ==============================================================================
REM #
REM # SendRESTRequest ERROR CODES
REM # 
REM # ARGUMENT_MISSING = -9002
REM # COMMAND_FAILED = -9001
REM # COMMAND_SUCCEEDED = 9000
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0SendRESTRequest GET %GETEKBSCHEMACONFIGURL% timeout=%RESTTIMEOUT%

IF %ERRORLEVEL% LEQ -9001 (
   EXIT /B 1
)

EXIT /B 0