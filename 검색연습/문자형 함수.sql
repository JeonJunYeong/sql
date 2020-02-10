select upper('Seoul'), ucase('seoul');
select lower('Seoul'), lcase('seoul');


-- 예제 employees 테이블에서 lst_name이 acton인 사원의 이름, 성별, 입사일 출력

select upper(concat(first_name,' ',last_name)) as 이름, gender as 성별 , hire_date as 입사일
from employees
where last_name='Acton';



select substring('Happy Day',3,2);

-- 예제 employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력

select concat(first_name,' ',last_name) as 이름 , hire_date as 입사일
from employees
where substring(hire_date,1,4)='1989';


select lpad('hi',5,'?'),lpad('joe','7','*');


-- 예제 salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시

select emp_no,lpad(cast(salary as char),10,'*')
from salaries
where substring(from_date,1,4)=2001 and salary<=70000;



select concat('---',ltrim('   hello    '),'---'),
	   concat('---',rtrim('         hello       '),'---'),
       concat('---',trim('   hello    '),'---'),
	   concat('---',trim(both ' ' from'   hello   '),'---'),
       concat('---',trim(leading 'X' from'XXhelloXXX'),'---'),
       concat('---',trim(trailing 'X' from'XXhelloXXX'),'---');
       
       
-- 예제 salaries 테이블에 대한 lpad 예제의 결과를 * 생략하여 표시 

select emp_no, trim(leading '*' from lpad(cast(salary as char),10,'*'))
from salaries
where substring(from_date,1,4)=2001
and salary<70000;
       
































