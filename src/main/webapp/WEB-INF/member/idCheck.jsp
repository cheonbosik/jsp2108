<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String mid = (String) request.getAttribute("mid");
  int res = (int) request.getAttribute("res");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>idCheck.jsp</title>
  <%@ include file="../../include/bs4.jsp" %>
  <script>
    function sendCheck() {
    	opener.window.document.myform.mid.value = "<%=mid%>";
    	opener.window.document.myform.pwd.focus();
    	window.close();
    }
    
    function idCheck() {
    	var mid = childForm.mid.value;
    	
    	if(mid=="") {
    		alert("아이디를 입력하세요!");
    		childForm.mid.focus();
    	}
    	else {
    		childForm.submit();
    	}
    }
  </script>
</head>
<body>
<p><br></p>
<div class="container">
  <h3>아이디 체크폼</h3>
<%if(res == 1) { %>
	<h4><font color="red"><%=mid%></font> 아이디는 사용 가능합니다.</h4>
	<p><input type="button" value="창닫기" onclick="sendCheck()"/></p>
<%} else { %>
	<h4><font color="red"><%=mid%></font> 아이디는 이미 사용중입니다.</h4>
	<form name="childForm" method="post" action="<%=request.getContextPath()%>/idCheck.mem">
	  <input type="text" name="mid"/>
	  <input type="button" value="아이디검색" onclick="idCheck()"/>
	</form>
<%} %>
</div>
<br/>
</body>
</html>