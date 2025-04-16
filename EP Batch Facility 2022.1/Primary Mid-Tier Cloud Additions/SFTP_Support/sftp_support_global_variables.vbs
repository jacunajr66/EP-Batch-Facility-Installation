'  Copyright (c) 2003-2013 by JDA Software, Inc.
'===============================================================================
'  Custom code created by JDA Implementation Services
'  
'  Version  Author  		Date         Comments
'  1.0      JDA 		2017-10-30 Initial Creation
'
' ==============================================================================
'
' Purpose:
'    This file contains global variables that are used by other scripts
'
' Inputs:
'    None
'       
' Outputs:
'    None
'
' ============================================================================== 

' ============================================================================== 
' The following variables are used to configure the thresholds for determining
' when a structure load should fail. Each table name has a corresponding 
' threshold number. 
'  If the threshold = 0 then any rejected records for that table will cause
'  the batch to fail
'  If the threshold = a number then the batch will fail if more records than 
'  the specified number are rejected for that table
'  If the threshold = -1 then the batch will continue no matter how many 
'  records are rejected
' ============================================================================== 

set goStrucThresholds = CreateObject ("Scripting.Dictionary")
goStrucThresholds.Add "AG_1_P1", 			0
goStrucThresholds.Add "AG_1_P2",			0
goStrucThresholds.Add "AG_1_TOTPROD", 			0
goStrucThresholds.Add "AG_1_DIV",			0
goStrucThresholds.Add "AG_1_DPT",			0
goStrucThresholds.Add "AG_1_SUBDPT", 			0
goStrucThresholds.Add "AG_1_CLASS", 			0
goStrucThresholds.Add "AG_1_SUBCLASS", 			0
goStrucThresholds.Add "AG_1_STYLE",			0
goStrucThresholds.Add "AG_1_STYLECOLOR",		0
goStrucThresholds.Add "AG_2_P1", 			0
goStrucThresholds.Add "AG_2_TOTORG",			0
goStrucThresholds.Add "AG_2_BU", 			0
goStrucThresholds.Add "AG_2_CHANNEL",			0
goStrucThresholds.Add "AG_2_REGION",			0
goStrucThresholds.Add "AG_2_DISTRICT",			0
goStrucThresholds.Add "AG_2_TOUCHPOINT", 		0
goStrucThresholds.Add "AG_4_TOTYEAR", 			0
goStrucThresholds.Add "AG_4_YEAR", 			0
goStrucThresholds.Add "AG_4_SEASON", 			0
goStrucThresholds.Add "AG_4_QUARTER", 			0
goStrucThresholds.Add "AG_4_PERIOD", 			0
goStrucThresholds.Add "AG_4_WEEK", 			0
goStrucThresholds.Add "AG_4_DAY", 			0
goStrucThresholds.Add "EXT_EPSD_IMPORT_MEMBER_REL", 	0
goStrucThresholds.Add "EXT_EPSD_IMPORT_ATTR_DEF_POT", 	0

' ============================================================================== 
' The following variables will change from environment to environment
' ============================================================================== 

DATABASE="[database SID]"
FILE_SERVER="[primary mid-tier server]"
ADMIN_SERVER="[primary mid-tier server]"
EP_SERVER="[primary mid-tier server]"
EP_PRIMARY_MID_TIER=EP_SERVER

' ============================================================================== 
' The following variables should stay the same from environment to environment
' ============================================================================== 

SFTP_DIRECTORY="D:\SFTP"
INTERFACE_SLEEP_INTERVAL=60000
INTERFACE_MAX_LOOPS=120
INBOX_DIRECTORY=SFTP_DIRECTORY & "\Inbox\"
INBOX_ARCHIVE=INBOX_DIRECTORY & "Archive\"
BATCH_SCRIPTS_DIRECTORY="\\" & EP_SERVER & "\EP_BATCH\SFTP_Support"
REMOTE_SCRIPTS_DIRECTORY="\\" & ADMIN_SERVER & "\EP_BATCH\Scripts\"
EXPORT_DIRECTORY=SFTP_DIRECTORY & "\Outbox\"
EXPORT_XML_DIRECTORY=SFTP_DIRECTORY & "\Export_Xml_Files\"
SLY_INBOX=INBOX_DIRECTORY

LOG_DIRECTORY=SFTP_DIRECTORY & "\SQLLDR_Logs\"
ERRORFILE_DIRECTORY=SFTP_DIRECTORY & "\SQLLDR_Errors\"
CTLFILE_DIRECTORY="D:\EP_Batch\SFTP_Support\Ctl_Files\"

LOG_RETENTION=28
ARCHIVE_RETENTION=28
EXPORT_RETENTION=28