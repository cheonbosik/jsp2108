<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>scContent.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  	// 일정 등록 및 수정
    function fCheck() {
    	var content = myform.content.value;
    	if(content == "") {
    		alert("일정 내역을 등록하세요!");
    		myform.content.focus();
    	}
    	else {
    		myform.submit();
    	}
    }
  	
  	// 일정 삭제
  	function delCheck() {
  		var ans = confirm("오늘 일정을 삭제 하시겠습니까?");
  		if(ans) location.href = "${ctp}/scDelete.sc?idx=${vo.idx}&ymd=${ymd}&mid=${sMid}";
  	}
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/scContentOk.sc">
  	<h2>일 정 관 리</h2>
  	<div class="form-group">
  	  <label for="sDate">일정날짜</label>
  	  <input type="text" class="form-control" name="sDate" id="sDate" value="${ymd}" readonly />
  	</div>
  	<div class="form-group">
  	  <label for="mid">등록자</label>
  	  <input type="text" class="form-control" name="mid" id="mid" value="${sMid}" readonly />
  	</div>
  	<div class="form-group">
  	  <label for="part">일정분류 : </label>
  	  <select name="part" id="part" class="form-control">
  	    <option value="모임" ${vo.part=="모임" ? "selected" : ""}>모임</option>
  	    <option value="업무" ${vo.part=="업무" ? "selected" : ""}>업무</option>
  	    <option value="학습" ${vo.part=="학습" ? "selected" : ""}>학습</option>
  	    <option value="여행" ${vo.part=="여행" ? "selected" : ""}>여행</option>
  	    <option value="기타" ${vo.part=="기타" ? "selected" : ""}>기타</option>
  	  </select>
  	</div>
  	<div class="form-group">
  	  <label for="content">일정내용 : </label>
  	  <textarea rows="5" name="content" id="content" class="form-control">${vo.content}</textarea>
  	</div>
  	<div class="form-group">
  	  <c:if test="${empty vo.content}">
  	    <input type="button" value="일정등록" onclick="fCheck()" class="btn btn-secondary"/>
  	    <input type="reset" value="다시쓰기" class="btn btn-secondary"/>
  	  </c:if>
  	  <c:if test="${!empty vo.content}">
  	    <input type="button" value="일정수정" onclick="fCheck()" class="btn btn-secondary"/>
  	    <input type="reset" value="다시쓰기" class="btn btn-secondary"/>
  	    <input type="button" value="일정삭제" onclick="delCheck()" class="btn btn-secondary"/>
  	  </c:if>
  	  <input type="button" value="돌아가기" onclick="location.href='${ctp}/schedule.sc?ymd=${ymd}';" class="btn btn-secondary"/>
  	</div>
  	<input type="hidden" name="idx" value="${vo.idx}"/>	<!-- 수정처리시에 넘져줘야한다. -->
  	<input type="hidden" name="ymd" value="${ymd}"/>
  </form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>