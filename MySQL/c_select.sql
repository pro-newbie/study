/*
CUBE = 소계 , 총계: GROUP BY 문과 함께 사용되며 GROUP BY 문에서 명시한 
전체 컬럼에서 대하여 추가적인 요약 정보를 단계적으로 만들어 준다 -> MySQL에는 CUBE가 없다.
*/

/*
GROUPING : GROUPING 함수는  그룹 기준에서 고려하지 않은 부분 총계인 경우에 1[롤업행]을 리턴하고,
                    그렇지 않은 경우 0[일반행]을 리턴한다. 
                    * 일반 그룹에 속해있는지, with rollup에 속해 있는지.
*/

-- Q1) 각 사원의 커미션의 합계, 각사원에 대한 커미션의 총합, 전체 커미션의 총합

SELECT ENAME, COMM, SUM(COMM) as SUM, GROUPING(ENAME), GROUPING(COMM)
FROM EMP
GROUP BY ENAME,COMM  WITH ROLLUP;

SELECT ENAME, comm, SUM(COMM) as SUM
FROM EMP
GROUP BY ENAME, comm with rollup;

select job, ename, sum(sal), grouping(job), grouping(ename)
from emp
group by job, ename with rollup
order by 2;


/*---------------ROW_NUMBER()---------------------------
SELECT ROW_NUMBER() [OVER  PARTITION BY, 
                            ORDER BY ]	
                    
 열 A 값의 내림차순으로 일련 번호 리턴 : SELECT ROW_NUMBER() OVER (ORDER BY A DESC);
 
 컬럼 X 의 값으로 그룹핑 분할 하고 ,그 중에서 컬럼 A 의 값의 내림차순으로 일련번호를 리턴
 SELECT ROW_NUMBER() OVER (PARTITION BY X ORDER BY  A DESC);
 
SELECT RANK() OVER  (PARTITION BY,   ORDER BY)	1,2,2,2,5,6,6,8
    ex) 3일에 입사한 모든 사원들은 같은순위를 받고, 그 다음 순위는 건너뛰게 된다.   
    
SELECT DENSE_RANK() OVER  (PARTITION BY,   ORDER BY )	1,2,2,2,3,4,4,5
    ex) 3일에 입사한 모든 사원들은 같은순위를 받고, 그 다음 순위는 건너뛰지않고 연속된다.                
  */
  
  -- Q1) 사원테이블에서 사원의 이름을 출력하되 1부터 번호를 매기자. no라는 별칭으로.
SELECT ROW_NUMBER()  OVER (ORDER BY ENAME ) as no, ENAME
FROM EMP;

-- Q2) 사원테이블에서 사원의 이름을 출력하되 14부터 거꾸로 번호를 매기자. no라는 별칭으로.
SELECT ROW_NUMBER()  OVER (ORDER BY ENAME) as no, ENAME
FROM EMP
order by 1 desc;

-- Q3) 사원테이블에서 사원의 이름이 Z~A 순으로 정렬이 되고 번호를 매기고 싶다. 별칭은 no.
SELECT ROW_NUMBER()  OVER (ORDER BY ENAME desc) as no, ENAME
FROM EMP;

-- Q4) 사원테이블에서 사원의 이름이 Z~A 순으로 정렬이 되고 번호를 매기고 싶다. 별칭은 no.
-- 홀수 라벨링 2N-1 -> N = row_number
SELECT (2 * ROW_NUMBER() OVER (ORDER BY ENAME desc) - 1) as no, ENAME
FROM EMP;

-- Q5) 사원테이블에서 사원의 이름이 Z~A 순으로 정렬이 되고 번호를 매기고 싶다. 별칭은 no.
-- 짝수 라벨링 2N -> N = row_number
SELECT (2 * ROW_NUMBER() OVER (ORDER BY ENAME desc)) as no, ENAME
FROM EMP;

-- Q6) 직업별로 그룹화 한 후 번호를 매겨서 출력하고 이름순으로 정렬하자.
SELECT ROW_NUMBER() OVER (PARTITION BY JOB ORDER BY ENAME) as no, job, ENAME
FROM EMP;

/*
group by : 테이블 내의 특정(열)의 값에 따라서 그룹화 하고 각 그룹에 집계함수를 적용한다.

row_number() : 각 행의 순서를 부여하는 기능, PARTITION BY 속성으로 지정하게 되면 특정열의 값에 따라
				  데이터를 여러 그룹으로 나눌 수 있고, order by 절에 따라 순서를 매긴다. (개별 O)
RANK() : 동일한 값에 같은 순위를 부여하고, 다음 순위는 중복된 개수만큼 건너뛴다.
DENSE_RANK() : 동일한 값에 같은 순위를 부여하고, 다음 순위는 건너뛰지않고 다음 번호를 부여한다.
*/

SELECT  RANK() OVER (ORDER BY  DAY(HIREDATE))  AS RANK_NO,
        DENSE_RANK() OVER (ORDER BY DAY(HIREDATE)) AS DENSE_NO,
        EMPNO, ENAME ,HIREDATE
FROM EMP;
        
SELECT  RANK() OVER  ( ORDER BY  YEAR(HIREDATE))  AS RANK_NO,
        DENSE_RANK() OVER  (  ORDER BY YEAR(HIREDATE)) AS DENSE_NO,
        EMPNO, ENAME ,HIREDATE
FROM EMP;      
  
SELECT  RANK() OVER  ( ORDER BY  MONTH(HIREDATE))  AS RANK_NO,
        DENSE_RANK() OVER  (  ORDER BY MONTH(HIREDATE)) AS DENSE_NO,
        EMPNO, ENAME ,HIREDATE
FROM EMP;  
  
 SELECT  RANK() OVER  ( ORDER BY  DATE(HIREDATE))  AS RANK_NO,
        DENSE_RANK() OVER  (  ORDER BY DATE(HIREDATE)) AS DENSE_NO,
        EMPNO, ENAME ,HIREDATE
FROM EMP;        
        
   SELECT  RANK() OVER  ( ORDER BY  WEEKDAY(HIREDATE))  AS RANK_NO,
        DENSE_RANK() OVER  (  ORDER BY WEEKDAY(HIREDATE)) AS DENSE_NO,
        EMPNO, ENAME ,HIREDATE, WEEKDAY(HIREDATE)
FROM EMP;         

SELECT WEEKDAY('23-12-13'); # 0  ~  6 월요일 ~ 일요일

/*(DATETIME OR DATE)
  YEAR(): 1000 ~  9999  4자리 표시  
  MONTH() : 1 ~ 12
  DAY ()  : 1~  31
  DAYOFMONTH()  = DAY()  
  HOUR() / MINUTE() / SECOND() 
  DATE_ADD( INTERVAL ) , DATE_SUB() 
 
*/

select year(hiredate), month(hiredate), day(hiredate)
from emp;

