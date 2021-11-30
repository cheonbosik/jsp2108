<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dynamicForm.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>동적폼 연습</h2>
  <p>DIV태그를 활용한 동적폼</p>
  <hr/>
  <div class="form-group">
    <input type="button" value="텍스트박스추가" onclick="textBoxAppend()"/>
  	<input type="text" name="product1" id="product1" class="form-control" autofocus />
  </div>
  <div class="form-group" id="textBoxInsert"></div>
  <hr/>
  <div class="form-group">
    <input type="button" value="출력" onclick="textView()" class="btn btn-secondary form-control"/>
  </div>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
<script>
	var cnt = 1;
	
	// 동적 텍스트박스 추가
	function textBoxAppend() {
		cnt++;
		var textBox = "";
		textBox += '<div class="form-group" id="tBox'+cnt+'">';
		textBox += '<input type="text" name="product'+cnt+'" id="product'+cnt+'" class="form-control" style="float:left;width:85%"/>';
		textBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-outline-secondary form-control ml-2" style="width:10%"/>';
		textBox += '</div>';
		$("#textBoxInsert").append(textBox);
	}
	
	// 동적 텍스트박스 삭제
	function deleteBox(cnt) {
		$("#tBox"+cnt).remove();
	}
	
	// 텍스트 박스의 내용을 출력
	function textView() {
		str = "";
		for(var i=1; i<=cnt; i++) {
			var product = 'product' + i; 
			str += document.getElementById(product).value + "/";
		}
		alert(str);
	}
</script>
</body>
</html>