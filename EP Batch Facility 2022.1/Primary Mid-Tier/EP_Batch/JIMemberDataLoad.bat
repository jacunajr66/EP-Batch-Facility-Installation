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
REM #     Executes the JI Server Data job to load EKBS Member updates.
REM # ==============================================================================
REM #
REM # TruncateJIErrors ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_TRUNCATE = -9001
REM #
REM # RowCount ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM #
REM # DumpErrors ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DUMP = -9001
REM # SUCCESSFUL_DUMP = 9000
REM # NO_ERRORS_TO_DUMP = 9001
REM #
REM # SendRESTRequest ERROR CODES
REM # 
REM # ARGUMENT_MISSING = -9002
REM # COMMAND_FAILED = -9001
REM # COMMAND_SUCCEEDED = 9000
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

%~dp0TruncateJIErrors %JIUSER% %DATASOURCE%

IF %MULE% == Y (
   %~dp0ClearImportTables.bat

   IF %ERRORLEVEL% LEQ -9001 (
      EXIT /B 1
   )

   %~dp0ProcessMemberData.bat

   IF %ERRORLEVEL% == 1 (
      EXIT /B 1
   )
) ELSE (
   %DSDIR%dsjob.exe -user %DSUSER% -password %DSPASSWORD% -server %DSSERVER% -run -wait ^
      -jobstatus %DSPROJECT% seqDBMASTER_EXT_TO_EPServerData

   IF ERRORLEVEL 3 (
      EXIT /B %ERRORLEVEL%
   )

   IF %ERRORLEVEL% LEQ -1 (
      EXIT /B %ERRORLEVEL%
   )
)

%~dp0RowCount %JIUSER% %DATASOURCE% EXT_EPSD_ERRORS

IF ERRORLEVEL 1 (
   IF %CLOUD% == Y (
      %~dp0DumpErrors %JIUSER% %DATASOURCE% %STRUCTURELOADERRORSPATH% structure
   )

   EXIT /B 9999
)

EXIT /B 0