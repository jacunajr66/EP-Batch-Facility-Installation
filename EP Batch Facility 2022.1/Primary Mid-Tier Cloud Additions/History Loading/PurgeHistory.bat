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
REM #     Fact data purging script run prior to an unattended fact history load when 
REM #     used in conjunction with the Cloud SFTP Add-On.
REM #
REM # StartProcess ERROR CODES
REM #
REM # ARGUMENT_MISSING = -9002,
REM # PROCESS_START_FAILED = -9001,
REM # ALL_SUCCEEDED = 9000,
REM # ALL_FAILED = 9001,
REM # ALL_PARTIALLY_SUCCEEDED = 9002,
REM # SOME_FAILED = 9003,
REM # SOME_PARTIALLY_SUCCEEDED = 9004
REM # ==============================================================================

CD %~dp0

StartProcess 4 ^
   "pkbfdatrm / type=facttables ftf=ACTUAL_INVBAL analyze=n empty=y" ^
   "pkbfdatrm / type=facttables ftf=ACTUAL_MKDNS analyze=n empty=y" ^
   "pkbfdatrm / type=facttables ftf=ACTUAL_RECEIPTS analyze=n empty=y" ^
   "pkbfdatrm / type=facttables ftf=ACTUAL_SALES analyze=n empty=y" ^
   "pkbfdatrm / type=facttables ftf=ACTUAL_ON_ORDER analyze=n empty=y" ^
   "pkbfdatrm / type=facttables ftf=ACTUAL_OTHINV analyze=n empty=y" ^
   "cimdatrm / plan_actual empty=y confirmempty=n"

EXIT /B %ERRORLEVEL%