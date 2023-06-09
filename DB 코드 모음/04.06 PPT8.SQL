SELECT NVL(NULL, 'SKPANG') AS FROM DUAL WHERE 1 = 1;

-- 거짓 -> 공집합이라서 아예NULL값 자체가 존재하지 않음
SELECT NVL(NULL, 'SKPANG') AS FROM DUAL WHERE 1 = 2;

-- 공집합이여도 MAX와 같은 직계함수를 사용하면 NULL에 해당하는 레코드가 생성됨
SELECT NVL(MAX(NULL), 'HELLO') AS VAL
  FROM DUAL
 WHERE 1 = 2
 
 SELECT NVL(MIN('Y'), 'N') AS EXIST_YN
   FROM LO_OUT_M
  WHERE OUTBOUND_DATE = '2019-06-03' 
    AND ROWNUM =1 
    

-------------------------------------------- 1번 문제 ------------------------------------------
SELECT INVOICE_NO, OUTBOUND_DATE, TO_CHAR(OUTBOUND_DATE, 'DAY') AS DY, ORDER_NM
  FROM A_OUT_M
 WHERE BRAND_CD = '1001'
 ORDER BY TO_CHAR(OUTBOUND_DATE, 'D') -- 요일 정보를 숫자로 전환하여 정렬할 수 있게 사용 

---------------------------------------------- 2번 문제 ----------------------------------------- 
SELECT M1.*
      ,MOD(TO_NUMBER(SUBSTR(INVOICE_NO, 2, 2)), 2) AS MOD_VAL
      , CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO, 2, 2)), 2)
             WHEN 0 THEN '짝'
             ELSE        '홀'
        END AS EVENODD                  
  FROM (
        SELECT BRAND_CD, INVOICE_NO, OUTBOUND_DATE, TO_CHAR(OUTBOUND_DATE, 'DAY') AS DY, OUT_TYPE_DIV, ORDER_NM
          FROM A_OUT_M
         WHERE BRAND_CD = '1001' 
       ) M1  
       
----------------------------------------------- 3번 문제 ------------------------------------------
SELECT BRAND_CD, COUNT(INVOICE_NO) AS INV_CNT
  FROM A_OUT_M
 GROUP BY BRAND_CD
 ORDER BY BRAND_CD
 
 ---------------------------------------------- 4번 문제 ---------------------------------------
 SELECT BRAND_CD, TO_CHAR(OUTBOUND_DATE, 'DAY') AS DY, COUNT(INVOICE_NO) AS INV_CNT
   FROM A_OUT_M
  GROUP BY BRAND_CD, TO_CHAR(OUTBOUND_DATE, 'DAY'), TO_CHAR(OUTBOUND_DATE, 'D')
  ORDER BY BRAND_CD, TO_CHAR(OUTBOUND_DATE, 'D')
  
------------------------------------------------- 5번 문제 ----------------------------------------
SELECT BRAND_CD
      ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO, 2, 2)), 2)
             WHEN 0 THEN '짝'
             ELSE        '홀'
          END AS EVENODD
      ,COUNT(DISTINCT INVOICE_NO) AS INV_CNT
      ,SUM(ORDER_QTY) AS SUM_QTY     
 FROM A_OUT_D
 GROUP BY BRAND_CD
        ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO, 2, 2)), 2)
             WHEN 0 THEN '짝'
             ELSE        '홀'
          END
 ORDER BY BRAND_CD 
 
 
 SELECT BRAND_CD
       ,EVENODD
       ,COUNT(DISTINCT INVOICE_NO) AS INV_CNT
       ,SUM(ORDER_QTY) AS SUM_QTY
   FROM (
         SELECT BRAND_CD
               ,INVOICE_NO
               ,CASE MOD(TO_NUMBER(SUBSTR(INVOICE_NO, 2, 2)), 2)
                     WHEN 0 THEN '짝'
                     ELSE        '홀'
                END AS EVENODD
               ,ORDER_QTY
           FROM A_OUT_D    
        )
  GROUP BY BRAND_CD, EVENODD
  ORDER BY BRAND_CD                       
             
--------------------------------------------------------- 7번 문제 -----------------------------------------

SELECT NVL(TO_CHAR(SUM(ORDER_QTY)), 'Empty..') AS ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724706215'
 
                       