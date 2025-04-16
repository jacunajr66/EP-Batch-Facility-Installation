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
REM #     Creates a subdirectory for the current date and moves all log files to
REM #     the directory.
REM # ==============================================================================

CALL GlobalVariables.bat

SET ARCHIVEDIR=.\Archive

IF NOT EXIST %ARCHIVEDIR% (
   mkdir %ARCHIVEDIR%
)

SET LOGDIR=.\Archive\Logs.%DATE:~-2,2%-%DATE:~-10,2%-%DATE:~-7,2%

IF NOT EXIST %LOGDIR% (
   mkdir %LOGDIR%
)

FORFILES /P .\Archive /D -%EXPIREDAYS% /C "cmd /c IF @isdir == TRUE rmdir /S /Q @path" 2>NUL

FOR %%a IN (%QUARTZHOMEPATHS%) DO (
   IF NOT EXIST %LOGDIR%\%%~nxa (
      mkdir %LOGDIR%\%%~nxa
   )

   FOR %%x IN (%ARCHIVEFILEEXTENSIONS%) DO (
      IF EXIST %%a\*.%%x (
         move /y %%a\*.%%x %LOGDIR%\%%~nxa
      )
   )

   FOR /d %%b IN (%%a\*) DO (
      IF NOT EXIST %LOGDIR%\%%~nxa\%%~nxb (
         mkdir %LOGDIR%\%%~nxa\%%~nxb
      )

      FOR %%y IN (%ARCHIVEFILEEXTENSIONS%) DO (
         IF EXIST %%a\%%~nb\*.%%y (
            move /y %%a\%%~nxb\*.%%y %LOGDIR%\%%~nxa\%%~nxb
         ) 
      )

      FOR /d %%c IN (%%b\*) DO (
         IF NOT EXIST %LOGDIR%\%%~nxa\%%~nxb\%%~nxc (
            mkdir %LOGDIR%\%%~nxa\%%~nxb\%%~nxc
         )

         FOR %%z IN (%ARCHIVEFILEEXTENSIONS%) DO (
            IF EXIST %%a\%%~nb\%%~nc\*.%%z (
               move /y %%a\%%~nxb\%%~nxc\*.%%z %LOGDIR%\%%~nxa\%%~nxb\%%~nxc
            )  
         )
      )
   )
)

FOR %%a IN (%ARCHIVEFILEEXTENSIONS%) DO (
   IF EXIST *.%%a (
      move /y *.%%a %LOGDIR%
   )
)

IF %CLOUD% == Y (
   cscript %SFTPSUPPORTPATH%\purge_old_files.wsf
)