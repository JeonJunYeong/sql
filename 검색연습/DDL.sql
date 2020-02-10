-- DDL


drop table member;

create table member(
	no integer unsigned not null auto_increment,
    email varchar(50) not null,
    password varchar(64) not null,
    name varchar(25) not null, 
    dept_name varchar(25) not null,
    primary key(no)
);

desc member;

-- 예제2 member 테이블에 juminbunho char 타입, 반드시 입력되어야 하는 칼럼을 추가하세요 accessible
-- desc member로 추가 결과를 확인해 보세요.accessible


alter table member add juminbunho char(13) not null after no;

desc member;
-- 예제3 예제 2에서 추가했던, juminbunho 칼럼을 삭제 하세요. desc member로 결과를 확인해 보세요.


alter table member drop juminbunho;

-- 예제4 member 테이블에 회원 가입날짜 datetime 타입의 join_date 이름의 칼럼을 추가하세요  반드시입력되어야 하는 컬럼입니다.

alter table member add join_date datetime not null ;

desc member;

-- 칼럼 수정
alter table member change no no int unsigned not null auto_increment;
desc member;

-- 
alter table member change dept_name department_name varchar(25) not null;
desc member;


alter table member change name name varchar(10) not null;



alter table member rename user;
desc user;


insert into user values(
	null,
	'iasdfasf@Naver.com',
	password('1234'),
	'김갑동',
	'시스템 개발팀',
	now());
    
    select * from user;


insert 
	into user(name,email,password,department_name,join_date)
values('dd','asfs@naver.com',password('1234'),'솔루션개발팀',now());

update user
   set join_date= (select now()), name='jjy1'
where no=1;


















