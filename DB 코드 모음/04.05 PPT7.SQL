------------------------------------- 1번 문제 ------------------------------------------
SELECT BRAND_CD
      ,ITEM_CD
      ,SUM(ORDER_QTY)
      ,(
        SELECT ITEM_NM
        FROM A_ITEM A1
        WHERE A1.BRAND_CD = D1.BRAND_CD 
        AND A1.ITEM_CD = D1.ITEM_CD
        ) AS ITEM_NM
        ,(
        SELECT QTY_IN_BOX
        FROM A_ITEM A1
        WHERE A1.BRAND_CD = D1.BRAND_CD 
        AND A1.ITEM_CD = D1.ITEM_CD
        ) AS QTY_IN_BOX
FROM A_OUT_D D1
GROUP BY BRAND_CD, ITEM_CD

-------------------------------------------- 풀이 --------------------------------------------------------
-- 4.박스입수와 상품명을 분리함
SELECT BRAND_CD, ITEM_CD, SUM_QTY, VAL
      ,TO_NUMBER(SUBSTR(VAL, 1, 3))   AS QTY_IN_BOX
      ,SUBSTR(VAL, 4, 100)            AS ITEM_NM
  FROM (-- 3.박스입수와 상품명을 연결하여 하나의 컬럼으로 가져옴
        SELECT L1.BRAND_CD
               ,L1.ITEM_CD
               ,L1.SUM_QTY
               ,( -- 2.상품명과 박스입수를 가져오는 스칼라쿼리
                 SELECT LPAD(S1.QTY_IN_BOX, 3, '0') || S1.ITEM_NM
                   FROM A_ITEM S1
                  WHERE S1.BRAND_CD = L1.BRAND_CD
                    AND S1.ITEM_CD = L1.ITEM_CD
                 ) AS VAL   
           FROM ( -- 1.브랜드/상품별 주문수량 합계를 구함
                 SELECT M1.BRAND_CD
                       ,M1.ITEM_CD
                       ,SUM(M1.ORDER_QTY) AS SUM_QTY
                   FROM A_OUT_D M1
                  GROUP BY M1.BRAND_CD, M1.ITEM_CD
                  ORDER BY M1.BRAND_CD, M1.ITEM_CD     
                 ) L1
       )



        
------------------------------------------------------------- JOIN을 사용한 경우 ------------------------------------------        
SELECT M1.BRAND_CD
      ,M1.ITEM_CD
      ,C1.ITEM_NM
      ,C1.QTY_IN_BOX
      ,SUM(ORDER_QTY)
  FROM A_OUT_D M1
       JOIN A_ITEM C1 ON C1.BRAND_CD = M1.BRAND_CD
                     AND C1.ITEM_CD = M1.ITEM_CD
 GROUP BY M1.BRAND_CD, M1.ITEM_CD, C1.ITEM_NM, C1.QTY_IN_BOX
 ORDER BY M1.BRAND_CD, M1.ITEM_CD 
 
 ----------------------------------------------------- 2번 문제------------------------------------------------- 
 SELECT BRAND_CD, ITEM_CD, ITEM_NM, SUM_QTY, QTY_IN_BOX
       , TRUNC(SUM_QTY / QTY_IN_BOX) AS BOX_CNT
       , MOD(SUM_QTY, QTY_IN_BOX) AS PCS_CNT
   FROM(
         -- 4.박스입수와 상품명을 분리함
        SELECT BRAND_CD, ITEM_CD, SUM_QTY, VAL
              ,TO_NUMBER(SUBSTR(VAL, 1, 3))   AS QTY_IN_BOX
              ,SUBSTR(VAL, 4, 100)            AS ITEM_NM
          FROM (-- 3.박스입수와 상품명을 연결하여 하나의 컬럼으로 가져옴
                SELECT L1.BRAND_CD
                       ,L1.ITEM_CD
                       ,L1.SUM_QTY
                       ,( -- 2.상품명과 박스입수를 가져오는 스칼라쿼리
                         SELECT LPAD(S1.QTY_IN_BOX, 3, '0') || S1.ITEM_NM
                           FROM A_ITEM S1
                          WHERE S1.BRAND_CD = L1.BRAND_CD
                            AND S1.ITEM_CD = L1.ITEM_CD
                         ) AS VAL   
                   FROM ( -- 1.브랜드/상품별 주문수량 합계를 구함
                         SELECT M1.BRAND_CD
                               ,M1.ITEM_CD
                               ,SUM(M1.ORDER_QTY) AS SUM_QTY
                           FROM A_OUT_D M1
                          GROUP BY M1.BRAND_CD, M1.ITEM_CD
                          ORDER BY M1.BRAND_CD, M1.ITEM_CD     
                         ) L1
               )
       )
---------------------------------------------------------------- 3번 문제----------------------------------------
SELECT ROWNUM, L2.*
FROM(
     SELECT BRAND_CD, ITEM_CD, ITEM_NM, SUM_QTY, QTY_IN_BOX
       , TRUNC(SUM_QTY / QTY_IN_BOX) AS BOX_CNT
       , MOD(SUM_QTY, QTY_IN_BOX) AS PCS_CNT
   FROM(
         -- 4.박스입수와 상품명을 분리함
        SELECT BRAND_CD, ITEM_CD, SUM_QTY, VAL
              ,TO_NUMBER(SUBSTR(VAL, 1, 3))   AS QTY_IN_BOX
              ,SUBSTR(VAL, 4, 100)            AS ITEM_NM
          FROM (-- 3.박스입수와 상품명을 연결하여 하나의 컬럼으로 가져옴
                SELECT L1.BRAND_CD
                       ,L1.ITEM_CD
                       ,L1.SUM_QTY
                       ,( -- 2.상품명과 박스입수를 가져오는 스칼라쿼리
                         SELECT LPAD(S1.QTY_IN_BOX, 3, '0') || S1.ITEM_NM
                           FROM A_ITEM S1
                          WHERE S1.BRAND_CD = L1.BRAND_CD
                            AND S1.ITEM_CD = L1.ITEM_CD
                         ) AS VAL   
                   FROM ( -- 1.브랜드/상품별 주문수량 합계를 구함
                         SELECT M1.BRAND_CD
                               ,M1.ITEM_CD
                               ,SUM(M1.ORDER_QTY) AS SUM_QTY
                           FROM A_OUT_D M1
                          GROUP BY M1.BRAND_CD, M1.ITEM_CD
                          ORDER BY M1.BRAND_CD, M1.ITEM_CD     
                         ) L1
               )
        ORDER BY BOX_CNT DESC
       )
WHERE ROWNUM <= 3       
       
----------------------------------------------------------------- 마지막 문제 --------------------------------------------
SELECT ROWNUM AS RNK, M2.*, CEIL(ORDER_QTY/QTY_IN_BOX) AS BOX_CNT_TOT
  FROM (
        SELECT M1.ITEM_CD, M1.QTY_IN_BOX, M1.ORDER_QTY
              , TRUNC(M1.ORDER_QTY / M1.QTY_IN_BOX) AS BOX_CNT
              , MOD(M1.ORDER_QTY, M1.QTY_IN_BOX) AS PCS_CNT
          FROM (
                SELECT ITEM_CD, QTY_IN_BOX, SUM(ORDER_QTY) AS ORDER_QTY
                  FROM LO_OUT_D
                 WHERE INVOICE_NO BETWEEN '346724706262' AND '346724706762'
                 GROUP BY ITEM_CD, QTY_IN_BOX 
               ) M1
         ORDER BY M1.ORDER_QTY DESC              
        ) M2
WHERE ROWNUM <= 5        
       
       