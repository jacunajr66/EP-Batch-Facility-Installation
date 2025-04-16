Contents of the Primary directory go on the primary mid-tier and the contents of the Secondary directory go on the secondary mid-tier.  Only exception is if the implementation will be running batch jobs (other than restarting mid-tier processes) on the secondary as well as the primary.

The GlobalVariables.bat file must maintain different values for the PRISEC variable value when dealing with primary vs secondary.  Specify the value of "primary" on the primary mid-tier and the value of "secondary" on the secondary mid-tier.  All other values need to be the same.

The Add-Ons directory contains non-typical features of the EP Batch Facility referenced in the documentation.  They are only to be installed when used at an implementation.

The following variables need to have implementation specific values set in the GlobalVariables.bat files:

	DSSERVER
	DATASOURCE	
	TRIGGERPATH
	CLOUD

In addition, if not a PlanNOW implementation the following variable needs to be set (comma separated if more than one Context):

	CONTEXTNAMES

All other variables in the GlobalVariables.bat files are defaulted to typical defaults but can be customized to the implementations specific needs.



Note that the anticipated location for installation is the D: drive.  Otherwise, an alternative path must be accounted for in the GlobalVariables.bat file (search for D: in the GlobalVariables.bat file):

	DSDIR

	QUARTZHOMEPATHS
	SFTPPATH
	FACTHISTORYPATH
	INBOXPATH
	INBOXARCHIVEPATH
	OUTBOXPATH
	SFTPSUPPORTPATH
	SQLLDRCONTROLPATH
	SQLLDRERRORSPATH
	SQLLDRLOGSPATH
	STRUCTURELOADERRORSPATH
	TYLOADERRORSPATH



The following files have implementation specific details such as FTF and Quartz Cube names.  By default they are setup for PlanNOW:
 

	
ActualsCubeSync.bat
	EPBatchFacility.xml
	FoundationActualsDataUpdate.bat
	FoundationPlanDataUpdate.bat
	GlobalVariables.bat
	PlanCubeSync.bat
	PurgeFoundation.bat (Optional, in Add-Ons)
	PurgeQuartz.bat (Optional, in Add-Ons)
	QuartzCubeRestructure.bat (Optional, in Add-Ons)
	QuartzCubeSync.bat
	QuartzPurgeAgedData.bat
	sftp_support_global_variables.vbs (Optional, in Add-Ons/Cloud SFTP/SFTP_Support)