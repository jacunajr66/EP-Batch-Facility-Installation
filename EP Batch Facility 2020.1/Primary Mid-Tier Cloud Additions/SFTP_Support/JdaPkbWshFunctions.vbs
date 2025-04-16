' COPYRIGHT 2004 - 2013 JDA SOFTWARE INC.,  SCOTTSDALE,  AZ 
'
' This file contain a library of VBScript function for the WSH scripts

' VBScript constants for file operations
Option Explicit

Const ForReading = 1, ForWriting = 2, ForAppending = 8
Const CollationReplacedFileSuffix = ".collation_replaced.mssql"
Const ValidCollation1 = "SQL_Latin1_General_CP1_CI"
Const ValidCollation2 = "Latin1_General_CI"
Const ValidCodePage1 = "SQL_Latin1_General_CP1"
Const ValidCodePage2 = "Latin1_General"
Const CollationSuffix = "_CS_AS"

' Global objects used by this script
Dim goFso
Dim goWshShell
Dim goWshSysEnv
Dim goWshUserEnv
Dim goWshProcEnv
Dim goExec
Dim CIM_ROOT
Dim DebugFunctions

Set goFso = CreateObject("Scripting.FileSystemObject")
Set goWshShell = CreateObject("WScript.Shell")
Set goWshSysEnv = goWshShell.Environment("System")
Set goWshUserEnv = goWshShell.Environment("USER")
Set goWshProcEnv = goWshShell.Environment("Process")

' ====================================================================
' This function executes process specified in Command parameter and 
' outputs the stdout to the console.
' NOTE: the stderr is not redirected
Function ExecCmd(Command, IsEcho)
    Dim oExec
    
    If DebugFunctions Then
    	WScript.Echo Command
    End If
    
    Set oExec = goWshShell.Exec( Command )

    Do While oExec.Status = 0
        If IsEcho = true Then 
            WScript.Echo oExec.StdOut.ReadAll
        End If
        WScript.Sleep 50
    Loop
    
    Set ExecCmd = oExec
    
End Function

' =================================================================================================
' This function checks if specifed folder exists
Function FolderExists( Folder )
    FolderExists = goFso.FolderExists(Folder)
End Function

' =================================================================================================
' This function checks if specifed folder exists
Function FileExists( File )
    FileExists = goFso.FileExists(File)
End Function

' =================================================================================================
' This function returns environment variable
Function GetEnv(Key)
    GetEnv = goWshProcEnv(Key)
    If GetEnv = VbNullString Then
        GetEnv = goWshUserEnv(Key)
    End If
End Function

' =================================================================================================
' This function returns true if FileCmd can be executed
Function CheckExe(FileCmd)
    On Error Resume Next
    Dim oExec
    CheckExe = false
    Set oExec = ExecCmd(FileCmd, false)
    If 0 = Err.number Then
        CheckExe = true
    End If
End Function

' =================================================================================================
' This function adds double quotes to the full filepath if they needed
Function QuoteFilePath(sFilePath)
    If Instr(sFilePath,"""") = 0 Then
        QuoteFilePath = """" & sFilePath & """"
    Else
        QuoteFilePath = sFilePath
    End If
End Function

' =================================================================================================
' This function removes double quotes from the full filepath if needed
Function UnquoteFilePath(sFilePath)
    If Left(sFilePath,1) = """" AND Right(sFilePath,1) = """" Then
        UnquoteFilePath = Mid( sFilePath, 2, Len(sFilePath) - 2 )
    Else
        UnquoteFilePath = sFilePath
    End If
End Function


' =================================================================================================
' This function creates a folder and returns true it was created successfully
Function CreateFolder(sFolderName)
    On Error Resume Next
    Dim oFolder
    CreateFolder = false
    Set oFolder = goFso.CreateFolder(sFolderName)
    If 0 = Err.number Then
        CreateFolder = true
    End If
End Function

' =================================================================================================
Function GetDir(strPrompt, strDefault)
    Dim CREATE_DIR
    Dim GET_DIR
    Dim REPLY
    Dim rex
    Dim theMatches
    Dim theOtherMatches
    Dim sharePath
    Dim AskCreate
    Dim thirdSlash
    
    Do While true
        
        CREATE_DIR="N"
        GET_DIR = AskForString(strPrompt, strDefault)
        
        If GET_DIR = VbNullString Then 
            GET_DIR = strDefault 
        End If
        
        Select Case GET_DIR
            Case VbNullString 
                WScript.Echo "You must enter a directory name"
            Case Else  
                Set rex = new RegExp
                rex.Pattern = "^[A-Za-z]\:\\"
                Set theMatches = rex.Execute(GET_DIR)
                rex.Pattern = "^\\\\"
                Set theOtherMatches = rex.Execute(GET_DIR)
                If (theMatches.Count + theOtherMatches.Count) = 0  Then
                    WScript.Echo "You must supply a complete path"
                Else
                    If Not FolderExists(GET_DIR) Then
											AskCreate = "Y"
											If theOtherMatches.Count > 0 Then										
												thirdSlash = InStr(3,GET_DIR,"\",1)
												sharePath = Left(GET_DIR,InStr(thirdSlash+1,GET_DIR,"\",1))
												If Not FolderExists(sharePath) Then
													WScript.Echo "Share path " & sharePath & " does not exist or is not accessible"
													' if no share path, they're stuffed
													AskCreate = "N"
												End If
											End If

											If AskCreate = "Y" Then
												Do While true
													REPLY = AskForString("Directory " & GET_DIR & " does not exist, ok to create","Y")
													Select Case REPLY
															Case VbNullString, "Y", "y" 
																	CREATE_DIR="Y"
																	Exit Do
															Case "N", "n" 
																	CREATE_DIR="N"
																	Exit Do
															Case Else 
																	WScript.Echo "Please respond Y or N"
													End Select
												Loop
											End If												
                        
											If CREATE_DIR = "Y" Then 
													If Not FolderExists(goFso.GetParentFolderName(GET_DIR)) Then
														goFso.CreateFolder(goFso.GetParentFolderName(GET_DIR))
													End If
													goFso.CreateFolder(GET_DIR)
													' TODO error handling
													Exit Do
											End If

                    Else
                        Select Case GET_DIR 
                            Case CIM_ROOT & "\bin", CIM_ROOT & "\db" ' TODO use regex?
                                WScript.Echo "This directory is reserved for use by Quartz"
                            Case Else
                                Exit Do
                        End Select
                    End If
                End If
        End Select
    Loop
    
    GetDir = GET_DIR
    
End Function


'# =================================================================================================
'#
'# Define function to elicit Yes or No answer
'#
'# ASKPROMPT Prompt 1 Default
'#
'# returns Y or N
'#
Function AskYesOrNo(ASKPROMPT, DefaultValue)
	
	Dim sReply
	
	Do While True
		WScript.StdOut.Write "   " & ASKPROMPT & " [" & DefaultValue & "] = ? "
		sReply = WScript.StdIn.ReadLine
		Select Case sReply
			 Case VbNullString
			    AskYesOrNo = DefaultValue
    		    Exit Do
			 Case "Y", "y" 
			    AskYesOrNo = "Y"
    		    Exit Do
			 Case "N", "n" 
			    AskYesOrNo = "N"
    		    Exit Do
			 Case Else 
			    WScript.Echo "Please respond Y or N"
		End Select
	Loop

End Function

' =================================================================================================
' Output a timestamped message
'
Function ConLog(str)
	WScript.Echo GetDate() & VbCrLf & "   " & str
End Function


' =================================================================================================
' IssueSQLCMD - executes an MSSQL command
' 
' if errstr not an empty string, issue an error message

Function IssueSQLCMD(ConnectOptions, sqlstr,errstr,usedb)
		Dim rc
		Dim cmdstr

		cmdstr = "sqlcmd " & ConnectOptions & " -Q """ & sqlstr & """ -b -o temp.txt"
		if usedb <> "" Then
			cmdstr = cmdstr & " -d " & usedb
		End If
		
		If DebugFunctions Then
				WScript.Echo "Issuing:" & cmdstr
		End If
		Set goExec = ExecCmd( cmdstr, false)
		rc = goExec.ExitCode
		if rc <> 0 And errstr <> "" Then
				WScript.Echo errstr& " - " & goExec.ExitCode
				WScript.Echo 
				WScript.Echo "Command was: " & VbCrLf & cmdstr
				WScript.Echo
				WScript.Echo "Error message from sqlcmd was:"
				ExecCmd "%comspec% /C type " & goWshShell.CurrentDirectory & " temp.txt ", true
		End If

		
		IssueSQLCMD = rc
End Function

' =================================================================================================
' IssueSQLCMD - executes an MSSQL command
' 
' if errstr not an empty string, issue an error message

Function RunSQLCMDScript(ConnectOptions, scriptfile,errstr,usedb)
		Dim rc
		Dim cmdstr
	
		cmdstr = "sqlcmd " & ConnectOptions & " -i """ & scriptfile & """ -b -o temp.txt"
		if usedb <> "" Then
			cmdstr = cmdstr & " -d " & usedb
		End If
		Set goExec = ExecCmd( cmdstr, false)
		rc = goExec.ExitCode
		if rc <> 0 And errstr <> "" Then
				WScript.Echo errstr& " - " & goExec.ExitCode
				WScript.Echo 
				WScript.Echo "Command was " & cmdstr
				WScript.Echo
				ExecCmd "%comspec% /C type " & goWshShell.CurrentDirectory & " temp.txt ", true
		End If

		
		RunSQLCMDScript = rc
End Function

'=================================================================================================
' Get MS SQL Server collation
'
Function GetMSSQLServerCollation(ConnectOptions)
Dim rc
Dim infile

	rc = IssueSQLCMD(ConnectOptions & " -h -1 ", "SELECT CONVERT (varchar, SERVERPROPERTY('collation'))", "", "")
	Set infile = goFso.OpenTextFile("temp.txt")
	GetMSSQLServerCollation = Trim(infile.ReadLine())
	infile.Close()

End Function


'=================================================================================================
' Is MS SQL Server collation supported by PKB
'
Function IsMSSQLServerCollationSupported(ConnectOptions)
Dim sCollation

	IsMSSQLServerCollationSupported = False

	'#find server collation
	sCollation = GetMSSQLServerCollation(ConnectOptions)
	
	If (InStr(1, sCollation, ValidCollation1, 1) = 1 Or InStr(1, sCollation, ValidCollation2, 1) = 1) Then
		IsMSSQLServerCollationSupported = True
	End If
	
End Function


'=================================================================================================
' Is server collation for Foundation the same as that for Quartz
'
Function IsSameServerCollation(QuartzConnectOptions, FoundationConnectOptions)
Dim qCollation
Dim fCollation

	IsSameServerCollation = False

	'#find server collation
	qCollation = GetMSSQLServerCollation(QuartzConnectOptions)
	fCollation = GetMSSQLServerCollation(FoundationConnectOptions)
	
	If (qCollation = fCollation) Then
		IsSameServerCollation = True
	End If
	
End Function


'=================================================================================================
' Get Column Collation for [n][var]char type
'
Function GetCSColumnCollation(ConnectOptions)
Dim sCollation

	'#find server collation
	sCollation = GetMSSQLServerCollation(ConnectOptions)
	
	If InStr(1, sCollation, ValidCollation1, 1) = 1 Then
		GetCSColumnCollation = CStr(ValidCodePage1) & CStr(CollationSuffix)
	Else 
		If InStr(1, sCollation, ValidCollation2, 1) = 1 Then
			GetCSColumnCollation = CStr(ValidCodePage2) & CStr(CollationSuffix)
		End If
	End If
	
End Function

'=================================================================================================
' Replace default [n][var]char column collation and return the file name
'
Function ReplaceCollationForFile(infilename, ConnectOptions)
Dim cCollation
Dim infile
Dim outfile
Dim outfilename

	'#get column collation
	cCollation = GetCSColumnCollation(ConnectOptions)
	
	If (cCollation = GetDefaultColumnCollation()) Then
		ReplaceCollationForFile = infilename
	Else
		outfilename = infilename & CollationReplacedFileSuffix
		Set infile = goFso.OpenTextFile(infilename, ForReading)
		Set outfile = goFso.OpenTextFile(outfilename, ForWriting, True)
		outfile.Write(Replace(infile.ReadAll(), GetDefaultColumnCollation(), cCollation))
		outfile.Close()
		ReplaceCollationForFile = outfilename
	End If
	
End Function

Function GetDefaultColumnCollation()
	GetDefaultColumnCollation = CStr(ValidCodePage1) & CStr(CollationSuffix)
End Function


'=================================================================================================
' Copy a file even if destination file exists and is read-only
Sub CopyFileClean(from_filename,to_filename)
	If DebugFunctions Then
			WScript.Echo  "CopyFileClean(" & from_filename & ", " & to_filename & ")"
	End If

	KillFile(to_filename)
	goFso.CopyFile from_filename, to_filename
End Sub


'=================================================================================================
' Delete file if it exists, even if it is read only
Sub KillFile(filename)
	Dim f
	If goFso.FileExists(filename) Then
		Set f= goFso.GetFile(filename)
		' clear any read-only bit that might be set
		f.Attributes =   f.Attributes And (Not 1) 
		goFso.DeleteFile(filename)
	End If
End Sub


'=================================================================================================
' Delete a directory if it exists
Sub KillDir(dirname)
	If DebugFunctions Then
			WScript.Echo "KillDir(" & dirname & ")"
	End If

	If goFso.FolderExists(dirname) Then
		goFso.DeleteFolder dirname, true
	End If
End Sub


' =================================================================================================
Function GetMSSQLServer(forq)

		Dim Done
		Dim connection
		Dim Pos
		Dim OK_WITH_SPLIT
		

		Done = "N"
		Do While Done <> "Y"
			connection = AskForString(forq & " SQL Server server (or server\instance)",ComputerName)

			pos = InStr(connection,"\")
			If pos > 0 Then
				ServerName = Left(connection,pos-1)
			Else
				ServerName = connection
			End If

			If UCase(ServerName) <> UCase(ComputerName) Then
				OK_WITH_SPLIT = AskYesOrNo("Database server is not the current server, are you sure","Y")
				SPLIT_DEPLOY = "Y"
				If OK_WITH_SPLIT = "Y" Then
					 Done = "Y"
				End If
			Else
				SPLIT_DEPLOY = "N"
				Done = "Y"
			End If
		Loop

		GetMSSQLServer = connection

End Function


SUb SplitDeployBlather

							WScript.Echo VbCrLf 
								WScript.Echo "This is known as 'Split Deployment'.  The 'EKBF Installation Guide' has "
								WScript.Echo "additional information about how split deployments work.  Prompts for "
								WScript.Echo "directories that follow will indicate whether the directory path is on the"
								WScript.Echo "current, server process 'SP' server machine, or on the database 'DB' server"
								WScript.Echo "machine.  In some cases you'll need to supply a UNC file path that works"
								WScript.Echo "for both server machines.  (A UNC path is one that starts \\myserver\...)"
								WScript.Echo "For the following:"
								WScript.Echo "  " & PathHint_SP & " - Enter a path on the local, server process server machine "
								WScript.Echo "  " & PathHint_DB & " - Enter a path on the databse server machine "
								WScript.Echo "  " & PathHint_UNCDB & " - Enter a UNC path to a directory on the database server "
								WScript.Echo "  " & "       " & "   machine, accessible from the server process server machine "
End Sub								