--------------------------------------- 1번 문제 -------------------------------------

SELECT *
  FROM (
        SELECT --+ ORDERED USE_NL(M2) 
        M1.INVOICE_NO, M1.OUTBOUND_NO, M1.OUTBOUND_BATCH, M2.ITEM_CD, M2.ITEM_NM, M2.ORDER_QTY
        FROM LO_OUT_M M1
             JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                             AND M1.OUTBOUND_DATE BETWEEN '2019-09-03' AND '2019-09-10'
                             AND M2.ITEM_NM LIKE '%골뱅이%'
       ORDER BY ORDER_QTY DESC
       )
 WHERE ROWNUM <= 5
 
 -------------------------------------- 2번 문제 ----------------------------------------
 
 SELECT M2.ITEM_CD, M2.ITEM_NM, SUM(M2.ORDER_QTY) AS ORDER_QTY
   FROM LO_OUT_M M1
        JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                         AND M1.OUT_BOX_DIV = 'D5'
        JOIN CM_ITEM C1  ON C1.ITEM_CD = M2.ITEM_CD
                         AND C1.ITEM_NM = M2.ITEM_NM
                         
  WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-03' AND '2019-09-10'
  GROUP BY M2.ITEM_CD, M2.ITEM_NM
  ORDER BY SUM(M2.ORDER_QTY) DESC 
  
 ----------------------------------- 3번 문제 --------------------------------------------                            

 SELECT M1.INVOICE_NO
      ,M1.OUTBOUND_DATE
      ,M1.OUT_TYPE_DIV
      ,M2.LINE_NO
      ,M2.ITEM_CD
      ,M3.ITEM_NM
      ,M2.ORDER_QTY
      ,NVL(S1.CODE_NM,'FAILED...') AS TEMP_NM
      ,NVL(S2.CODE_NM,'FAILED...') AS OUT_TYPE_NM
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2     ON M2.INVOICE_NO = M1.INVOICE_NO
       JOIN CM_ITEM M3      ON M3.ITEM_CD = M2.ITEM_CD 
  LEFT JOIN CS_CODE S1      ON S1.CODE_CD = M1.TEMP_DIV 
                            AND S1.CODE_GRP = 'LDIV011'
  LEFT JOIN CS_CODE S2      ON S2.CODE_CD = M1.OUT_TYPE_DIV 
                            AND S2.CODE_GRP = 'LDIV03'
 WHERE M1.INVOICE_NO IN (346724703834, 346724722535, 346724717915)    
 ORDER BY M1.INVOICE_NO, M2.LINE_NO
 
 -------------------------------- 4번 문제 ------------------------------------------------
 SELECT --+ ORDERED USE_NL(M2)
        D1.OUT_DATE
       ,NVL(SUM(M2.ORDER_QTY),'0') AS QTY
   FROM (
         SELECT LEVEL + TO_DATE('2019-08-31', 'YYYY-MM-DD') AS OUT_DATE  
           FROM DUAL 
        CONNECT BY LEVEL<= 19
        ) D1
   LEFT JOIN LO_OUT_M M1 ON M1.OUTBOUND_DATE = D1.OUT_DATE 
   LEFT JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 GROUP BY D1.OUT_DATE
 ORDER BY D1.OUT_DATE      
 
 -- WHERE M1.OUTBOUND_DATE BETWEEN TO_DATE(TO_CHAR(:TODAY, 'YYYYMM') || '01', 'YYYYY-MM-DD') AND :TODAY


SELECT LEVEL + TO_DATE('2019-08-31', 'YYYY-MM-DD') AS OUT_DATE  
  FROM DUAL 
CONNECT BY LEVEL<= 19


SELECT NO
  FROM CS_NO
 WHERE NO <= :OUT_DATE2 - :OUT_DATE1 + 1
 
SELECT :OUT_DATE2 - :OUT_DATE1 + 1
  FROM DUAL
  
SELECT TO_DATE('20190901', 'YYYY-MM-DD') + NO -1, NO
  FROM CS_NO
 WHERE NO <= TO_DATE('20190919', 'YYYY-MM-DD') - TO_DATE('20190901', 'YYYY-MM-DD') + 1 
 
 
SELECT M1.OUTBOUND_DATE
      ,NVL(M2.SUM_QTY, 0) AS SUM_QTY 
  FROM (
       SELECT TO_DATE('20190901', 'YYYY-MM-DD') + NO -1, NO
         FROM CS_NO
        WHERE NO <= TO_DATE('20190919', 'YYYY-MM-DD') - TO_DATE('20190901', 'YYYY-MM-DD') + 1 
       ) M1
  LEFT JOIN(
            SELECT --+ ORDERED USE NL(M2)
                  M1.OUTBOUND_DATE
                 ,SUM(M2.ORDER_QTY) AS SUM_QTY
              FROM LO_OUT_M M1
                   JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
             WHERE M1.OUTBOUND_DATE BETWEEN TO_DATE('20190901', 'YYYY-MM-DD') AND TO_DATE('20190919', 'YYYY-MM-DD')
             GROUP BY M1.OUTBOUND_DATE         
           ) M2 ON M2.OUTBOUND_DATE = M1.OUTBOUND_DATE                 
                                               