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
REM #     Restarts IIS and starts EP Mid-Tier Services for a single Mid Tier.
REM # ==============================================================================

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