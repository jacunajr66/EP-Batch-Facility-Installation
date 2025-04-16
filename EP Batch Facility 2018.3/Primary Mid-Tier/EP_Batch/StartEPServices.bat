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
REM #     Restarts IIS and starts EP Mid-Tier Services for a single Mid Tier.
REM # ==============================================================================

CD %~dp0

CALL GlobalVariables.bat

iisreset

IF "%PRISEC%" == "primary" (
   net start JDAEKBStructureFactsSynchronizationService
   net start JDAEKBStructureCacheService
)

FOR %%i IN (%SERVERCLONES%) DO (
   net start %%i
)

EXIT /B 0