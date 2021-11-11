<%@page import="java.util.Date"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  // 한글처리
  // request.setCharacterEncoding("utf-8");
  String title = request.getParameter("title");
  String content = request.getParameter("content");
  
  Date date = new Date();
  long time = date.getTime();
  
  String fileName = time + ".txt";
  
  PrintWriter writer = null;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>writeFormOk.jsp</title>
  <%@ include file="../include/bs4.jsp" %>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>저장된 파일의 내용보기</h2>
<%
	try {
		String filePath = application.getRealPath("/textFile/" + fileName);
		writer = new PrintWriter(filePath);
		writer.println("제목 : " + title);
		writer.println("내용 : \n===========================\n" + content);
		out.println("<p>'"+filePath+"'에 저장되었습니다.</p>");
		out.println("<p><a href='writeForm.jsp' class='btn btn-secondary'>돌아가기</a></p>");
	} catch (IOException e) {
		out.println("파일에 데이터를 쓸수 없습니다.");
		out.println("<p><a href='writeForm.jsp' class='btn btn-secondary'>돌아가기</a></p>");
	} finally {
		try {
			writer.close();
		} catch (Exception e) {}
	}
%>
</div>
</body>
</html>