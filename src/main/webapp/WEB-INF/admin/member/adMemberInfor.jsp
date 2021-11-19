<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine","\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adMemberInfor.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    
  </script>
</head>
<body>
<p><br></p>
<div class="container">
  <h2>회 원 정 보</h2>
  <br/>
  <table class="table">
    <tr><td>아이디 : ${vo.mid}</td></tr>
    <tr><td>별명 : ${vo.nickName}</td></tr>
    <tr><td>성명 : ${vo.name}</td></tr>
    <tr><td>성별 : ${vo.gender}</td></tr>
    <tr><td>생일 : ${fn:substring(vo.birthday,0,10)}</td></tr>
    <tr><td>전화번호 : ${vo.tel}</td></tr>
    <tr><td>주소 : ${vo.address}</td></tr>
    <tr><td>이메일 : ${vo.email}</td></tr>
    <tr><td>홈페이지 : ${vo.homePage}</td></tr>
    <tr><td>직업 : ${vo.job}</td></tr>
    <tr><td>취미 : ${vo.hobby}</td></tr>
    <tr><td>사진 : <img src="images/${vo.photo}" width="100px"/></td></tr>
    <tr><td>자기소개 : <br/>${fn:replace(vo.content,newLine,'<br/>')}</td></tr>
    <tr><td>공개여부 : ${vo.userInfor}</td></tr>
    <tr>
      <td>탈퇴여부 : 
        <c:if test="${vo.userDel ne 'NO'}"><font color="red">탈퇴신청</font></c:if>
        <c:if test="${vo.userDel eq 'NO'}">활동중</c:if>
      </td>
    </tr>
    <tr><td>포인트 : <fmt:formatNumber value="${vo.point}"/></td></tr>
    <tr>
      <td>레벨 :
        <c:choose>
	        <c:when test="${vo.level == 2}"><c:set var="level" value="정회원"/></c:when>
	        <c:when test="${vo.level == 3}"><c:set var="level" value="우수회원"/></c:when>
	        <c:when test="${vo.level == 0}"><c:set var="level" value="관리자"/></c:when>
	        <c:otherwise><c:set var="level" value="준회원"/></c:otherwise>
	      </c:choose>
	      ${level}
      </td>
    </tr>
    <tr><td>총방문수 : ${vo.visitCnt}</td></tr>
    <tr><td>최초가입일 : ${vo.startDate}</td></tr>
    <tr><td>최종방문일 : ${vo.lastDate}</td></tr>
    <tr><td>오늘방문수 : ${vo.todayCnt}</td></tr>
  </table>
  <hr/>
  <a href="${ctp}/adMemberList.ad" class="btn btn-secondary">돌아가기</a>
</div>
<br/>
</body>
</html>