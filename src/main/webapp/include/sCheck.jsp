<!-- sCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String mid = (String) session.getAttribute("sMid");
	if(mid == null) {
		out.println("<script>");
		out.println("alert('로그인후 사용하세요!');");
		out.println("location.href='"+request.getContextPath()+"/memLogin.mem';");
		out.println("</script>");
	}
%>