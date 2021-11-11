<%@page import="guest.GuestVO"%>
<%@page import="java.util.List"%>
<%@page import="guest.GuestDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String mid = session.getAttribute("sAdmin")==null ? "" : (String) session.getAttribute("sAdmin");

  GuestDAO dao = new GuestDAO();
  //List<GuestVO> vos = dao.gList();
  List<GuestVO> vos = dao.gList(0,10);	// gList(시작번호, 페이지분량)
  GuestVO vo = new GuestVO();
  
  int no = vos.size();	// 총 건수
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>gList.jsp(방명록리스트_기본)</title>
  <%@ include file="../include/bs4.jsp" %>
  <script>
    function delCheck(idx) {
    	var ans = confirm("현재 방문소감 글을 삭제하시겠습니까?");
    	if(ans) location.href="<%=request.getContextPath()%>/GDelete?idx="+idx;
    }
  </script>
  <style>
    th {
    	background-color: #ccc;
    	text-align: center;
    }
  </style>
</head>
<body>
<%@ include file="../include/header_home.jsp" %>
<%@ include file="../include/nav.jsp" %>
<p><br></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td colspan="2" style="text-align:center;"><h2>방 명 록 리 스 트</h2></td>
    </tr>
    <tr>
      <td>
<%
        if(mid.equals("admin")) {
          out.println("<a href='"+request.getContextPath()+"/AdminLogOut' class='btn btn-secondary'>관리자 로그아웃</a>");
        }
        else {
        	out.println("<a href='adminLogin.jsp' class='btn btn-secondary'>관리자</a>");
        }
%>
      </td>
      <td style="text-align:right;"><a href="<%=request.getContextPath()%>/guest/gInput.jsp" class="btn btn-secondary">글쓰기</a></td>
    </tr>
  </table>
<%
	for(int i=0; i<vos.size(); i++) {
		vo = vos.get(i);
		
		String email = vo.getEmail();
		if(email.equals("") || email == null) email = "-없음-";
		String homepage = vo.getHomepage();
		// if(homepage.equals("") || homepage == null) homepage = "-없음-";
		
		String vDate = vo.getvDate().substring(0, vo.getvDate().length()-2);
		
		String content = vo.getContent().replace("\n", "<br/>");
%>
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        방문번호 : <%=no %> &nbsp;
<%
					if(mid.equals("admin")) {
					  out.println("<a href='javascript:delCheck("+vo.getIdx()+")' class='btn btn-secondary btn-sm'>삭제</a>");
					}
%>
	      </td>
	      <td style="text-align:right;">
	        방문IP : <%=vo.getHostIp() %>
	      </td>
	    </tr>
	  </table>
	  <table class="table table-bordered">
	    <tr>
	      <th style="width:20%;">성명</th>
	      <td style="width:25%;"><%=vo.getName() %></td>
	      <th style="width:20%;">방문일자</th>
	      <td style="width:35%;"><%=vDate %></td>
	    </tr>
	    <tr>
	      <th>전자우편</th>
	      <td colspan="3"><%=email %></td>
	    </tr>
	    <tr>
	      <th>홈페이지</th>
	      <td colspan="3">
<%
					if(homepage.length() <=8) {
						out.println("-없음-");
					}
					else {
						out.println("<a href='"+homepage+"' target='_blank'>"+homepage+"</a>");
					}
%>
	      </td>
	    </tr>
	    <tr>
	      <th>글내용</th>
	      <td colspan="3"><%=content %></td>
	    </tr>
	  </table>
	  <br/>
<%	no--;
  }
%>
</div>
<br>
<%@ include file="../include/footer.jsp" %>
</body>
</html>