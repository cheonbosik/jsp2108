/* guest.sql(방명록) */
create table guest (
	idx   int not null auto_increment primary key,	/* 방명록 고유번호 */
	name  varchar(20) not null,				/* 방문자 성명 */
	email varchar(60),								/* 이메일 주소 */
	homepage varchar(60),							/* 홈페이지(블로그)주소 */
	vDate datetime default now(),			/* 방문일자 */
  hostIp varchar(50) not null,			/* 방문자 IP */
  content  text not null						/* 방문소감 */
);

desc guest;
/* drop table guest; */

insert into guest values (default,'관리자','cjsk1126@naver.com','blog.daum.net/cjsk1126',default,'218.236.203.146','방명록 서비스를 시작합니다.');
insert into guest values (default,'홍길동','hkd1234@hanmail.net','',default,'192.168.0.10','잠시 방문해 봅니다.');

select * from guest;

select count(*) from guest;

select * from guest order by idx desc limit 0,10;
select * from guest order by idx desc limit 10,10;
select * from guest order by idx desc limit 20,10;


