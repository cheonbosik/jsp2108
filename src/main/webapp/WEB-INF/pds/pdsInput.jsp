<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsInput.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    var cnt = 1;
    
    // 파일 입력폼 추가
    function fileAppend() {
    	cnt++;
    	fileIn = '';
    	fileIn += '<div class="form-group" id="fBox'+cnt+'">';
    	fileIn += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" style="float:left;width:85%" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp"/>';
    	fileIn += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-outline-secondary btn-sm ml-2" style="width:10%"/>';
    	fileIn += '</div>';
    	$("#fileInsert").append(fileIn);
    }
    
    // 추가된 파일 입력폼 삭제
    function deleteBox(cnt) {
    	$("#fBox"+cnt).remove();
    }
    
    // 자료 전송을 위한 폼체크
    function fCheck() {
    	var fName = myform.fName1.value;
    	var maxSize = 1024 * 1024 * 20; 	// 20MB까지 허용
    	var title = myform.title.value;
    	
    	if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요?");
    		return false;
    	}
    	else if(title.trim() == "") {
    		alert("파일 제목을 입력하세요?");
    		myform.title.focus();
    		return false;
    	}
    	
    	var fileSize = 0;
    	for(var i=1; i<=cnt; i++) {
    		fName = "fName" + i;
    		/* if(document.getElementById(fName).value != "" && document.getElementById(fName).value != null) { */
    		if(document.getElementById(fName) != null) {
	    		if(document.getElementById(fName).value != "" && document.getElementById(fName).value != null) {
	    			tempFname = document.getElementById(fName).value;
	    			var ext = tempFname.substring(tempFname.lastIndexOf(".")+1);
	    			var uExt = ext.toUpperCase();
	    			
	    			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "ZIP" && uExt != "PPT" && uExt != "PPTX" && uExt != "HWP") {
	    				alert("업로드 가능한 파일은 'jpg/gif/png/zip/ppt/pptx/hwp' 입니다.");
	    				return false;
	    			}
	    			else if(tempFname.indexOf(" ") != -1) {
	    				alert("업로드할 파일명에는 공백이 없어야 합니다.")
	    				return false;
	    			}
	    			else {
	    				fileSize += document.getElementById(fName).files[0].size;
	    			}
	    		}
    		}
    	}
    	if(fileSize > maxSize) {
    		alert("업로드하는 파일의 최대용량은 20MByte 이내입니다.");
    		return false;
    	}
    	else {
    		myform.fileSize.value = fileSize;
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/pdsInputOk.pds" enctype="multipart/form-data">
	  <h2>자료 올리기</h2>
	  <div class="form-group">
	    <input type="button" value="파일 추가" onclick="fileAppend()"/>
	    <input type="file" name="fName1" id="fName1" class="form-control-file border" accept=".jpg,.gif,.png,.zip,.ppt,.pptx,.hwp"/>
	  </div>
	  <div class="form-group" id="fileInsert"></div>
	  <div class="form-group">올린이 : ${sNickName}</div>
	  <div class="form-group">
	    <label for="title">제목 : </label>
	    <input type="text" name="title" id="title" placeholder="자료 제목을 입력하세요" class="form-control" required />
	  </div>
	  <div class="form-group">
	    <label for="content">내용 : </label>
	    <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	  </div>
	  <div class="form-group">
	    <label for="part">자료분류 : </label>
	    <select name="part" id="part" class="form-control">
	      <option value="학습" selected>학습</option>
  	    <option value="여행">여행</option>
  	    <option value="음식">음식</option>
  	    <option value="기타">기타</option>
	    </select>
	  </div>
	  <div class="form-group">
	    <label for="openSw">공개여부 : </label>
	    <input type="radio" name="openSw" id="openSw" value="공개" checked/>공개 &nbsp;&nbsp;
	    <input type="radio" name="openSw" id="openSw" value="비공개"/>비공개
	  </div>
	  <div class="form-group">
	    <label for="pwd">비밀번호 : </label>
	    <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." class="form-control"/>
	  </div>
	  <div class="form-group">
	    <input type="button" value="자료올리기" onclick="fCheck()" class="btn btn-secondary"/>
	    <input type="reset" value="다시쓰기" class="btn btn-secondary"/>
	    <input type="button" value="돌아가기" onclick="javascript:location.href='${ctp}/pdsList.pds';" class="btn btn-secondary"/>
	  </div>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="nickName" value="${sNickName}"/>
	  <input type="hidden" name="fileSize"/>
  </form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>