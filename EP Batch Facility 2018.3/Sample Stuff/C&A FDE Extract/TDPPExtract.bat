echo off

SET TABLEFILE=.\FDEOutput\PLAN_TDPP_%4.tbl

echo CALENDAR;1 > %TABLEFILE%
echo ORGANIZATION;2 >> %TABLEFILE%
echo PRODUCT;3 >> %TABLEFILE%
echo ADJ_CST_TDPP;4 >> %TABLEFILE%
echo ADJ_CST_TDP2;5 >> %TABLEFILE%
echo ADJ_UNT_TDPP;6 >> %TABLEFILE%
echo ADJ_UNT_TDP2;7 >> %TABLEFILE%
echo BOP_CST_TDPP;8 >> %TABLEFILE%
echo BOP_CST_TDP2;9 >> %TABLEFILE%
echo BOP_UNT_TDPP;10 >> %TABLEFILE%
echo BOP_UNT_TDP2;11 >> %TABLEFILE%
echo CALBOP_CST_TDPP;12 >> %TABLEFILE%
echo CALBOP_CST_TDP2;13 >> %TABLEFILE%
echo CALBOP_UNT_TDPP;14 >> %TABLEFILE%
echo CALBOP_UNT_TDP2;15 >> %TABLEFILE%
echo CAOTB_CST_TDPP;16 >> %TABLEFILE%
echo CAOTB_CST_TDP2;17 >> %TABLEFILE%
echo CAOTB_UNT_TDPP;18 >> %TABLEFILE%
echo CAOTB_UNT_TDP2;19 >> %TABLEFILE%
echo FRT_CST_TDPP;20 >> %TABLEFILE%
echo FRT_CST_TDP2;21 >> %TABLEFILE%
echo MDPMD_RTL_TDPP;22 >> %TABLEFILE%
echo MDPMD_RTL_TDP2;23 >> %TABLEFILE%
echo MDPOS_RTL_TDPP;24 >> %TABLEFILE%
echo MDPOS_RTL_TDP2;25 >> %TABLEFILE%
echo OTB_CST_TDPP;26 >> %TABLEFILE%
echo OTB_CST_TDP2;27 >> %TABLEFILE%
echo OTB_UNT_TDPP;28 >> %TABLEFILE%
echo OTB_UNT_TDP2;29 >> %TABLEFILE%
echo RECCOM_CST_TDPP;30 >> %TABLEFILE%
echo RECCOM_CST_TDP2;31 >> %TABLEFILE%
echo RECCOM_UNT_TDPP;32 >> %TABLEFILE%
echo RECCOM_UNT_TDP2;33 >> %TABLEFILE%
echo RECNCOM_CST_TDPP;34 >> %TABLEFILE%
echo RECNCOM_CST_TDP2;35 >> %TABLEFILE%
echo RECNCOM_UNT_TDPP;36 >> %TABLEFILE%
echo RECNCOM_UNT_TDP2;37 >> %TABLEFILE%
echo SHR_CST_TDPP;38 >> %TABLEFILE%
echo SHR_CST_TDP2;39 >> %TABLEFILE%
echo SHR_UNT_TDPP;40 >> %TABLEFILE%
echo SHR_UNT_TDP2;41 >> %TABLEFILE%
echo SLSCON_CST_TDPP;42 >> %TABLEFILE%
echo SLSCON_CST_TDP2;43 >> %TABLEFILE%
echo SLSCON_RTL_TDPP;44 >> %TABLEFILE%
echo SLSCON_RTL_TDP2;45 >> %TABLEFILE%
echo SLSCON_UNT_TDPP;46 >> %TABLEFILE%
echo SLSCON_UNT_TDP2;47 >> %TABLEFILE%
echo SLSNXT_EXPC_TDPP;48 >> %TABLEFILE%
echo SLSNXT_EXPC_TDP2;49 >> %TABLEFILE%
echo SLSNXT_EXPU_TDPP;50 >> %TABLEFILE%
echo SLSNXT_EXPU_TDP2;51 >> %TABLEFILE%
echo SLS_CST_TDPP;52 >> %TABLEFILE%
echo SLS_CST_TDP2;53 >> %TABLEFILE%
echo SLS_RTL_TDPP;54 >> %TABLEFILE%
echo SLS_RTL_TDP2;55 >> %TABLEFILE%
echo SLS_UNT_TDPP;56 >> %TABLEFILE%
echo SLS_UNT_TDP2;57 >> %TABLEFILE%
echo SQM_TDPP;58 >> %TABLEFILE%
echo SQM_TDP2;59 >> %TABLEFILE%

sqlplus -L -S %1/%2@%3 @PLAN_TDPP.sql %4

echo %4 > .\FDEOutput\PLAN_TDPP_%4.done