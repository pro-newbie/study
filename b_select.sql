-- Q1.) 전체 테이블 목록을 출력하자.  
use my_emp;
select * from emp;

-- Q2.) 사원의 이름 , 봉급, 커미션을 출력해보자. 
select ename, sal, comm from emp;

-- Q3.)  사원의 이름과 매니저를 출력해보자. 
select  ename, mgr from emp;

-- Q4.) 사원의 이름과 연봉을 출력해보자
select ename, sal*12 from emp;

-- Q5) 사원의 이름과 급여를 출력하되 급여 = 봉급 + 커미션으로 계산하자.
select ename, sal, comm, sal+comm as 급여 from emp;  # null은 연산이 불가능하다.

-- null값을 0으로 만들자, ifnull(널값컬럼, 대입값), oracle = nvl
select comm, ifnull(comm,0), ifnull(comm,sal) from emp;

select ename, sal, comm, sal+ifnull(comm,0) as 급여 from emp;  # null은 연산이 불가능하다.

-- Q6) 커미션이 측정되지 않으면 '없음'이라고 출력하고 사원의 이름과 커미션을 출력해보자.
select ename, ifnull(comm,'없음') as 커미션 from emp;

-- Q7) 커미션이 책정되지 않은 사원의 커미션을 3000으로 지정한 후 시원의 이름, 봉급, 커미션을 출력해보자.
select ename '사원의 이름', sal 봉급, ifnull(comm,3000) 커미션 from emp;

-- Q8) '사원의 이름', 봉급, 커미션, 세금, 급여를 별칭을 주고 출력하자.
-- 급여 = 봉급 + 커미션 - 세금, (세금 = 봉급의 15%)
select ename as '사원의 이름', sal as 봉급, comm as 커미션, 
(sal*0.15) as 세금, (sal+ifnull(comm,0))-(sal*0.15) as 급여 from emp;

/*
비교연산 >  >=  <=  =  !=   <>  and   or
select ----3
from   ----1
where  ----2  결과가 TRUE/FALSE
*/

-- Q1) 사원의 봉급이 1000 이상인 사원의 이름과 봉급을 출력 해보자.
select ename, sal from emp where sal >= 1000;

-- Q2) 부서 번호가 10번인 사원과 부서 번호를 출력 해보자.
select ename, deptno from emp where deptno = 10;

-- Q3) 부서 번호가 10번이고 월급이 1000 이상인 사원의 이름, 부서번호, 월급을 출력하자.
select ename, deptno, sal from emp where deptno = 10 and sal >= 1000;

-- Q4) 부서번호가 10, 20번인 사원의 이름과 부서번호를 출력해보자.
select ename, deptno from emp where deptno = 10 or deptno = 20;
select ename, deptno from emp where deptno in (10,20);

-- Q5) 사원의 입사 년도가 80년 이후에 입사한 사원의 이름과 입사일을 출력하자.
-- 날짜를 구분할 수 있는 표현 '년/월/일' , '년-월-일'
-- str_to_date ('17-11-1981', '%d-%m-%Y') / 숫자, 믄자열, 날짜

select str_to_date ('17-11-1981', '%d-%m-%Y') as 날짜;
select str_to_date ('17-11-1981', '%d-%m-%Y')-3 as 날짜;

select ename, hiredate from emp where hiredate >= '1980/01/01';
select ename, hiredate from emp where hiredate >= '1980-01-01';
select ename, hiredate from emp where hiredate >= '80-01-01';

/*
===========================
문자열 like  %[모든] _[하나]
'ABCD' like 'A%' => 'ABCD'
*/

-- Q1) 사원테이블에서 사원의 이름이 A로 시작하는 사원의 이름을 출력하자.
select ename from emp where ename like 'A%';

-- Q2) 사원의 이름에서 T가 2개들어간 사원의 이름을 출력하자.->
select ename from emp where ename like '%T%%T';

-- Q3) 사원테이블에서  L자가 2개 들어간 사원의 이름을 출력하자.
select ename from emp where ename like '%L%L%';

-- Q4) 사원의 이름이 T로 끝나는 사원의 이름을 출력하자.
select ename from emp where ename like '%T';

-- Q5) 사원의 이름이 A로 시작하고 N으로 끝나는 이름을 출력하자.
select ename from emp where ename like 'A%N';

-- Q6) 사원의 이름이 두번째가 M인 이름을 출력하자.
select ename from emp where ename like '_M%';

/*
select 컬럼1, 컬럼2, 컬럼3 from 테이블명 order by 정렬하고자 하는 컬럼명;
select 컬럼1, 컬럼2, 컬럼3 from 테이블명 order by 컬럼2;
select 컬럼1, 컬럼2, 컬럼3 from 테이블명 order by 2;

asc[default], desc  컬럼명 뒤에 오름차순, 내림차순을 적어준다.
*/

-- Q1) 사원테이블에서 사원의 이름을 오름차순으로 출력하자.
select ename 
from emp 
order by ename;

select ename 
from emp 
order by 1 asc;

-- Q2) 사원테이블에서 사원의 이름을 내림차순으로 출력하자.
select ename 
from emp 
order by ename desc;

select ename 
from emp 
order by 1 desc;

-- Q3) 사원 테이블에서 사원의 이름을 오름차순으로 구현하고 봉급을 내림차순으로 출력해보자.
select ename, sal
from emp
order by 1 asc, 2 desc;

select ename, sal
from emp
order by ename, 2 desc;

/*
집계 함수(컬럼명) : sum(), avg(), count(), max(), min(), var(), std(),,,
*/

-- Q1) 봉급을 집계 함수를 통해서 출력 해보자.
select sum(sal), avg(sal), count(sal), max(sal), min(sal)
from emp;

-- Q2) count(*) 함수를 사용해보자.
select count(ename), count(*), count(comm), count(ifnull(comm,0))
from emp;

-- Q3) max() 함수
select max(ename), max(comm), max(ifnull(comm,0))
from emp;

-- Q4) sum() 함수
select sum(ename), sum(comm), sum(ifnull(comm,0))
from emp;

-- Q5) 사원테이블에서 부서번호가 10번인 평균 월급을 구해보자.
select avg(sal)
from emp
where deptno = 10;

-- Q6) 사원테이블에서 부서번호가 10번과 20번인 평균 월급을 구해보자
select avg(sal)
from emp
where deptno = 10 or deptno = 20;

select avg(sal)
from emp
where deptno in (10,20);

-- Q7) 사원테이블에서 직업이 SALESMAN인 사원의 평균 월급을 구해보자
select avg(sal)
from emp
where job = 'SALESMAN';

select job, avg(sal)
from emp
where job = 'SALESMAN';

/*
select
from
group by

 -group by
1. group by 문 다음에는 데이터를 구분 짓기위한 표현식으로  해당 테이블의 컬럼 명이나 변수 값 등이 올수 있으며 
        그룹 함수를 사용한 형태는 올 수 없다< group by avg(sal) 안됨>
        --> 그룹함수는 그룹이 형성된 후에 그룹별로 계산되기 때문이다.

2. select-list에는 group by문에는 명시된 표현식과 그외 그룹합수를 사용한 표현식만이 올 수있다
     (*는 안됨 )
3. 출력된 결과를 정렬하기 위해 order by 문을 사용하면 된다
  단 order by 문 다음에는 select-list에서 명시된 컬럼 또는 표현식과 컬럼의 별칭(alias), 컬럼 번호 등만 사용
*/

-- Q1) 부서별 평균 월급을 구하자.
select deptno, avg(sal)  # 3
from emp              # 1
group by deptno       # 2
order by 2;           # 4

select deptno as no, avg(sal)
from emp
group by deptno
order by 2;

select deptno, avg(sal) as 평균월급
from emp
group by deptno
order by 2;

/*
실행순서
1) from -> group by -> 집계함수 -> select -> order by (where X)
2) from -> where -> group by -> 집계함수 -> select -> order by (where O)
*/

-- Q2) 직업별 평균 월급을 구하자.
select job, avg(saL)
from emp
group by job;

-- Q3) 부서별 평균 월급을 구하되 10번 부서의 평균 월급만 출력하자.
select deptno, avg(sal)
from emp
where deptno = 10
group by deptno;

-- Q4) 직업별 월급의 합을 구하자.
select job, sum(sal)
from emp
group by job;

-- Q5) 직업이 SALESMAN인 사원의 월급의 합을 구하라.
select job, sum(sal)
from emp
where job = 'SALESMAN';

-- Q6) 사원테이블에서 사원의 최대 월급을 출력하자.
select max(sal)
from emp;

-- Q7) 사원테이블에서 사원의 최소 월급을 출력하자.
select min(sal)
from emp;

-- Q8) 각 부서별 최대 월급을 출력하자.
select deptno, max(sal)
from emp
group by deptno;

/*
is [not] null
*/

-- Q1) 사원 테이블에서 커미션이 책정되어 있는 사원의 이름과 커미션을 출력하라.
select ename, comm
from emp
where comm is not null;

-- Q2) 사원 테이블에서 커미션이 책정되지 않은 사원의 이름과 커미션을 출력하라.
select ename, comm
from emp
where comm is null;

/*
having : 그룹함수로 집계된 데이터에 조건을 줄 때 사용
	- having 연산자는 group by 연산에 의해서 나누어진 데이터들을 다시 걸러주기 위해서 사용
    - 제2의 where 조건문이라고 할 수 있다.
    - having 다음에는 select-list에서 그룹핑에 사용한 컬럼과 그룹함수를 사용한 컬림에 대해서만 조건을 줄 수 있다.
*/

-- Q1) 직업별 총월급을 구하고, 총 월급이 5000이상인 것만 출력하자.
select job, sum(sal)
from emp
group by job
having sum(sal) >= 5000;

-- Q2) 부서별 월급의 합을 구하고 그 총합이 10000 이상인 것만 출력하자.
select deptno, sum(sal)
from emp
group by deptno
having sum(sal) >= 10000;

/*
with rollup = 그룹의 총계, 부분 소계
	- rollup 연산자는 group by 문과 함께 사용되며,
      group by 문에서 명시된 컬럼 순서대로 추가적인 요약 정보를 단계적으로 만들어 준다.
*/

-- Q1) 부서별 총합 뿐만 아니라 전체 총합 및 세부 내역을 출력해보자.
select deptno, ename, sum(sal)
from emp
group by deptno, ename with rollup;

-- Q2) rollup을 이용하여 직위별 사원의 이름과 월급을 출력하라.
select job, ename, sum(sal)
from emp
group by job, ename with rollup
order by 2;














