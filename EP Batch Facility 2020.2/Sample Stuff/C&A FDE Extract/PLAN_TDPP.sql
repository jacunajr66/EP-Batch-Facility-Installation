SET HEADING OFF;
SET PAGESIZE 0;
SET WRAP OFF;
SET LINESIZE 10000;
SET TRIMSPOOL ON;
SET TRIMOUT ON;
SET TERMOUT OFF;
SET FEEDBACK OFF;
SPOOL .\FDEOutput\PLAN_TDPP_&&1..csv;
SELECT
'"' || CALENDAR || '";' ||
'"' || ORGANIZATION || '";' ||
'"' || PRODUCT || '";' ||
ROUND(ADJ_CST_TDP1,2) || ';' ||
ROUND(ADJ_CST_TDP2,2) || ';' ||
ROUND(ADJ_UNT_TDP1,2) || ';' ||
ROUND(ADJ_UNT_TDP2,2) || ';' ||
ROUND(BOP_CST_TDP1,2) || ';' ||
ROUND(BOP_CST_TDP2,2) || ';' ||
ROUND(BOP_UNT_TDP1,2) || ';' ||
ROUND(BOP_UNT_TDP2,2) || ';' ||
ROUND(CALBOP_CST_TDP1,2) || ';' ||
ROUND(CALBOP_CST_TDP2,2) || ';' ||
ROUND(CALBOP_UNT_TDP1,2) || ';' ||
ROUND(CALBOP_UNT_TDP2,2) || ';' ||
ROUND(CAOTB_CST_TDP1,2) || ';' ||
ROUND(CAOTB_CST_TDP2,2) || ';' ||
ROUND(CAOTB_UNT_TDP1,2) || ';' ||
ROUND(CAOTB_UNT_TDP2,2) || ';' ||
ROUND(FRT_CST_TDP1,2) || ';' ||
ROUND(FRT_CST_TDP2,2) || ';' ||
ROUND(MDPMD_RTL_TDP1,2) || ';' ||
ROUND(MDPMD_RTL_TDP2,2) || ';' ||
ROUND(MDPOS_RTL_TDP1,2) || ';' ||
ROUND(MDPOS_RTL_TDP2,2) || ';' ||
ROUND(OTB_CST_TDP1,2) || ';' ||
ROUND(OTB_CST_TDP2,2) || ';' ||
ROUND(OTB_UNT_TDP1,2) || ';' ||
ROUND(OTB_UNT_TDP2,2) || ';' ||
ROUND(RECCOM_CST_TDP1,2) || ';' ||
ROUND(RECCOM_CST_TDP2,2) || ';' ||
ROUND(RECCOM_UNT_TDP1,2) || ';' ||
ROUND(RECCOM_UNT_TDP2,2) || ';' ||
ROUND(RECNCOM_CST_TDP1,2) || ';' ||
ROUND(RECNCOM_CST_TDP2,2) || ';' ||
ROUND(RECNCOM_UNT_TDP1,2) || ';' ||
ROUND(RECNCOM_UNT_TDP2,2) || ';' ||
ROUND(SHR_CST_TDP1,2) || ';' ||
ROUND(SHR_CST_TDP2,2) || ';' ||
ROUND(SHR_UNT_TDP1,2) || ';' ||
ROUND(SHR_UNT_TDP2,2) || ';' ||
ROUND(SLSCON_CST_TDP1,2) || ';' ||
ROUND(SLSCON_CST_TDP2,2) || ';' ||
ROUND(SLSCON_RTL_TDP1,2) || ';' ||
ROUND(SLSCON_RTL_TDP2,2) || ';' ||
ROUND(SLSCON_UNT_TDP1,2) || ';' ||
ROUND(SLSCON_UNT_TDP2,2) || ';' ||
ROUND(SLSNXT_EXPC_TDP1,2) || ';' ||
ROUND(SLSNXT_EXPC_TDP2,2) || ';' ||
ROUND(SLSNXT_EXPU_TDP1,2) || ';' ||
ROUND(SLSNXT_EXPU_TDP2,2) || ';' ||
ROUND(SLS_CST_TDP1,2) || ';' ||
ROUND(SLS_CST_TDP2,2) || ';' ||
ROUND(SLS_RTL_TDP1,2) || ';' ||
ROUND(SLS_RTL_TDP2,2) || ';' ||
ROUND(SLS_UNT_TDP1,2) || ';' ||
ROUND(SLS_UNT_TDP2,2) || ';' ||
ROUND(SQM_TDP1,2) || ';' ||
ROUND(SQM_TDP2,2) || '|'
FROM CA_PLAN_TDPP_VIEW;
SPOOL OFF;
EXIT;