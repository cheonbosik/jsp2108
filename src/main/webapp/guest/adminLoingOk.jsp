<!-- adminLoingOk.jsp(관리자 인증처리) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
	
	if(mid.equals("admin") && pwd.equals("1234")) {
		session.setAttribute("sAdmin", "admin");
		out.println("<script>");
		out.println("alert('관리자 인증 성공!!!');");
		out.println("location.href='gList.jsp';");
		out.println("</script>");
	}
	else {
		out.println("<script>");
		out.println("alert('관리자 인증 실패~~~');");
		out.println("location.href='gList.jsp';");
		out.println("</script>");
	}
%>
