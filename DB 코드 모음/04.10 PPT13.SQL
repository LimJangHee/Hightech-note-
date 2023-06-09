----------------------------------------- 1번 문제 ------------------------------------

SELECT --+ ORDERED USE_NL(M2) 
      M1.OUTBOUND_DATE, SUM(M2.ORDER_QTY) AS SUM_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
  WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
  GROUP BY M1.OUTBOUND_DATE
  ORDER BY SUM_QTY DESC  
  
----------------------------------------- 2번 문제 --------------------------------------
  
SELECT SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '1' THEN M2.ORDER_QTY END) AS SUN
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '2' THEN M2.ORDER_QTY END) AS MON
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '3' THEN M2.ORDER_QTY END) AS TUE
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '4' THEN M2.ORDER_QTY END) AS WED
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '5' THEN M2.ORDER_QTY END) AS THU
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '6' THEN M2.ORDER_QTY END) AS FRI
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'D') WHEN '7' THEN M2.ORDER_QTY END) AS SAT
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
 
 
 SELECT SUN, MON, TUE, WED, THU, FRI, SAT
   FROM (
         SELECT --+ORDERED USE_NL(M2)
                TO_CHAR(M1.OUTBOUND_DATE, 'D') AS DY
               ,SUM(M2.ORDER_QTY) AS ORDER_QTY
           FROM LO_OUT_M M1
                JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
          WHERE M1.OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
          GROUP BY TO_CHAR(M1.OUTBOUND_DATE, 'D')          
        )
   PIVOT (SUM(ORDER_QTY) FOR DY IN (1 AS SUN, 2 AS MON, 3 AS TUE, 4 AS WED, 5 AS THU, 6 AS FRI, 7 AS SAT))     
 

SELECT --+ ORDERED USE_NL(M2) 
      TO_CHAR(M1.OUTBOUND_DATE, 'DAY') AS DY
     ,SUM(M2.ORDER_QTY) AS SUM_QTY
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
  WHERE OUTBOUND_DATE BETWEEN '2019-09-01' AND '2019-09-30'
  GROUP BY TO_CHAR(M1.OUTBOUND_DATE, 'DAY')
          ,TO_CHAR(M1.OUTBOUND_DATE, 'D')
  ORDER BY TO_CHAR(M1.OUTBOUND_DATE, 'D')
 
------------------------------------------------------------- 3번 문제 ------------------------------------ 
  
SELECT --+ ORDERED USE_NL(M2)
       SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '01' THEN M2.ORDER_QTY END) AS M01
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '02' THEN M2.ORDER_QTY END) AS M02
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '03' THEN M2.ORDER_QTY END) AS M03
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'Q') WHEN '1' THEN M2.ORDER_QTY END) AS Q1
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '04' THEN M2.ORDER_QTY END) AS M04
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '05' THEN M2.ORDER_QTY END) AS M05
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '06' THEN M2.ORDER_QTY END) AS M06
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'Q') WHEN '2' THEN M2.ORDER_QTY END) AS Q2
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '07' THEN M2.ORDER_QTY END) AS M07
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '08' THEN M2.ORDER_QTY END) AS M08
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '09' THEN M2.ORDER_QTY END) AS M09
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'Q') WHEN '3' THEN M2.ORDER_QTY END) AS Q3
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '10' THEN M2.ORDER_QTY END) AS M10
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '11' THEN M2.ORDER_QTY END) AS M11
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'MM') WHEN '12' THEN M2.ORDER_QTY END) AS M12
      ,SUM(CASE TO_CHAR(M1.OUTBOUND_DATE, 'Q') WHEN '4' THEN M2.ORDER_QTY END) AS Q4
  FROM LO_OUT_M M1
       JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
 WHERE M1.OUTBOUND_DATE BETWEEN '2019-01-01' AND '2019-12-31'
 
------------------------------------------------------------ 4번 문제 ----------------------------------

SELECT L1.*
   FROM(
       SELECT CASE WHEN ROWNUM <= 5 THEN ROWNUM  ELSE 0               END AS RNUM                                                             
             ,CASE WHEN ROWNUM <= 5 THEN ITEM_CD ELSE '99999'         END AS ITEM_CD
             ,CASE WHEN ROWNUM <= 5 THEN ITEM_NM ELSE 'TOP5제외 합계' END AS ITEM_NM
             ,SUM(ORDER_QTY) AS ORDER_QTY
         FROM (
               SELECT --+ ORDERED USE_NL(M2)
                    M2.ITEM_CD
                   ,M2.ITEM_NM
                   ,SUM(M2.ORDER_QTY) AS ORDER_QTY
               FROM LO_OUT_M M1
                    JOIN LO_OUT_D M2 ON M2.INVOICE_NO = M1.INVOICE_NO
                                     AND M2.ITEM_NM LIKE '%참치%'
              WHERE OUTBOUND_DATE BETWEEN '2019-06-01' AND '2019-06-30'
              GROUP BY M2.ITEM_CD, M2.ITEM_NM
              ORDER BY ORDER_QTY DESC
              )
        GROUP BY CASE WHEN ROWNUM <= 5 THEN ROWNUM  ELSE 0               END                                                              
                ,CASE WHEN ROWNUM <= 5 THEN ITEM_CD ELSE '99999'         END 
                ,CASE WHEN ROWNUM <= 5 THEN ITEM_NM ELSE 'TOP5제외 합계' END 
      ) L1
 ORDER BY CASE RNUM WHEN 0 THEN 2 ELSE 1 END
         ,RNUM                                            