<%@page import="study.mapping2.UserVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  // 한글처리
  List<UserVO> vos = (List<UserVO>) request.getAttribute("vos");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>urlMappingList.jsp</title>
  <%@ include file="../../../include/bs4.jsp" %>
  <script>
    function delCheck(idx) {
    	var ans = confirm("삭제 하시겠습니까?");
    	if(ans) {
    		location.href="<%=request.getContextPath()%>/urlMappingDelete.um?idx="+idx;
    	}
    }
  </script>
</head>
<body>
<%@ include file="../../../include/header_home.jsp" %>
<%@ include file="../../../include/nav.jsp" %>
<p><br></p>
<div class="container">
  <h2>사용자 정보 리스트</h2>
  <br/>
  <div>
    <button type="button" onclick="location.href='<%=request.getContextPath()%>/urlMappingInput.um';" class="btn btn-secondary">정보등록</button> &nbsp;&nbsp;
    <button type="button" onclick="location.href='<%=request.getContextPath()%>/URLMapping.url2';" class="btn btn-secondary">돌아가기</button>
  </div>
  <hr/>
  <div>
    <table class="table table-hover">
      <tr class="table-dark text-dark">
        <th>번호</th>
        <th>성명</th>
        <th>나이</th>
        <th>비고</th>
      </tr>
<%    for(UserVO vo : vos) { %>
				<tr>
				  <td><%=vo.getIdx() %></td>
				  <td><%=vo.getName() %></td>
				  <td><%=vo.getAge() %></td>
				  <td>
				    <a href="javascript:delCheck(<%=vo.getIdx()%>)" class="btn btn-secondary btn-sm">삭제</a>&nbsp;
				    <a href="<%=request.getContextPath()%>/urlMappingUpdate.um?idx=<%=vo.getIdx()%>" class="btn btn-secondary btn-sm">수정</a>
				  </td>
				</tr>
<%    } %>
    </table>
  </div>
</div>
<br/>
<%@ include file="../../../include/footer.jsp" %>
</body>
</html>