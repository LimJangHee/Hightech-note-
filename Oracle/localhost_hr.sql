/*
    t_board (�Խ���) ���̺�
    ��ȣ           ������            �⺻Ű(unique  + not null)
    ����           ������            �ʼ��׸�   
    �ۼ���        ������            �ʼ��׸�
    �����        ��¥��            ����ð����� ���
 */
 
 create table t_board(
        no                 number(5)          primary key
       ,title              varchar2(200)     not null
       ,writer            varchar2(100)     not null
       ,reg_date        date                    default sysdate
);

-- drop table t_board


-- �Խ��� �Ϸù�ȣ ����
/*
create sequence seq_01;

select seq_01.nextval from dual;


create sequence seq_02
    start with 2023000001;
    
select seq_02.nextval from dual;
*/

create sequence seq_t_board_no; -- ������, ���̺��, �÷���
alter sequence seq_t_board_no nocache; -- �ѹ��� 20���� �����ͼ� ���� ������ ���� ������ 21���� ������ �̸� �����ϱ� ���ؼ� ���
-- drop sequence seq_t_board_no; -- �����Ҷ�

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