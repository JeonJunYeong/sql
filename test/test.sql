update test set name='또치' where no=2;



drop table test;
show tables;


create database bookshop;
create user 'bookshop'@'localhost' identified by 'bookshop';
grant all privileges on bookshop.* to 'bookshop'@'localhost';
flush privileges;

