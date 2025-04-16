@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 3/20/2018
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Initializes the SFTP environment for an EP Cloud implementation.
REM #
REM # CreateSFTPControlFiles ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_CREATE = -9001
REM # SUCCESSFUL_CREATE = 9000
REM # NO_FILES_TO_CREATE = 9001
REM # ==============================================================================

CD %~dp0

CALL GlobalVariables.bat

IF %CLOUD% == N (
   ECHO Environment not configured for Cloud in GlobalVariables.bat.

   EXIT /B 0
)

IF NOT EXIST %SFTPPATH% (
   mkdir %SFTPPATH%
)

IF NOT EXIST %FACTHISTORYPATH% (
   mkdir %FACTHISTORYPATH%
)

IF NOT EXIST %INBOXPATH% (
   mkdir %INBOXPATH%
)

IF NOT EXIST %INBOXARCHIVEPATH% (
   mkdir %INBOXARCHIVEPATH%
)

IF NOT EXIST %OUTBOXPATH% (
   mkdir %OUTBOXPATH%
)

IF NOT EXIST %SQLLDRERRORSPATH% (
   mkdir %SQLLDRERRORSPATH%
)

IF NOT EXIST %SQLLDRLOGSPATH% (
   mkdir %SQLLDRLOGSPATH%
)

IF NOT EXIST %STRUCTURELOADERRORSPATH% (
   mkdir %STRUCTURELOADERRORSPATH%
)

IF NOT EXIST %TYLOADERRORSPATH% (
   mkdir %TYLOADERRORSPATH%
)

IF NOT EXIST %SFTPSUPPORTPATH% (
   mkdir %SFTPSUPPORTPATH%
)

IF NOT EXIST %SQLLDRCONTROLPATH% (
   mkdir %SQLLDRCONTROLPATH%
)

FOR %%i IN (%SQLLDRCONTROLPATH%\*.*) DO (
    DEL %%i
)

CreateSFTPControlFiles %FOUNDATIONUSER% %DATASOURCE% %SQLLDRCONTROLPATH% actuals

IF %ERRORLEVEL% EQU 9000 (
   CreateSFTPControlFiles %JIUSER% %DATASOURCE% %SQLLDRCONTROLPATH% structure

   IF %ERRORLEVEL% EQU 9000 (
      EXIT /B 0
   )
)

EXIT /B %ERRORLEVEL%