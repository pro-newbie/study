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




