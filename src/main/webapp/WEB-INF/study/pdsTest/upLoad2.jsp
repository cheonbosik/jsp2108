<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>upLoad2.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    function fCheck() {
    	var fName = myform.fName1.value;
    	var ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
    	var uExt = ext.toUpperCase();
    	var maxSize = 1024 * 1024 * 10;	// 업로드할 파일의 최대 용량은 10MByte로 한다.
    	
    	// 첫번째 파일(fName1) 처리
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요?");
    		return false;
    	}
    	var fileSize = document.getElementById("fName1").files[0].size;
    	
    	if(uExt != "ZIP" && uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
    		alert("업로드 가능한 파일은 'ZIP/JPG/GIF/PNG/HWP/PPT/PPTX");
    		return false;
    	}
    	else if(fName.indexOf(" ") != -1) {
    		alert("업로드할 파일명에는 공백을 포함하실수 없습니다.");
    		return false;
    	}
    	else if(fileSize > maxSize) {
    		alert("업로드할 파일의 크기는 10MByte 이하입니다.");
    		return false;
    	}
    	
    	// 두번째 파일(fName2) 처리
    	fName = myform.fName2.value;
    	if(fName.trim() != "") {
    		ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
      	uExt = ext.toUpperCase();
    	  fileSize = document.getElementById("fName2").files[0].size;
    	  
	    	if(uExt != "ZIP" && uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
	    		alert("업로드 가능한 파일은 'ZIP/JPG/GIF/PNG/HWP/PPT/PPTX");
	    		return false;
	    	}
	    	else if(fName.indexOf(" ") != -1) {
	    		alert("업로드할 파일명에는 공백을 포함하실수 없습니다.");
	    		return false;
	    	}
	    	else if(fileSize > maxSize) {
	    		alert("업로드할 파일의 크기는 10MByte 이하입니다.");
	    		return false;
	    	}
    	}
    	else {
    		alert("두번째 파일을 선택하세요");
    		return false;
    	}
    	
    	// 세번째 파일(fName3) 처리
    	fName = myform.fName3.value;
    	if(fName.trim() != "") {
    		ext = fName.substring(fName.lastIndexOf(".")+1);	// 파일 확장자 발췌
      	uExt = ext.toUpperCase();
    	  fileSize = document.getElementById("fName3").files[0].size;
    	  
	    	if(uExt != "ZIP" && uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
	    		alert("업로드 가능한 파일은 'ZIP/JPG/GIF/PNG/HWP/PPT/PPTX");
	    		return false;
	    	}
	    	else if(fName.indexOf(" ") != -1) {
	    		alert("업로드할 파일명에는 공백을 포함하실수 없습니다.");
	    		return false;
	    	}
	    	else if(fileSize > maxSize) {
	    		alert("업로드할 파일의 크기는 10MByte 이하입니다.");
	    		return false;
	    	}
    	}
    	else {
    		alert("세번째 파일을 선택하세요");
    		return false;
    	}
    	
    	myform.submit();
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>파일 업로드 테스트 2(멀티파일처리)</h2>
  <p>cos라이브러리를 이용한 파일 업로드</p>
  <hr/>
  <br/>
  <form name="myform" method="post" action="${ctp}/upLoad2Ok.st" enctype="Multipart/form-data">
	  <div class="form-group">파일명
	    <input type="file" name="fName1" id="fName1" class="form-control-file border"/>
	    <input type="file" name="fName2" id="fName2" class="form-control-file border"/>
	    <input type="file" name="fName3" id="fName3" class="form-control-file border"/>
	    <input type="button" value="파일전송" onclick="fCheck()" class="btn btn-secondary form-control"/>
	  </div>
  </form>
  <hr/><br/>
  <p><a href="${ctp}/downLoad1.st" class="btn btn-secondary form-control">다운로드 폼으로 이동하기</a></p>
  <hr/>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>