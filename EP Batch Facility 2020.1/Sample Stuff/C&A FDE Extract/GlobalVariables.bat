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
REM #     Single location to set variable values used by various other batch 
REM #     scripts.
REM # ==============================================================================

REM # ==============================================================================
REM # JI ONLY SCRIPT VARIABLES
REM # ==============================================================================

SET DSDIR=D:\IBM\InformationServer\Clients\Classic\
SET DSPASSWORD=isadmin
SET DSPROJECT=SPPMMEP
SET DSSERVER=FR1CNAPRDEP1V
SET DSUSER=isadmin
SET JIUSER=ext

REM # ==============================================================================
REM # GLOBAL SCRIPT VARIABLES
REM # ==============================================================================

SET DATASOURCE=CNPDEPDB
SET FOUNDATIONUSER=ekb
SET SFTPSERVER=FR1CNAPRDAPP2V

REM # ==============================================================================
REM # MID-TIER STOP START VARIABLES
REM # ==============================================================================

SET PRISEC=primary
SET SERVERCLONES=

REM # ==============================================================================
REM # CONTEXT REBUILD VARIABLES
REM # ==============================================================================

SET CONTEXTNAMES=EPPlan

REM # ==============================================================================
REM # FOUNDATION TIME VARIABLES
REM # ==============================================================================

SET DEFAULTINCREMENT=+WEEK
SET DEFAULTFTFTABLE=PF_FT_ACTUAL_RECEIPTS_000
SET DEFAULTFTFTIMECOLUMN=CALENDAR_KEY

REM # ==============================================================================
REM # ACTUAL DATA POSTING VARIABLES
REM # ==============================================================================

SET ALLOWED_ERROR_CODES=
SET FORCEEMPTY=ACTUAL_ON_ORDER
SET FULLSTATEMENT=ACTUAL_ON_ORDER

REM # ==============================================================================
REM # EP SHUTDOWN VARIABLES
REM # ==============================================================================

SET TRIGGERPATH=D:\Toolkit_Prd\PlanNOW_CMA\Corporate\Plan\trigger.ini

REM # ==============================================================================
REM # LOG ARCHIVING VARIABLES
REM # ==============================================================================

SET ARCHIVEFILEEXTENSIONS=log,trc,errlist,errors,infolist,bin,shape,facttables,sr,tmp,merged,sts
SET EXPIREDAYS=28
SET QUARTZHOMEPATHS=D:\ProgramData\JDA\EKB