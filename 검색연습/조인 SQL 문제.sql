-- 조인 SQL


-- 문제1) 현재 급여가 많은 직우너부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.

SELECT 
    a.emp_no AS 사번,
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.salary AS 연봉
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND to_date = '9999-01-01'
ORDER BY b.salary DESC;


-- 문제2) 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.

SELECT 
    a.emp_no AS 사번,
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.title AS 직책
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name);


-- 문제3) 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.

select  a.emp_no AS 사번, CONCAT(a.first_name, ' ', a.last_name) AS 이름, c.dept_name as 부서
from employees a, dept_emp b, departments c
where a.emp_no=b.emp_no
	AND b.dept_no=c.dept_no
    AND b.to_date='9999-01-01'
ORDER BY CONCAT(a.first_name,' ',a.last_name);    

-- 문제4) 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.


SELECT 
    a.사번, a.이름, a.연봉, b.직책, c.부서
FROM
    (SELECT 
        a.emp_no AS 사번,
            CONCAT(a.first_name, ' ', a.last_name) AS 이름,
            b.salary AS 연봉
    FROM
        employees a, salaries b
    WHERE
        a.emp_no = b.emp_no
            AND to_date = '9999-01-01'
	) a,
    (SELECT 
        a.emp_no AS 사번, b.title AS 직책
    FROM
        employees a, titles b
    WHERE
        a.emp_no = b.emp_no
            AND b.to_date = '9999-01-01') b,
    (SELECT 
        a.emp_no AS 사번, c.dept_name AS 부서
    FROM
        employees a, dept_emp b, departments c
    WHERE
        a.emp_no = b.emp_no
            AND b.dept_no = c.dept_no
            AND b.to_date = '9999-01-01') c
WHERE
    a.사번 = b.사번
        AND b.사번 = c.사번;
-- ORDER BY A.이름;

SELECT 
    a.emp_no AS 사번,
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.salary AS 연봉,
    c.title AS 직책,
    d.dept_name AS 부서
FROM
    employees a,
    salaries b,
    titles c,
    (SELECT 
        b.emp_no, a.dept_name
    FROM
        departments a, dept_emp b
    WHERE
        a.dept_no = b.dept_no
            AND b.to_date = '9999-01-01') d
WHERE
    a.emp_no = b.emp_no
        AND b.emp_no = c.emp_no
        AND c.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name);
         
         



-- 문제5) 'Technique Leader' 의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요 
-- (현재 'Technique Leader 의 직책으로 근무하는 사원은 고려하지않습니다) 이름은 first_name 과 last_name을 합쳐 출력합니다.


SELECT 
    a.emp_no as 사번, CONCAT(first_name, ' ', last_name) as 이름
FROM
    employees a,
    (SELECT 
        emp_no, title, to_date
    FROM
        titles
    WHERE
        title LIKE 'Technique Leader'
            AND to_date != '9999-01-01') b
WHERE
    a.emp_no = b.emp_no;



-- 문제 6 직원 이름(last_name) 중에서 S로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요 

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.dept_name AS 부서명,
    a.title AS 직책
FROM
    (SELECT 
        a.emp_no, a.first_name, a.last_name, b.title
    FROM
        employees a, titles b
    WHERE
        a.emp_no = b.emp_no
            AND b.to_date = '9999-01-01') a,
    (SELECT 
        a.dept_no, a.dept_name, b.emp_no
    FROM
        departments a, dept_emp b
    WHERE
        a.dept_no = b.dept_no
            AND b.to_date = '9999-01-01') b
WHERE
    a.emp_no = b.emp_no
        AND a.last_name LIKE 's%';



-- 문제7) 현재 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.


select a.emp_no, a.first_name, a.last_name ,b.title
from employees a, titles b
where a.emp_no=b.emp_no 
	and b.to_date='9999-01-01' 
    and b.title like 'Engineer';

select a.emp_no,b.salary
from employees a, salaries b
where a.emp_no=b.emp_no
	and b.to_date='9999-01-01' 
    and salary>=40000;


SELECT 
    a.emp_no AS 사번,
    CONCAT(first_name, ' ', last_name) AS 이름,
    a.title AS 직책,
    b.salary AS 급여
FROM
    (SELECT 
        a.emp_no, a.first_name, a.last_name, b.title
    FROM
        employees a, titles b
    WHERE
        a.emp_no = b.emp_no
            AND b.to_date = '9999-01-01'
            AND b.title LIKE 'Engineer') a,
    (SELECT 
        a.emp_no, b.salary
    FROM
        employees a, salaries b
    WHERE
        a.emp_no = b.emp_no
            AND b.to_date = '9999-01-01'
            AND salary >= 40000
    ORDER BY salary DESC) b
WHERE
    a.emp_no = b.emp_no;
    
 SELECT  a.emp_no AS 사번,
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.title AS 직책,
    c.salary AS 급여
 FROM employees a, titles b, salaries c
 WHERE a.emp_no= b.emp_no 
	AND b.emp_no=c.emp_no
    AND b.to_date='9999-01-01'
    AND b.title LIKE 'Engineer'
    AND c.to_date='9999-01-01'
    AND c.salary>=40000
ORDER BY c.salary;
    
-- order by b.salary;
    

-- 문제8) 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오 

select a.emp_no, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no 
	AND b.salary>50000
	AND b.to_date='9999-01-01'
    ORDER BY b.salary desc ;


select a.emp_no, b.title
from employees a, titles b
where a.emp_no = b.emp_no;


SELECT 
  b.title as 직책, a.salary as 급여 
FROM
    (SELECT 
        a.emp_no, b.salary
    FROM
        employees a, salaries b
    WHERE
        a.emp_no = b.emp_no AND b.salary > 50000
            AND b.to_date = '9999-01-01') a,
    (SELECT 
        a.emp_no, b.title
    FROM
        employees a, titles b
    WHERE
        a.emp_no = b.emp_no) b
WHERE
    a.emp_no = b.emp_no;
-- order by a.salary;
   
   
SELECT b.salary , c.title
FROM employees a, salaries b, titles c 
where a.emp_no=b.emp_no 
	AND b.emp_no=c.emp_no
    AND b.to_date='9999-01-01'
    AND c.to_date='9999-01-01'
    AND b.salary>50000
ORDER BY b.salary desc;
   
   
-- 문제9) 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.

SELECT dept_no,sum(salary)
FROM dept_emp a, salaries b 
WHERE a.emp_no=b.emp_no
	and a.to_date='9999-01-01' 
    and b.to_date='9999-01-01'
group by dept_no
order by sum(salary);



select a.dept_no as 부서번호, a.dept_name as 부서이름, b.avg_salary as 부서별평균 
from departments a, (SELECT dept_no,avg(salary) as avg_salary
FROM dept_emp a, salaries b 
WHERE a.emp_no=b.emp_no
	and a.to_date='9999-01-01' 
    and b.to_date='9999-01-01'
group by dept_no)b
where a.dept_no=b.dept_no
order by avg_salary desc;


-- 문제10 현재 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.accessible

select a.title as 직책 ,avg(b.salary) as 평균연봉
from titles a,salaries b
where a.emp_no=b.emp_no
	and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
group by a.title
order by avg(b.salary) desc;