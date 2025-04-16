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
REM #     Sets the Foundation Current Time
REM # ==============================================================================
REM #
REM # FoundationRestartStatus ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002
REM # CANNOT_DETERMINE = -9001
REM # NO_RESTART_PENDING = 9000
REM # RESTART_PENDING = 9001
REM # PROCESS_RUNNING = 9002
REM # RESTART_PENDING_FOR_OTHER_TYPE = 9003
REM # RESTART_PENDING_FOR_BLOCKING_COMMAND = 9004
REM # RESTART_PENDING_FOR_OTHER_FACT_TABLE = 9005
REM # BLOCKING_COMMAND_RUNNING = 9006
REM # ==============================================================================

CALL %~dp0GlobalVariables.bat

FOR /f %%i IN ('%~dp0LatestFactDataTime %FOUNDATIONUSER% %DATASOURCE% %DEFAULTFTFTABLE% %DEFAULTFTFTIMECOLUMN%') DO SET TIME_MEMBER=%%i

%~dp0FoundationRestartStatus %FOUNDATIONUSER% %DATASOURCE% pkbfstrstime

IF %ERRORLEVEL% EQU 9000 (
   IF "%1" EQU "" (
      pkbfstrstime / %DEFAULTINCREMENT%

      GOTO :EXIT
   ) 

   if "%1" EQU "latest" (
      pkbfstrstime / %TIME_MEMBER%

      GOTO :EXIT
   )

   pkbfstrstime / %1

   GOTO :EXIT
)

IF %ERRORLEVEL% EQU 9001 (
   IF "%1" EQU "" (
      pkbfstrstime / %DEFAULTINCREMENT% restart=y

      GOTO :EXIT
   ) 

   if "%1" EQU "latest" (
      pkbfstrstime / %TIME_MEMBER% restart=y

      GOTO :EXIT
   )

   pkbfstrstime / %1 restart=y
)

:EXIT

EXIT /B %ERRORLEVEL%