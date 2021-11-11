<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adminLogin.jsp(관리자 인증차)</title>
  <%@ include file="../include/bs4.jsp" %>
  <style>
    table {
      width: 400px;
      margin: 0px auto;
    }
    th {
      background-color: #ddd;
      text-align: center;
    }
    th, td {
      border: 1px solid #777;
    }
  </style>
</head>
<body>
<%@ include file="../include/header_home.jsp" %>
<%@ include file="../include/nav.jsp" %>
<p><br></p>
<div class="container">
  <form name="myfrom" method="post" action="adminLoingOk.jsp">
	  <table class="table">
	    <tr>
	      <td colspan="2" style="text-align: center; border:none; border-bottom:1px solid #777;"><h2>관리자 인증창</h2></td>
	    </tr>
	    <tr style="border-top: 1px solid #000 !important;">
	      <th class="p-3">관리자아이디</th>
	      <td class="p-3"><input type="text" name="mid" required autofocus /></td>
	    </tr>
	    <tr>
	      <th class="p-3">관리자비밀번호</th>
	      <td class="p-3"><input type="password" name="pwd" required /></td>
	    </tr>
	    <tr>
	      <td colspan="2" style="text-align:center;" class="p-3">
	        <input type="submit" value="관리자로그인" />&nbsp;
	        <input type="reset" value="다시입력" />&nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='<%=request.getContextPath()%>/';"/>
	      </td>
	    </tr>
	  </table>
  </form>
</div>
<br>
<%@ include file="../include/footer.jsp" %>
</body>
</html>