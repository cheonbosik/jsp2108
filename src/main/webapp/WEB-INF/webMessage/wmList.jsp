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
    function msgDel(idx) {
    	var ans = confirm("선택된 메세지를 삭제하시겠습니까?");
    	if(!ans) return false;
    	var query = {
    			idx : idx,
    			mFlag : 's'
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
    <c:set var="mCount" value="${fn:length(vos)}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${mCount}</td>
        <td>
          <c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
        	<c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
        </td>
        <td>
          <a href="${ctp}/wmMessage.wm?mSw=6&idx=${vo.idx}&mFlag=${param.mFlag}">
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
      <c:set var="mCount" value="${mCount - 1}"/>
    </c:forEach>
  </table>
</div>
<br/>
</body>
</html>