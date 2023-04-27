/*
    t_board (게시판) 테이블
    번호           숫자형            기본키(unique  + not null)
    제목           문자형            필수항목   
    작성자        문자형            필수항목
    등록일        날짜형            현재시간으로 등록
 */
 
 create table t_board(
        no                 number(5)          primary key
       ,title              varchar2(200)     not null
       ,writer            varchar2(100)     not null
       ,reg_date        date                    default sysdate
);

-- drop table t_board


-- 게시판 일련번호 생성
/*
create sequence seq_01;

select seq_01.nextval from dual;


create sequence seq_02
    start with 2023000001;
    
select seq_02.nextval from dual;
*/

create sequence seq_t_board_no; -- 시퀀스, 테이블명, 컬럼명
alter sequence seq_t_board_no nocache; -- 한번에 20개씩 가져와서 쓰기 때문에 다음 생성시 21부터 생성됨 이를 제거하기 위해서 사용
-- drop sequence seq_t_board_no; -- 삭제할때

select * from t_board;




create table a_board(
        no number(5) primary key
       ,ID varchar2(100) not null
       ,PW varchar2(100) not null
       ,name varchar2(100) not null
       ,birth varchar2(100) not null
       ,email varchar2(200) not null
       ,pnum varchar2(200) not null
);

drop table a_board;

create sequence seq_a_board_no nocache;

drop sequence seq_a_board_no;