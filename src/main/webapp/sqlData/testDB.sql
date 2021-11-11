show tables;

select * from ddd;

insert into ddd values ('이기자',default,'서울');
insert into ddd values ('김말숙',default,'제주');
insert into ddd values ('소나무',29,'인천');
insert into ddd values ('장나라',33,'청주');

delete from ddd;

drop table ddd;

-- 이곳은 주석입니다.
/*
  이곳도 주석입니다.
*/
show databases;		-- 데이터베이스 목록 보여주기
show tables;		-- 현재 데이터베이스의 테이블 목록 보여주기

-- 데이터베이스 : javacourse
-- 테이블명 : insarok 
-- 필드설계(정의)
-- 사원번호(no)	숫자 , Null불허	자동번호메기기	primarykey(주키)	
-- 부서(buser), 문자(10),	Null불허,
-- 성명(name),  가변길이(20), Null불허
-- 직위(jikwi), 가변문자(10), Null불허
-- 성별(gender),문자(2),	기본값(남자)
-- 나이(age),	숫자,	Null허용
-- 입사일(ipsail),날짜시간, 기본값을 오늘날짜시간
-- 주소(address), 가변길이문자(50)  Null허용

create table insarok(
  no	int  not null auto_increment primary key,		-- 사원번호
  buser char(5) not null,								-- 부서명(인사과,자재과,영업과,생산과)
  name  varchar(20) not null,							-- 성명
  jikwi varchar(20) not null,							-- 직위
  gender char(2)	default '남자',						-- 성별(남자,여자)
  age	 int,											-- 나이
  ipsail datetime   default now(),						-- 입사일
  address varchar(50)									-- 주소
);

drop table insarok;

desc insarok;

select * from insarok;

insert into insarok values (default,'인사과','홍길동','과장',default,37,'1995-1-5','서울');
insert into insarok values (default,'총무과','김말숙','과장','여자',40,'1990-1-25','부산');
insert into insarok values (default,'영업과','이기자','부장',default,52,'1985-1-12','인천');
insert into insarok values (default,'자재과','강감찬','대리',default,33,'2000-3-18','청주');
insert into insarok values (default,'총무과','소나무','사원',default,27,'2015-2-5','부산');
insert into insarok values (default,'영업과','오하늘','과장','여자',36,'1999-1-5','서울');
insert into insarok values (default,'인사과','이선희','대리','여자',30,'2010-6-11','인천');
insert into insarok values (default,'총무과','고인돌','사원',default,30,'2015-1-25','청주');
insert into insarok values (default,'인사과','나도야','과장',default,33,'2000-2-5','부산');
insert into insarok values (default,'자재과','가나다','사원',default,28,'2020-7-15','인천');
insert into insarok values (default,'총무과','오늘도','대리','여자',31,'2018-8-12','서울');
insert into insarok values (default,'영업과','김기자','사원',default,27,'2021-5-25','청주');
insert into insarok values (default,'영업과','이순신','부장',default,47,'1988-9-22','부산');
insert into insarok values (default,'영업과','홍길동','사원',default,31,'2020-1-22','인천');
insert into insarok values (default,'인사과','홍길순','사원','여자',29,'2020-10-25','청주');
insert into insarok values (default,'영업과','김나래','대리','여자',34,'2006-11-15','청주');
insert into insarok values (default,'영업과','이순신','부장',default,47,'1989-9-22','부산');
insert into insarok values (default,'영업과','이길동','사원',default,31,'2021-1-22','인천');
insert into insarok values (default,'영업과','홍길자','사원','여자',29,'2018-10-25','청주');
insert into insarok values (default,'총무과','김나진','대리','여자',34,'2009-11-15','서울');

delete from insarok;
select * from insarok;

-- ************************ DDL **********************
-- alter 명령어는 테이블의 구조를 변경(alter table)할때 사용한다.
-- insarok테이블의 구조를 보여주시오?
desc insarok;

-- name필드를 irum필드로 수정(change column)하시오?
alter table insarok change column name irum varchar(50);

-- irum필드를 name필드로 수정하시오? 길이는 가변문자형(20), Null값 불허...
alter table insarok change column irum name varchar(20) not null;

-- netpay(급여)필드를 추가(add column)하시오? 정수형타입, 기본값은 0
alter table insarok add column netpay int default 0;

-- netpay(급여)필드를 삭제(drop column)하시오?
alter table insarok drop column netpay;

-- insarok테이블의 이름을 insa로 변경(rename)하시오.
alter table insarok rename insa;
show tables;

-- insa테이블의 이름을 insarok로 변경(rename)하시오.
alter table insa rename insarok;

-- 테이블의 목록보기
show tables;

-- ***************** DML(데이터 조작어) *************************
-- insarok테이블에서 작업한다.
-- insarok테이블의 전체 내용보기
select * from insarok;

-- 성명, 성별, 직위, 주소 필드의 자료들만 모두 보여주시오.
select name, gender, jikwi, address from insarok;
select name as '성명', gender '성별', jikwi as '직위', address '주소' from insarok;

-- '홍길동' 레코드를 보여주시오?
select * from insarok where name='홍길동';

-- 성별이 여자인 레코드를 출력하세요?
select * from insarok where gender='여자';

-- 주소가 '서울'인 자료를 보여주시오?
select * from insarok where address='서울';

-- 나이가 30살 이하인 레코드를 보여주시오?
select * from insarok where age <= 30;

-- 입사일이 2000년도 이전에 입사한 직원을 보여주시오?
select * from insarok where ipsail < '2000-1-1';

-- 전체자료를 성명순(오름차순)으로 보여주시오. : 순서 - order by asc(오름차순:생략)/desc(내림차순)
select * from insarok order by name asc;
select * from insarok order by name;

-- 나이많은 순으로 보여주시오?
select * from insarok order by age desc;

-- 직위가 '사원'인 직원만 보여주시오?
select * from insarok where jikwi = '사원';

-- 남자이면서 나이가 30살 이하인 자료?
select * from insarok where age <= 30 and gender = '남자';

-- 서울에 사는 여자직원을 보여주시오?
select * from insarok where address='서울' and gender='여자';

-- '영업과' 직원을 보여주시오?
select * from insarok where buser='영업과';

-- '영업과'직원중 '남자'사원을 출력하시오?
select * from insarok where buser='영업과' and gender='남자' and jikwi='사원';

-- '영업과', '남자'사원중 '인천'에 사는 직원을 출력하시오?
select * from insarok where buser='영업과' and gender='남자' and jikwi='사원' and address='인천';

-- '영업과', '남자'직원중 '인천'에살거나 '부산'에 사는 직원을 출력하시오?(또는 : or / in)
select * from insarok where buser='영업과' and gender='남자' and (address='인천' or address='부산');
select * from insarok where buser='영업과' and gender='남자' and address in('인천', '부산');

-- 나이가 30~40 사이(포함)의 모든 자료를 출력하시오.(그리고 : and / between)
select * from insarok where age>=30 and age<=40;
select * from insarok where age between 30 and 40;

-- 성별이 여자인 20대 직원을 보여주시오?
select * from insarok where gender='여자' and age>=20 and age<=29;
select * from insarok where gender='여자' and age between 20 and 29;

-- 성별이 여자인 20대 직원중 성명, 성별, 나이, 주소만 보여주시오?
select name, age, address from insarok where gender='여자' and age between 20 and 29;

-- 성별이 여자인 20대 직원중 '성명', '성별', '나이', '주소'만 보여주시오?(필드명을 한글로 표시하시오)
select name as '성명', gender as '성별', age as '나이', address '주소' from insarok;

-- '홍'씨성을 가진 직원을 출력하시오? 포함 : like + '%'
select * from insarok where name like '홍%';

-- 이름이 '동'으로 끝나는 사람을 출력?
select * from insarok where name like '%동';

-- 자료추가 : 성명(길동무), 직위(과장), 부서(인사과)
insert into insarok (name, jikwi, buser) values ('길동무','과장','인사과');

-- 자료추가 : 성명(길길무), 직위(사원), 부서(영업과)
insert into insarok (name, jikwi, buser) values ('길길무','사원','영업과');
select * from insarok;

-- 이름에 '길' 이 포함됨 모든 자료를 출력하세요?  포함유무 : like + '%'
select * from insarok where name like '%길%';

-- 포함유무(와일드카드)? 복수개 : '%' ,  단수개 : '_'
-- 이름의 2번째 글자가 '길'인 자료를 출력하세요?
select * from insarok where name like '_길%';

-- 처음부터 5건만(limit) 출력하시오?
select * from insarok limit 0,5;
select * from insarok limit 5;


-- 인덱스번호 5번부터(6번째자료부터) 5건만(limit) 출력하시오?(시작은 0번레코드이다.)
select * from insarok limit 5,5;

-- 남자자료 처음부터 4건만 출력하시오?
select * from insarok where gender='남자' limit 4;

-- 남자자료 처음부터 4건을 나이 내림차순으로 출력하시오?
select * from insarok where gender='남자' order by age desc limit 4;


select * from insarok;
-- 수정(update) 하기 : 문법 : "update 테이블명 set 필드명=수정내용 where 조건절"
-- '홍길동'의 직급을 '부장'으로 변경하시오?
update insarok set jikwi='부장' where name='홍길동';

-- 모든 직원의 나이를 1살 더해주세요..
update insarok set age=age+1;

-- 여자직원 모두 1살씩 나이를 빼주세요.
update insarok set age=age-1 where gender='여자';

-- 부장 급여는 5000000원 지급하시오.
update insarok set netpay=5000000 where jikwi='부장';

-- 과장 급여는 4000000원 지급하시오.
update insarok set netpay=4000000 where jikwi='과장';

-- 대리 급여는 3000000원 지급하시오.
update insarok set netpay=3000000 where jikwi='대리';

-- 사원 급여는 2500000원 지급하시오.
update insarok set netpay=2500000 where jikwi='사원';

-- 영업과 사원을 출력?


-- '영업과', '사원'들에 대하여 직급을 모두 '대리'로 승진시키고, 기존급여에 50000추가하시오.
update insarok set jikwi='대리', netpay=netpay+50000 where buser='영업과' and jikwi='사원';
select * from insarok;


-- 레코드(행/튜플) 삭제 : delete from 테이블명 where 조건;

-- '영업과'의 '홍길동' 레코드를 삭제하시오?
delete from insarok where buser='영업과' and name='홍길동';


-- 여자중에서 부산에 사는 사람을 삭제하시오.?
delete from insarok where gender='여자' and address='부산';

select * from insarok where gender='여자';
