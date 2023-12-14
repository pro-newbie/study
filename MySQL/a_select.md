
>1. select 출력문을 확인
>2. select ~ from
>3. select ~ from , as 별칭 [컬럼별칭, 테이블별칭]


## use apple;  스키마 이동
`select 100+200;` 별칭이 없을 경우에는 컬럼명과 값으로 출력된다.   
`select 'abc \n de \t f' as res ;`  as라는 키워드로 컬럼명을 별칭을 주자.  
`select 'abc    de    f' as res02;`  

## my_emp 스키마로 이동하자.
`use my_emp;`  
 ### Q1) 오늘의 날짜를 출력해보자.  
`select now();`  
>select 컬럼리스트,,, * from 테이블명  

 ### Q2) 사원 테이블의 모든 내용을 출력 해보자.  
`select * from emp;`

 ### Q3) 부서 테이블의 모든 내용을 출력 해보자.  
`select * from dept;`  

 ### Q4) my_emp의 전체 테이블의 목록을 확인 해보자.  
`show tables;`  

 ### Q5) 사원 테이블의 스키마 구조를 확인 해보자. [필드명,   데이터타입, 널값유무, 키값, 기본값, 시퀀스값]  
`desc emp;`   
`describe emp;` -> 약어로 사용가능 (desc)   

 ### Q6) 사원 테이블에서 사원의 이름, 사원의 번호, 매니저,   봉급을 출력 해보자.  
`select ename, empno, mgr, sal`-- 2 시행순서  
`from emp;` -- 1 시행순서  

 ### Q7) 부서 테이블에서 부서번호, 부서명을 출력 해보자.  
`select deptno, dname from dept;`   

 ### Q8) 두개의 테이블의 모든 내용을 출력 해보자.  
`select * from emp, dept;` # 풀조인 emp * dept의 row로   계산된다 16*4  

 ### Q9) 사원의 테이블에서 사원의 이름, 사원의 번호 두개의 컬럼을   별칭과 함께 출력하자.  
    > 별칭 : 컬럼의 별칭, 테이블 별칭 / 컬럼 as 별칭,   테이블 as 별칭    
    
`select ename '사원의 이름', empno '사원의 번호' from emp;`

 ### Q10) 사원의 테이블에서 사원의 이름, 사원의 번호 두개의 컬럼을   별칭과 함께 출력하자.     
    > 별칭 : 컬럼의 별칭, 테이블 별칭 / 컬럼 as 별칭,   테이블 as 별칭
    
`select ename as '사원의 이름', empno as '사원의 번호' from   emp;`   

 ### Q11) 사원의 테이블에서 사원의 이름, 사원의 번호 두개의 컬럼을   별칭과 함께 출력하자.   
    > 별칭 : 컬럼의 별칭, 테이블 별칭 / 컬럼 as 별칭,   테이블 as 별칭    

`select ename as 사원이름, empno as 사원번호 from emp;`   

 ### Q12) 사원의 테이블에서 사원의 이름, 사원의 번호 두개의 컬럼을   별칭과 함께 출력하자.   
    > 별칭 : 컬럼의 별칭, 테이블 별칭 / 컬럼 as 별칭,   테이블 as 별칭   

`select ename 사원이름, empno 사원번호 from emp;`  

 ### Q13) 사원의 테이블에서 사원이름, 사원번호, 매니저,   입사일로 컬럼 별칭을 주고 출력 해보자.  

`select ename 사원이름, empno 사원번호, mgr 매니저,   hiredate 입사일 from emp;`  
`select ename as 사원이름, empno as 사원번호, mgr as   매니저, hiredate as 입사일 from emp;`  
`select ename '사원이름', empno '사원번호', mgr '매니저',   hiredate '입사일' from emp;`  
`select ename as '사원 이름', empno as '사원 번호', mgr as   '매니저', hiredate as '입사일' from emp;`  

### Q14) 사원의 테이블의 별칭을 주고 사원의 이름, 봉급을   출력하자.  
`select ename, sal from emp e;`   # emp를 e라는 별칭으로 선언  
`select ename, sal from emp as e;`  
`select 사원.ename, 사원.sal from emp as 사원;`  

### Q15) 사원테이블의 사원 별칭을 주고 사원의 이름, 봉급을   별칭으로 출력하자.  
`select 사원.ename '사원의 이름', 사원.sal 봉급 from emp 사원;`  

`select ename 사원.'사원의 이름', sal 사원.봉급 from emp 사원;` = 잘못된 구문  

`select 사원.ename '사원의 이름', 매니저.sal 봉급 from emp 사원, emp 매니저;`     

> 테이블 별칭에는 공백이 포함될 수 없다.  

### Q16) 테이블 별칭을 활용해보자. _ 사원의 이름, 부서번호, 부서명을 출력 해보자.  
 `select emp.ename, emp.deptno, dname from emp, dept;`  
 `select e.ename, e.deptno, dname from emp e, dept;`  
 `select ename, d.deptno, d.dname from emp e, dept d;`  
 `select e.ename, d.deptno, d.dname from emp as e, dept as d;`  


select 컬럼리스트   
from 테이블리스트   
where 조건문, [숫자비교, 문자비교, 대소문자비교, null비교, 날짜값]   
having group by 비교연산   
group by 집계연산(sum, avg, var, mean, max, min,,,)   
order by 정렬   
