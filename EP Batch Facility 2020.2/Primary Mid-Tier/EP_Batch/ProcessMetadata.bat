@ECHO OFF

REM # 
REM #  Created by John Acuna Version 2020.1.0.0 on 3/4/2018
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Executes the Mule Request to Process the EXT Meta Data Staging Tables
REM # ==============================================================================
REM #
REM # SendRESTRequest ERROR CODES
REM # 
REM # ARGUMENT_MISSING = -9002
REM # COMMAND_FAILED = -9001
REM # COMMAND_SUCCEEDED = 9000
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat
CALL %~dp0ClearImportTables.bat

%~dp0SendRESTRequest POST %PROCESSMETADATAURL% timeout=%RESTTIMEOUT%

IF %ERRORLEVEL% LEQ -9001 (
   EXIT /B 1
)

EXIT /B 0