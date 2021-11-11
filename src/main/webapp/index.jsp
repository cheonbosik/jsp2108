<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jsp2108(길동이 JSP 프로젝트수정(211109_10:18)-->> https://github.com/cheonbosik/jsp2108 )</title>
  <%@ include file="include/bs4.jsp" %>
  <style>
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  </style>
</head>
<body>
	<%@ include file="include/header.jsp" %>
	
	<div class="container" style="margin-top:30px">
	  <div class="row">
	    <div class="col-sm-4">
	      <h2>방명록</h2>
	      <h5><a href="#">바로가기 ▷</a></h5>
	      <div class="fakeimg">Fake Image</div>
	      <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
	      <h3>Some Links</h3>
	      <p>Lorem ipsum dolor sit ame.</p>
	      <ul class="nav nav-pills flex-column">
	        <li class="nav-item">
	          <a class="nav-link active" href="#">Active</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#">Link123123</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#">Link</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link disabled" href="#">Disabled</a>
	        </li>
	      </ul>
	      <hr class="d-sm-none">
	    </div>
	    <div class="col-sm-8">
	      <h2>TITLE HEADING</h2>
	      <h5>Title description, Dec 7, 2017</h5>
	      <div class="fakeimg">Fake Image</div>
	      <p>Some text..</p>
	      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
	      <br>
	      <h2>TITLE HEADING</h2>
	      <h5>Title description, Sep 2, 2017</h5>
	      <div class="fakeimg">Fake Image</div>
	      <p>Some text..</p>
	      <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
	    </div>
	  </div>
	</div>
	
	<%@ include file="include/footer.jsp" %>
</body>
</html>