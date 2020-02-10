-- join

-- 예제 8 employees 테이블과 titles 테이블을 join 하여 직원의 이름과 직책을 모두 출력하세요


select concat(a.last_name,' ',a.first_name) AS name, a.emp_no , b.title
from employees a,titles b
where a.emp_no=b.emp_no;

-- 여성 엔지니어만 출력


select concat(a.last_name,' ',a.first_name) AS name, a.emp_no , b.title
from employees a,titles b
where a.emp_no=b.emp_no 
	and a.gender='f' and b.title='Engineer';
    
    
    
-- natural join
-- 두테이블에 공통 칼럼이 있으면 별다른 조인 조건 없이 묵시적으로 조인됨
-- 쓸일이 없음

select concat(a.first_name, ' ' , a.last_name)as name,b.title
from employees a join titles b;



-- join using

select concat(a.first_name, ' ' , a.last_name)as name,b.title
from employees a join titles b USING(emp_no);

-- join on 

select concat(a.first_name,' ', a.last_name) as name, b.title 
from employees a
join titles b 
  on a.emp_no = b.emp_no
  where a.gender='f' and b.title='Engineer';



-- 현재 회사 상황을 반영한 직원별 근무부서를 사번,지구언 전체이름, 근무부서 형태로 출력해보세요

select a.emp_no, concat(a.first_name,' ',a.last_name) as name, c.dept_name
from employees a
join dept_emp b on a.emp_no=b.emp_no
join departments c on b.dept_no=c.dept_no
where b.to_date='9999-01-01';


-- 현재 회사에서 지급되고 있는 급여체계를 반여한 결과를 출력하세요. 사번, 전체이름, 연봉 이런 형태로 출력하세요.
select a.emp_no, concat(a.first_name,' ',a.last_name) as name ,b.salary
from employees a
join salaries b on a.emp_no=b.emp_no
where b.to_date='9999-01-01';


select a.emp_no ,concat(a.first_name,' ',a.last_name) as name, b.salary
from employees a ,  salaries b
where a.emp_no=b.emp_no and b.to_date='9999-01-01';










