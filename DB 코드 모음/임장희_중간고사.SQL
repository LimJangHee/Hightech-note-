-------------------------------------------- 1번 문제 ----------------------------

SELECT TO_CHAR(OUTBOUND_DATE, 'YYYY-MM') AS OUT_DATE
      ,COUNT(INVOICE_NO)
      ,SUM(SET_QTY) AS SET_QTY
  FROM LO_OUT_M
  WHERE OUTBOUND_DATE BETWEEN '2019-06-01' AND '2019-08-31'
  GROUP BY TO_CHAR(OUTBOUND_DATE, 'YYYY-MM')
  ORDER BY TO_CHAR(OUTBOUND_DATE, 'YYYY-MM')
  
  
 ------------------------------------------ 2번 문제 ---------------------------------
 SELECT *
   FROM (
         SELECT M1.OUT_TYPE_DIV
               ,SUM(M2.ORDER_QTY) AS SUM_QTY
           FROM LO_OUT_M M1
                JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
          WHERE OUTBOUND_DATE = '2019-09-03'
          GROUP BY M1.OUT_TYPE_DIV
          ORDER BY CASE WHEN OUT_TYPE_DIV LIKE 'M1%' THEN SUM_QTY END
                  ,CASE WHEN OUT_TYPE_DIV LIKE 'M2%' THEN SUM_QTY END DESC
        )
  WHERE SUM_QTY >= 5000
 
 
------------------------------------------ 3번 문제 ------------------------------------
SELECT L1.*
  FROM (
        SELECT CASE WHEN ROWNUM <= 10 THEN TO_CHAR(OUTBOUND_DATE, 'YYYY-MM-DD') ELSE 'ETC'        END AS OUT_DATE
              ,CASE WHEN ROWNUM <= 10 THEN ITEM_CD                              ELSE '00000'      END AS ITE_CD
              ,CASE WHEN ROWNUM <= 10 THEN ITEM_NM                              ELSE 'ETC'        END AS ITEM_NM
              ,SUM(SUM_QTY) AS SUM_QTY 
          FROM (
                SELECT --+ ORDERED USE_NL(M2) INDEX(M2 LO_OUT_D_IDXPK)
                       M1.OUTBOUND_DATE
                      ,M2.ITEM_CD
                      ,M2.ITEM_NM
                      ,SUM(M2.ORDER_QTY) AS SUM_QTY             
                  FROM LO_OUT_M M1
                       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                                       AND M2.ITEM_NM LIKE '%참치%'
                 WHERE M1.OUTBOUND_DATE BETWEEN '2019-06-01' AND '2019-06-30'
                 GROUP BY M1.OUTBOUND_DATE
                         ,M2.ITEM_CD
                         ,M2.ITEM_NM
                 ORDER BY SUM(M2.ORDER_QTY) DESC 
               )
         GROUP BY CASE WHEN ROWNUM <= 10 THEN TO_CHAR(OUTBOUND_DATE, 'YYYY-MM-DD') ELSE 'ETC'        END 
                 ,CASE WHEN ROWNUM <= 10 THEN ITEM_CD                              ELSE '00000'      END
                 ,CASE WHEN ROWNUM <= 10 THEN ITEM_NM                              ELSE 'ETC'        END
         ORDER BY SUM_QTY DESC  
       ) L1
ORDER BY CASE WHEN OUT_DATE = 'ETC' THEN 2 ELSE 1 END
        ,SUM_QTY DESC       
       
         
         
             
-------------------------------------------- 4번 문제 -------------------------------------

SELECT TO_CHAR(C1.NO) || '단' AS DANSU
      ,TO_CHAR(C1.NO) || 'X' || TO_CHAR(C2.NO) || '=' || TO_CHAR(C1.NO * C2.NO) AS CONTENTS
  FROM CS_NO C1
       JOIN CS_NO C2 ON C2.NO <= 9
 WHERE C1.NO BETWEEN :GUGUDAN1 AND :GUGUDAN2
 ORDER BY DANSU, C2.NO          
          

                           
                                        