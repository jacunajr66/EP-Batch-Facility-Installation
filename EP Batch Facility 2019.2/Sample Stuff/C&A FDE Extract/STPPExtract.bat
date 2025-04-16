echo off

SET TABLEFILE=.\FDEOutput\PLAN_STPP_%4.tbl

echo CALENDAR;1 > %TABLEFILE%
echo ORGANIZATION;2 >> %TABLEFILE%
echo PRODUCT;3 >> %TABLEFILE%
echo AVGINV_CST_STP2;4 >> %TABLEFILE%
echo AVGINV_CST_STPP;5 >> %TABLEFILE%
echo GM_STP2;6 >> %TABLEFILE%
echo GM_STPP;7 >> %TABLEFILE%
echo SLSCOMP_RTL_STP2;8 >> %TABLEFILE%
echo SLSCOMP_RTL_STPP;9 >> %TABLEFILE%
echo SLSNCOMP_RTL_STP2;10 >> %TABLEFILE%
echo SLSNCOMP_RTL_STPP;11 >> %TABLEFILE%
echo SLS_CST_STP2;12 >> %TABLEFILE%
echo SLS_CST_STPP;13 >> %TABLEFILE%
echo SLS_UNT_STP2;14 >> %TABLEFILE%
echo SLS_UNT_STPP;15 >> %TABLEFILE%

sqlplus -L -S %1/%2@%3 @PLAN_STPP.sql %4

echo %4 > .\FDEOutput\PLAN_STPP_%4.done