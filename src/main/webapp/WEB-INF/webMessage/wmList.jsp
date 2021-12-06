<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
  	setTimeout("location.reload()",1000*10)
	
    function msgDel(idx) {
    	var ans = confirm("선택된 메세지를 삭제하시겠습니까?");
    	if(!ans) return false;
    	var query = {
    			idx : idx,
    			mFlag : 11
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/wmMsgDel.wm",
    		data : query,
    		success:function() {
    			alert("메세지가 삭제되었습니다.");
    			location.reload();
    		}
    	});
    }
  </script>
</head>
<body>
<p><br></p>
<div class="container">
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸사람</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
      </th>
      <th>메세지 제목</th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸/확인(날짜)</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은날짜</c:if>
      </th>
    </tr>
    <%-- <c:set var="mCount" value="${fn:length(vos)}"/> --%>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStrarNo}</td>
        <td>
          <c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
        	<c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
        </td>
        <td>
          <a href="${ctp}/wmMessage.wm?&mSw=6&idx=${vo.idx}&mFlag=${param.mFlag}">
	          <c:if test="${vo.sendSw == 'g' && mSw == 5}">(보낸메세지) </c:if>
	          ${vo.title}
          </a>
          <c:if test="${vo.receiveSw=='n'}"><img src="${ctp}/images/new.gif"/></c:if>
          <c:if test="${mSw == 3}">
            <a href="javascript:msgDel(${vo.idx})" class="badge badge-secondary">삭제</a>
          </c:if>
        </td>
        <td>
          <%-- ${fn:substring(vo.receiveDate,0,10)} --%>
          ${fn:substring(vo.receiveDate,0,19)}
        </td>
      </tr>
      <c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
</div>
<br/>
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
<div class="container">
	<ul class="pagination justify-content-center pagination-sm">
		<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
		<c:if test="${totPage != 0}">
		  <c:if test="${pag != 1}">
		    <li class="page-item"><a href="wmMessage.wm?mSw=${mSw}&pag=1" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
		  </c:if>
		  <c:if test="${curBlock > 0}">
		    <li class="page-item"><a href="wmMessage.wm?mSw=${mSw}&pag=${(curBlock-1)*blockSize + 1}" title="이전블록" class="page-link text-secondary">◀</a></li>
		  </c:if>
		  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
		    <c:if test="${i == pag && i <= totPage}">
		      <li class="page-item active"><a href='wmMessage.wm?mSw=${mSw}&pag=${i}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
		    </c:if>
		    <c:if test="${i != pag && i <= totPage}">
		      <li class="page-item"><a href='wmMessage.wm?mSw=${mSw}&pag=${i}' class="page-link text-secondary">${i}</a></li>
		    </c:if>
		  </c:forEach>
		  <c:if test="${curBlock < lastBlock}">
		    <li class="page-item"><a href="wmMessage.wm?mSw=${mSw}&pag=${(curBlock+1)*blockSize + 1}" title="다음블록" class="page-link text-secondary">▶</a>
		  </c:if>
		  <c:if test="${pag != totPage}">
		    <li class="page-item"><a href="wmMessage.wm?mSw=${mSw}&pag=${totPage}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
		  </c:if>
		</c:if>
	</ul>
</div>
<!-- 블록 페이징처리 끝 -->
</body>
</html>