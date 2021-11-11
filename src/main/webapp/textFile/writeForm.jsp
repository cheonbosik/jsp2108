<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>writeForm</title>
  <%@ include file="../include/bs4.jsp" %>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>문서 글쓰기</h2>
  <form name="myform" method="post" action="writeFormOk.jsp">
    제목 : <input type="text" name="title" class="form-control" autofocus /><br/>
    내용 : <textarea rows="5" name="content" class="form-control"></textarea><br/>
    <p>
      <input type="submit" value="저장하기" class="btn btn-secondary"/>
    </p>
  </form>
</div>
<br>
</body>
</html>