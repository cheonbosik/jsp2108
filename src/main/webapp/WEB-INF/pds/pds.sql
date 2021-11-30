show tables;

create table pds (
  idx 	int  not null auto_increment,	/* 자료실 고유번호 */
  mid   varchar(20) not null,					/* 자료실 등록자 아이디 */
  nickName varchar(20)  not null,			/* 등록자 별명 */
  fName		 varchar(200) not null,			/* 업로드할때 파일명 */
  fSName	 varchar(200) not null,			/* 파일서버에 저장되는 실제 파일명 */
  fSize	   int,												/* 총 파일 사이즈 */
  title		 varchar(100) not null,			/* 파일 제목 */
  part     varchar(20)  not null,			/* 파일분류 */
  pwd		   varchar(100) not null,			/* 비밀번호(삭제시필요) - 'SHA-256'암호화 */
  fDate    datetime default now(),		/* 파일 업로드한 날짜 */
  downNum  int default 0,							/* 다운로드 횟수 */
  openSw	 char(6) default '공개',			/* 파일 공개여부(공개/비공개) */
  content  text,											/* 파일 상세설명 */
  primary key (idx)
);

desc pds;
delete from pds;

select * from pds order by idx desc;
