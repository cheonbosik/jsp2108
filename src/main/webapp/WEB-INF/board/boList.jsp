<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boList.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
    th, td {
      text-align: center;
    }
  </style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td class="p-0"><h2>게 시 판 리 스 트</h2></td>
    </tr>
    <tr>
      <td class="text-left p-0">
        <a href="${ctp}/boInput.bo" class="btn btn-secondary btn-sm">글쓰기</a>
      </td>
    </tr>
  </table>
  <table class="table table-hover">
    <tr class="table-dark text-dark">
      <th>글번호</th>
      <th>글제목</th>
      <th>글쓴이</th>
      <th>글쓴날짜</th>
      <th>조회수</th>
      <th>좋아요</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
	    <tr>
	      <td>${curScrStrarNo}</td>
	      <td>${vo.title}</td>
	      <td>${vo.nickName}</td>
	      <td>${vo.wDate}</td>
	      <td>${vo.readNum}</td>
	      <td>${vo.good}</td>
	    </tr>
	    <c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  
<!-- 블록 페이징처리 시작 -->
<div style="text-align:center">
<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
<c:if test="${totPage != 0}">
	<div style="text-align:center">
	  <c:if test="${pag != 1}"><a href="boList.bo?pag=1" title="첫페이지">◁◁</a></c:if> &nbsp;&nbsp;
	  <c:if test="${curBlock > 0}"><a href="boList.bo?pag=${(curBlock-1)*blockSize + 1}" title="이전블록">◀</a></c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
	    <c:if test="${i == pag && i <= totPage}"><a href='boList.bo?pag=${i}'><font color='red'><b>${i}</b></font></a></c:if>
	    <c:if test="${i != pag && i <= totPage}"><a href='boList.bo?pag=${i}'>${i}</a></c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}"><a href="boList.bo?pag=${(curBlock+1)*blockSize + 1}" title="다음블록">▶</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag != totPage}"><a href="boList.bo?pag=${totPage}" title="마지막페이지">▷▷</a></c:if>
	</div>
</c:if>
</div>
<!-- 블록 페이징처리 끝 -->
<%--
<!-- 블록 페이징처리 시작(break문장 대체용으로 sw사용) -->
<div style="text-align:center">
<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
<c:if test="${totPage != 0}">
	<div style="text-align:center">
	  <c:set var="pageSW" value="0"/>
	  <c:if test="${pag != 1}"><a href="boList.bo?pag=1" title="첫페이지">◁◁</a></c:if> &nbsp;&nbsp;
	  <c:if test="${curBlock > 0}"><a href="boList.bo?pag=${(curBlock-1)*blockSize + 1}" title="이전블록">◀</a></c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
	    <c:if test="${i>totPage}"><c:set var="pageSw" value="1"/></c:if>
	      <c:if test="${pageSw != 1}">
			    <c:if test="${i == pag}"><a href='boList.bo?pag=${i}'><font color='red'><b>${i}</b></font></a></c:if>
			    <c:if test="${i != pag}"><a href='boList.bo?pag=${i}'>${i}</a></c:if>
		    </c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}"><a href="boList.bo?pag=${(curBlock+1)*blockSize + 1}" title="다음블록">▶</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag != totPage}"><a href="boList.bo?pag=${totPage}" title="마지막페이지">▷▷</a></c:if>
	</div>
</c:if>
</div>
<!-- 블록 페이징처리 끝 -->
--%>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>