------------------------------------------- 3번 문제 ---------------------------------------------

SELECT SUM(CASE MM WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE MM WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE MM WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE MM WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE MM WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE MM WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE MM WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE MM WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE MM WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE MM WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE MM WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE MM WHEN '12' THEN SET_QTY END) AS M12
  FROM(
       SELECT INVOICE_NO, OUTBOUND_DATE, OUT_TYPE_DIV, SET_QTY
              ,tO_CHAR(OUTBOUND_DATE, 'MM') AS MM
         FROM LO_OUT_M
        WHERE OUTBOUND_DATE BETWEEN TO_DATE(:YYYY || '0101', 'YYYY-MM-DD') AND TO_DATE(:YYYY || '1231', 'YYYY-MM-DD') 
      )

------------------------------------------ 4번 문제 ---------------------------------------------------
-- 행 조건 개수가 2개이상이기 때문에 GROUP BY를 해줘야 됨

SELECT OUTBOUND_DATE
      ,SUM(CASE MM WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE MM WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE MM WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE MM WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE MM WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE MM WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE MM WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE MM WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE MM WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE MM WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE MM WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE MM WHEN '12' THEN SET_QTY END) AS M12
  FROM(
       SELECT INVOICE_NO, OUTBOUND_DATE, OUT_TYPE_DIV, SET_QTY
              ,TO_CHAR(OUTBOUND_DATE, 'MM') AS MM
         FROM LO_OUT_M
        WHERE OUTBOUND_DATE BETWEEN TO_DATE(:YYYY || '0101', 'YYYY-MM-DD') AND TO_DATE(:YYYY || '1231', 'YYYY-MM-DD') 
      )
 GROUP BY OUTBOUND_DATE
 
 -------------------------------------- 5번 문제 ----------------------------------------------------------- 
 
 SELECT YYYY
      ,SUM(CASE MM WHEN '01' THEN SET_QTY END) AS M01
      ,SUM(CASE MM WHEN '02' THEN SET_QTY END) AS M02
      ,SUM(CASE MM WHEN '03' THEN SET_QTY END) AS M03
      ,SUM(CASE MM WHEN '04' THEN SET_QTY END) AS M04
      ,SUM(CASE MM WHEN '05' THEN SET_QTY END) AS M05
      ,SUM(CASE MM WHEN '06' THEN SET_QTY END) AS M06
      ,SUM(CASE MM WHEN '07' THEN SET_QTY END) AS M07
      ,SUM(CASE MM WHEN '08' THEN SET_QTY END) AS M08
      ,SUM(CASE MM WHEN '09' THEN SET_QTY END) AS M09
      ,SUM(CASE MM WHEN '10' THEN SET_QTY END) AS M10
      ,SUM(CASE MM WHEN '11' THEN SET_QTY END) AS M11
      ,SUM(CASE MM WHEN '12' THEN SET_QTY END) AS M12
  FROM(
       SELECT INVOICE_NO, OUTBOUND_DATE, OUT_TYPE_DIV, SET_QTY
              ,TO_CHAR(OUTBOUND_DATE, 'MM') AS MM
              ,TO_CHAR(OUTBOUND_DATE, 'YYYY') AS YYYY
         FROM LO_OUT_M
        WHERE OUTBOUND_DATE BETWEEN TO_DATE(:YYYY || '0101', 'YYYY-MM-DD') AND TO_DATE(:YYYY + 1 || '1231', 'YYYY-MM-DD') 
      )
 GROUP BY YYYY DESC
 
--------------------------------------- 6번 문제 ---------------------------------------------------------------------

SELECT INVOICE_NO, LINE_NO, ITEM_CD, ITEM_NM, ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724706214'
 ORDER BY CASE :SORT_TYPE WHEN 1 THEN LINE_NO
                          WHEN 2 THEN ORDER_QTY
           END 
         ,LINE_NO
         
-- DECODE(:SORT_TYPE, 1, LINE_NO, ORDER_QTY)         
------------------------------ 추가 팁 --------------------------------------
-- CASE문에서는 ASC, DESC를 RETURN해주지 못함-> 내림차순을 -로 표현해줘야됨        
        
SELECT INVOICE_NO, LINE_NO, ITEM_CD, ITEM_NM, ORDER_QTY
  FROM LO_OUT_D
 WHERE INVOICE_NO = '346724706214'
 ORDER BY CASE :SORT_TYPE WHEN 1 THEN ORDER_QTY
                          WHEN 2 THEN -ORDER_QTY
           END 
         ,LINE_NO        
                          