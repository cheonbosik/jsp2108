/* board.sql */

show tables;

create table board (
	idx  int not null auto_increment,	/* 게시글의 고유번호 */
	nickName varchar(20)  not null,		/* 게시글 올린사람의 닉네임 */
	title    varchar(100) not null,		/* 게시글의 글 제목 */
	email 	 varchar(50),							/* 올린이의 메일주소 */
	homePage varchar(50),							/* 올린이의 홈페이지주소(블로그주소) */
	content  text not null,						/* 글 내용 */
	wDate    datetime default now(),  /* 글쓴 날짜(기본값:현재날짜/시간) */
	readNum  int default 0,						/* 글 조회수 */
	hostIp	 varchar(50) not null,		/* 접속 IP주소 */
	goods		 int  default 0,					/* 좋아요 */
	mid			 varchar(20) not null,		/* 회원 아이디(게시글 조회시 사용) */
	primary  key(idx)									/* 기본키 : 글 고유번호 */
);

desc board;

insert into board values (default,'관리맨','게시판 서비스를 시작합니다.','cjsk1126@naver.com','blog.daum.net/cjsk1126','이곳은 게시판입니다. 좋은글 많이 부탁드려요',default,default,'218.236.203.146',default,'admin');

select * from board order by idx desc;
