'#  Copyright (c) 2003-2013 by JDA Software, Inc.
'#==============================================================================

'==============================================================================
' Purpose:
'    This file contains functions developed for EP Batch
' Functions:
'    LoadToStagingTable
'==============================================================================

'==============================================================================

Function LogMessage (Message)

' Purpose:
'    This function writes a message to the screen and to a log file specified
'    in the LOGFILE variable
' Inputs:
'    Message = Message to be logged
' Outputs:

'==============================================================================
	
	on error resume next
	
	set objLogFile = goFso.OpenTextFile(LOGFILE,ForAppending,true) ' create file if it doesn't exist
	if Err.Number <> 0 then
		Wscript.Echo Now & " " & Err.Number & " " & Err.Description
		Wscript.Echo Now & " unable to open logfile " & LOGFILE
	else 
		objLogFile.WriteLine Now & " " & Message 
		objLogFile.Close
	end if
	
	WScript.Echo Now & " " & Message
End Function

'==============================================================================

Function LogError (Message)

' Purpose:
'    This function writes an error message to the screen and to a log file
'    specified in the LOGFILE variable
' Inputs:
'    Message = Message to be logged
' Outputs:
'    Return code
'       0     = No errors
'      -1     = Failed to access log file

'	Dim ERRCODE
'	Dim CONN


'==============================================================================

	LogMessage("ERROR: " & Message)
	
End Function

'==============================================================================

Function LogonCredentials (logonType)

' Purpose:
'    This function returns database logon credentials
' Inputs:
'    Type = S (Structure - JI database)
'           F (Fact - EKB database)
' Outputs:
'    Database connection string


'==============================================================================

	if logonType = "S" then
		LogonCredentials = "EXT/ext@" & DATABASE
	elseif logonType = "L" then
		LogonCredentials = "epadmin/P@ssword01@" & DATABASE
	else
		LogonCredentials = "EKB/ekb@" & DATABASE
	end if
End Function

'==============================================================================

Function WildcardFileExists (directory, filenamePart)

' Purpose:
'    This function checks to see if a file exists in 'directory' with a name 
'    that ends with the string specifiied in 'filenamePart'
' Inputs:
'    directory = the directory to check for the file
'    filenamePart = a string containing the last part of the filename
' Outputs:
'    false = file or directory does not exist
'    true = file exists

	on error resume next
	
	returnCode = "notFound"
	
	set objFolder = goFso.GetFolder(directory) 
	
	if Err.Number <> 0 then
		LogError "Unable to open directory " & directory
	end if
	
	for each objFile in objFolder.Files
		if right(objFile,len(filenamePart)) = filenamePart then 
			returnCode = objFile
		end if 
	next 

	'Clean up! 
	set objFolder = Nothing 
	set objFile = Nothing 

	WildcardFileExists = returnCode
End Function


'==============================================================================

Function StartScript

' Purpose:
'    This function initializes standard variables and writes a standard string 
'    to the logfile. It should be called at the beginning of every script after 
'    the SCRIPTNAME and LOGFILE variables have been set declared
' Inputs:
' Outputs:


'==============================================================================

	SCRIPTNAME = WScript.ScriptName
	SCRIPTNAME_BODY = Left(SCRIPTNAME,InStrRev(SCRIPTNAME,".")-1)
	
	if LOGFILE_JOB="" then
		LOGFILE = LOG_DIRECTORY & GetDayTimestamp & "_" & SCRIPTNAME_BODY & ".log"
	else
		LOGFILE = LOG_DIRECTORY & GetDayTimestamp & "_" & SCRIPTNAME_BODY & "_" & LOGFILE_JOB & ".log"
	end if
	
	LogMessage ""
	LogMessage "==========================================================================="	
	LogMessage ""
	LogMessage SCRIPTNAME & " starting on " & WScript.CreateObject( "WScript.Network" ).ComputerName
	LogMessage ""

End Function

'==============================================================================

Function EndScript(errorCode)

' Purpose:
'    This function writes a standard string to the logfile. It should be called
'    at the end of every script before exiting. This script uses
'    the SCRIPTNAME and LOGFILE variables.
' Inputs: errorCode
' Outputs:


'==============================================================================
	
	computerName = WScript.CreateObject( "WScript.Network" ).ComputerName
	
	if errorCode = 0 then
		LogMessage ""
		LogMessage SCRIPTNAME & " completed successfully on " & computerName
		LogMessage ""
		LogMessage "==========================================================================="	
		LogMessage ""
		WScript.Quit(0)	
	else
		LogMessage ""
		LogMessage "Exiting " & SCRIPTNAME & " with error code " & errorCode & " on " & computerName
		LogMessage ""
		LogMessage "==========================================================================="	
		LogMessage ""
		WScript.Quit(errorCode)			
	end if
End Function

'==============================================================================

Function GetTimestamp 

' Purpose:
'    This function returns a timestamp in the form YYYYMMDDHHMM for use in
'    logfile names etc.
' Inputs:
'    None
' Outputs:
'    returns timestamp string

'==============================================================================
		
	GetTimestamp = Right("0000" & Year(Now),4) _
			& Right("00" & Month(Now),2) _
			& Right("00" & Day(Now),2) _
			& Right("00" & Hour(Now),2) _
			& Right("00" & Minute(Now),2)
End Function

'==============================================================================

Function GetDayTimestamp 

' Purpose:
'    This function returns a timestamp to the day level in the form YYYYMMDD0000 
'    for use in logfile names etc.
' Inputs:
'    None
' Outputs:
'    returns timestamp string

'==============================================================================
		
	GetDayTimestamp = Right("0000" & Year(Now),4) _
			& Right("00" & Month(Now),2) _
			& Right("00" & Day(Now),2) _
			& "0000"
End Function

'==============================================================================

Function CompressFile(filename)

' Purpose:
'    This function compresses a file
' Inputs:
'    full directory path filename
' Outputs:

'==============================================================================

	cFlags = FOF_SILENT + FOF_NOCONFIRMATION + FOF_NOERRORUI
		
	zipFileName = Left(filename, Len(filename)-4) & ".ZIP"
	
	'Create empty ZIP file.
	set zipFile = goFSO.CreateTextFile(zipFileName, True)
	zipFile.Write "PK" & Chr(5) & Chr(6) & String(18, vbNullChar)
	zipFile.Close
	
	set objShell = CreateObject("Shell.Application")

	objShell.NameSpace(zipFileName).CopyHere(filename)
	do until objShell.NameSpace(zipFileName).Items.Count = 1
  		wScript.sleep 1000
	loop
	
	Set objShell = Nothing
	
	goFSO.DeleteFile(filename)
	
	CompressFile = 0
	
End Function

'==============================================================================

Function UncompressFile(directory, filename)

' Purpose:
'    This function uncompresses a file. If the uncompresed file already 
'    exists in the directory it will be overwritten
' Inputs:
'    directory
'    filename
' Outputs:

'==============================================================================
	
	on error resume next
	
	Const FOF_SILENT = &H4&
	Const FOF_RENAMEONCOLLISION = &H8&
	Const FOF_NOCONFIRMATION = &H10&
	Const FOF_ALLOWUNDO = &H40&
	Const FOF_FILESONLY = &H80&
	Const FOF_SIMPLEPROGRESS = &H100&
	Const FOF_NOCONFIRMMKDIR = &H200&
	Const FOF_NOERRORUI = &H400&
	Const FOF_NOCOPYSECURITYATTRIBS = &H800&
	Const FOF_NORECURSION = &H1000&
	Const FOF_NO_CONNECTED_ELEMENTS = &H2000&

	cFlags = FOF_SILENT + FOF_NOCONFIRMATION + FOF_NOERRORUI

	set objShell = CreateObject("Shell.Application")
	set FilesInZip = objShell.NameSpace(directory & filename).Items
	ERRCODE=Err.Number
	ERRDESC=Err.Description
	if ERRCODE <> 0 then
		LogError "Unable to access " & directory & filename
		LogError ERRCODE & " " & ERRDESC
		UncompressFile = ERRCODE
		Set objShell = Nothing
		Exit Function
	end if
	objShell.NameSpace(directory).CopyHere FilesInZip, cFlags
	ERRCODE=Err.Number
	ERRDESC=Err.Description
	if ERRCODE <> 0 then
		LogError "Unable to uncompress files from " & filename & " to " & directory
		LogError ERRCODE & " " & ERRDESC
		Set objShell = Nothing
		UncompressFile = ERRCODE
		Exit Function
	end if
	Set objShell = Nothing
	Set FilesInZip = Nothing
	UncompressFile = 0
	
End Function

'==============================================================================

Function MoveFile(sourceFilename, destinationDirectory)

' Purpose:
'    moves a file to a destination directory
' Inputs:
'    sourceFilename - should include full source directory path
'    destinationDirectory
' Outputs:

'==============================================================================

' =============================================================================	
'	If the destination already exists then delete it first
' =============================================================================	
	
	on error resume next
	
	fileName = Right(sourceFilename,Len(sourceFilename)-InStrRev(sourceFilename,"\"))
	
	if goFso.FileExists(destinationDirectory & fileName) then
		LogMessage "Deleting old " & fileName
		goFso.DeleteFile destinationDirectory & fileName
		if Err.Number <> 0 then
			LogError Err.Number & " " & Err.Description
		end if
	end if
		
	goFso.MoveFile sourceFilename, destinationDirectory
	
	if Err.Number <> 0 then
		LogError Err.Number & " " & Err.Description
	end if
	
	MoveFile=Err.Number
	
End Function

'==============================================================================

Function LineCount(filename)

' Purpose:
'    This function counts the number of lines in a file
' Inputs:
'    filename - full path name of a text file
' Outputs:
'    returns number of lines in the file

'==============================================================================
	
	on error resume next
	
	set objLineCountFile = goFso.OpenTextFile(filename, ForReading)	
	ERRCODE=Err.Number
	ERRDESC=Err.Description
	if ERRCODE <> 0 then
		LogError "unable to open " & filename
		LogError ERRCODE & " " & ERRDESC
		Exit Function
	end if
	objLineCountFile.ReadAll
'	LineCount = objLineCountFile.Line-1 (commented out - rco)
	LineCount = objLineCountFile.Line
	objLineCountFile.Close
	
End Function

'==============================================================================

Function StringInFile (searchString, fileName)

' Purpose:
'    This function returns the count of the number of times the string 
'    "searchString" appears in the file pointed to by fileName
' Inputs
'    searchString = text to search for
'    fileName = full path to a file to be searched
' Outputs:
'    number of times string appears

'==============================================================================

	on error resume next
	
	set objFile = goFso.OpenTextFile(fileName,ForReading)
	if Err.Number <> 0 then
		LogError "unable to open " & fileName
		LogError Err.Number &  " " & Err.Description
		exit function
	end if
	
	strFileContents = objFile.ReadAll
	objFile.Close
		
	set regEx = new RegExp
	regEx.pattern = searchString
	set matches = regEx.Execute(strFileContents)
	StringInFile = matches.Count
		
End Function

'==============================================================================

Function CheckConsole 

' Purpose:
'    This function checks that a script is being run in console mode and exits
'    if it is. This function should be called at the beginning of a script
' Inputs
'    None
' Outputs:
'    None

'==============================================================================
	
	On Error Resume Next

	WScript.StdErr.WriteLine("")
	If Err.number <> 0 then 
		WScript.Echo "This script requires console mode. " _
        		& VBCrLf & "Please run it using CScript or set default script host to CScript using ""CScript //H:CScript"" command"
		WScript.Quit(1)
	End If

End Function

'==============================================================================

' ====================================================================
' This function executes process specified in Command parameter and 
' outputs the stdout to the file defined in the LOGFILE.variable
' NOTE: the stderr is also redirected

Function ExecCmdWithLogging(Command, IsEcho)
	
'	On Error Resume Next
	
	Dim oExec
	
	If DebugFunctions Then
		WScript.Echo Command
	End If
	
	Set oExec = goWshShell.Exec( Command )
	
	Do While oExec.Status = 0
			
		If IsEcho = true Then 
			standardOutput = oExec.StdOut.ReadAll
			if standardOutput <> "" then
				LogMessage standardOutput 
			end  if
			errorOutput = oExec.StdErr.ReadAll
			if errorOutput <> "" then
				LogError errorOutput
			end if
		End If
		WScript.Sleep 50
	Loop
	
	Set ExecCmdWithLogging = oExec
	
End Function


'==============================================================================

Function PurgeFiles (directory, retention)

' Purpose:
'    This function deletes all files older than 'retention' days from 'directory'
' Inputs:
'    directory = the directory containing files to be purged
'    retention = number of days old a file has to be to be deleted
' Outputs:
'    none

	on error resume next
	
	set objFolder = goFso.GetFolder(directory) 
	if Err.Number <> 0 then
		LogError "Unable to open directory " & directory
		Exit Function
	end if
	
	for each objFile in objFolder.Files
		dateFileCreated = FormatDateTime(objFile.DateCreated, "2")
		If DateDiff("d", dateFileCreated, Date) > retention Then
			LogMessage "Deleting " & objFile
			KillFile(objFile)
		End If
	next 

	'Clean up! 
	set objFolder = Nothing 
	set objFile = Nothing 

End Function


' =============================================================================	
'	Process each record in the control file
' =============================================================================	

Function ProcessControlFile (controlFile)
	set objConFile = goFso.OpenTextFile(controlFile)
	ERRCODE=Err.Number
	ERRDESC=Err.Description
	if ERRCODE <> 0 then
		LogError "unable to open " & controlFile
		LogError ERRCODE & " " & ERRDESC
		EndScript ERRCODE
	end if

	fileError = false
	rejectedRecords = false
	
	do until objConFile.AtEndOfStream
		
		strLine = trim(objConFile.ReadLine) 
		
		if strLine <> "" then 'skip empty lines 

			lineFields = Split(strLine,"|")
			dataFile = lineFields(0)
			conRecordCount = lineFields(1)

			LogMessage "Processing " & dataFile

			dataFileLength = Len(dataFile)
		
' =============================================================================	
'			Uncompress the DAT file
' =============================================================================	
		
			zipFile = Left(dataFile, dataFileLength-3) & "ZIP"
			LogMessage "Uncompressing " & zipFile
			if UncompressFile(inputSource, zipFile) <> 0 then
				LogError "Failed to process " & zipFile
				fileError = true
			else

' =============================================================================	
'				Verify number of records in the DAT file
' =============================================================================	
		
				datRecordCount = LineCount(inputSource & dataFile)-1 'header row is not counted
				if StrComp(datRecordCount,conRecordCount) <> 0 then
					LogError "Record count for " & dataFile & " (" & datRecordCount & ") " & _
					         "does not match CTL file.(" & conRecordCount & ")"
					fileError = true
				else
			
' =============================================================================	
'					Edit the sqlldr CTL file
' =============================================================================	

					tableName = Right(Left(dataFile,dataFileLength-4),dataFileLength-17)
					ctlFile = CTLFILE_DIRECTORY & tableName & ".CTL"
					sqlldrLogFile = LOG_DIRECTORY & Left(dataFile,dataFileLength-4) & "_SQLLDR.LOG"
					badFile =  Left(dataFile,dataFileLength-3) & "BAD"

					LogMessage "Editing " & ctlFile

					set objCtlFile = goFso.OpenTextFile(ctlFile,ForReading)
					if Err.Number <> 0 then
						LogError "unable to open " & ctlFile
						fileError = true
					else
						strText = objCtlFile.ReadAll
						objCtlFile.Close

						set regEx = new RegExp
						regEx.pattern = "INFILE .*"
						strText = regEx.replace(strText, "INFILE '" & inputSource & dataFile & "'")
						regEx.pattern = "BADFILE .*"
						strText = regEx.replace(strText, "BADFILE '" & ERRORFILE_DIRECTORY & badFile & "'")

						set objCtlFile = goFso.OpenTextFile(ctlFile,ForWriting)

						objCtlFile.WriteLine strText 

						objCtlFile.Close	

' =============================================================================	
'						load the data using sqlldr
' =============================================================================	
		
						LogMessage "Beginning load of " & dataFile
						set oExec = ExecCmdWithLogging("sqlldr " & logonCreds & " control=" & ctlFile & " log=" & sqlldrLogFile, true)
						ERRCODE=oExec.ExitCode
						if ERRCODE <> 0 then
							LogError "Data load for " & dataFile & " failed. "
							LogError "See " & sqlldrLogFile & " for more details. "
							if FileExists(ERRORFILE_DIRECTORY & badFile) then
								LogError "See " & ERRORFILE_DIRECTORY & badFile & " for rejected records. "

' =============================================================================	
'								Check thresholds to determine if batch should fail
' =============================================================================	
							
								rejectedRecords = LineCount(ERRORFILE_DIRECTORY & badFile)
								recordsRejected = true
								LogError rejectedRecords & " records rejected"
								if goStrucThresholds.Item(tableName) <> -1 then
									if goStrucThresholds.Item(tableName) < rejectedRecords then
										LogError "Threshold exceeded - Failing script"
										fileError = true
									else
										rejectedRecords = true
									end if
								end if
							else
								fileError = true
							end if
						else
							LogMessage "Data loaded successfully for " & dataFile

' =============================================================================	
'							Archive the ZIP file and clean up the DAT file
' =============================================================================	

							LogMessage "Moving " & zipFile & " to " & archiveDirectory
							MoveFile inputSource & zipFile, archiveDirectory
							LogMessage "Deleting " & dataFile
							KillFile inputSource & dataFile
							LogMessage "Successfully processed " & zipFile
						end if ' sqlldr
					end if ' open ctl file
				end if ' record count
			end if ' uncompress file
			LogMessage ""
		end if ' skip empty lines
	loop
	
	objConFile.Close
	
	errorCode = 0
	
	if fileError then
		LogError "Error processing one or more files"
		errorCode = -3
	elseif rejectedRecords then
		LogMessage "WARNING: some records were rejected but less than threshold amount."
		errorCode = 1
	end if
	
' =============================================================================	
'	If script completed successfully, archive the CON file
' =============================================================================	
	if errorCode >= 0 then
		LogMessage "Moving " & controlFile & " to " & archiveDirectory
		MoveFile controlFile, archiveDirectory
	end if

	ProcesscontrolFile = errorCode

End Function