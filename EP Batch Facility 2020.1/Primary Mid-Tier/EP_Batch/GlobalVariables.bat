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
REM # GLOBAL SCRIPT VARIABLES
REM # ==============================================================================

SET DATASOURCE=[database SID]
SET FOUNDATIONUSER=ekb

REM # ==============================================================================
REM # JI SCRIPT VARIABLES
REM # ==============================================================================

SET MULE=Y
SET JIUSER=ext

REM # ==============================================================================
REM # JI ON MULE ONLY SCRIPT VARIABLES
REM # ==============================================================================

SET MULEENV=dev
SET MULELABEL=defaultLabel
SET RESTTIMEOUT=100

SET CLEARIMPORTTABLESURL=http://localhost:9091/clear/ekbsimporttables
SET CREATEAGTABLESURL=http://localhost:9091/init/agtables
SET GETBATCHRESULTURL=http://localhost:9091/result/
SET GETEKBSCHEMACONFIGURL=http://localhost:9091/config/ep
SET GETEXTSCHEMACONFIGURL=http://localhost:9091/config/ji
SET INITEXTSCHEMAURL=http://localhost:9091/init/extschema
SET PENDINGBATCHPROCESSESURL=http://localhost:9091/import/pendingbatches
SET PROCESSBERELDATAURL=http://localhost:9091/import/crossdimrel
SET PROCESSMEMBERDATAURL=http://localhost:9091/import/memberdata
SET PROCESSMETADATAURL=http://localhost:9091/import/metadata
SET SETJIPROPERTIESURL=http://localhost:9811/cps/api/v1/application/ji/properties

SET EKBSCHEMAPROPS="?categories=%FOUNDATIONUSER%&environment=%MULEENV%&label=%MULELABEL%"
SET EMAILPROPS="?categories=email&environment=%MULEENV%&label=%MULELABEL%"
SET EXTSCHEMAPROPS="?categories=%JIUSER%&environment=%MULEENV%&label=%MULELABEL%"
SET FRAMEWORKPROPS="?categories=eFramework&environment=%MULEENV%&label=%MULELABEL%"
SET HTTPPROPS="?categories=http&environment=%MULEENV%&label=%MULELABEL%"
SET JIPROPS="?environment=%MULEENV%&label=%MULELABEL%"

REM # ==============================================================================
REM # JI ON DATASTAGE ONLY SCRIPT VARIABLES
REM # ==============================================================================

SET DSDIR=D:\IBM\InformationServer\Clients\Classic\
SET DSPASSWORD=isadmin
SET DSPROJECT=SPEXTEPSD
SET DSSERVER=[primary mid-tier server]
SET DSUSER=isadmin

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

SET TRIGGERPATH=\\[admin sever]\Toolkit\Corporate\Plan\trigger.ini

REM # ==============================================================================
REM # LOG ARCHIVING VARIABLES
REM # ==============================================================================

SET ARCHIVEFILEEXTENSIONS=log,trc,errlist,errors,infolist,bin,shape,facttables,sr,tmp,merged,sts,rsp,tin,al,pl,sorted
SET EXPIREDAYS=28
SET QUARTZHOMEPATHS=C:\ProgramData\JDA\EKB

REM # ==============================================================================
REM # CLOUD SFTP VARIABLES
REM # ==============================================================================

SET CLOUD=N
SET SFTPPATH=D:\SFTP
SET FACTHISTORYPATH=%SFTPPATH%\Fact_History
SET INBOXPATH=%SFTPPATH%\Inbox
SET INBOXARCHIVEPATH=%INBOXPATH%\Archive
SET OUTBOXPATH=%SFTPPATH%\Outbox
SET RECLASSPATH=%INBOXPATH%\Reclass
SET SFTPSUPPORTPATH=D:\EP_Batch\SFTP_Support
SET SQLLDRCONTROLPATH=%SFTPSUPPORTPATH%\Ctl_Files
SET SQLLDRERRORSPATH=%SFTPPATH%\SQLLDR_Errors
SET SQLLDRLOGSPATH=%SFTPPATH%\SQLLDR_Logs
SET STRUCTURELOADERRORSPATH=%SFTPPATH%\Structure_Load_Errors
SET TYLOADERRORSPATH=%SFTPPATH%\TY_Load_Errors