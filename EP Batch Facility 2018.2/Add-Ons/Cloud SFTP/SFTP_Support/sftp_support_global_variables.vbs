'  Copyright (c) 2003-2013 by JDA Software, Inc.
'===============================================================================
'  Custom code created by JDA Implementation Services for use at CVS
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
goStrucThresholds.Add "AG_1_STYLE", 		0
goStrucThresholds.Add "AG_1_SIZE_CONCEPT",	0
goStrucThresholds.Add "AG_1_CLASS", 		0
goStrucThresholds.Add "AG_1_DEPARTMENT",	0
goStrucThresholds.Add "AG_1_MSTRDEPARTMENT",	0
goStrucThresholds.Add "AG_1_CATEGORY", 		0
goStrucThresholds.Add "AG_1_DIVISION", 		0
goStrucThresholds.Add "AG_1_TOTPROD", 		0
goStrucThresholds.Add "AG_1_DEPARTMENT_SIZE",	0
goStrucThresholds.Add "AG_1_MSTRDEPT_SIZE",	0
goStrucThresholds.Add "AG_1_CATEGORY_SIZE",	0
goStrucThresholds.Add "AG_1_DIVISION_SIZE",	0
goStrucThresholds.Add "AG_1_TOTAL_SIZE",	0
goStrucThresholds.Add "AG_2_LOCATION", 		0
goStrucThresholds.Add "AG_2_DISTRICT",		0
goStrucThresholds.Add "AG_2_REGION", 		0
goStrucThresholds.Add "AG_2_SUBCHANNEL",	0
goStrucThresholds.Add "AG_2_CHANNEL",		0
goStrucThresholds.Add "AG_2_CHANNEL_GRP",	0
goStrucThresholds.Add "AG_2_TOTORG", 		0
goStrucThresholds.Add "AG_2_SUBCHANNEL_GRP",	0
goStrucThresholds.Add "AG_4_DAY", 		0
goStrucThresholds.Add "AG_4_WEEK", 		0
goStrucThresholds.Add "AG_4_MONTH", 		0
goStrucThresholds.Add "AG_4_QUARTER", 		0
goStrucThresholds.Add "AG_4_HALF", 		0
goStrucThresholds.Add "AG_4_YEAR", 		0
goStrucThresholds.Add "EXT_EPSD_IMPORT_MEMBER_REL", 	0
goStrucThresholds.Add "EXT_EPSD_IMPORT_ATTR_DEF_POT", 	0

' ============================================================================== 
' The following variables will change from environment to environment
' ============================================================================== 

DATABASE="TLBEPTST"
FILE_SERVER="DLTLBTSTAP1V"
ADMIN_SERVER="DLTLBTSTAP1V"
EP_SERVER="DLTLBTSTAP1V"
EP_PRIMARY_MID_TIER=EP_SERVER

' ============================================================================== 
' The following variables should stay the same from environment to environment
' ============================================================================== 

INTERFACE_SLEEP_INTERVAL=60*1000 ' milliseconds
INTERFACE_MAX_LOOPS=2*60 
INBOX_DIRECTORY="D:\SFTP\Inbox\"
INBOX_ARCHIVE=INBOX_DIRECTORY & "Archive\"
ADHOC_INBOX_DIRECTORY="D:\SFTP\adhoc_inbox\"
ADHOC_INBOX_ARCHIVE=ADHOC_INBOX_DIRECTORY & "archive\"
BATCH_SCRIPTS_DIRECTORY="\\" & EP_SERVER & "\EP_BATCH\SFTP_Support"
REMOTE_SCRIPTS_DIRECTORY="\\" & ADMIN_SERVER & "\EP_BATCH\Scripts\"
EXPORT_DIRECTORY="D:\SFTP\Outbox\"
EXPORT_XML_DIRECTORY="D:\SFTP\Export_Xml_Files\"
SLY_INBOX=INBOX_DIRECTORY

LOG_DIRECTORY="D:\SFTP\SQLLDR_Logs\"
ERRORFILE_DIRECTORY="D:\SFTP\SQLLDR_Errors\"
CTLFILE_DIRECTORY="D:\EP_Batch\SFTP_Support\Ctl_Files\"

LOG_RETENTION=28 'days
ARCHIVE_RETENTION=28 'days
EXPORT_RETENTION=28 'days