show tables;

/* testDB2 */
/* 책 정보 테이블(books) */
create table books (
	bookId    int not null auto_increment primary key, /* 책 고유번호 */
	bookName  varchar(20) not null,				/* 책 이름 */
	publisher varchar(20) not null,				/* 출판사명 */
	price			int													/* 책가격(정가) */
	/* primary key(bookId, bookName) */
);
/* drop table books; */
/* drop table orders; */
/* drop table customer; */

insert into books values (1,'축구의 역사','굿스포츠',7000);
insert into books values (2,'축구아는 여자','나무수',13000);
insert into books values (3,'축구의 이해','대한미디어',22000);
insert into books values (4,'골프 바이블','대한미디어',35000);
insert into books values (5,'피겨 교본','굿스포츠',8000);
insert into books values (6,'역도 단계별기술','굿스포츠',6000);
insert into books values (7,'야구의 추억','이상미디어',20000);
insert into books values (8,'야구를 부탁해','이상미디어',13000);
insert into books values (9,'올림픽 이야기','삼성당',7500);
insert into books values (10,'Olympic Champions','Pearson',13000);
insert into books values (11,'자바의 정석','도우출판사',30000);
insert into books values (12,'포토샵 CS6','제우미디어',25000);
insert into books values (13,'노인과 바다','이상미디어',13000);
insert into books values (14,'C#','삼성당',22000);
insert into books values (15,'전산세무2급','제우미디어',15000);
insert into books values (16,'반응형웹','ICOX',28000);
insert into books values (17,'파이썬따라잡기','이상미디어',22000);
insert into books values (18,'이젠나도자바','삼성당',19000);
insert into books values (19,'구기종목 정복','굿스포츠',9900);
insert into books values (20,'컬러리스트길잡이','나무수',31000);

select * from books;

/* 갯수를 구하는 함수? count() */
-- 전체 책의 권수는?
select count(*) from books;

-- 전체 책의 권수는?(단, 열이름을 '총권수'라고 지정하시오)
select count(*) as '총권수' from books;
select count(*) 총권수 from books;

-- 삼성당 출판사의 개수는?
select count(*) 삼성당출판사개수 from books where publisher = '삼성당';

-- 전체 책의 가격합계?(열이름 : 총가격)
select sum(price) 총가격 from books;
select format(sum(price),0) 총가격 from books;

-- '삼성당' 출판사의 전체 책 평균?(열이름: 삼성당책평균가격) - 소수이하 1자리까지 출력
select format(avg(price),1) 총가격 from books where publisher = '삼성당';

-- 책가격이 2만원 이상인 책 가격의 전체 금액합계?
select format(sum(price),0) from books where price >= 20000;

-- 가장 비싼책과 가장 싼책의 가격을 출력하시오?
select max(price), min(price) from books;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오?(2가지 방법 사용)
select * from books where publisher = '굿스포츠' or publisher = '대한미디어';
SELECT * FROM books WHERE publisher IN ('굿스포츠','대한미디어');

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오?
SELECT * FROM books WHERE publisher NOT IN ('굿스포츠','대한미디어');

-- 도서이름중에서 '축구'가 포함된 출판사를 검색하시오?(단, 책이름과 출판사명만 출력하시오)
SELECT bookName, publisher FROM books WHERE bookName LIKE '%축구%';

-- 도서이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서를 모두 검색하시오.
SELECT * FROM books WHERE bookName LIKE '_구%';

-- '축구'에 관한 도서중에서 가격이 2만원이상인 도서만 검색하시오?
SELECT * FROM books WHERE bookName LIKE '%축구%' AND price >= 20000;

-- 도서를 가격순으로 검색하되, 가격이 같으면 도서이름으로 내림차순 검색하시오?
SELECT * FROM books ORDER BY price, bookName DESC;

-- 도서테이블에서 모든 출판사를 검색하시오(중복허용) - 출판사필드만 검색
SELECT publisher FROM books;

-- 도서테이블에서 모든 출판사를 검색하시오(중복불허) - 출판사필드만 검색
SELECT DISTINCT publisher FROM books;

/* 그룹으로 묶어서 작업처리 : GROUP BY ~ HAVING(조건:집계함수)
 * group by뒤의 검색조건필드를 select절의 필드로 적어준다.
 * 또한, select절에선 group by뒤의 검색조건필드를 집계함수와 함께 사용할수 있다.
 *  */
-- 도서테이블에서 모든 출판사를 검색하시오(중복불허 : GROUP BY사용) - 출판사필드만 검색
SELECT publisher FROM books GROUP BY publisher;

-- 책을 납품한 출판사의 납품한 책의 총 권수는?
SELECT publisher, count(publisher)  FROM books GROUP BY publisher;

-- 출판사별로 책 가격의 전체 합계와 평균?
SELECT publisher, sum(price), avg(price) FROM books GROUP BY publisher;

-- 출판사별로 책 가격중 최고가격과 최저가격의 책을 출력?(출판사/최고가격/최저가격) - 천단위마다 쉼표추가
SELECT publisher, format(max(price),0), format(min(price),0) FROM books GROUP BY publisher;

-- 책 1권의 가격이 2만원 이상인 책을 납품한 출판사는?(출판사명은 중복불허)
select publisher, price from books where price>=20000;
select distinct publisher, price from books where price>=20000;  /* 오답 */
select publisher, price from books where price>=20000 group by publisher;  /* 정답 */
select publisher, price from books group by publisher having price>=20000; /* <- 틀림 : having절에는 집계함수가 와야한다. */

-- 책을 납품한 횟수가 2회 이상인 출판사와 납품횟수를 출력하시오?
select publisher, count(publisher) from books group by publisher having count(publisher)>=2;

-- 책을 2번이상 납품한 출판사의 책중, 최고 가격인 출판사명을 출력하시오?
select publisher, max(price) from books group by publisher having count(publisher)>=2;

/* 한계치를 적용한 출력? 'limit 처음인덱스위치, 개수' */
-- 처음부터 10권의 책을 보여주시오?
SELECT * FROM books limit 10;

-- 책자료중 2번째부터 5건을 보여주시오?
SELECT * FROM books limit 1,5;

-- 책가격이 가장 높은순으로 5건만 출력하시오?
SELECT * FROM books order by price desc limit 5;


/* -------------------다중 테이블 활용하기-------------------------------- */
/* 주문자(고객) 테이블 : customer */
CREATE TABLE customer (
  custId  int not null auto_increment primary key, /* 고객 고유 아이디 */
  name 		varchar(20) not null,					/* 고객명 */
  address varchar(30) not null,					/* 고객주소 */
  phone   varchar(15)										/* 고객 연락처 */
);

-- customer(고객정보 등록)
INSERT INTO customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO customer VALUES (3, '김말숙', '대한민국 강원도', '000-7000-0001');
INSERT INTO customer VALUES (4, '손흥민', '영국 토트넘', '000-8000-0001');
INSERT INTO customer VALUES (5, '박세리', '대한민국 대전',  null);
INSERT INTO customer VALUES (6, '이순신', '대한민국 아산',  '');


/* 주문테이블(orders) */
-- on update cascade  : 원본테이블의 데이터를 변경시 참조테이블이 영향을 받는다.
-- on delete restrict : 원본테이블의 데이터를 삭제시 참조테이블이 영향을 받는다.(참조테이블에서 참조를 하고 있다면 삭제 불가)
create table orders (
	orderId   int not null auto_increment,/* 주문 고유번호 */
	custId		int not null,								/* 고객(주문자) 아이디 */
	bookId    int not null,								/* 책 고유번호 */
	salePrice int not null,								/* 책 할인가격(실제 판매가격) */
	orderDate timestamp,									/* 책 주문날짜(날짜형식) */
	primary key(orderId),									/* 주키 : orderId  , 외래키 : custId, bookId */
	foreign key(custId) references customer(custId) on update cascade on delete restrict,
	foreign key(bookId) references books(bookId) on update cascade on delete restrict
);
/* drop table orders; */

-- orders(주문정보) 데이터 생성
INSERT INTO orders VALUES (1, 1, 1, 6000, '2009-07-01'); 
INSERT INTO orders VALUES (2, 1, 3, 21000, '2018-02-03');
INSERT INTO orders VALUES (3, 2, 5, 8000, '2021-05-03'); 
INSERT INTO orders VALUES (4, 3, 6, 6000, '2020-06-04'); 
INSERT INTO orders VALUES (5, 4, 7, 20000, '2019-11-05');
INSERT INTO orders VALUES (6, 1, 2, 12000, '2021-09-07');
INSERT INTO orders VALUES (7, 4, 8, 13000, '2019-03-07');
INSERT INTO orders VALUES (8, 3, 10, 12000, '2018-07-08'); 
INSERT INTO orders VALUES (9, 2, 10, 9000, '2019-05-09'); 
INSERT INTO orders VALUES (10, 3, 11, 27000, '2020-06-15');
INSERT INTO orders VALUES (11, 2, 13, 11000, '2021-06-18');
INSERT INTO orders VALUES (12, 3, 15, 13000, '2021-08-20');
INSERT INTO orders VALUES (13, 6, 18, 19000, '2021-10-10');
INSERT INTO orders VALUES (14, 6, 16, 27000, '2021-11-20');
INSERT INTO orders VALUES (15, 3, 20, 30000, '2021-11-20');
INSERT INTO orders VALUES (16, 4, 16, 26000, '2021-11-25');
INSERT INTO orders VALUES (17, 4, 8, 13000, '2021-06-10');
INSERT INTO orders VALUES (18, 6, 8, 12000, '2021-06-10');
INSERT INTO orders VALUES (19, 2, 15, 13000, '2021-07-12');
INSERT INTO orders VALUES (20, 2, 17, 22000, '2021-10-15');

select * from books;
select * from customer;
select * from orders;

delete from customer where custId = 5;	/* 원본테이블의 5번자료는 참조테이블에 없기에 삭제가능 */
delete from customer where custId = 6;	/* 원본테이블의 6번자료는 참조테이블에 있기에 삭제안됨.(on delete restrict) */

delete from books where bookId = 4;
delete from books where bookId = 5;

update books set bookId = 20 where bookId = 21; /* 원본테이블의 20번자료는 참조테이블에 있기에 원본에서 수정처리하면 참조테이블도 반영된다.(on update casecade) */


-- customer테이블의 전화번호가 null 인 자료?
select * from customer where phone is null;

-- 고객별로 주문한 도서의 총수량과 총판매액을 구하시오. 이때 '고객아이디'도 출력하시오.
select custId, count(*) from orders group by custId;

/* 도서가격이 8천원이상인 도서를 구매한 고객에 대하여 주문도서의 총수량을 구하시오. 
   단, 4권이상 구매한 고객만 대상으로한다.(고객아이디 출력) */
SELECT custId,count(*) 
FROM orders 
WHERE salePrice>=8000 GROUP BY custId HAVING count(*)>=4;

/* -----------------Join(조인) - 다중테이블 응용 --------------------------------- */
/* 고객테이블과 주문테이블을 조건없이 연결하여 출력해 보자? */ 
SELECT * FROM customer, orders;
SELECT * FROM customer cc, orders oo;

-- 제약조건없이, 객테이블과 주문테이블을 검색하되, 고객아이디는 주문테이블에서, 성명은 고객테이블에서 출력하시오.
select oo.custId, cc.name from customer cc, orders oo;

-- 고객명과 해당고객이 주문한 사항을 모두 출력시켜보시오.
select * from customer, orders where customer.custId = orders.custId;
select * from customer cc, orders oo where cc.custId = oo.custId;

-- 고객과 해당고객이 주문한 정보에 대한자료를 출력하되 고객번호순으로 출력하시오.
select * from customer cc, orders oo where cc.custId = oo.custId order by cc.custId desc;

-- 고객명과 해당고객이 주문한 도서의 판매가격을 검색하시오(출력: 고객명, 도서 실제판매가격)
select name, salePrice 
from customer cc, orders oo 
where cc.custId = oo.custId;

-- 고객명과 고객이 주문한 도서의 이름을 출력하시오(3개 테이블 Join) - bookId도 함께 출력
select cc.name, bb.bookName, bb.bookId 
from books bb, customer cc, orders oo
where oo.custId = cc.custId and oo.bookId = bb.bookId;

-- 실제 판매가격이 2만원이상인 도서를 주문한 고객명과 도서명과 도서판매정가를 구하시오?
select cc.name, bb.bookName, bb.price  
from books bb, customer cc, orders oo
where oo.custId=cc.custId and oo.bookId=bb.bookId and oo.salePrice>=20000;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명별로 정렬하여 출력하시오.(출력:고객명, 총판매액)
SELECT cc.name, sum(oo.salePrice) FROM customer cc, orders oo
where cc.custId = oo.custId GROUP BY cc.name ORDER BY cc.name;

SELECT cc.name 고객명, format(sum(oo.salePrice),0) 총판매액, format(avg(oo.salePrice),1) 평균판매액 
FROM customer cc, orders oo
where cc.custId = oo.custId GROUP BY cc.name ORDER BY cc.name;

SELECT cc.name 고객명, format(sum(oo.salePrice),0) 총판매액, format(avg(oo.salePrice),1) 평균판매액 
FROM customer cc inner join orders oo
where cc.custId = oo.custId GROUP BY cc.name ORDER BY cc.name;

/* 고객 모두에 대하여 책을 주문한 내역을 출력?(단, 책을 구매하지 않은회원도 출력하시오) - Left JOIN(왼쪽테이블 우선) */
SELECT cc.name, oo.bookId from customer cc left join orders oo
on cc.custId = oo.custId;

/* 구매한 책에 대하여 책을 주문한 고객의 내역을 출력하시오.(단, 구매된 정보는 모두 출력하시오) - Right Join(오른쪽테이블우선) */
SELECT cc.name, oo.bookId from customer cc right join orders oo
on cc.custId = oo.custId;

/* Outer Join : 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서판매가격을 출력? */
SELECT cc.name, oo.salePrice
FROM customer cc left outer join orders oo
ON cc.custId = oo.custId;

/* -----------------부속질의(Sub Query)------------------------------------------- */
-- 가장 비싼 도서의 이름과 정가격을 출력?
SELECT bookName, max(price) FROM books;
SELECT bookName, price FROM books WHERE price = (SELECT max(price) FROM books);

/* 도서를 구매한 적이 있는 고객의 이름을 출력하세요? */
SELECT name FROM customer WHERE custId IN (SELECT custId FROM orders);

/* '대한미디어'출판사 책을 구매한 고객의 이름을 출력해 보시오? */
SELECT name FROM customer 
WHERE custId IN 
  (SELECT custId FROM orders 
   WHERE bookId IN (SELECT bookId FROM books WHERE publisher='대한미디어'));

/* 도서를 구매하지 않은 고객의 이름을 출력하시오 */
select distinct cc.name from customer cc, orders oo 
where cc.custId not in (select custId from orders);

select name from customer where custId not in (select custId from orders);


/* ----------------------------------------- */
select count(*) from orders where custId = 1;

select orderId from orders where orderDate not between '2019-7-4' and '2020-6-5';

select name, address from customer where name like '김%아';

select bb.bookName, bb.price, bb.price-oo.saleprice
from books bb, customer cc, orders oo 
where cc.custId = oo.custId and oo.bookId = bb.bookId and cc.name = '박지성';

select name, sum(salePrice) 구매액 from customer cc, orders oo
where cc.custId = oo.custId 
group by name;

select * from books bb, orders oo
where oo.bookId = bb.bookId  
and (price-salePrice) = (select max(price-salePrice) 
from orders, books where orders.bookId = books.bookId);

select name, avg(salePrice) from customer cc, orders oo
where oo.custId = cc.custId group by name;

-- 1. 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)?
select count(*) from orders where custId = 1;


-- 2. 2019년 7월 4일~2020년 6월 5일 사이에 주문받은 도서를 제외한 도서의 주문번호를 출력하시오.
select orderId from orders where orderDate not between '2019-7-4' and '2020-6-5';


-- 3. 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 ‘이름’과 ‘주소’를 출력하시오.
select name, address from customer where name like '김%아';


-- 4. 고객별로주문한도서의총수량과 총판매액을구하시오. 이때'고객아이디'도 출력하시오.
select custId, count(*) from orders group by custId;


-- 5. 도서가격이 8천원이상인도서를구매한고객에대하여주문도서의총수량을구하시오. 단, 4권이상구매한 고객만을 대상으로한다.(고객아이디출력)
SELECT custId,count(*) 
FROM orders 
WHERE salePrice>=8000 GROUP BY custId HAVING count(*)>=4;


-- 6. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격(세일가격)의 차이를 출력하시오.
select bb.bookName, bb.price, bb.price-oo.saleprice
from books bb, customer cc, orders oo 
where cc.custId = oo.custId and oo.bookId = bb.bookId and cc.name = '박지성';


-- 7. 주문하지 않은 고객의 이름을 출력하시오?(부속질의 사용)
select distinct cc.name from customer cc, orders oo 
where cc.custId not in (select custId from orders);


-- 8. 고객의 이름과 고객별 구매액을 출력하시오.
select name, sum(salePrice) 구매액 from customer cc, orders oo
where cc.custId = oo.custId 
group by name;


-- 9. 도서의 가격(Books 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문을 출력하시오.
select * from books bb, orders oo
where oo.bookId = bb.bookId  
and (price-salePrice) = (select max(price-salePrice) 
from orders, books where orders.bookId = books.bookId);


-- 10. 고객별 평균 구매액을 구하시오.(출력: 고객명, 평균구매액)
select name, avg(salePrice) from customer cc, orders oo
where oo.custId = cc.custId group by name;