<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmMessage.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    function wmDeleteAll() {
    	var ans = confirm("휴지통을 모두 비우시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/wmDeleteAll.wm",
    		success:function() {
  				alert("휴지통의 모든 메세지가 삭제 되었습니다.");
  				location.reload();
    		} 
    	});
    }
  </script>
  <style>
    #leftWindow {
      float : left;
      width : 25%;
      height: 500px;
      text-align: center;
      background-color: #ddd;
    }
    #rightWindow {
      float : left;
      width : 75%;
      height: 500px;
      text-align: left;
      background-color: #eec;
      overflow: auto;
    }
    #footerTopMargin {
      clear:both;
      margin: 10px;
    }
    h3 {text-align: center}
  </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h3>메세지 관리</h3>
  <div>(현재접속자:<font color='red'>${sMid}</font>)</div>
  <div id="leftWindow">
  	<p><br/></p>
  	<p><a href="${ctp}/wmMessage.wm?mSw=0">메세지작성</a></p>
  	<p><a href="${ctp}/wmMessage.wm?mSw=1&mFlag=10">받은메세지</a></p>	<!-- mSw는 우측에 표시될 화면을 의미하기에 휴지통으로 메세지보낼때 '받은메세지함'인지 '보낸메세지함'인지를 구별하기위해 mFlag를 이용함(10은 받은메세지, 11은 보낸메세지를 의미) -->
  	<p><a href="${ctp}/wmMessage.wm?mSw=2">새메세지</a></p>
  	<p><a href="${ctp}/wmMessage.wm?mSw=3&mFlag=11">보낸메세지</a></p>
  	<p><a href="${ctp}/wmMessage.wm?mSw=4">수신확인</a></p>
  	<p><a href="${ctp}/wmMessage.wm?mSw=5">휴지통</a></p>
  	<p><a href="javascript:wmDeleteAll()">휴지통비우기</a></p>
  </div>
  <div id="rightWindow">
  	<p>
  	  <c:if test="${mSw == 0}">
  	    <h3>메세지작성</h3>
  	    <jsp:include page="wmInput.jsp"/>
  	  </c:if>
  	  <c:if test="${mSw == 1}">  <!-- 받은 메세지(전체) -->
  	    <h3>받은 메세지</h3>
  	    <jsp:include page="wmList.jsp"/>
  	  </c:if>
  	  <c:if test="${mSw == 2}">  <!-- 새 메세지확인하기 -->
  	    <h3>신규 메세지</h3>
  	    <jsp:include page="wmList.jsp"/>
  	  </c:if>
  	  <c:if test="${mSw == 3}">  <!-- 보낸 메세지확인하기 -->
  	    <h3>보낸 메세지</h3>
  	    <jsp:include page="wmList.jsp"/>
  	  </c:if>
  	  <c:if test="${mSw == 4}">  <!-- 수신여부 확인하기 -->
  	    <h3>수신 확인</h3>
  	    <jsp:include page="wmList.jsp"/>
  	  </c:if>
  	  <c:if test="${mSw == 5}">  <!-- 휴지통 확인하기 -->
  	    <h3>휴지통 목록</h3>
  	    <jsp:include page="wmList.jsp"/>
  	  </c:if>
  	  <c:if test="${mSw == 6}">		<!-- 메세지 내용상세보기 -->
  	    <h3>메세지 내용보기</h3>
  	    <jsp:include page="wmContent.jsp"/>
  	  </c:if>
  	</p>
  </div>
</div>
<br/>
<div id="footerTopMargin">&nbsp;</div>
<div id="footer" class="text-center" style="margin-bottom:0; height:100px; padding: 40px 0 0; background-color: #ddd;">
  <p>Copyright  2021. 11. 08. Design by Happy Cheon</p>
</div>
</body>
</html>