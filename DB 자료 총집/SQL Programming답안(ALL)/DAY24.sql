--실전문제① ▶ 결과창에 텍스트 출력하는 PROCEDURE 만들기--------------------------------------------
CREATE OR REPLACE PROCEDURE EDU_USER.DAY23_1_SKP
AS
/*--------------------------------------------------------------------------------------------------
 * SP 명        : DAY23_1_SKP
 * 기능설명     : 프로시저 설명용 프로그램 
 * 사용UNIT     
 * 작성자       : 아세테크
 * 수정자       : 아세테크
 * 작성일자     : 2019-12-10
 * 수정일자     :                                
 * RETURN VALUE : 
--------------------------------------------------------------------------------------------------*/

--변수선언------------------------------------------------------------------------------------------
V_STRING      VARCHAR2(100);
----------------------------------------------------------------------------------------------------

BEGIN

  V_STRING := '현재 시간은 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ' 입니다.';
  
  DBMS_OUTPUT.PUT_LINE(V_STRING);

EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
----------------------------------------------------------------------------------------------------










--실전문제② ▶ 테이블에 레코드 1건 입력하는 PROCEDURE 만들기----------------------------------------
CREATE OR REPLACE PROCEDURE EDU_USER.DAY23_2_SKP (
  P_USER_ID              IN  ZZ_TEST_SAMPLE.REG_USER_ID%TYPE                                        --사용자ID
   
 ,O_MSG                 OUT VARCHAR2
) AS
/*--------------------------------------------------------------------------------------------------
 * SP 명        : DAY23_2_SKP
 * 기능설명     : 샘플용 프로그램 
 * 사용UNIT     
 * 작성자       : 아세테크
 * 수정자       : 아세테크
 * 작성일자     : 2019-12-06
 * 수정일자     :                                
 * RETURN VALUE : 
--------------------------------------------------------------------------------------------------*/

--변수선언------------------------------------------------------------------------------------------
V_STRING      VARCHAR2(100);
V_NUMBER      NUMBER;
----------------------------------------------------------------------------------------------------

BEGIN

  V_STRING := '현재 시간은 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ' 입니다.';
  V_NUMBER := MYSEQ1.NEXTVAL;

  --DML작성-----------------------------------------------------------------------------------------
  BEGIN
  
    INSERT INTO ZZ_TEST_SAMPLE
           (ID      , CONTENTS, REG_USER_ID, REG_DATETIME)
    VALUES (V_NUMBER, V_STRING, P_USER_ID  , SYSDATE     );
  
  EXCEPTION
    WHEN OTHERS THEN
      O_MSG := '1[' || SQLCODE || '] ' || SQLERRM;
      ROLLBACK;
      RETURN;
  
  END;
  --------------------------------------------------------------------------------------------------
  
  O_MSG := 'OK';
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    O_MSG := '[' || SQLCODE || '] ' || SQLERRM;
END;
/
----------------------------------------------------------------------------------------------------
