-- Q1) 다음 쿼리를 통해 테이블을 생성해보자.
/*
create talbe My_REPORT(
name varchar(10),
color varchar(10),
sales int);
*/

-- Q2) 데이터를 다음과 같이 입력해본다.
/*
insert into my_report values ('shoes', 'Red', 5200);
insert into my_report values ('wallet', 'White', 3800);
insert into my_report values ('shoes', 'Red', 5100);
insert into my_report values ('shoes', 'Black', 4600);
insert into my_report values ('wallet', 'Black', 3900);
insert into my_report values ('wallet', 'White', 4000);
insert into my_report values ('shoes', 'Red', 5200);
*/

-- Q3) 다음과 같이 그룹핑 하자.
select name, sum(sales)
from my_report
group by name;

-- Q4) 다음과 같이 그룹핑하자.
select name, color, sum(sales)
from my_report
group by name, color;

-- Q5) 다음과 같이 그룹핑 하자. with rollup 사용
select name, sum(sales)
from my_report 
group by name with rollup;

-- Q6) 다음과 같이 출력해보자.
select name, color, sum(sales)
from my_report
group by name, color
order by 3 desc;

-- Q7) 다음과 같이 출력해보자. with rollup 사용
select name, color, sum(sales)
from my_report 
group by name, color with rollup;

-- Q8) sales 값이 150 이상의 데이터만을 대상으로 그룹화하고, 그룹별로 sales 평균를 리턴 하되 200 이상 만 출력하자. 
select name, avg(sales) as average
from my_report
where sales >= 150
group by name
having avg(sales) >= 200;





