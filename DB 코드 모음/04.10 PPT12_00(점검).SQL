----------------------------------------------- 1번 문제 ---------------------------------

SELECT OUTBOUND_DATE, INVOICE_NO, WORK_SEQ
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-06-03' AND '2019-06-04'
   AND SET_TYPE_CD = '000581225'
   AND SET_QTY = 3
 ORDER BY CASE :SORT_TYPE WHEN '1' THEN WORK_SEQ
                          WHEN '2' THEN -WORK_SEQ
          END               
         ,INVOICE_NO
         
----------------------------------------------- 2번 문제 --------------------------------------- 
         
SELECT INVOICE_NO, LINE_NO, ITEM_NM
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724704405'
 ORDER BY CASE :SORT_TYPE WHEN 1 THEN ITEM_NM END ASC
         ,CASE :SORT_TYPE WHEN 2 THEN ITEM_NM END DESC                                            