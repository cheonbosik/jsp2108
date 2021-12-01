<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsContent.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<div class="modal-dialog">
  <div class="modal-content">

    <!-- Modal Header -->
    <div class="modal-header">
      <h4 class="modal-title">${vo.title} (분류 : ${vo.part})</h4>
      <button type="button" class="close" data-dismiss="modal" onclick="window.close()">&times;</button>
    </div>

    <!-- Modal body -->
    <div class="modal-body">
      <hr/>
      - 올린이 : ${vo.nickName}
      <hr/>
      - 아이디 : ${vo.mid}<br/>
      - 파일명 : ${vo.fName}<br/>
      - 올린날짜 : ${fn:substring(vo.fDate,0,19)}<br/>
      - 파일크기 : <fmt:formatNumber value="${vo.fSize/1024}"/>KByte
      <hr/>
      - 자료설명 :<br/>
        <p>${fn:replace(vo.content, newLine,"<br/>")}</p>
      <hr/>
      <!--
      012345678
      atom.jpg/mbc.zip/
      -->
      <%-- <c:set var="fName" value="${vo.fName}"/> --%>
      <c:set var="fSName" value="${vo.fSName}"/>
      <c:set var="fSNames" value="${fn:split(fSName,'/')}"/>
      <c:forEach var="fSName" items="${fSNames}" varStatus="st">
      	${st.count}. ${fSName}<br/>
      	<c:set var="fSNameLen" value="${fn:length(fSName)}"/>
      	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
      	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
      	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">
      		<img src="${ctp}/data/pds/${fSName}" width="350px"/><br/>
      	</c:if>
      	<hr/>
      </c:forEach>
    </div>

    <!-- Modal footer -->
    <div class="modal-footer">
      <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="window.close()">Close</button>
    </div>

  </div>
</div>
</body>
</html>