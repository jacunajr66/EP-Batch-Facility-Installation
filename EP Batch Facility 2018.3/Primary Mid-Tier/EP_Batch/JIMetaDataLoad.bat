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
REM #     Executes the JI Meta Data job to load EKBS Meta Data changes.
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
REM # ==============================================================================

CD %~dp0

CALL GlobalVariables.bat

TruncateJIErrors %JIUSER% %DATASOURCE%

%DSDIR%dsjob.exe -user %DSUSER% -password %DSPASSWORD% -server %DSSERVER% -run -wait ^
   -param "LoadAttributeDefnitionPotFromCSVToEXT=Do not process" ^
   -param "LoadAttributeDefnitionFromCSVToEXT=Do not process" ^
   -param "LoadHierarchyDefnitionFromCSVToEXT=Do not process" ^
   -param "LoadMemberDefnitionFromCSVToEXT=Do not process" ^
   -param "LoadLevelDefnitionFromCSVToEXT=Do not process" ^
   -param "LoadMemberAttributeDefnitionFromCSVToEXT=Do not process" ^
   -param "LoadHierarchyLevelDefnitionFromCSVToEXT=Do not process" ^
   -param "LoadWellKnownLevelsFromCSV=Do not process" ^
   -jobstatus %DSPROJECT% seqDBMASTER_EXT_MetaData_TO_EPSD_MetaData

IF ERRORLEVEL 3 (
   EXIT /B %ERRORLEVEL%
)

IF %ERRORLEVEL% LEQ -1 (
   EXIT /B %ERRORLEVEL%
)

RowCount %JIUSER% %DATASOURCE% EXT_EPSD_ERRORS

IF ERRORLEVEL 1 (
   IF %CLOUD% == Y (
      DumpErrors %JIUSER% %DATASOURCE% %STRUCTURELOADERRORSPATH% structure
   )

   EXIT /B 9999
)

EXIT /B 0