<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/guest/gList.jsp">방명록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">자료실</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link btn btn-secondary dropdown-toggle" data-toggle="dropdown" href="#">학습실</a>
		    <div class="dropdown-menu">
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/URLMapping">URL(디렉토리)매핑</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/URLMapping.url">URL(확장자)매핑</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/URLMapping.url2">URL(확장자)매핑2</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/password">비밀번호암호화</a>
		    </div>
      </li>
      <li class="nav-item">
<%      if(level != 99 ) { %>
	        <a class="nav-link" href="<%=request.getContextPath()%>/memLogOut.mem">LogOut</a>
<%      } else { %>
  	      <a class="nav-link" href="<%=request.getContextPath()%>/memLogin.mem">Login</a>
<%      } %>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/memJoin.mem">Join</a>
      </li>
    </ul>
  </div>  
</nav>