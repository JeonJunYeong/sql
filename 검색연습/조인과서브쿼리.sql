-- FROM 절의 서브쿼리

select now() as a,sysdate() as b, 3+1 as c;
select a,b,c from(select now() as a, sysdate() as b, 3+1 as c) a;

-- WHERE 절의 서브쿼리 : 단일행
-- 단일행 연산자 : =,>,<,<=,>=,<>

-- 예제 현재 Fai Bale 이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요


SELECT 
    b.dept_no
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale';
    
    
select a.emp_no,concat(a.first_name,' ',a.last_name) as name
from employees a, dept_emp b
where a.emp_no =b.emp_no
and b.to_date='9999-01-01'
and b.dept_no=(select b.dept_no
				from employees a, dept_emp b
				where a.emp_no=b.emp_no
				and b.to_date='9999-01-01'
				and concat(a.first_name,' ',a.last_name)='Fai Bale');
				
                
                
                
-- 실습문제 1: 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요accessible


select avg(salary)
from salaries
where to_date='9999-01-01';

SELECT 
    a.emp_no, CONCAT(a.first_name, ' ', a.last_name) AS name, b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
		AND b.to_date='9999-01-01'
        AND b.salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01');

-- 실습문제2: 현재 가장적은 평균 급여를 받고 있는 직책에해서 평균 급여를 구하세요accessible


-- 1)

SELECT 
    a.title, AVG(b.salary) AS avg_salary
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY a.title
HAVING ROUND(avg_salary) = ROUND((SELECT 
                MIN(avg_salary)
            FROM
                (SELECT 
                    a.title, AVG(salary) AS avg_salary
                FROM
                    salaries b, titles a
                WHERE
                    a.emp_no = b.emp_no
                        AND b.to_date = '9999-01-01'
                        AND a.to_date = '9999-01-01'
                GROUP BY a.title) a));

-- 2)TOP-K ORDER BY 한 후에 TOP부터 K개를 뺴내는것 


SELECT 
    a.title, AVG(b.salary) AS avg_salary
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY a.title
HAVING ROUND(avg_salary) = ROUND((SELECT 
                MIN(avg_salary)
            FROM
                (SELECT 
                    a.title, AVG(salary) AS avg_salary
                FROM
                    salaries b, titles a
                WHERE
                    a.emp_no = b.emp_no
                        AND b.to_date = '9999-01-01'
                        AND a.to_date = '9999-01-01'
                GROUP BY a.title
                ORDER BY avg_salary ASC
                LIMIT 0 , 1) a));


-- 3) JOIN으로만 해결 : 서브쿼리를 사용할 필요가 없음 
SELECT 
    a.title, AVG(salary) AS avg_salary
FROM
    salaries b,
    titles a
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND a.to_date = '9999-01-01'
GROUP BY a.title
ORDER BY avg_salary ASC
LIMIT 0 , 1;
									
    
    
    
-- WHERE 절의 서브쿼라 : 복수행
-- 복수행 연산자 : IN , NOT IN, ANY, ALL 

-- any 사용법 
-- 1. =any :  in과 완전 동일
-- 2. >any, >=any : 최솟값 비교 
-- 3. <any, <=any : 최대값 비교 
-- 4. <> any : not in 과 동일all

-- all 사용법 
-- 1. =all 
-- 2. >all, >=all: 최대값 비교
-- 3. <all, <=all: 최소값 비교


-- 예제 : 현재 급여가 50000이상인 직원 이름 출력 



-- sol1
select concat(a.first_name,' ',a.last_name) as name , b.salary
from employees a,salaries b 
where a.emp_no=b.emp_no and salary>=50000 and b.to_date='9999-01-01';

-- sol 2
select concat(first_name,' ',last_name) as name
from employees
where emp_no IN (SELECT emp_no from salaries where to_date = '9999-01-01' and salary>=50000);

-- sol3
select concat(a.first_name,' ',a.last_name) as name, b.salary
from employees a, (select emp_no,salary from salaries where to_date='9999-01-01' and salary>50000) b
where a.emp_no =b.emp_no ;


-- 현재 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력 

-- sol1) where subquery

	select a.dept_no, max(salary) 
    from dept_emp a, salaries b
    where a.emp_no = b.emp_no
		and a.to_date='9999-01-01'
        and b.to_date='9999-01-01'
	group by a.dept_no;
    
    
    select a.first_name,b.salary
    from employees a, salaries b, dept_emp c
    where a.emp_no = b.emp_no 
		and b.emp_no = c.emp_no
        and b.to_date = '9999-01-01'
        and c.to_date = '9999-01-01'
        and (c.dept_no, b.salary) IN (select a.dept_no, max(salary) 
    from dept_emp a, salaries b
    where a.emp_no = b.emp_no
		and a.to_date='9999-01-01'
        and b.to_date='9999-01-01'
	group by a.dept_no);

    
-- sol2) from subquery








    