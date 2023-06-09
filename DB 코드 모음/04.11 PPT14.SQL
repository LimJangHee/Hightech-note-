--------------------------------------------- 1번 문제 --------------------------------------------

SELECT DAYY
      ,OUTBOUND_DATE
      ,TO_NUMBER(SUBSTR(MAX, 1, 8)) AS ORDER_QTY
  FROM(
       SELECT DAYY
             ,OUTBOUND_DATE
             ,MAX(LPAD(ORDER_QTY, 8, '0') || TO_CHAR(OUTBOUND_DATE)) AS MAX 
       FROM(
            SELECT --+ ORDERED USE_NL(M2)
                  TO_CHAR(M1.OUTBOUND_DATE,'DY') AS DAYY, M1.OUTBOUND_DATE, SUM(M2.ORDER_QTY) AS ORDER_QTY
              FROM LO_OUT_M M1
                   JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
             WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'     
             GROUP BY TO_CHAR(M1.OUTBOUND_DATE,'DY'), TO_CHAR(M1.OUTBOUND_DATE, 'D'), M1.OUTBOUND_DATE
             ORDER BY TO_CHAR(M1.OUTBOUND_DATE, 'D') 
           )
       GROUP BY DAYY, OUTBOUND_DATE, TO_CHAR(OUTBOUND_DATE, 'D')
       ORDER BY TO_CHAR(OUTBOUND_DATE, 'D')
      )
      
---------------------------------------------------- 풀이 ----------------------------------------------------
      
SELECT DAYY
      ,TO_DATE(SUBSTR(VAL, 10, 8), 'YYYY-MM-DD') AS OUT_DATE
      ,TO_NUMBER(SUBSTR(VAL, 1, 8)) AS SUM_QTY
  FROM (
         SELECT DAYY, D
               ,MAX(LPAD(SUM_QTY, 8, '0') || TO_CHAR(OUTBOUND_DATE, 'YYYYMMDD')) VAL
           FROM (
                 SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
                        TO_CHAR(M1.OUTBOUND_DATE, 'DY') AS DAYY
                       ,TO_CHAR(M1.OUTBOUND_DATE, 'D')  AS D 
                       ,M1.OUTBOUND_DATE
                       ,SUM(M2.ORDER_QTY) AS SUM_QTY
                   FROM LO_OUT_M M1
                        JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                  WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
                  GROUP BY M1.OUTBOUND_DATE
                  ORDER BY TO_CHAR(M1.OUTBOUND_DATE, 'DY')   
                )
          GROUP BY DAYY,D 
       )
 ORDER BY D
 
 --------------------------------------------------- 2번 문제 -------------------------------------------------------
 SELECT MAX(QTY) AS MAX_QTY
       ,MIN(QTY) AS MIN_QTY
       ,TRUNC(AVG(QTY)) AS AVG_QTY
   FROM (
         SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
                M1.OUTBOUND_DATE
               ,SUM(M2.ORDER_QTY) AS QTY
           FROM LO_OUT_M M1
                JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
          WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-03' AND '2019-09-10'
          GROUP BY M1.OUTBOUND_DATE  
        ) 
        
SELECT LEVEL + TO_DATE('2019-09-02' 'YYYY-MM-DD') AS OUT_DATE
  FROM DUAL
CONNECT BY LEVEL 20 

SELECT M1.OUTBOUND_DATE
      ,SUM(M2.ORDER_QTY) AS QTY
  FROM (
        SELECT LEVEL + TO_DATE('2019-09-02' 'YYYY-MM-DD') AS OUT_DATE
         FROM DUAL
       CONNECT BY LEVEL 20    
       ) D1
       JOIN LO_OUT_M M1 ON M1.OUTBOUND_DATE = D1.OUT_DATE
        AND LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
  WHERE EXISTS (SELECT 1
  
----------------------------------------------------- 풀이 ------------------------------------------
SELECT MAX(SUM_QTY) AS MAX_QTY
      ,MIN(SUM_QTY) AS MIN_QTY
      ,TRUNC(AVG(SUM_QTY)) AS AVG_QTY
  FROM (
       SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
              M1.OUTBOUND_DATE
             ,SUM(M2.ORDER_QTY) AS SUM_QTY
         FROM LO_OUT_M M1
              JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
        WHERE M1.OUTBOUND_DATE IN (
                                   SELECT STD_DATE
                                     FROM (
                                          SELECT NO, TO_DATE('20190903', 'YYYY-MM-DD') + NO - 1 AS STD_DATE
                                            FROM CS_NO
                                           WHERE NO <= 10  
                                          ) M1
                                     WHERE EXISTS (
                                                   SELECT 1
                                                     FROM LO_OUT_M S1
                                                    WHERE S1.OUTBOUND_DATE = M1.STD_DATE 
                                                  )
                                       AND ROWNUM <= 7
                                   )
         GROUP BY M1.OUTBOUND_DATE 
         )            
     
SELECT STD_DATE
  FROM (
       SELECT NO, TO_DATE('20190903', 'YYYY-MM-DD') + NO - 1 AS STD_DATE
         FROM CS_NO
        WHERE NO <= 10  
       ) M1
  WHERE EXISTS (
                SELECT 1
                  FROM LO_OUT_M S1
                 WHERE S1.OUTBOUND_DATE = M1.STD_DATE 
               )
    AND ROWNUM <= 7                          
           
------------------------------------------------------------ 3번 문제 -----------------------------------------
SELECT ITEM_CD
      ,TO_DATE(SUBSTR(MAX, 4, 8), 'YYYY-MM-DD') AS MAX_DATE
      ,SUBSTR(MAX, 1, 3) AS MAX_BATCH
  FROM (
        SELECT ITEM_CD
            ,MAX(OUTBOUND_BATCH || TO_CHAR(OUTBOUND_DATE, 'YYYYMMDD')) AS MAX
        FROM (
              SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
                   M2.ITEM_CD, M1.OUTBOUND_DATE, M1.OUTBOUND_BATCH
              FROM LO_OUT_M M1
                   JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
              WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-19'
                AND M2.ITEM_CD IN ('30500', '73510')
             )
       GROUP BY ITEM_CD
       )
       
--------------------------------------------------------- 풀이 ---------------------------------------------

SELECT ITEM_CD
      ,SUBSTR(VAL, 5, 8) AS MAX_DATE
      ,DECODE(SUBSTR(VAL, 1, 3), 'ZZZ', '001', SUBSTR(VAL, 1, 3) AS MAX_BATCH -- ZZZ로 치환된 값을 다시 001로 되돌림 
  FROM (
        SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
              M2.ITEM_CD
             ,MAX(DECODE(M1.OUTBOUND_BATCH, '001', 'ZZZ', M1.OUTBOUND_BATCH) || TO_CHAR(M1.OUTBOUND_DATE, 'YYYYMMDD')) AS VAL --001 일경우 ZZZ로 치환  
         FROM LO_OUT_M M1
              JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                              AND M2.ITEM_CD IN ('30500', '73510')
        WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-19'
        GROUP BY M2.ITEM_CD
       )



SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
       M2.ITEM_CD
      ,MAX(DECODE(M1.OUTBOUND_BATCH, '001', 'ZZZ', M1.OUTBOUND_BATCH) || TO_CHAR(M1.OUTBOUND_DATE, 'YYYYMMDD')) AS VAL 
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                       AND M2.ITEM_CD IN ('30500', '73510')
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-19'
 GROUP BY M2.ITEM_CD 
 
 
                            
----------------------------------------------------- 4번 문제 --------------------------------------------------------

SELECT WEEK_OF_YEAR
      ,ORDER_QTY
      ,CASE WHEN ORDER_QTY >= 900000 THEN 'A'
            WHEN ORDER_QTY >= 800000 THEN 'B'
            WHEN ORDER_QTY >= 700000 THEN 'C'
            WHEN ORDER_QTY >= 600000 THEN 'D'
            ELSE 'F'
        END AS GRADE    
  FROM (
        SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
               TO_CHAR(M1.OUTBOUND_DATE, 'IW') AS WEEK_OF_YEAR
              ,SUM(M2.ORDER_QTY) AS ORDER_QTY
          FROM LO_OUT_M M1
               JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
         WHERE M1.OUTBOUND_DATE BETWEEN '2019-01-01' AND '2019-12-31'
         GROUP BY TO_CHAR(M1.OUTBOUND_DATE, 'IW')
         ORDER BY TO_CHAR(M1.OUTBOUND_DATE, 'IW') 
       )
           
       
       
       

                
         