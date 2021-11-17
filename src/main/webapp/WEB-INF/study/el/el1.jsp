<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>el1.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>EL(Expression Language)</h2>
  <hr/>
  <p>
    <b>용도 : 사용자가 값(변수/객체/수식)을 전송후에 담아줄(저장할) 용도로 사용한다.</b><br/>
    <b>표기법 : </b>$ {변수 or 값 or 수식 or 제어문}<br/>
  </p>
  <hr/>
  <div>
    <p><b>저장소</b></p>
    <ol>
      <li>Server
        <ul>
          <li>Application : 전역변수...</li>
          <li>Session : 브라우저 생성시 발생/소멸</li>
          <li>Request : request에 의해서 전송시 유효.. 이후는 소멸..</li>
          <li>pageContext : 현재 Page에서만 통용되는 저장소</li>
        </ul>
      </li>
      <li>Client
        <ul>
          <li>Cookie</li>
        </ul>
      </li>
    </ol>
  </div>
  <hr/>
<%
	String atom = "Seoul";		// String atom = request.getParameter("atom");  같은 용도로 사용중...
  String name = "홍길동";
	int su1 = 100, su2 = 200;
%>
  <p>앞의 저장된 내용을 스크립틀릿을 이용한 출력?</p>
  atom = <%=atom%><br/>
  name = <%=name %><br/>
  su1 = <%=su1 %><br/>
  su2 = <%=su2 %><br/>
  <hr/>
<%
  // request.setAttribute("atom", atom);
  // request.setAttribute("name", name);
  // request.setAttribute("su1", su1);
  // request.setAttribute("su2", su2);
  
  pageContext.setAttribute("atom", atom);
  pageContext.setAttribute("name", name);
  pageContext.setAttribute("su1", su1);
  pageContext.setAttribute("su2", su2);
%>
  <h2>EL 사용예</h2>
  atom = ${atom}<br/>
  name = ${name}<br/>
  su1 = ${su1}<br/>
  su2 = ${su2}<br/>
  <hr/>
  <p>일반적인 '값(숫자,문자)/수식/변수/제어문' 출력?</p>
  123 = ${123}<br/>
  mbc1 = ${'mbc1'}<br/>
  mbc2 = ${"mbc2"}<br/>
  su1 + su2 = ${su1 + su2}<br/>
  삼항연산자 $ {su1 > su2 ? su1 : su2} => ${su1 > su2 ? su1 : su2}<br/>
  <hr/>
  <p>앞페이지에서 값을 넘겨줄때는 '$ {param.xxx}'로 받는다.</p>
  atom = ${param.atom}<br/>
  su1 = ${param.su1}<br/>
  su2 = ${param.su2}<br/>
  <hr/>
  <h3>Form에 의한 값의 전달</h3>
  <div>
    <form name="myform" method="post" action="<%=request.getContextPath()%>/el2.st">
      <p>아이디 : <input type="text" name="mid" class="form-control"/></p>
      <p>비밀번호 : <input type="password" name="pwd" class="form-control"/></p>
      <p>성명 : <input type="text" name="name" class="form-control"/></p>
      <p><input type="submit" value="값전송" class="form-control btn-secondary"/></p>
      <input type="hidden" name="mbc" value="MBC방송국"/>
      <p>
	      <input type="checkbox" name="hobby" value="등산" checked/>등산 &nbsp;
	      <input type="checkbox" name="hobby" value="낚시"/>낚시 &nbsp;
	      <input type="checkbox" name="hobby" value="바둑"/>바둑 &nbsp;
	      <input type="checkbox" name="hobby" value="수영"/>수영 &nbsp;
      </p>
    </form>
  </div>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>