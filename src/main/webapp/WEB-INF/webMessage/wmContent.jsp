<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wmContent.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <style>
    th {
      background-color: #ccc;
      text-align: center;
      width : 20%;
    }
    td {
      background-color: #eef;
      width : 80%;
    }
  </style>
</head>
<body>
<p><br></p>
<div class="container">
  <table class="table table-bordered">
      <tr>
        <th>보내는 사람</th>
        <td>${vo.sendId}</td>
      </tr>
      <tr>
        <th>받는 사람</th>
        <td>${vo.receiveId}</td>
      </tr>
      <tr>
        <th>메세지 제목</th>
        <td>${vo.title}</td>
      </tr>
      <tr>
        <th>메세지 내용</th>
        <td style="height:130px;">${fn:replace(vo.content, newLine, "<br/>")}</td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="답장쓰기" onclick="location.href='${ctp}/wmMessage.wm?mSw=0&receiveId=${vo.sendId}';" class="btn btn-secondary"/> &nbsp;
          <%-- <input type="button" value="휴지통으로" onclick="location.href='${ctp}/wmDeleteCheck.wm?mSw=${mSw}&mFlag=${param.mFlag}&idx=${vo.idx}';" class="btn btn-secondary"/> &nbsp; --%>
          <%-- <c:if test="${mSw == 1 || mSw == 3 || param.mFlag == 10 || param.mFlag == 11}"> --%>
          <c:if test="${param.mFlag == 10 || param.mFlag == 11}">
          	<input type="button" value="휴지통으로" onclick="location.href='${ctp}/wmDeleteCheck.wm?mSw=${param.mFlag}&idx=${vo.idx}';" class="btn btn-secondary"/> &nbsp;
          </c:if>
          
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/wmMessage.wm';" class="btn btn-secondary"/> &nbsp;
        </td>
      </tr>
    </table>
</div>
<br/>
</body>
</html>