----------------------------------------- 1번 문제 --------------------------------
SELECT OUTBOUND_DATE, ORDER_NM
      ,CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
              WHEN 'M1' THEN '상온'
              WHEN 'M2' THEN '저온'
       END AS TEMP       
  FROM A_OUT_M

----------------------------------------- 2번 문제 ------------------------------
SELECT BRAND_CD, INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY
      ,CASE WHEN ORDER_QTY BETWEEN 1 AND 2 THEN '하'
            WHEN ORDER_QTY BETWEEN 3 AND 4 THEN '중'
            WHEN ORDER_QTY >= 5 THEN '상'
       END AS GRADE
  FROM A_OUT_D  

----------------------------------------- 3번 문제 -------------------------------  
 SELECT BRAND_CD, TEMP, COUNT(INVOICE_NO) AS CNT
 FROM (
       SELECT OUTBOUND_DATE, ORDER_NM, INVOICE_NO, BRAND_CD
            ,CASE SUBSTR(OUT_TYPE_DIV, 1, 2)
                    WHEN 'M1' THEN '상온'
                    WHEN 'M2' THEN '저온'
             END AS TEMP       
        FROM A_OUT_M
       )
  GROUP BY BRAND_CD, TEMP
  ORDER BY BRAND_CD, TEMP 
 
 ------------------------------------------ 4번 문제-------------------------------- 
 SELECT BRAND_CD, GRADE, SUM(ORDER_QTY)
 FROM(
      SELECT BRAND_CD, INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY
            ,CASE WHEN ORDER_QTY BETWEEN 1 AND 2 THEN '하'
                  WHEN ORDER_QTY BETWEEN 3 AND 4 THEN '중'
                  WHEN ORDER_QTY >= 5 THEN '상'
             END AS GRADE
        FROM A_OUT_D
     )
 GROUP BY BRAND_CD, GRADE
 ORDER BY BRAND_CD, GRADE
 
 
 
 SELECT BRANDCD, INVOICE_NO
       ,CASE WHEN SUM_QTY <= 2 THEN '하'
             WHEN SUM_QTY <= 4 THEN '중'
             ELSE '상'
        END AS GRADE
        ,COUNT(1) AS CNT      
   FROM (
         SELECT BRAND_CD, INVOICE_NO, SUM(ORDER_QTY) AS SUM_QTY
           FROM A_OUT_D
          GROUP BY BRAND_CD, INVOICE_NO
        )
  GROUP BY BRAND_CD
          ,CASE WHEN SUM_QTY <= 2 THEN '하'
                WHEN SUM_QTY <= 4 THEN '중'
                ELSE '상'
            END       

------------------------------------------ 5번 문제 ------------------------------------- 
 SELECT ITEM_CD
       ,CASE WHEN ROWNUM <= 2 THEN TO_CHAR(SUM_QTY)
             ELSE             'ETC'
        END AS TOP2     
 FROM (
       SELECT ITEM_CD ,SUM(ORDER_QTY) AS SUM_QTY
         FROM A_OUT_D
        GROUP BY ITEM_CD
        ORDER BY SUM_QTY DESC
      ) 
      


-- 컬럼을 아예 새롭게 생성
SELECT RNK, ITEM, ORDER_QTY
      ,CASE WHEN RNK IN (1, 2) THEN 1 ELSE 2 END AS AAA
  FROM (
        SELECT CASE WHEN ROWNUM <= 2 THEN ROWNUM ELSE 0      END AS RNK
               ITEM_CD
              ,CASE WHEN ROWNUM <= 2 THEN ITEM_CD ELSE 'ETC' END AS ITEM
              ,SUM(SUM_QTY) AS ORDER_QTY
          FROM (
               SELECT ITEM_CD
                     ,SUM(ORDER_QTY) AS SUM_QTY
                 FROM A_OUT_D
                 GROUP BY ITEM_CD
                 ORDER BY SUM_QTY DESC
               )
         GROUP BY CASE WHEN ROWNUM <= 2 THEN ROWNUM ELSE 0      END     
                 ,CASE WHEN ROWNUM <= 2 THEN ITEM_CD ELSE 'ETC' END       
       )
 ORDER BY CASE WHEN RNK IN (1,2) THEN 1 ELSE 2 END
         ,RNK  
         
------------------------------------------------------- 6번 문제 ------------------------------------------------              
SELECT INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY
  FROM A_OUT_D
 WHERE BRAND_CD = '1001'
 ORDER BY CASE ITEM_CD WHEN 'C' THEN 1 ELSE 2 END -- C상품을 먼저 표시하고 
         ,ITEM_CD                                 -- 상품코드 순으로 나열
         ,OREDER_QTY DESC                         --
         
------------------------------------------------------- 7번 문제 -------------------------------------------------
SELECT OUTBOUND_DATE
      ,COUNT(1) AS INVOICE_CNT
      ,COUNT(CASE WHEN OUT_TYPE_DIV LIKE 'M1%' THEN 1 END) AS M1_CNT
      ,COUNT(CASE WHEN OUT_TYPE_DIV LIKE 'M2%' THEN 1 END) AS M2_CNT
  FROM LO_OUT_M
 WHERE OUTBOUND_DATE BETWEEN TO_DATE(TO_CHAR(:TODAY, 'YYYYMM') || '01', 'YYYY-MM-DD') AND :TODAY -- 끝날짜를 입력받고 시작 날짜 부터 계산
   AND OUT_BOX_DIV LIKE CASE :COND WHEN 1 THEN 'D'
                                   WHEN 2 THEN 'F'
                                   WHEN 0 THEN NULL
                                   ELSE 'ZZZ' -- 조회가 안되게 이상한 값
                        END || '%'
 GROUP BY OUTBOUND_DATE
 ORDER BY OUTBOUND_DATE                                   
            
 ---------------------------------------------------- 8번 문제 ---------------------------------------------------
 SELECT ITEM_BAR_CD
       ,COUNT(DISTINCT ITEM_CD) AS ITEM_CNT
   FROM LO_OUT_D
  GROUP BY ITEM_BAR_CD
 HAVING COUNT(DISTINCT ITEM_CD) > 1
  ORDER BY CASE WHEN ITEM_BAR_CD IS NULL THEN 2 ELSE 1 END
          ,-ITEM_CNT


SELECT ITEM_BAR_CD, ITEM_CNT
      ,CASE WHEN ITEM_BAR_CD IS NULL THEN '2' ELSE '1' END AS AAA -- NULL값을 조건으로서 비교할려면 IS NULL을 해줘야됨
  FROM(
      SELECT ITEM_BAR_CD, COUNT(DISTINCT ITEM_CD)
        FROM LO_OUT_D
       GROUP BY ITEM_BAR_CD
      HAVING COUNT(DISTINCT ITEM_CD) > 1 
      )
ORDER BY AAA, ITEM_CNT DESC                
                                     
 
     
                