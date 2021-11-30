<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
  	  <td colspan="2"><h2>자 료 실 리 스 트</h2></td>
  	</tr>
  	<tr>
  	  <td class="text-left" style="width:25%">
  	  	<form name="partForm">
  	  	  <select name="part" onchange="partCheck()" class="form-control">
  	  	    <option value="전체">전체</option>
  	  	    <option value="학습">학습</option>
  	  	    <option value="여행">여행</option>
  	  	    <option value="음식">음식</option>
  	  	    <option value="기타">기타</option>
  	  	  </select>
  	  	</form>
  	  </td>
  	  <td class="text-right"><a href="${ctp}/pdsInput.pds" class="btn btn-outline-secondary btn-sm">자료올리기</a></td>
  	</tr>
  </table>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
    	<th>번호</th>
    	<th>자료제목</th>
    	<th>올린이</th>
    	<th>올린날짜</th>
    	<th>파일명(사이즈)</th>
    	<th>다운수</th>
    	<th>비고</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
    	<tr>
    	  <td>${vo.idx}</td>
    	  <td>${vo.title}</td>
    	  <td>${vo.nickName}</td>
    	  <td>${vo.fDate}</td>
    	  <td>${vo.fName}</td>
    	  <td>${vo.downNum}</td>
    	  <td><a href="#" class="btn btn-outline-secondary btn-sm">삭제</a></td>
    	</tr>
    </c:forEach>
  </table>
  <!-- 페이징처리 -->
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>