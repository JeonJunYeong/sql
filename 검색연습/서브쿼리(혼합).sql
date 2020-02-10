-- 문제1) 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?

select avg(salary)
from salaries
where to_date='9999-01-01';



SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    to_date = '9999-01-01'
        AND salary > (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01');
            
            
-- 문제2) 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 부서 연봉을 조회하세요. 
-- 단 조회 결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다.

SELECT 
    a.emp_no AS 사번,
    CONCAT(c.first_name, ' ', c.last_name) AS 이름,
    a.dept_name AS 부서,
    MAX(salary) AS 연봉
FROM
    (SELECT 
        a.emp_no, a.dept_no, a.to_date, b.dept_name
    FROM
        dept_emp a, departments b
    WHERE
        a.dept_no = b.dept_no) a,
    salaries b,
    employees c
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY dept_no
ORDER BY MAX(salary);

-- 문제3 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번 이름과 연봉을 조회하세요.


select a.emp_no,concat(a.first_name,' ',a.last_name), b.dept_no,c.salary
from employees a, dept_emp b,salaries c
where a.emp_no=b.emp_no
	and b.emp_no=c.emp_no
	and b.to_date='9999-01-01'
    and c.to_date='9999-01-01';



select dept_no,avg(b.salary)
from dept_emp a,salaries b
where a.emp_no=b.emp_no
	and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by dept_no;


SELECT 
    a.사번, a.이름, a.연봉
FROM
    (SELECT 
        a.emp_no AS 사번,
            CONCAT(a.first_name, ' ', a.last_name) AS 이름,
            b.dept_no,
            c.salary AS 연봉
    FROM
        employees a, dept_emp b, salaries c
    WHERE
        a.emp_no = b.emp_no
            AND b.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01') a,
    (SELECT 
        dept_no, AVG(b.salary) AS avg_salary
    FROM
        dept_emp a, salaries b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY dept_no) b
WHERE
    a.dept_no = b.dept_no
        AND a.연봉 > b.avg_salary;
        
        
        
-- 문제4) 현재, 사원들의 사번, 이름 매니저 이름, 부서 이름으로 출력해 보세요


SELECT 
        a.dept_name,b.emp_no, b.dept_no, b.to_date
    FROM
        departments a, dept_emp b
    WHERE
        a.dept_no = b.dept_no;
SELECT 
   *
FROM
    (SELECT 
        a.dept_name,b.emp_no, b.dept_no, b.to_date
    FROM
        departments a, dept_emp b
    WHERE
        a.dept_no = b.dept_no) a,
    dept_manager b,
    employees c
WHERE
    a.dept_no = b.dept_no
        AND a.emp_no = c.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01';
    
select a.emp_no ,a.dept_no, b.emp_no ,concat(c.first_name,' ',c.last_name)
from dept_emp a,dept_manager b,employees c
where a.dept_no=b.dept_no 
and c.emp_no=b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01';


SELECT 
    a.emp_no as 사원번호,
    CONCAT(a.first_name, ' ', a.last_name) as 사원이름,
    b.매니저,
    b.부서이름
FROM
    employees a,
    (SELECT 
		a.dept_name as 부서이름,
        a.emp_no as 사번,
            a.dept_no as 부서번호,
            b.emp_no ,
            CONCAT(c.first_name, ' ', c.last_name) AS 매니저
    FROM
        (SELECT 
        a.dept_name,b.emp_no, b.dept_no, b.to_date
    FROM
        departments a, dept_emp b
    WHERE
        a.dept_no = b.dept_no) a, dept_manager b, employees c
    WHERE
        a.dept_no = b.dept_no
            AND c.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01') b
WHERE
    a.emp_no = b.사번;



-- 문제5 현재 평균연봉이 가장 높은 부서의 사원들의 사번,이름,직책,연봉을 조회하고 연봉순으로 출력하세요

select dept_no
from dept_emp a,salaries b
where a.emp_no=b.emp_no
group by dept_no
order by avg(salary) desc
limit 0,1;


SELECT 
    a.emp_no AS 사번,
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    d.title AS 직책,
    b.salary AS 연봉
FROM
    employees a,
    salaries b,
    dept_emp c,
    titles d
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND c.emp_no = d.emp_no
        AND b.to_date='9999-01-01'
        AND c.to_date='9999-01-01'
        AND d.to_date='9999-01-01'
        AND c.dept_no = (SELECT 
            dept_no
        FROM
            dept_emp a,
            salaries b
        WHERE
            a.emp_no = b.emp_no
            AND a.to_date='9999-01-01'
            AND b.to_date='9999-01-01'
        GROUP BY dept_no
        ORDER BY AVG(salary) DESC
        LIMIT 0 , 1)
ORDER BY b.salary;




-- 문제 6 평균 연봉이 가장 높은 부서는?
SELECT 
    dept_name
FROM
    departments
WHERE
    dept_no = (SELECT 
            dept_no
        FROM
            dept_emp a,
            salaries b
        WHERE
            a.emp_no = b.emp_no 
            and a.to_date='9999-01-01'
            and b.to_date='9999-01-01'
        GROUP BY dept_no
        ORDER BY AVG(salary) DESC
        LIMIT 0 , 1);



-- 문제 7 평균 연봉이 가장 높은 직책?

SELECT 
    b.title
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
ORDER BY AVG(salary) DESC
LIMIT 0 , 1;




-- 문제8 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저이름, 매니저연봉순으로 출력합니다.


select a.emp_no , a.salary as 매니저연봉,b.dept_no 
from salaries a,dept_manager b
where a.emp_no=b.emp_no
and a.to_date='9999-01-01'
and b.to_date='9999-01-01'
group by a.emp_no;



SELECT 
    a.emp_no AS 사번,
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.salary AS 연봉,d.매니저연봉 
FROM
    employees a,
    salaries b,
    dept_emp c,
    (SELECT 
        a.emp_no, a.salary AS 매니저연봉, b.dept_no
    FROM
        salaries a, (SELECT a.emp_no ,b.to_date,concat(a.first_name,' ',a.last_name) as 이름, b.dept_no 
					FROM employees a, dept_manager b
					WHERE a.emp_no=b.emp_no) b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY a.emp_no) d
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND b.salary > d.매니저연봉;

