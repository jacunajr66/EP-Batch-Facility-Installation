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
REM #     Stops EP Mid-Tier Services for a single Mid Tier.
REM # ==============================================================================

CD %~dp0

CALL GlobalVariables.bat

net stop JDABIApplicationServer

IF "%PRISEC%" == "primary" (
   net stop JDAEKBStructureCacheService
   net stop JDAEKBStructureFactsSynchronizationService
   net stop JDAEKBStructureService
)

FOR %%i IN (%SERVERCLONES%) DO (
   net stop %%i
)

EXIT /B 0