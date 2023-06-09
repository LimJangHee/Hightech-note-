SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
 ORDER BY ORDER_QTY DESC

SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE INVOICE_NO LIKE '#0%'
   AND ORDER_QTY >= 3
 ORDER BY ORDER_QTY DESC, ITEM_CD

SELECT ROWNUM AS RNUM, BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
  FROM (
       SELECT BRAND_CD, INVOICE_NO, ITEM_CD, ORDER_QTY
         FROM A_OUT_D
        WHERE INVOICE_NO LIKE '#0%'
          AND ORDER_QTY >= 3
        ORDER BY ORDER_QTY DESC, ITEM_CD
       )
 WHERE ROWNUM <= 2
 
SELECT COUNT(*)
  FROM A_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-04'
 
SELECT COUNT(DISTINCT INVOICE_NO)
  FROM A_OUT_D

SELECT SUM(ORDER_QTY) AS SUM_QTY
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'

SELECT BRAND_CD, COUNT(INVOICE_NO)
  FROM A_OUT_M
 GROUP BY BRAND_CD

SELECT BRAND_CD, OUTBOUND_DATE, COUNT(INVOICE_NO)
  FROM A_OUT_M
 GROUP BY BRAND_CD, OUTBOUND_DATE
 ORDER BY BRAND_CD, OUTBOUND_DATE

SELECT BRAND_CD, SUM(ORDER_QTY) AS SUM_QTY
  FROM A_OUT_D
 GROUP BY BRAND_CD

SELECT BRAND_CD, ITEM_CD, SUM(ORDER_QTY) AS SUM_QTY
  FROM A_OUT_D
 GROUP BY BRAND_CD, ITEM_CD
 ORDER BY BRAND_CD, ITEM_CD

SELECT BRAND_CD, MAX(ORDER_QTY), MIN(ORDER_QTY)
  FROM A_OUT_D
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD
 
 SELECT BRAND_CD, OUTBOUND_DATE, COUNT(INVOICE_NO)
  FROM A_OUT_M
 GROUP BY BRAND_CD, OUTBOUND_DATE
 HAVING COUNT(*) = 2
 ORDER BY BRAND_CD, OUTBOUND_DATE

SELECT BRAND_CD, MAX(SUM_QTY), MIN(SUM_QTY)
  FROM (
 
        SELECT BRAND_CD, ITEM_CD, SUM(ORDER_QTY) AS SUM_QTY
          FROM A_OUT_D
         GROUP BY BRAND_CD, ITEM_CD
         ORDER BY BRAND_CD, ITEM_CD
       )
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD
 
SELECT INVOICE_NO, OUTBOUND_DATE, OUT_TYPE_DIV, OUT_BOX_DIV, oUT_BOX_NM
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-02'
   AND OUT_TYPE_DIV IN ('M15', 'M22')
   AND OUT_BOX_DIV LIKE 'F%'
   AND ORDER_PLACE = '52685'
 ORDER BY OUTBOUND_DATE, INVOICE_NO 

SELECT OUTBOUND_DATE
     , COUNT(OUT_BOX_DIV)          AS TOT_CNT
     , COUNT(DISTINCT OUT_BOX_DIV) AS OUT_BOX_CNT
     , MIN(OUT_BOX_DIV)            AS OUT_BOX_MIN
     , MAX(OUT_BOX_DIV)            AS OUT_BOX_MAX 
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-02'
   AND OUT_TYPE_DIV IN ('M15', 'M22')
   AND OUT_BOX_DIV LIKE 'F%'
   AND ORDER_PLACE = '52685'
 GROUP BY OUTBOUND_DATE
 ORDER BY OUTBOUND_DATE
 
 SELECT COUNT(*)           AS CNT1
       ,COUNT(CD)          AS CNT2                                                 
       ,COUNT(DISTINCT CD) AS CNT3
       ,COUNT(QTY)         AS CNT4
       ,COUNT(1)           AS CNT5 -- 모든 레코드에 1을 부여하고 이것을 카운트
       ,COUNT(CONST)       AS CNT6
   FROM (
         SELECT CD, QTY, '폴리텍' AS CONST -- 모든레코드에 폴리텍을 부여하고 컬럼 이름을 CONST로      
           FROM (
                 SELECT 'A' AS CD, 1    AS QTY FROM DUAL UNION ALL
                 SELECT 'B' AS CD, 2    AS QTY FROM DUAL UNION ALL
                 SELECT 'C' AS CD, NULL AS QTY FROM DUAL UNION ALL
                 SELECT 'C' AS CD, 4    AS QTY FROM DUAL UNION ALL
                 SELECT 'E' AS CD, 5    AS QTY FROM DUAL
                 )
        )