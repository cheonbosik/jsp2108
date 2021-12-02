show tables;

create table schedule (
  idx    	int not null auto_increment primary key, /* 고유번호 */
  mid			varchar(20) not null,							/* 회원 고유 아이디 */
  sDate	datetime not null default now(),	/* 일정 등록 날짜 */
  part    varchar(10) not null,							/* 기념일(모임/업무/학습/여행/기타) */
  content text not null											/* 기념일 상세내역 */
);

desc schedule;
/* drop table schedule; */
/* delete from schedule; */

insert into schedule value (default,'hkd1234',default,'모임','저녁약속: 청주사거리 맛집 6시');

select * from schedule;
