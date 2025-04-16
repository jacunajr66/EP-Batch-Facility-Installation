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
REM #     Creates or deletes the trigger file that enables/disables the EP Client
REM #	  Shutdown feature.
REM # ==============================================================================

CD %~dp0

CALL %~dp0GlobalVariables.bat

IF EXIST %TRIGGERPATH% (
   del %TRIGGERPATH%
)

IF %ERRORLEVEL% EQU 0 (
   IF "%1" == "disable" (
      ECHO [ShutDown] > %TRIGGERPATH%
      ECHO Message=Enterprise Planning will shut down in 2 minutes.  Please save all your work and exit. >> %TRIGGERPATH%
      ECHO TimeOut=2 >> %TRIGGERPATH%

      START /WAIT TIMEOUT 180

      del %TRIGGERPATH%

      ECHO [ShutDown] > %TRIGGERPATH%
      ECHO Message=Enterprise Planning is shut down. >> %TRIGGERPATH%
      ECHO TimeOut=1 >> %TRIGGERPATH%
   )
)

EXIT /B %ERRORLEVEL%