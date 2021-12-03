show tables;

create table webMessage (
  idx  			int not null auto_increment primary key, 	/* 고유번호 */
  title			varchar(100) not null,			/* 메세지 제목 */
  content		text	not null,							/* 메세지 내용 */
  sendId		varchar(20) not null,				/* 보내는 사람 아이디 */
  sendSw		char(1)			not null,				/* 보낸메세지(s), 휴지통(g), 휴지통삭제(x) 표시 */
  sendDate  datetime		default now(),	/* 메세지 보낸 날짜 */
  receiveId	varchar(20) not null,				/* 받는 사람 아이디 */
  receiveSw		char(1)			not null,			/* 받은 새메세지(n), 읽은메세지(r), 휴지통(g), 휴지통삭제(x) 표시 */
  receiveDate  datetime		default now() /* 메세지 보낸 날짜 */
);

desc webMessage;

insert into webMessage values (default,'안녕! 말숙아~~','주말에 시간있니?','hkd1234','s',default,'kms1234','n',default);
insert into webMessage values (default,'답장! 반갑다 길동아~~','주말에 프로젝트 계획이있어서 다음에 만나자','kms1234','s',default,'hkd1234','n',default);

select * from webMessage order by idx desc;