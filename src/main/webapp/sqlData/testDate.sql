/* 날짜 함수 연습 */
/* 오늘 날짜? */
select now();
select sysdate();
select localtime()

/* 날짜함수에 +1을 하면? 'yyyyMMddHHmmss + 1' */
select now(), now() + 1;
select sysdate() + 1;
select localtime() + 1;

/* 오늘날짜만? */
select curdate();

/* 오늘 년도? */
select year(now());

/* 오늘 월? */
select month(now());

/* 오늘 몇일? */
select day(now());

select concat(year(now()),'-',month(now()),'-',day(now()));

select nickName,wDate from board order by idx desc;
select nickName,year(wDate),month(wDate),day(wDate) from board order by idx desc;
select nickName,day(wDate) from board where day(now())-1 = day(wDate) order by idx desc;

/* 현재 시간? */
select hour(now());
select minute(now());
select second(now());

/* 오늘은 무슨요일?(인덱스값으로 반환됨 : 일-1, 월-2, 화-3, 수-4, 목-5, 금-6, 토-7) */
select dayofweek(now());

/* 오늘 요일을 영문으로? */
select dayname(now());
select dayname(curdate());

select nickName, wDate, dayname(wDate) from board;

/* 해당월의 마지막일(Last_Day)? : (2021-02-28) 평년의 2월 28, 윤년의 2월 29 */
select last_day("2021-02-01");
select last_day("2021-11-01 11:56:25");
select last_day(now());
select nickName, last_day(wDate) from board;

/* 날짜 형식 설정 : DATE_FORMAT(날짜, 형식) */
/*
  %Y : 4자리년도 , %y : 2자리년도
  %M : 영문으로 긴 월 , %b : 영문 짧은 월
  %m : 숫자 월 두자리로 표시 , %c :숫자월(한자리 월은 한자리로 표시) 
  %d : 일자(두자리) , %e : 일자(한자리일은 한자리로 표시)
  %l : 시간(12시간제) , %H : 시간(24시간제)
  %i : 분
  %s : 초
  %r :  hh:mm:ss AM , PM
  %T :  hh:mm:ss
*/
select date_format(now(), "%Y / %y");
select date_format(now(), "%M / %b");
select date_format(now(), "%m / %c");
select date_format(wDate, "%m / %c") from board;
select date_format(wDate, "%d / %e") from board;
select date_format(wDate, "%l / %H / %r / %T") from board;

/* 두 날짜 사이의 값을 비교?( DATEDIFF() : 앞쪽날짜-뒤쪽날짜) */
select datediff("2021-11-24", "2021-11-1");
select datediff(now(), "2021-11-1");
select datediff(now(), "2021-1-1");
select datediff("2021-12-31",now());

/* 날짜 연산(DATE_ADD() / DATE_SUB()) */
/* interval 정수 인자 */
/* 인자 : month / day / hour / minute */

/* 오늘 날짜에 2월을 더한 날짜를 반환 */
select date_add(now(), interval 2 month);

/* 오늘 날짜에 2월을 뺀 날짜를 반환 */
select date_add(now(), interval -2 month);

/* 게시글의 글중 1개월 이내의 자료만 출력하시오 */
select nickName,wDate from board where date_add(now(), interval -1 month) < wDate;

/* 게시글의 글중 1일 이내의 자료만 출력하시오 */
select nickName,wDate from board where date_add(now(), interval -1 day) < wDate;

/* 게시글의 글중 24시간 이내의 자료만 출력하시오(date_add()) */
select nickName,wDate from board where date_add(now(), interval -24 hour) < wDate;

/* 게시글의 글중 24시간 이내의 자료만 출력하시오(date_sub()) */
select nickName,wDate from board where date_sub(now(), interval 24 hour) < wDate;