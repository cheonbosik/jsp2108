<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl3.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>Function 라이브러리</h2>
  <p>사용법 : $ {fn:함수명(변수)}</p>
  <hr/>
<%
							 //0         1         2
               //0123456789012345678901234567890
  String atom = "Welcome to My Homepage(O:홍길동)!";
  //request.setAttribute("atom", atom);
  //pageContext.setAttribute("atom", atom);
%>
  atom의 길이 : <%=atom.length() %><br/>
  1.jstl함수를 이용한 atom의 길이(length): ${fn:length(atom)}<br/>
  <c:set var="atom" value="<%=atom%>"/>
  2.jstl함수를 이용한 atom의 길이(length): ${fn:length(atom)}<br/>
  3.대문자변환(toUpperCase()) : ${fn:toUpperCase(atom)}<br/>
  4.소문자변환(toLowerCase()) : ${fn:toLowerCase(atom)}<br/>
  5.문자열추출(substring(변수명,처음위치,마지막위치+1)) :
    <ul> 
      <li>처음부터 3문자만 추출 : ${fn:substring(atom,0,3)}</li>
      <li>3부터 3문자만 추출 : ${fn:substring(atom,3,6)}</li>
    </ul><br/>
  6.특정문자열의 위치값찾기(indexOf(변수,'찾을문자')) :
  	<ul> 
      <li>처음 만나는 'o' 문자의 위치값? ${fn:indexOf(atom, 'o')}</li>
      <li>처음 만나는 'O' 문자의 위치값? ${fn:indexOf(atom, 'O')}</li>
      <li>처음 만나는 's' 문자의 위치값? ${fn:indexOf(atom, 's')}</li>
      <c:forEach var="i" begin="0" end="${fn:length(atom)-1}">
        <c:if test="${fn:substring(atom,i,i+1) == 'o'}">
          <c:set var="lastStr" value="${i}"/>
        </c:if>
      </c:forEach>
      <li>마지막에 만나는 'o' 문자의 위치값? ${lastStr}</li>
    </ul><br/>
  7.문자열추출(substringBefore() / substringAfter)
    <ul>
      <li>atom변수의 문자 : ${atom}</li>
      <li>특정문자 앞쪽까지 출력 - substringBefore() : ${fn:substringBefore(atom,'o')}</li>
      <li>특정문자 뒤쪽부터 마지막 출력 - substringAfter() : ${fn:substringAfter(atom,'o')}</li>
      <c:set var="str2" value="${fn:substringAfter(atom,'o')}"/>
      <li>2번째로 만나는 'o'문자 뒤의 값을 모두 출력? ${fn:substringAfter(str2,'o')}</li>
      <li>2번째로 만나는 'o'문자 뒤의 값을 모두 출력? ${fn:substringAfter(fn:substringAfter(atom,'o'),'o')}</li>
      
      <li>1번째 'o'에서 2번째 'o'사이의 문자를 발췌?<br/>
        과정 : ${fn:substring(atom,0,fn:indexOf(atom,'o'))}<br/>
        결과 : ${fn:substring(fn:substring(atom,fn:indexOf(atom,'o')+1,fn:length(atom)),0,fn:indexOf(atom,'o'))}<br/>
      </li>
    </ul><br/>
  8.문자열 분리(split(변수,분리할문자))
    <ul>
      <li>'o'문자를 기준으로 각각 분리시켜 출력하시오?
        <c:set var="arrAtom" value="${fn:split(atom,'o')}"/>
        <c:forEach var="arr" items="${arrAtom}">
          ${arr} / &nbsp;
        </c:forEach>
      </li>
      <li>1번째 'o'에서 2번째 'o'사이의 문자를 발췌?
        <c:set var="arrAtom" value="${fn:split(atom,'o')}"/>
        <c:forEach var="arr" items="${arrAtom}" varStatus="st">
          <c:if test="${st.count == 2}"> ${arr}</c:if>
        </c:forEach>
      </li>
      <li>1.전화번호 010-1234-5678 중에서 '국번호'만 출력하시오?
        <c:set var="telephone" value="010-1234-5678"/>
        <%-- <c:set var="arrTel" value="${fn:split('010-1234-5678','-')}"/> --%>
        <c:set var="arrTel" value="${fn:split(telephone,'-')}"/>
        <c:forEach var="tel" items="${arrTel}" varStatus="st">
          <c:if test="${st.count == 2}"> ${tel}</c:if>
        </c:forEach>
      </li>
      <li>2.전화번호 010-1234-5678 중에서 '국번호'만 출력하시오?
        <c:set var="arrTel" value="${fn:split(telephone,'-')}"/>
        ${arrTel[1]}
      </li>
      <li>3.구분자 '-'을 기준으로 마지막에 저장된 항목을 출력하시오.(010-1234-5678)?
        <c:set var="arrTel" value="${fn:split(telephone,'-')}"/>
        <c:forEach var="tel" items="${arrTel}" varStatus="st">
          <c:if test="${st.last}">${tel}</c:if>
        </c:forEach>
      </li>
      <li>4.구분자 '-'을 기준으로 마지막에 저장된 항목을 출력하시오.(010-1234-5678)?
        <c:set var="arrTel" value="${fn:split(telephone,'-')}"/>
        ${arrTel[fn:length(arrTel)-1]}
      </li>
    </ul><br/>
  9.문자열 치환(replace(변수,원본문자,치환할문자))
    <ul>
      <li>My를 Your로 변경하여 출력하시오.? ${fn:replace(atom,'My','Your')}</li>
      <li>atom변수안의 모든 공백을 제거후 출력하시오? ${fn:replace(atom, ' ', '')}</li> 
    </ul><br/>
  10.특정 문자로 시작하는지의 유무를 판단? startsWith(문자열, 시작문자열)
    <ul>
      <li>atom변수의 시작글자가 'W' 인지를 판단? ${fn:startsWith(atom, 'W')}</li>
      <li>atom변수의 시작글자가 'w' 인지를 판단? ${fn:startsWith(atom, 'w')}</li>
    </ul><br/>
  11.특정 문자로 끝나는지의 유무를 판단? endsWith(문자열, 시작문자열)
    <ul>
      <li>atom변수의 마지막글자가 '!' 인지를 판단? ${fn:endsWith(atom, '!')}</li>
      <li>atom변수의 마지막글자가 '?' 인지를 판단? ${fn:endsWith(atom, '?')}</li>
    </ul><br/>
  12.특정 문자를 포함하는지의 유무를 판단? contains(변수, 문자열)
    <ul>
      <li>atom변수에 'o'를 포함하고 있는가를 판단? ${fn:contains(atom, 'o')}</li>
      <li>atom변수에 's'를 포함하고 있는가를 판단? ${fn:contains(atom, 's')}</li>
      <li>atom변수에 '홍'을 포함하고 있는가를 판단? ${fn:contains(atom, '홍')}</li>
      <li>atom변수에 '홍길순'을 포함하고 있는가를 판단? ${fn:contains(atom, '홍길순')}</li>
    </ul><br/>
  <hr/>
  <h2>형식문자열 지정(Formatting 라이브러리)</h2>
  <p>사용법 : < fmt :명령어 value="변수/값" [,type="형식문자열",pattern="패턴"]}</p>
<%
  int won = 1234567;
  pageContext.setAttribute("won", won);
%>
  <hr/>
  <h4>formatNumber 형식</h4>
  <ul>
    <li>won = ${won}</li>
    <li>천단위마다 콤마표시 : <fmt:formatNumber value="${won}"/></li>
    <li>화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency"/></li>
    <li>화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="USD"/></li>
    <li>화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencySymbol="$"/></li>
    <li>화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="JPY"/></li>
    <li>화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="EUR"/></li>
    <li>화폐단위로 콤마표시 : <fmt:formatNumber value="${won}" type="currency" currencyCode="AUD"/></li>
    <c:set var="su2" value="123456.789"/>
    <li>1.소수이하 두자리 출력(반올림) : <fmt:formatNumber value="${su2}" pattern=".00"/></li>
    <li>2.정수부 출력(반올림) : <fmt:formatNumber value="${su2}" pattern="0"/></li>
    <li>3.정수부 출력(반올림) : <fmt:formatNumber value="${su2}" pattern="#,##0"/></li>
    <li>4.숫자값 그대로 출력 : <fmt:formatNumber value="${su2}"/></li>
    <li>5.소수이하 버림 : <fmt:parseNumber value="${su2}" integerOnly="true"/></li>
    <li>천단위 콤마표시, 소수이하 두자리 출력 : <fmt:formatNumber value="${won}" pattern="#,###.00"/></li>
    <c:set var="su1" value="55"/>
    <c:set var="total" value="100"/>
    <li>백분율 형식표시 : <fmt:formatNumber value="${su1/total}" type="percent"/></li>
  </ul>
  <hr/>
  <h4>formatDate 형식</h4>
  <c:set var="now" value="<%=new java.util.Date() %>"/>
  <ul>
    <li>오늘 날짜 : ${now}</li>
    <li><fmt:formatDate value="${now}"/></li>
    <li><fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/></li>
    <li><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일"/></li>
    <li><fmt:formatDate value="${now}" pattern="yyyy-MM-dd hh:mm:ss"/></li>
    <li><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초"/></li>
  </ul><br/>
  <hr/>
  <h4>타임존 설정</h4>
  <jsp:useBean id="today" class="java.util.Date"/>
  <ul>
    <li>오늘 날짜 : ${today}</li>
    <li>Korea KST : <fmt:formatDate value="${today}" dateStyle="full" timeStyle="full" type="both"/></li>
    <li>
      <fmt:timeZone value="GMT">
        Swiss GMT : <fmt:formatDate value="${today}" dateStyle="full" timeStyle="full" type="both"/> 
      </fmt:timeZone>
    </li>
    <li>
      <fmt:timeZone value="GMT-8">
        NewYork GMT-8 : <fmt:formatDate value="${today}" dateStyle="full" timeStyle="full" type="both"/> 
      </fmt:timeZone>
    </li>
  </ul><br/>
  <h4>국가별설정(로케일)</h4>
  <ul>
    <li>톰캣 서버의 기본 로케일 : <%=response.getLocale() %></li>
    <li>
      <fmt:setLocale value="en_US"/>
      로케일을 미국식으로 설정후 통화표시 : <fmt:formatNumber value="${won}" type="currency"/> / &nbsp;
      날짜 : <fmt:formatDate value="${now}"/>
    </li>
    <li>
      <fmt:setLocale value="ja_JP"/>
      로케일을 일본식으로 설정후 통화표시 : <fmt:formatNumber value="${won}" type="currency"/> / &nbsp;
      날짜 : <fmt:formatDate value="${now}"/>
    </li>
    <li>
      <fmt:setLocale value="ko_KR"/>
      로케일을 일본식으로 설정후 통화표시 : <fmt:formatNumber value="${won}" type="currency"/> / &nbsp;
      날짜 : <fmt:formatDate value="${now}"/>
    </li>
  </ul><br/>
  <h4>import문 : jsp:include 액션태그와 같다.</h4>
  <hr/>
  <h4>redirect문 == response.sendRedirect(경로) == location.href(경로)</h4>
  <%-- <c:redirect url="${ctp}/jstl1.st"/> --%>
  <hr/>
  <%--
  <h4>URL문 : 그림파일과 같은 외부파일을 불러온다.</h4>
  <p><img src="${ctp}/images/noimage.jpg" width="200px"/></p>
  <p>
    <c:url var="data" value="/images/noimage.jpg"/>
    <img src="${data}" width="150px"/>
  </p>
  <p>
    <c:set var="data2" value="${ctp}/images/noimage.jpg"/>
    <img src="${data2}" width="100px"/>
  </p>
  --%>
  <h4>URL문 : 그림파일과 같은 외부파일을 불러온다.</h4>
  <p><img src="${ctp}/noimage.st" width="200px"/></p>
  <p><img src="images/noimage.jpg" width="200px"/></p>
  <p>
    <c:url var="data" value="images/noimage.jpg"/>
    <img src="${data}" width="150px"/>
  </p>
  <p>
    <c:set var="data2" value="images/noimage.jpg"/>
    <img src="${data2}" width="100px"/>
  </p>
</div>
<br/>
<%-- <%@ include file="/include/footer.jsp" %> --%>
<c:import url="/include/footer.jsp"/>
</body>
</html>