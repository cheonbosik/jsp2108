<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>shaTest.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    function passCheck() {
    	var pwd = $("#pwd").val();
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shaTestOk.st",
    		data : {pwd : pwd},
    		success:function(data) {
    			var str = "비밀번호 : " + pwd + "<br/>암호화 : " + data;
    			document.getElementById("demo").innerHTML = str;
    		}
    	});
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>SHA(Secure Hash Algorithm) 암호화</h2>
  <pre>
    : SHA는 단방향식 암호화기법으로, 암호학적 해시함수들의 모임이다.
      일반적으로 복호화 할 수 없도록 만든 알고리즘을 SHA-2라고 한다.
      해시함수가 출력하는 암축된 문장을 다이제스트(Digest)라고 한다.
      SHA-2가 생성해주는 다이제스트의 출력길이는 256,512 Bit 이다.
      256Bit의 출력길이를 갖는 SHA-2암호화를 SHA-256 암호화 방식이라고 한다.
  </pre>
  <hr/>
  <p>
    숫자나 문자를 입력하시오?
    <input type="password" name="pwd" id="pwd" autofocus />
    <input type="button" value="암호화" onclick="passCheck()"/>
  </p>
  <hr/>
  <p id="demo"></p>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>