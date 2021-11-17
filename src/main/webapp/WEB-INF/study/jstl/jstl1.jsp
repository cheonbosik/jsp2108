<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl1.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>JSTL(Java Standard Tag Library)</h2>
  <table class="table">
    <tr>
      <th>라이브러리명</th>
      <th>주소(URL)</th>
      <th>접두어(prefix)</th>
      <th>문법</th>
    </tr>
    <tr>
      <td>Core</td>
      <td>http://java.sun.com/jsp/jstl/core</td>
      <td>c</td>
      <td>< c : 태그... ></td>
    </tr>
    <tr>
      <td>Function</td>
      <td>http://java.sun.com/jsp/jstl/functions</td>
      <td>fn</td>
      <td>$ { fn : 태그... }</td>
    </tr>
    <tr>
      <td>Formatting</td>
      <td>http://java.sun.com/jsp/jstl/fmt</td>
      <td>fmt</td>
      <td>< fmt : 태그... ></td>
    </tr>
    <tr>
      <td>SQL</td>
      <td>http://java.sun.com/jsp/jstl/sql</td>
      <td>sql</td>
      <td>< sql : 태그... ></td>
    </tr>
  </table>
  <hr/>
  <h3>Core라이브러리 : 변수제어(선언/할당), 제어문/반복문</h3>
  <p>변수 선언 : < c :set var="변수명" value="값" /></p> 
  <p>변수(값) 출력 : < c :out value="변수(el표기법)/값" /></p>
  <p>변수 제거 : < c :remove var="변수명"/> 설정한 변수를 메모리에서 제거한다.</p>
  <p>예외처리 : <c :catch 문장.... /></p>
   
  su1변수 선언? <c:set var="su1" value="500"/><br/>
  '100'값 출력? <c:out value="100"/><br/>
  su1값 출력? <c:out value="${su1}"/><br/>
  < c : out ... ./>대신에 바로 EL표기법으로 출력가능.....<br/>
  su1값 출력? ${su1}<br/>
<% String name = "홍길동"; %>
  <c:set var="name" value="<%=name%>"/>
  name : ${name}<br/>
  <hr/>
  <h3>jstl core라이브러리 응용</h3>
  <p>연산</p>
  <c:set var="su2" value="100"/><br/>
  su1 + su1 = <c:out value="${su1 + su2}"/><br/>
  su1 + su1 = ${su1 + su2}<br/>
  su1 - su1 = ${su1 - su2}<br/>
  su1 * su1 = ${su1 * su2}<br/>
  su1 / su1 = ${su1 / su2}<br/>
  su1 % su1 = ${su1 % su2}<br/>
  <hr/>
<%
  MemberVO vo = new MemberVO();
  vo.setName("홍길동");
  vo.setAddress("서울");
  vo.setEmail("cjsk1126@naver.com");
  request.setAttribute("vo", vo);
  //pageContext.setAttribute("vo", vo);
%>
  VO객체의 name : ${vo.name}<br/>
  VO객체의 address : ${vo.address}<br/>
  VO객체의 email : ${vo.email}<br/>
  VO객체의 name을 jstl변수 name에 담아서 출력?
  <c:set var="name" value="${vo.name}"/>
  name = ${name}<br/><br/>
  
  <h4>vo객체의 name필드에 '김말숙'을 저장시켜보자</h4>
  <c:set var="irum" value="이기자"/>
  <%-- <c:set target="${vo}" property="name" value="김말숙"/> --%>
  <c:set target="${vo}" property="name" value="${irum}"/>
  저장된 vo객체의 name필드값은? ${vo.name} 또는 <%=vo.getName() %><br/>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>