@ECHO OFF

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 3/5/2019
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Executes a single data load per configured input source.
REM # ==============================================================================
REM #
REM # ==============================================================================

IF "%1" == "" (
   ECHO Usage: [FTF] [trusted/untrusted]

   EXIT /B 1
)

CALL GlobalVariables.bat

FOR /f %%i IN ('GETINPUTSOURCENAME %FOUNDATIONUSER% %DATASOURCE% %1') DO CALL ActualsDataUpdateByInputSource.bat %1, %%i, %2

EXIT /B %ERRORLEVEL%