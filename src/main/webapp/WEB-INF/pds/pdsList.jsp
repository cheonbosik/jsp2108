<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    // 부분자료 검색처리
	  function partCheck() {
		  var part = partForm.part.value;
		  location.href = "${ctp}/pdsList.pds?pag=${pag}&part="+part;
	  }  
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <table class="table table-borderless text-center">
    <tr>
  	  <td colspan="2"><h2>자 료 실 리 스 트(${part})</h2></td>
  	</tr>
  	<tr>
  	  <td class="text-left" style="width:20%">
  	  	<form name="partForm">
  	  	  <select name="part" onchange="partCheck()" class="form-control">
  	  	    <option value="전체" ${part == '전체' ? 'selected' : ''}>전체</option>
  	  	    <option value="학습" ${part == '학습' ? 'selected' : ''}>학습</option>
  	  	    <option value="여행" ${part == '여행' ? 'selected' : ''}>여행</option>
  	  	    <option value="음식" ${part == '음식' ? 'selected' : ''}>음식</option>
  	  	    <option value="기타" ${part == '기타' ? 'selected' : ''}>기타</option>
  	  	  </select>
  	  	</form>
  	  </td>
  	  <td class="text-right"><a href="${ctp}/pdsInput.pds" class="btn btn-outline-secondary btn-sm">자료올리기</a></td>
  	</tr>
  </table>
  <table class="table table-hover text-center">
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
    	  <td>${curScrStrarNo}</td>
    	  <td>
    	    ${vo.title}
    	    <c:if test="${vo.wNdate <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
    	  </td>
    	  <td>${vo.nickName}</td>
    	  <td>
    	    <c:if test="${vo.wNdate <= 24}">${fn:substring(vo.fDate,11,19)}</c:if>
	        <c:if test="${vo.wNdate >  24}">${fn:substring(vo.fDate,0,10)}</c:if>
    	  </td>
    	  <td>
    	  	<c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
    	  	<c:forEach var="fName" items="${fNames}">
	    	    ${fName}<br/>
    	  	</c:forEach>
    	  	(<fmt:formatNumber value="${vo.fSize / 1024}" pattern="#,##0"/>KByte)
    	  </td>
    	  <td>${vo.downNum}</td>
    	  <td><a href="#" class="btn btn-outline-secondary">삭제</a></td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${totPage != 0}">
			  <c:if test="${pag != 1}">
			    <li class="page-item"><a href="pdsList.pds?pag=1&part=${part}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${curBlock > 0}">
			    <li class="page-item"><a href="pdsList.pds?pag=${(curBlock-1)*blockSize + 1}&part=${part}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
			    <c:if test="${i == pag && i <= totPage}">
			      <li class="page-item active"><a href='pdsList.pds?pag=${i}&part=${part}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pag && i <= totPage}">
			      <li class="page-item"><a href='pdsList.pds?pag=${i}&part=${part}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${curBlock < lastBlock}">
			    <li class="page-item"><a href="pdsList.pds?pag=${(curBlock+1)*blockSize + 1}&part=${part}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pag != totPage}">
			    <li class="page-item"><a href="pdsList.pds?pag=${totPage}&part=${part}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>