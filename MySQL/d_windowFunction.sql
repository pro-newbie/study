use my_emp;
SET SQL_SAFE_UPDATES = 0;


CREATE TABLE t (b BIT(8));  # 8비트를 사용하겠다 / 부울 값(TRUE,FALSE) / 플래그
# MYSQL전용
INSERT INTO t SET b = b'11111111'; # 255
INSERT INTO t SET b = b'1010';  # 10
INSERT INTO t SET b = b'0101';  # 5

# SQL
INSERT INTO t VALUES(B'11');  # 3

-- Q1) 전체 구조확인
DESC T;

-- Q2) 테이블 내용 확인
SELECT *
FROM T;

-- Q3) 도움말 확인
HELP BIT;


-- Q4) 각 비트별로 값을 변환 후 출력 해보자.
SELECT b+0, BIN(b), OCT(b), HEX(b) FROM t;
SELECT b FROM t;

-- Q5) CAST 함수를 이용해보자. 정수로 변환해보자.
HELP CAST;
SELECT CAST(B AS UNSIGNED) FROM t;

-- Q6) b'11111111'을 b'0101'로 수정하자.
-- insert into 테이블명 values(값,,,);
-- insert into 테이블명(컬럼명) values(값);

-- update 테이블명 set 컬럼 = 변경할 값,,, where 조건문; -> 조건 수정
update t
set B = b'0101'
where B = b'11111111';

select b from t;
-- update 테이블명 set 컬럼 = 변경할 값,,,; -> 컬럼 전체 수정

-- delete from 테이블명; -> 전체 삭제
-- delete from 테이블명 where 조건문; -> 조건 삭제

-- Q7) b'11'을 찾아 삭제 해보자.
 delete from t
 where b = b'11';

-- Q8) 고유값만 출력 해보자. (중복값 생략)
select distinct b
from t;

-- Q9) 새로운 열을 추가해보자. -> 테이블이 새로운 컬럼이 추가되면서 수정이 된다.
alter table t
add c varchar(20),
add d varchar(20);

desc t;

select *
from t;

-- Q10) c컬럼을 삭제 해보자.
alter table t
drop c,
drop d;

desc t;

SELECT TRUE, true, FALSE, false;

select _binary'hello'; # 이진 문자열은 접두어를 사용한 구문을 함께 지정해서 저장한다.
select point(10,20);
select ST_AsText(point(10,20)); # 문자열로 변환 후 출력
/*
문자리터럴, 숫자리터럴, 16진수리터럴 '0x', 'X' 접두사, 비트필드 BIT(8), 부울리터럴, 
_binary, point() : 공간 데이터 표현, 날짜 시간
*/

/*
DB에서 스키마란? Schema 소유자 라고 하는 특정 데이터 베이스 사용자 이름과 연결된 데이터 베이스 개체의 컬렉션
Schema Object Names
1. 스키마의 개체 유형 : 테이블, 뷰, 인덱스, 시퀀스, 프로시저, 함수, 트리거 등
2. 명명규칙 : 이름의 길이, 사용할 수 있는 문자유형(일반적으로 영숫자, _, 대소문자 제한)
    # 132 -> 스토리지 엔진에서 64자 정도
    
    lower_case_tabel_names / 서버시작시 설정값
    서버시작시 설정값 : 일관성, 복제(환경설정), 크로스 플렛폼

3. 고유성 : 단일 스키마 내에서는 고유성이 있어야 한다.
4. 적격스키마 : 스키마 객체를 참조하려면 스키마 명을 명시해야 한다. my_emp.emp (schema_name.table_table)
5. 키워드 : 예약어 목록
6. 네임스페이스 : Schema
7. 데이터 베이스 호환성 : 데이터 베이스 명세서
*/
/*
https://dev.mysql.com/doc/refman/8.0/en/show-tables.html
<13.7.7.39 SHOW TABLES Statement>
SHOW [EXTENDED] [FULL] TABLES
    [{FROM | IN} db_name]
    [LIKE 'pattern' | WHERE expr]
SHOW {DATABASES | SCHEMAS}
    [LIKE 'pattern' | WHERE expr]
*/

-- Q1) 사원테이블에서 입사일에서 입사년도, 입사월, 입사일, 입사요일을 추출해서 별칭으로 추출해보자.
select 
extract(year from hiredate) as 입사년도,
extract(month from hiredate) as 입사년도,
extract(day from hiredate) as 입사년도,
dayname(hiredate) as 입사요일
from emp;

-- Q2) 사원테이블에서 입사일에서 입사년도, 입사월, 입사일, 입사요일을 추출해서 별칭으로 추출해보자.
-- case ~ when ~ then 선택문을 이용해서 월요일,~일요일로 표현하자 dayofweek(date) -> 1(일요일)~7(토요일)
select 
extract(year from hiredate) as 입사년도,
extract(month from hiredate) as 입사년도,
extract(day from hiredate) as 입사년도,
case dayofweek(hiredate)
	when 1 then '일요일'
    when 2 then '월요일'
    when 3 then '화요일'
    when 4 then '수요일'
    when 5 then '목요일'
    when 6 then '금요일'
    when 7 then '토요일'
    end as 입사요일
from emp;


/*
9.6 Query Attributes : 쿼리문을 실행할 때 쿼리구조, 수행작업 유형, 데이터 접근방식, 스키마 상태 등
	데이터 비율 / 쿼리 실행시 리턴되는 수 = 조인, 인덱싱
		비용(cost) : CPU 시간, 메모리사용량, 디스크 I/O 측정 = 데이터베이스 최적화 기 = 비용추정 (실행계획)
		투영 작업(Projection) : 쿼리가 검색하는 열이나 필드의 집합 -> 어떤 데이터가 선택되는지 알 수 있다.
        조건 : where절을 사용시 특정 기준값 / 집계 (데이터 요약 그룹화)
        이노디비 스토리지 특성값 가지고있다 (동시성제어 = 데이터 무결성) 트랜젝션, 복원, 버퍼

*/

SHOW VARIABLES LIKE 'character_set_system';

SHOW VARIABLES LIKE 'datadir';

-- Q1) 테이블의 스키마 내용을 확인 해보자.
select column_name, character_set_name, collation_name
from information_schema.columns
where table_schema = 'my_emp'
and table_name = 't'

-- Q2) 각 변수를 통해 MySQL 서버 또는 클라이언트의 문자 세트 설정을 확인해보자.
show variables like 'character_set_%';
show variables like 'collation';
my_report

-- Q3) varchar/ utf8mb4 은 최대 몇자 저장 가능?
select 65535/4; -- 최대 16383 글자만 대입하겠다.

/*
https://dev.mysql.com/doc/workbench/en/wb-sql-editor.html
https://dev.mysql.com/doc/workbench/en/wb-design-modeling-interface.html
*/


-- percent_rank() over_clause
-- Q1) 사원 테이블에서 봉급의 백분율 순위를 계산해보자.
select sal,
percent_rank() over(order by sal) as p_rank
from emp;

-- Q2) 사원 테이블에서 봉급의 백분율과 순위를 구해보자.
select sal,
percent_rank() over(order by sal) as p_rank,
rank() over (order by sal desc) as no
from emp;

-- Q3) 사원 테이블에서 봉급의 합을 구해보자.
-- over는 행의 결과 집합이 리턴된다. 결과 집합의 시작 부터 현재 행까지의 모든 행에 대한 누적 합계
select sum(sal) over (order by sal), sal,
sum(sal) over (order by sal)l
from emp;

-- Q4) 같은 부서내 모든 사원의 급여의 합계를 내보자.
select deptno, sal, sum(sal) over (partition by deptno) as res
from emp;

-- Q5) 년도별 고용수를 확인하자.
select extract(YEAR FROM hiredate) as 입사년도, count(*) as '년도별 입사한 수'
from emp
group by 입사년도;  -- group by 컬럼 별칭 사용가능

/*
select 및 group by 절 모두에서 동일한 작업을 사용하면
sql 엔진은 일반적으로 이를 최적화하고 불필요한 중복 계산은 하지 않습니다.
DBMS는 표현식을 한번 계산한 다음 결과를 두곳에서 모두 사용합니다.
*/

explain select extract(YEAR FROM hiredate) as 입사년도, count(*) as '년도별 입사한 수'
from emp
group by 입사년도;  -- group by 컬럼 별칭 사용가능

-- Q6) 사원 테이블에서 각 부서번호와 각 부서(deptno) 직원의 평균 재직 기간(년)을 출력해보자.
-- 현재날짜는 오늘날짜로, 직원이 있는 부서에 대한 계산만 한다.
-- avg, timestampdiff, count 사용
select deptno, avg(timestampdiff(year,hiredate,now())) as 평균재직기간
from emp
group by deptno
having count(empno) > 0;

-- Q7) 사원테이블에서 직업과 사원의 근무기간의 표준편차를 출력해보자. 현재날짜는 오늘날짜로 계산한다.
select job, std(timestampdiff(year,hiredate,now())) as 표준편차
from emp
group by job;

-- Q8) 부서번호와 각 부서에 대한 봉급의 차이를 출력해보자.
/*
variance(sal) : 각 부서의 봉급차이 sal을 계산하겠다.
				분산은 각 부서의 급여가 해당부서의 평균 급여와 얼마나 다른지 측정하는 것
                차이가 클수록 급여간 격차가 더 크다는 것을 의미한다.
                - 급여 분포를 계산한 것
                variance(sal) 결과가 높으면(크다면) 해당 부서내 급여 범위가 넓다는 의미 이고
                일부 직원은 다른 직원보다 훨씬 봉급이 많거나 적은 봉급을 받는 것을 의미한다.
*/
select deptno, variance(sal) as 봉급차이 
from emp
group by deptno;

-- Q9) 부서번호와 각 부서에 대한 표본 분산을 출력해보자. (급여의 변동성)
-- 전체 데이터 셋이 아닌 하위 집합을 나타낼때 사용된다.
select deptno, var_samp(sal) as '부서의 표본분산'  # 모집단 표본을 기본으로 분산하겠다.
from emp
group by deptno;

explain select deptno, var_samp(sal) as '부서의 표본분산'  # 모집단 표본을 기본으로 분산하겠다.
from emp
group by deptno;

-- Q10) 사원테이블에서 각 부서별 직원 봉급의 표준편차를 계산해보자.
-- stddev(expr) [over_clause] : 표존편차가 높을수록 급여 범위가 더 넓다.
/*
부서내 급여 표준편차란? 부서의 개인 급여가 해당 부서의 평균 급여와 얼마나 차이가 나는지 측정하는 것
*/
select deptno, stddev(sal) as '직원 봉급의 표준편차' 
from emp
group by deptno;

-- Q11) 부서별 사원의 목록을 ,로 나열해서 출력해보자.
/*
group_concat([distinct] expr [,expr...]
			  [order by {unsigned_integer | col_name | expr}
              [asc | desc], [,col_name...]]
              [separator str_vall])
*/
select deptno, group_concat(ename order by ename asc separator ',') as res
from emp
group by deptno;

-- Q12) 부서별 직업의 목록을 ,로 나열해서 출력해보자.
select deptno, group_concat(distinct job order by job asc separator ',') as res
from emp
group by deptno;

-- Q13) 사원테이블에서 연도별, 사원이 입사한 날짜를 , 로 나열해보자.
select extract(YEAR FROM hiredate),
	group_concat(date_format(hiredate, '%y-%m-%d') order by hiredate asc separator ',') as hiredate
from emp
group by extract(YEAR FROM hiredate);

-- case 01
select year(hiredate) as 입사년도,
	group_concat(distinct hiredate order by hiredate asc separator ',') as hiredate
from emp
group by 입사년도;

-- case 02
SELECT HireYear, 
       GROUP_CONCAT(HireDateCount ORDER BY HireDate ASC SEPARATOR ', ') AS HireInfo
FROM (
    SELECT EXTRACT(YEAR FROM HIREDATE) AS HireYear,
           DATE_FORMAT(HIREDATE, '%Y-%m-%d') AS HireDate,
           COUNT(*) AS NumHires,
           CONCAT(DATE_FORMAT(HIREDATE, '%Y-%m-%d'), ' (', COUNT(*), ')') AS HireDateCount
    FROM EMP
    GROUP BY HireYear, HireDate
) AS SubQuery
GROUP BY HireYear;
# 년도(인원수)

-- Q14) 이름과 직업을 연결해 하나의 컬럼을 만들어서 사원번호, 결합한내용을 별칭으로 출력하자. concat
select empno as 사원번호, concat(ename, '-', job) as 결합내용
from emp;

select empno as 사원번호, concat_ws('-', ename, job) as 결합내용
from emp;

-- Q15) 직업의 처음 세글자를 추출해서 출력하자. substr, sunstring
select substr(job, 1, 3) as res
from emp;

select substring(job, 1, 3) as res
from emp;

-- Q16) 사원의 번호, 사원의 이름을 출력하되 사원의 이름의 첫글자만 대문자 나머지는 소문자로 출력하자.
select empno, concat(upper(substr(ename,1,1)), lower(substr(ename,2))) as '사원의 이름'
from emp
group by empno;

-- Q17) 사원의 이름, 입사한날짜(0000년도, 00월, 00일) 출력하자
select ename, date_format(hiredate, '%y년도 %m월 %d일')
from emp;

-- Q18) 사원의 이름을 두번째 글자를 기준으로 내림차순 정렬하자.
select ename
from emp
order by substr(ename, 2, 1) desc;

-- Q19) 사원의 이름과 길이를 출력하자.
select ename, length(ename) as 길이
from emp;

-- Q20) 사원번호, 사원의 이름, 연봉의 별칭으로 하나의 문자열로 출력하자.
select concat(empno, ename, sal) as res
from emp;

-- Q21) 사원의 이름을 역순으로 출력하자. riverse
select ename, reverse(ename) as res
from emp;

-- Q22) base64 : 이메일 -> 텍스트 전용 시스템을 통해서 문제 발생될부분의 인코딩
-- radix-64 : 64를 밑수로 사용하는 것 [a-z, A-Z, 0-9] + /
/*
base64 : 바이너리 데이터 각 3byte(24bit)씩 4개의 6bit 그룹으로 나눈다. ->
		6bit 그룹에 2진 데이터를 표현할 수 있는 문자열로 리턴, 만일 바이너리 데이터가 3의 배수가
        아닌경우 패팅문자 '='이 추가된다.

base64 : 이진데이터 분류 -> 문자에 매핑 (radix-64) -> 인코딩 프로세싱 -> 패딩
*/
select to_base64('abc'), from_base64(to_base64('abc')); -- base64 인코딩
select to_base64('hello, mysql'); -- 바이너리 데이터를 radix-64 --> ascii = base64 인코딩

help to_base64;

select length('text')
from emp;

-- Q23) 테이블을 생성해서 파일을 로드 해보자.
show variables like 'secure_file_priv';
show variables like 'max_allowed_packet';

select load_file('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pic.jpg');
select load_file('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DBnotice.txt');

create table my_file(
	id int auto_increment primary key,
    file_content longtext);
    
insert into my_file(file_content)
values(load_file('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data.txt'));

select * from my_file;

create table my_images(
	id int auto_increment primary key,
    image_data longblob);

insert into my_images(image_data)
values(load_file('C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\data.txt'));

select *
from my_images;

# 비트연산
# 0001 = 1
# 0100 = 4
# |------
# 0101 = 5
select make_set(1 | 4, 'hello', 'nice', 'world', null) as res;
# 0001 = 1
# 0101 = 5
# &------
# 0001 = 1
select make_set(1 & 5, 'hello', 'nice', 'world', null) as res;

select strcmp('A', 'B') res;  # 65 < 66
select strcmp('Z', 'A') res;  
select strcmp('AB', 'A') res;   
select strcmp('B', 'A') res;  

select weight_string('Hello');
-- weight_string(str [as {char|binary}(n)] [flags]

select ename
from emp
order by weight_string(ename); # 이름의 기준을 언어 규칙으로 정렬하겠다.(베트남어, 중국어, 라틴어등)

select ename, weight_string(ename)
from emp;

-- 정규패턴을 활용해 보자.
show variables like 'regexp_stack_limit'; # 스택메모리 제한
show variables like 'regexp_time_limit'; # 시간제한

-- Q1) 사원이름에서 J로 시작하는 이름을 찾아보자.
select ename
from emp
where ename regexp '^J';

-- Q2) 사원이름에서 ER$로 끝나는 이름을 찾아보자.
select ename
from emp
where ename regexp 'ER$';

-- Q3) 사원이름에서 S이 들어있는 이름을 찾아보자.
select ename
from emp
where ename regexp 'S';

-- Q4) 사원이름에서 숫자가 들어있는 이름을 찾아보자.
select ename
from emp
where ename regexp '[0-9]';

-- Q5) 사원이름에서 두번째 문자가 'A'인 이름을 찾아보자. ^.[A]
-- ^는 문자열의 시작 앵커
-- .는 단일 문자와 일치하는 와일드 카드(개행문자 제외)
-- [A]는 []안에 문자와 일치
-- ^.[A] : 임의의 문자.으로 시작하고 바로뒤에 오는 문자 A가 일치하는 모든 문자열
-- ex) BA, ZA, AA = 일치한다. / AB, A, ZYZ = 일치하지 않는다.
select ename
from emp
where ename regexp '^.[A]';

-- Q6) 사원이름에서 JOHE 또는 Jone이라는 이름을 출력해보자.
select ename
from emp
where ename regexp 'JO(HE|NE)';

-- Q7) 사원이름에서 이름이 5글자라는 이름을 출력 해보자.
select ename
from emp
where ename regexp '^.{5}$';

-- Q8) 사원이름이 'J'로 시작하고 's'로 끝나는 모든 내용을 출력하자. * = 0, more (빈문자열이 있으면 리턴)
select *
from emp
where ename regexp '^J[A-Z]*S$';

select *
from emp
where REGEXP_LIKE(ename,'^J[A-Z]*S$');

-- Q9) 직업이 대문자인 사원만 출력하자. + = 1, more (빈문자열이 있으면 리턴안함)
select *
from emp
where regexp_like(job,'^[A-Z]+$');

-- a+ : a, aa, aaa
-- a* : '', a, aa, aaa

-- https://regexr.com/

-- Q10) regexp_instr()
/*
REGEXP_INSTR(expr, pat[, pos[, occurrence[, return_option[, match_type]]]])
REGEXP_INSTR(검색할 문자열, 패턴, 위치, 반환옵션, 유형옵션)
*/
select regexp_instr('Hello, World!', 'o');
select regexp_instr('Hello, World!', 'o',1 , 2);
select regexp_instr('Hello, World!', 'W', 1, 1, 0, 'c');

-- 이메일 패턴, 전화번호 패턴, 우편번호 패턴, 주민번호, 운전면허, 여권 등등
-- URL 패턴











