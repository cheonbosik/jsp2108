show tables;

create table member (
	idx		int not null auto_increment,	/* 회원 고유번호 */
	mid		varchar(20)   not null,				/* 회원 아이디(중복불허) */
	pwd		varchar(50)		not null,				/* 비밀번호(입력시 9자로 제하처리할것) */
	pwdKey int  not null,								/* 해시키관리하는 키번호 */
	nickName  varchar(20) not null,			/* 별명(중복불허) */
	name			varchar(20) not null,			/* 성명 */
	gender    varchar(10) default '남자',/* 성별 */
	birthday	datetime		default now(),/* 생일 */
	tel				varchar(15),							/* 연락처 */
	address		varchar(50),							/* 주소 */
	email			varchar(50)	not null,			/* 이메일(아이디/비밀번호 분실시 필요) */
	homePage	varchar(50),							/* 홈페이지(블로그)주소 */
	job				varchar(20),							/* 직업 */
	hobby			varchar(60),							/* 취미 */
	photo			varchar(100) default 'noimage.jpg', 	/* 회원사진 */
	content   text,											/* 자기소개 */
	userInfor char(6) default '공개',		/* 회원 정보 공개여부(공개/비공개) */
	userDel		char(2) default 'NO',			/* 회원 탈퇴 신청 여부(OK:탈퇴신청한회원, NO:현재가입중인회원) */
	point     int default 100,					/* 포인트(최초가입회원은 100, 한번 방문시마다 10 */
	level			int default 1,						/* 1:준회원, 2:정회원, 3:우수회원 (4:운영자) 0:관리자 */
	visitCnt	int default 0,						/* 방문횟수 */
	startDate datetime default now(),		/* 최초 가입일 */
	lastDate  datetime default now(),		/* 마지막 접속일 */
	primary key(idx, mid)								/* 키본키 : 고유번호, 아이디 */
);

desc member;

insert into member values (default,'admin','1234',1,'관리맨','관리자',default,default,'010-3423-2704','경기도 안성시','cjsk1126@naver.com','blog.daum.net/cjsk1126','프리랜서','등산/바둑',default,'관리자입니다.',default,default,default,default,default,default,default);

