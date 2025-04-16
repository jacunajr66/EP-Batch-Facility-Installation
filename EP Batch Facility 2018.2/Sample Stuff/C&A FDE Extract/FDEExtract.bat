@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 5/25/2017
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Multithreads the execution of multiple FDE extracts.
REM # ==============================================================================
REM #
REM # StartProcess ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # PROCESS_START_FAILED = -9001
REM # PROCESS_COMPLETED = 9000
REM # PROCESS_FAILED = 9001
REM # ==============================================================================

CALL GlobalVariables.bat

FOR %%i IN (.\FDEOutput\*.*) DO (
    DEL %%i
)

FOR %%i IN (\\%SFTPSERVER%\SFTP\EP\outbox\*.*) DO (
    MOVE %%i "\\%SFTPSERVER%\SFTP\EP\outbox\archive\"
)

CALL jTimestamp.bat -z +60 -f {YYYY}{MM}{DD}{HH}{NN}{SS}{FFF} -r TIMESTAMP

StartProcess 4 ^
   "BUPPExtract.bat %FOUNDATIONUSER% Ho45y#k87GiN2 %DATASOURCE% %TIMESTAMP%" ^
   "MOPPExtract.bat %FOUNDATIONUSER% Ho45y#k87GiN2 %DATASOURCE% %TIMESTAMP%" ^
   "TDPPExtract.bat %FOUNDATIONUSER% Ho45y#k87GiN2 %DATASOURCE% %TIMESTAMP%" ^
   "STPPExtract.bat %FOUNDATIONUSER% Ho45y#k87GiN2 %DATASOURCE% %TIMESTAMP%" 

IF %ERRORLEVEL% EQU 9000 (
   COPY ".\FDEOutput\*.csv" "\\"%SFTPSERVER%"\SFTP\EP\outbox\"
   COPY ".\FDEOutput\*.done" "\\"%SFTPSERVER%"\SFTP\EP\outbox\"

   EXIT /B 0
)

EXIT /B %ERRORLEVEL%