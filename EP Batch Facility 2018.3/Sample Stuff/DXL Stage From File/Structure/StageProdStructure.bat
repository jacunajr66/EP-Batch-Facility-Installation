@ECHO OFF

SETLOCAL ENABLEDELAYEDEXPANSION

REM # 
REM #  Created by John Acuna Version 1.0.0.0 on 11/2/2016
REM #  
REM #  Revision History
REM #
REM #  Version   Author           Comments
REM # 
REM # ==============================================================================
REM #  Purpose:
REM #     Looks for structure data files and stages the contents to the EXT schema.
REM # ==============================================================================

IF "%1" == "" (
   ECHO Usage: [database sid]

   EXIT /B 1
)

SET CONTROLFILE=SQLLDR.ctl
SET DATABASECREDS=ext/ext@%1
SET EXPIREDAYS=28
SET FILEPREFIX=AG_1_*

SET ARCHIVEDIR=.\Archive
SET BADDIR=.\Bad\
SET DISCARDDIR=.\Discard\
SET LOGDIR=.\Log\
SET STRUCTUREDIR=.\Archive\ProdStructure.%DATE:~-2,2%-%DATE:~-10,2%-%DATE:~-7,2%

SET FILEFOUND=0

REM # ==============================================================================
REM #  Create working directories referenced in SQL Loader control file.
REM # ==============================================================================

IF NOT EXIST %BADDIR% (
   MKDIR %BADDIR%
)

IF NOT EXIST %DISCARDDIR% (
   MKDIR %DISCARDDIR%
)

IF NOT EXIST %LOGDIR% (
   MKDIR %LOGDIR%
)

REM # ==============================================================================
REM #  Search for Structure data files from host, generate the SQL Loader
REM #     control file and call SQL Loader to stage file contents into EXT schema.
REM # ==============================================================================

FOR %%a IN (%FILEPREFIX%) DO (
   SET TABLE=%%a
   SET TABLE=!TABLE:~0,-9!

   IF EXIST %CONTROLFILE% (
      DEL %CONTROLFILE%
   )

   ECHO LOAD DATA>>%CONTROLFILE%
   ECHO INFILE '%%a.'>>%CONTROLFILE%
   ECHO BADFILE '%BADDIR%!TABLE!.bad'>>%CONTROLFILE%
   ECHO DISCARDFILE 'DISCARDDIR%!TABLE!.dsc'>>%CONTROLFILE%
   ECHO TRUNCATE INTO TABLE !TABLE!>>%CONTROLFILE%
   ECHO FIELDS TERMINATED BY "|" TRAILING NULLCOLS>>%CONTROLFILE%
   ECHO ^(inputsequence,actioncode,current_id,id,parent_member_id,member_tech_key,messageid,messagetext,culture_name,short_description,long_description,matching_key,planningid^)>>%CONTROLFILE%

   sqlldr userid=%DATABASECREDS% control=%CONTROLFILE% log=%LOGDIR%!TABLE!.log

   SET FILEFOUND=1
)

IF EXIST %CONTROLFILE% (
   DEL %CONTROLFILE%
)

REM # ==============================================================================
REM #  Create archive directories, delete expired archives and archive host
REM #     files.
REM # ==============================================================================

IF NOT EXIST %ARCHIVEDIR% (
   mkdir %ARCHIVEDIR%
)

IF NOT EXIST %STRUCTUREDIR% (
   mkdir %STRUCTUREDIR%
)

FORFILES /P .\Archive /D -%EXPIREDAYS% /C "cmd /c IF @isdir == TRUE rmdir /S /Q @path" 2>NUL

IF %FILEFOUND% == 1 (
   MOVE /y %FILEPREFIX% %STRUCTUREDIR%
)