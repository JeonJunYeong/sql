-- 현재 직책이 Enginner인 직원들에 대해서만 평균급여를 구하세요.

select avg(b.salary)
from titles a, salaries b
where a.emp_no=b.emp_no and
	a.title='Engineer' and
    a.to_date='9999-01-01' and
    b.to_date='9999-01-01';


-- 현재 부서별로 현재 직책이 Enginner인 직원들에 대해서만 평균급여를 구하세요.


select c.dept_no,d.dept_name,avg(b.salary)
from titles a, salaries b, dept_emp c, departments d
where a.emp_no=b.emp_no and
	b.emp_no=c.emp_no and 
    c.dept_no=d.dept_no and
	a.title='Engineer' and
    a.to_date='9999-01-01' and
    c.to_date='9999-01-01' and
    b.to_date='9999-01-01'
group by c.dept_no;






-- 현재 직책별로 급여의 총합을 구하되 Enginner 직책은 제외하세요 단, 총합이 2,000,000,000 이상인 직책만 나타내며 급여 총합에 대해서 내림차순으로 정렬하세요.

select * 
from salaries;

select * from titles;

select b.title,sum(a.salary)
from salaries a,titles b
where a.emp_no=b.emp_no 
	and a.to_date='9999-01-01' 
    and b.to_date='9999-01-01'
    and b.title != 'Engineer'
group by b.title
having sum(a.salary)>2000000000
order by sum(a.salary) desc;
		