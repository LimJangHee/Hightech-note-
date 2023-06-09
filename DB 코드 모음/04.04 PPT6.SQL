SELECT OUTBOUND_DATE
       ,INVOICE_NO
       ,OUT_TYPE_DIV
  FROM LO_OUT_M M1
 WHERE M1.OUTBOUND_DATE = '2019-09-03'
   AND M1.INVOICE_NO BETWEEN '352613619120' AND '352613619150'
   AND EXISTS(
              SELECT 1
                FROM LO_OUT_D S1
               WHERE S1.INVOICE_NO = M1.INVOICE_NO
                 AND S1.ORDER_QTY > 100
              )
              
SELECT M1.OUTBOUND_DATE
      ,M1.INVOICE_NO
      ,M1.OUT_TYPE_DIV
      ,(
        SELECT SUM(S1.ORDER_QTY)
          FROM LO_OUT_D S1
         WHERE S1.INVOICE_NO = M1.INVOICE_NO
        ) AS SUM_QTY
 FROM LO_OUT_M M1
WHERE M1.INVOICE_NO LIKE '3467247026%';

SELECT *
  FROM A_OUT_D
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                 SELECT BRAND_CD, INVOICE_NO
                                   FROM A_OUT_M
                                  WHERE OUTBOUND_DATE = '2023-01-03'
                                 )
 ORDER BY BRAND_CD, INVOICE_NO  

SELECT *
  FROM A_OUT_D
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                 SELECT BRAND_CD, INVOICE_NO
                                   FROM A_OUT_M
                                  WHERE BRAND_CD = '1001'
                                    AND OUT_TYPE_DIV LIKE 'M1%'
                                 )
 ORDER BY BRAND_CD, INVOICE_NO  
                     
SELECT *
  FROM A_OUT_M
 WHERE (BRAND_CD, INVOICE_NO) IN (
                                  SELECT BRAND_CD, INVOICE_NO
                                    FROM A_OUT_D
                                   GROUP BY BRAND_CD, INVOICE_NO
                                   HAVING SUM(ORDER_QTY) >= 3
                                 )
                                 
SELECT M1.BRAND_CD
      ,M1.ITEM_CD
      ,SUM(M1.ORDER_QTY) AS SUM_QTY
      ,(
        SELECT S1.ITEM_NM
          FROM A_ITEM S1
         WHERE S1.BRAND_CD = M1.BRAND_CD
           AND S1.ITEM_CD = M1.ITEM_CD
        ) ITEM_NM   
  FROM A_OUT_D M1
 GROUP BY M1.BRAND_CD, M1.ITEM_CD  
 
 SELECT DISTINCT OUTBOUND_DATE
   FROM LO_OUT_M
  WHERE OUTBOUND_DATE BETWEEN :OUTBOUND_DATE AND :OUTBOUND_DATE + 10
  ORDER BY OUTBOUND_DATE
  
SELECT *
  FROM(
       SELECT TO_DATE('20190615', 'YYYY-MM-DD') + NO AS OUT_DATE
         FROM CS_NO
        WHERE NO <= 10
       ) M1
  WHERE EXISTS ( -- EXISTS구문 이전것을 먼저 확인하고 EXISTS에서 중복이 하나라도 있으면 그 값을 반환해줌      
                 SELECT 1 -- EXISTS구문에서는 SELECT가 뭔지 상관없음
                 FROM LO_OUT_M S1
                 WHERE S1.OUTBOUND_DATE = M1.OUT_DATE
                )
                
SELECT INVOICE_NO
      ,OUT_TYPE_DIV
      ,OUT_BOX_DIV
      ,TO_NUMBER(SUBSTR(VAL, 12, 10)) AS MAX_LINE_NO
      ,TO_NUMBER(SUBSTR(VAL, 1, 10)) AS MAX_ORDER_QTY
      FROM(
           SELECT INVOICE_NO
                 ,OUT_TYPE_DIV
                 ,OUT_BOX_DIV
                 ,(
                   SELECT MAX(LPAD(ORDER_QTY, 10, '0') || '-' || LPAD(LINE_NO, 10, '0'))
                     FROM LO_OUT_D S1
                    WHERE S1.INVOICE_NO = M1.INVOICE_NO
                  ) AS VAL
             FROM LO_OUT_M M1
            WHERE OUTBOUND_DATE = '2019-06-03'
              AND OUTBOUND_NO BETWEEN 'D190603-897353' AND 'D190603-897360'   
          )                                                    
                                                         

            
   