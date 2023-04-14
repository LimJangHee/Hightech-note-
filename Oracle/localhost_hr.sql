select * from tab;

create table t_test (
      id      varchar2(20) primary key
     ,name varchar2(20) not null
);

select * from t_test;

insert into t_test(id, name)
    values('hong', 'ȫ�浿');

commit;