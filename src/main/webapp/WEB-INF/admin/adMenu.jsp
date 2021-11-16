<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMenu.jsp</title>
  <frameset cols="120px, *">
  	<frame src="<%=request.getContextPath()%>/adLeft.ad" name="adLeft" frameboard="0"/>
  	<frame src="<%=request.getContextPath()%>/adContent.ad" name="adContent" frameboard="0"/>
  </frameset>
</head>
<body>
</body>
</html>