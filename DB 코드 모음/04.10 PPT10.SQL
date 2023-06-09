-------------------------------------------------- 실전 문제1 ------------------------------------------

SELECT M1.INVOICE_NO, M1.OUTBOUND_DATE, M1.OUT_TYPE_DIV, M2.LINE_NO, M2.ITEM_CD, M3.ITEM_NM, M2.ORDER_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
       JOIN CM_ITEM M3 ON M3.ITEM_CD = M2.ITEM_CD
 WHERE M1.INVOICE_NO IN (346724703834, 346724722535, 346724717915)
 ORDER BY M1.INVOICE_NO, M2.LINE_NO
 
-------------------------------------------------- 실전 문제2 -------------------------------------------- 
 
SELECT M1.INVOICE_NO
      ,M1.OUTBOUND_DATE
      ,M1.OUT_TYPE_DIV
      ,M2.LINE_NO
      ,M2.ITEM_CD
      ,M3.ITEM_NM
      ,M2.ORDER_QTY
      ,S1.CODE_NM AS TEMP_NM
      ,S2.CODE_NM AS OUT_TYPE_NM
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
       JOIN CM_ITEM M3 ON M3.ITEM_CD = M2.ITEM_CD 
       JOIN CS_CODE S1 ON S1.CODE_CD = M1.TEMP_DIV 
                       AND S1.CODE_GRP = 'LDIV01'
       JOIN CS_CODE S2 ON S2.CODE_CD = M1.OUT_TYPE_DIV 
                       AND S2.CODE_GRP = 'LDIV03'
 WHERE M1.INVOICE_NO IN (346724703834, 346724722535, 346724717915)    
 ORDER BY M1.INVOICE_NO, M2.LINE_NO             