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
REM #     Executes the JI Server Data job to load EKBS Member updates.
REM # ==============================================================================
REM #
REM # TruncateJIErrors ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_TRUNCATE = -9001
REM # ==============================================================================
REM #
REM # RowCount ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM # ==============================================================================

CALL GlobalVariables.bat

TruncateJIErrors %JIUSER% %DATASOURCE%

%DSDIR%dsjob.exe -user %DSUSER% -password %DSPASSWORD% -server %DSSERVER% -run -wait ^
   -jobstatus %DSPROJECT% seqGRANDMASTER_PMM_TO_EKBS

IF ERRORLEVEL 3 (
   EXIT /B %ERRORLEVEL%
)

RowCount %JIUSER% %DATASOURCE% EXT_EPSD_ERRORS

IF ERRORLEVEL 1 (
   EXIT /B 9999
)

EXIT /B 0