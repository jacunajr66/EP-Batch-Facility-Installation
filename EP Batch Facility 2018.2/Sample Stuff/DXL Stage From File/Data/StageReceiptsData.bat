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
REM #     Looks for Receipts data files and stages the contents to the EKB schema.
REM # ==============================================================================

IF "%1" == "" (
   ECHO Usage: [database sid] [history]

   EXIT /B 1
)

SET CONTROLFILE=SQLLDR.ctl
SET DATABASECREDS=ekb/ekb@%1
SET EXPIREDAYS=28
SET FILEPREFIX=PKB_ACTUAL_RECEIPTS_*

SET ARCHIVEDIR=.\Archive
SET BADDIR=.\Bad\
SET DISCARDDIR=.\Discard\
SET LOGDIR=.\Log\
SET DATADIR=.\Archive\Receipts.%DATE:~-2,2%-%DATE:~-10,2%-%DATE:~-7,2%

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
REM #  Search for Receipts data files from host, generate the SQL Loader
REM #     control file and call SQL Loader to stage file contents into EKB schema.
REM # ==============================================================================

FOR %%a IN (%FILEPREFIX%) DO (
   SET TABLE=%%a

   IF "%2" == "history" (
       SET TABLE=!TABLE:~0,-12!
   ) ELSE (
       SET TABLE=!TABLE:~0,-9!
   )

   IF EXIST %CONTROLFILE% (
      DEL %CONTROLFILE%
   )

   ECHO LOAD DATA>>%CONTROLFILE%
   ECHO INFILE '%%a.'>>%CONTROLFILE%
   ECHO BADFILE '%BADDIR%!TABLE!.bad'>>%CONTROLFILE%
   ECHO DISCARDFILE 'DISCARDDIR%!TABLE!.dsc'>>%CONTROLFILE%
   ECHO TRUNCATE INTO TABLE !TABLE!>>%CONTROLFILE%
   ECHO FIELDS TERMINATED BY "|" TRAILING NULLCOLS>>%CONTROLFILE%
   ECHO ^(trans_id,product_name,organization_name,calendar_name,reccom_cst,reccom_rtl,reccom_unt,vtcds_cst,vtcds_rtl,vtcds_unt^)>>%CONTROLFILE%

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

IF NOT EXIST %DATADIR% (
   mkdir %DATADIR%
)

FORFILES /P .\Archive /D -%EXPIREDAYS% /C "cmd /c IF @isdir == TRUE rmdir /S /Q @path" 2>NUL

IF %FILEFOUND% == 1 (
   MOVE /y %FILEPREFIX% %DATADIR%
)