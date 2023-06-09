---------------------------------------------------- 1번 문제 ----------------------------------------------------------

-- 직계함수 + OVER -> 분석함수 : GROUP BY를 필요로 하지 않음
SELECT INVOICE_NO, LINE_NO, ITEM_CD, ITEM_NM, ORDER_QTY
      ,SUM(ORDER_QTY) OVER(PARTITION BY INVOICE_NO ORDER BY LINE_NO) AS ACC_ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO IN ('346724703845', '346724706214') 
 
 
---------------------------------------------------- 3번 문제 ---------------------------------------------------------

SELECT L1.INVOICE_NO
      ,L1.LINE_NO
      ,L1.ITEM_CD
      ,L1.ITEM_NM
      ,L1.ORDER_QTY AS ER_QTY
      ,L2.ORDER_QTY AS LO_QTY
  FROM (
        SELECT INVOICE_NO, LINE_NO, ITEM_CD, ITEM_NM, ORDER_QTY
          FROM ER_OUT
         WHERE OUTBOUND_DATE = :OUTBOUND_DATE
           AND OUTBOUND_BATCH = :OUTBOUND_BATCH
           AND ITEM_NM LIKE '%한입떡갈비%'
       ) L1
  LEFT JOIN (
             SELECT M2.INVOICE_NO, M2.LINE_NO, M2.ITEM_CD, M2.ITEM_NM, M2.ORDER_QTY
               FROM LO_OUT_M M1
                    JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                                    AND M2.ITEM_NM LILKE '%한입떡갈비%'
              WHERE M1.OUTBOUND_DATE = :OUTBOUND_DATE
                AND M1.OUTBOUND_BATCH = :OUTBOUND_BATCH                      
            ) L2 ON L2.INVOICE_NO = L1.INVOICE_NO
                AND L2.LINE_NO = L1.LINE_NO
  WHERE L2.INVOICE_NO IS NULL
  ORDER BY L1.INVOICE_NO
          ,L1.LINE_NO                       