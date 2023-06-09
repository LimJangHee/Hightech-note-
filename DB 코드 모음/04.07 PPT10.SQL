SELECT M1.INVOICE_NO, M1.OUTBOUND_DATE, M1.OUT_TYPE_DIV
      ,M2.LINE_NO ,M2.ITEM_CD ,M2.ORDER_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICD_NO = M1.INVOICE_NO
 WHERE M1.INVOCIE_NO IN ('346724703834', '346724722535', '346724717915') 
 
 
 ------------------------------------------------ 1번 문제 ----------------------------------------------------
 SELECT M1.BRAND_CD, M1.OUTBOUND_DATE, M1.INVOICE_NO
       ,D1.LINE_NO, D1.ORDER_QTY
   FROM A_OUT_M M1
        JOIN A_OUT_D D1 ON D1.BRAND_CD = M1.BRAND_CD AND D1.INVOICE_NO = M1.INVOICE_NO                      
  WHERE M1.OUTBOUND_DATE = '2023-01-04'
    AND D1.ITEM_CD IN ('B', 'D')
    
    
 ---------------------------------------------- 2번 문제 --------------------------------------------------
SELECT M1.BRAND_CD, M1.OUTBOUND_DATE, D1.ITEM_CD, SUM(D1.ORDER_QTY) AS SUM_QTY
   FROM A_OUT_M M1
        JOIN A_OUT_D D1 ON D1.BRAND_CD = M1.BRAND_CD AND D1.INVOICE_NO = M1.INVOICE_NO
  WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-03' AND '2023-01-4'
    AND D1.ITEM_CD IN ('B', 'D')
  GROUP BY M1.BRAND_CD, M1.OUTBOUND_DATE, D1.ITEM_CD
  ORDER BY M1.BRAND_CD
  
------------------------------------------------ 3번 문제 ---------------------------------------------------
SELECT *
  FROM (
        SELECT M1.INVOICE_NO, M1.ORDER_NM
              ,SUM(D1.ORDER_QTY) AS SUM_QTY
          FROM A_OUT_M M1
               JOIN A_OUT_D D1 ON D1.BRAND_CD = M1.BRAND_CD AND D1.INVOICE_NO = M1.INVOICE_NO
         WHERE M1.BRAND_CD = '1001'
           AND M1.OUTBOUND_DATE BETWEEN '2023-01-04' AND '2023-01-05'
         GROUP BY M1.INVOICE_NO, M1.ORDER_NM
         ORDER BY -SUM_QTY
       )
 WHERE ROWNUM = 1 
 
 ----------------------------------------------- 4번 문제 ---------------------------------------------------
 SELECT M1.BRAND_CD, M1.OUTBOUND_DATE, M1.INVOICE_NO, M2.ITEM_CD, M3.ITEM_NM, M2.ORDER_QTY
   FROM A_OUT_M M1
        JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD AND M2.INVOICE_NO = M1.INVOICE_NO
        JOIN A_ITEM M3 ON M3.BRAND_CD = M2.BRAND_CD AND M3.ITEM_CD = M2.ITEM_CD
  WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
    AND M2.ORDER_QTY >= 3
    
----------------------------------------------- 5번 문제 ----------------------------------------------------               
 SELECT BRAND_CD, ITEM_CD, SUM(ORDER_QTY) AS SUM_QTY
   FROM (
         SELECT M1.BRAND_CD, M1.OUTBOUND_DATE, M1.INVOICE_NO, M2.ITEM_CD, M3.ITEM_NM, M2.ORDER_QTY
           FROM A_OUT_M M1
                JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD AND M2.INVOICE_NO = M1.INVOICE_NO
                JOIN A_ITEM M3 ON M3.BRAND_CD = M2.BRAND_CD AND M3.ITEM_CD = M2.ITEM_CD
          WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
        )
  GROUP BY BRAND_CD, ITEM_CD

              
SELECT M1.BRAND_CD, M1.ITEM_CD, C1.ITEM_NM, C1.QTY_IN_BOX, M1.SUM_QTY
  FROM (
        SELECT M1.BRAND_CD, M2.ITEM_CD, SUM(M2.ORDER_QTY) AS SUM_QTY
          FROM A_OUT_M M1
               JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD
                              AND M2.INVOICE_NO = M1.INVOICE_NO
         WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
         GROUP BY M1.BRAND_CD, M2.ITEM_CD                     
       ) M1
       JOIN A_ITEM C1 ON C1.BRAND_CD = M1.BRAND_CD
                     AND C1.ITEM_CD = M1.ITEM_CD
 ORDER BY M1.BRAND_CD, M1.ITEM_CD                            
          
           
  
  
 --------------------------------------------- 6번 문제 ------------------------------------------------------- 
 SELECT BRAND_CD, ITEM_CD, ITEM_NM, QTY_IN_BOX, SUM_QTY
       ,TRUNC(SUM_QTY / QTY_IN_BOX) AS BOX_CNT
       ,MOD(SUM_QTY, QTY_IN_BOX)    AS PCS_CNT
   FROM (
         SELECT M1.BRAND_CD, M1.ITEM_CD, C1.ITEM_NM, C1.QTY_IN_BOX, M1.SUM_QTY
           FROM (
                 SELECT M1.BRAND_CD, M2.ITEM_CD, SUM(M2.ORDER_QTY) AS SUM_QTY
                   FROM A_OUT_M M1
                        JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD
                                       AND M2.INVOICE_NO = M1.INVOICE_NO
                  WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
                  GROUP BY M1.BRAND_CD, M2.ITEM_CD                     
                ) M1
                JOIN A_ITEM C1 ON C1.BRAND_CD = M1.BRAND_CD
                              AND C1.ITEM_CD = M1.ITEM_CD
          ORDER BY M1.BRAND_CD, M1.ITEM_CD 
        )        
 
------------------------------------------------ 7번 문제 ----------------------------------------------------
SELECT *
  FROM (
        SELECT BRAND_CD, ITEM_CD, ITEM_NM, QTY_IN_BOX, SUM_QTY
              ,TRUNC(SUM_QTY / QTY_IN_BOX) AS BOX_CNT
              ,MOD(SUM_QTY, QTY_IN_BOX)    AS PCS_CNT
          FROM (
                SELECT M1.BRAND_CD, M1.ITEM_CD, C1.ITEM_NM, C1.QTY_IN_BOX, M1.SUM_QTY
                  FROM (
                        SELECT M1.BRAND_CD, M2.ITEM_CD, SUM(M2.ORDER_QTY) AS SUM_QTY
                          FROM A_OUT_M M1
                               JOIN A_OUT_D M2 ON M2.BRAND_CD = M1.BRAND_CD
                                              AND M2.INVOICE_NO = M1.INVOICE_NO
                         WHERE M1.OUTBOUND_DATE BETWEEN '2023-01-01' AND '2023-01-04'
                         GROUP BY M1.BRAND_CD, M2.ITEM_CD                     
                       ) M1
                       JOIN A_ITEM C1 ON C1.BRAND_CD = M1.BRAND_CD
                                     AND C1.ITEM_CD = M1.ITEM_CD
                 ORDER BY M1.BRAND_CD, M1.ITEM_CD 
        )
        ORDER BY TRUNC(SUM_QTY / QTY_IN_BOX) DESC 
       )       
 WHERE ROWNUM <= 3
 
--------------------------------------------------- 조인 기본 ----------------------------------------------
SELECT LEVEL + TO_DATE('2023-04-07', 'YYYY-MM-DD') AS DY  
  FROM DUAL 
CONNECT BY LEVEL<= 10          

-- 데이터를 복제해서 2세트를 만든다는것 -> NO가 1일때의 정보들이 NO가 2일때의 정보들과 같음(복사) 
SELECT INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY, NO
  FROM LO_OUT_D M1
       JOIN CS_NO C1 ON C1.NO <= 2
 WHERE INVOICE_NO = '346724706214'
 ORDER BY LINE_NO, NO 
 
 -- 복제 해온 데이터들 중에 NO 2에 들어가 있는 ORDER_QTY의 값들은 SUM을 하고 나머지들은 하나의 값들로 통일하여 합침
 SELECT CASE NO WHEN 1 THEN INVOICE_NO ELSE '합계' END AS INVOICE_NO -- NO가 1인 애들은 그대로 표시하고 2인 애들을 모두 '합계'로 표시
       ,CASE NO WHEN 1 THEN LINE_NO    ELSE 0      END AS LINE_NO
       ,CASE NO WHEN 1 THEN ITEM_CD    ELSE '-'    END AS ITEM_CD
       ,SUM(ORDER_QTY) AS SUM_QTY
       ,NO
  FROM LO_OUT_D M1
       JOIN CS_NO C1 ON C1.NO <= 2
 WHERE INVOICE_NO = '346724706214'
 GROUP BY CASE NO WHEN 1 THEN INVOICE_NO ELSE '합계' END AS INVOICE_NO 
         ,CASE NO WHEN 1 THEN LINE_NO    ELSE 0      END AS LINE_NO
         ,CASE NO WHEN 1 THEN ITEM_CD    ELSE '-'    END AS ITEM_CD
      -- ,NO
 ORDER BY NO
         ,CASE NO WHEN 1 THEN INVOICE_NO ELSE '합계' END AS INVOICE_NO 
         ,CASE NO WHEN 1 THEN LINE_NO    ELSE 0      END AS LINE_NO        
          

SELECT INVOICE_NO, LINE_NO, ITEM_CD, ORDER_QTY, NO
  FROM LO_OUT_D M1
       JOIN CS_NO C1 ON C1.NO <= M1.ORDER_QTY
 WHERE INVOICE_NO = '346724706214'
 ORDER BY LINE_NO, NO     
                                              