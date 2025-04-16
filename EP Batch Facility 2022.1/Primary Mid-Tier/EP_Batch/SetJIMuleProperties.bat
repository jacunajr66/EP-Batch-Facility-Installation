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
REM #     Executes the Mule Requests to Set JI on Mule Property Values
REM # ==============================================================================
REM #
REM # SendRESTRequest ERROR CODES
REM # 
REM # ARGUMENT_MISSING = -9002
REM # COMMAND_FAILED = -9001
REM # COMMAND_SUCCEEDED = 9000
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0SendRESTRequest POST %SETJIPROPERTIESURL% parms=%EKBSCHEMAPROPS% json=SetEKBSchemaProperties.json timeout=%RESTTIMEOUT%
%~dp0SendRESTRequest POST %SETJIPROPERTIESURL% parms=%EMAILPROPS% json=SetEmailProperties.json
%~dp0SendRESTRequest POST %SETJIPROPERTIESURL% parms=%EXTSCHEMAPROPS% json=SetEXTSchemaProperties.json timeout=%RESTTIMEOUT%
%~dp0SendRESTRequest POST %SETJIPROPERTIESURL% parms=%FRAMEWORKPROPS% json=SetFrameworkProperties.json timeout=%RESTTIMEOUT%
%~dp0SendRESTRequest POST %SETJIPROPERTIESURL% parms=%HTTPPROPS% json=SetHTTPProperties.json timeout=%RESTTIMEOUT%
%~dp0SendRESTRequest POST %SETJIPROPERTIESURL% parms=%JIPROPS% json=SetJIProperties.json timeout=%RESTTIMEOUT%
