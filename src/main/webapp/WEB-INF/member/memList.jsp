<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memList.jsp</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
    // 개별회원 검색
    function midSearch() {
    	var mid = myForm.mid.value;
    	if(mid == "") {
    		alert("아이디를 입력하세요?");
    		myForm.mid.focus();
    	}
    	else {
    		location.href = "${ctp}/memList.ad?mid="+mid;
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/include/header_home.jsp"/>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <form name="myForm">      
	  <table class="table table-borderless m-0">
	    <tr>
	      <td>
	        <c:if test="${empty mid}"><c:set var="title" value="전체"/></c:if>
	        <c:if test="${!empty mid}"><c:set var="title" value="${mid}"/></c:if>
	        <h2 style="text-align:center;">${title} 회원 리스트</h2>
	      </td>
	    </tr>
	    <tr>
	      <td style="text-align:left">
	        <input type="text" name="mid" value="${mid}" placeholder="검색할아이디입력"/>
	        <input type="button" value="개별검색" onclick="midSearch()"/>
	        <input type="button" value="전체보기" onclick="location.href='${ctp}/memList.ad';" class="btn btn-secondary btn-sm"/>
	      </td>
	    </tr>
	  </table>
  </form>
  <table class="table table-hover">
    <tr class="table-dark text-dark text-center">
      <th>번호</th>
      <th>아이디</th>
      <th>별명</th>
      <th>성명</th>
      <th>성별</th>
    </tr>
    <c:forEach var="vo" items="${vos}">
    	<tr class="text-center">
    	  <td>${curScrStrarNo}</td>
    	  <td>
    	    <c:if test="${vo.userInfor == '공개'}"><a href="${ctp}/memInfor.ad?idx=${vo.idx}">${vo.mid}</a></c:if>
    	    <c:if test="${vo.userInfor != '공개'}">${vo.mid}</c:if>
    	  </td>
    	  <td>${vo.nickName}</td>
    	  <td>
    	    <c:if test="${vo.userInfor=='비공개'}">비공개</c:if>
    	    <c:if test="${vo.userInfor!='비공개'}">${vo.name}</c:if>
    	  </td>
    	  <td>
    	    <c:if test="${vo.userInfor=='비공개'}">비공개</c:if>
    	    <c:if test="${vo.userInfor!='비공개'}">${vo.gender}</c:if>
    	  </td>
    	</tr>
    	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
    </c:forEach>
  </table>
  <br/>
  
<!-- 페이징처리 시작 -->
<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
<c:if test="${totPage != 0}">
	<div style="text-align:center">
	  <c:if test="${pag != 1}"><a href="${ctp}/memList.ad?pag=1&mid=${mid}">◁◁</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag > 1}"><a href="${ctp}/memList.ad?pag=${pag-1}&mid=${mid}">◀</a></c:if>
	  &nbsp;&nbsp; ${pag}Page / ${totPage}pages &nbsp;&nbsp;
	  <c:if test="${pag < totPage}"><a href="${ctp}/memList.ad?pag=${pag+1}&mid=${mid}">▶</a></c:if> &nbsp;&nbsp;
	  <c:if test="${pag != totPage}"><a href="${ctp}/memList.ad?pag=${totPage}&mid=${mid}">▷▷</a></c:if>
	</div>
</c:if>
<!-- 페이징처리 끝 -->

</div>
<br/>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>