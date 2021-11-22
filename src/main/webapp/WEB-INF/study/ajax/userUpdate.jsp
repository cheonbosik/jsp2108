<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>userUpdate.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    function updateCheck() {
    	var name = updateForm.name.value;
    	var age = updateForm.age.value;
    	
    	if(name == "") {
    		alert("성명을 입력하세요");
    		updateForm.name.value;
    		return false;
    	}
    	else if(age <= 0) {
    		alert("나이를 입력하세요");
    		updateForm.age.value;
    		return false;
    	}
    	
    	var query = {
    			idx  : ${vo.idx},
    			name : name,
    			age  : age
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/userUpdateOk",
    		data : query,
    		success:function(data) {
    			alert("수정되었습니다.");
    			location.href = "${ctp}/ajax1.st";
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
  <form name="updateForm">
    <table class="table table-bordered">
      <tr style="text-align:center;">
        <th colspan="2"><h3>User 정보 수정</h3></th>
      </tr>
      <tr>
        <th>성명</th>
        <td><input type="text" name="name" id="name" value="${vo.name}" class="form-control" autofocus required /></td>
      </tr>
      <tr>
        <th>나이</th>
        <td><input type="number" name="age" id="age" value="${vo.age}" value="20" class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2" style="text-align:center;">
          <input type="button" value="수정" onclick="updateCheck()" class="btn btn-secondary"/>
          <input type="reset" value="다시입력" class="btn btn-secondary"/>
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/ajax1.st';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
  </form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>