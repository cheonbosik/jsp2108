<%@page import="java.io.IOException"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fileRead.jsp</title>
  <%@ include file="../include/bs4.jsp" %>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>inputFile.txt파일 내용보기</h2>
  <br/>
<%
  BufferedReader reader = null;
	try {
		// application.getRealPath() : 홈디렉토리의 절대경로를 알아오는 메소드
		String filePath = application.getRealPath("/textFile/inputFile.txt");
		reader = new BufferedReader(new FileReader(filePath));
		while(true) {
			String str = reader.readLine();
			if(str == null) break;
			out.println(str + "<br/>");
		}
	} catch (FileNotFoundException e) {
		out.println("파일이 존재하지 않습니다.");
	} catch (IOException e) {
		out.println("파일을 읽을수 없습니다.");
	} finally {
		try {
			reader.close();
		} catch (Exception e) {}
	}
%>
</div>
</body>
</html>