<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
%>
<script>
  function memberDel() {
	  var ans = confirm("정말 탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴후 1개월간은 같은아이디로 가입하실수 없습니다.\n탈퇴 하시겠습니까?");
		  if(ans) location.href="<%=request.getContextPath()%>/memDelete.mem";
	  }
  }
</script>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/guest/gList.jsp">GUEST</a>
      </li>
<%    if(level != 99 && level !=1) { %>
      <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/boList.bo">BOARD</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">PDS</a>
      </li>
      <li class="nav-item dropdown mr-2">
        <a class="nav-link btn btn-secondary btn-sm dropdown-toggle" data-toggle="dropdown" href="#">Study</a>
		    <div class="dropdown-menu">
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/URLMapping">URL(디렉토리)매핑</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/URLMapping.url">URL(확장자)매핑</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/URLMapping.url2">URL(확장자)매핑2</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/password">비밀번호암호화</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/el1.st">EL학습1</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/el2.st">EL학습2</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/jstl1.st">JSTL학습1</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/jstl2.st">JSTL학습2</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/jstl3.st">JSTL학습3</a>
		    </div>
      </li>
      <li class="nav-item dropdown mr-2">
        <a class="nav-link btn btn-secondary btn-sm dropdown-toggle" data-toggle="dropdown" href="#">Study2</a>
		    <div class="dropdown-menu">
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/ajax1.st">AJax연습</a>
		      <a class="dropdown-item" href="<%=request.getContextPath()%>/ajax2.st">AJax연습2</a>
		    </div>
      </li>
<%    } %>
<%    if(level != 99) { %>
	      <li class="nav-item dropdown">
	        <a class="nav-link btn btn-secondary btn-sm dropdown-toggle" data-toggle="dropdown" href="#">My Page</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/memMain.mem">회원방</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/memUpdate.mem">회원정보변경</a>
<%          if(level != 1) { %>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/memList.ad">회원리스트</a>
<%          }
            if(level != 0) { %>
			      <a class="dropdown-item" href="javascript:memberDel()">회원탈퇴</a>
<%          }
            if(level == 0) { %>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/adMenu.ad">관리자메뉴</a>
<%          } %>
			    </div>
	      </li>
	      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/memLogOut.mem">LogOut</a>
	      </li>
<%    } else { %>
	      <li>
	  	      <a class="nav-link" href="<%=request.getContextPath()%>/memLogin.mem">Login</a>
	  	  </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<%=request.getContextPath()%>/memJoin.mem">Join</a>
	      </li>
<%    } %>
    </ul>
  </div>  
</nav>