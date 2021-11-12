<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String msg = (String) request.getAttribute("msg");
  String url = (String) request.getAttribute("url");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <script> 
  	var msg = "<%=msg%>";
  	var url = "<%=url%>";
  
  	if(msg == "userDeleteOk") msg = "정보가 삭제되었습니다.";
  	else if(msg == "userDeleteNo") msg = "정보가 삭제되지 않았습니다.";
  	else if(msg == "userInputOk") msg = "정보가 입력되었습니다.";
  	else if(msg == "userInputNo") msg = "정보가 입력되지 않았습니다.";
  	else if(msg == "userUpdateOk") msg = "정보가 수정되었습니다.^.^.";
  	else if(msg == "userUpdateNo") msg = "정보가 수정되지 않았습니다.ㅜㅜ.";
  	
    alert(msg);
    if(url != "") location.href = url;
  </script>
</head>
<body>

</body>
</html>