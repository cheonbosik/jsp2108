<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  String msg = (String) request.getAttribute("msg");
  String url = (String) request.getAttribute("url");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <script> 
  	var msg = "<%=msg%>";
  	var url = "<%=url%>";
  	var val = "${val}";
  
  	if(msg == "memberDeleteOk") msg = "회원 정보가 삭제되었습니다.";
  	//else if(msg == "memberDeleteNo") msg = "회원 정보가 삭제되지 않았습니다.";
  	else if(msg == "memberJoinOk") msg = "회원 가입되었습니다.";
  	else if(msg == "memberJoinNo") msg = "회원 가입에 실패하셨습니다.";
  	else if(msg == "memberLoginOk") msg = val + "님 로그인 되었습니다.";
  	else if(msg == "memberLoginNo") msg = "로그인 실패하셨습니다.";
  	else if(msg == "memberLogoutOk") msg = val + "님 로그아웃 되었습니다.";
  	else if(msg == "memberLoginPwdNo") msg = "비밀번호를 확인하세요.";
  	else if(msg == "memberUpdateOk") msg = "회원정보가 수정되었습니다.^.^.";
  	else if(msg == "memberUpdateNo") msg = "회원정보가 수정되지 않았습니다.ㅜㅜ.";
  	else if(msg == "memberLevelChangeOk") msg = "회원 등급이 변경 되었습니다.";
  	else if(msg == "memberResetOk") msg = "회원정보가 DB에서 삭제 되었습니다.";
  	else if(msg == "boInputOk") msg = "게시글이 등록 되었습니다.";
  	else if(msg == "boInputNo") msg = "게시글이 등록 실패~~~";
  	else if(msg == "boDeleteOk") msg = "게시글이 삭제 되었습니다.";
  	else if(msg == "boDeleteNo") msg = "게시글이 삭제 실패~~~";
  	else if(msg == "boUpdateOk") msg = "게시글이 수정되었습니다.";
  	else if(msg == "boUpdateNo") msg = "게시글 수정실패~~~";
  	else if(msg == "replyBoardInputOk") msg = "댓글이 등록되었습니다.";
  	else if(msg == "upLoad1Ok") msg = "파일이 업로드 되었습니다.";
  	else if(msg == "upLoad1No") msg = "파일이 업로드 실패~~~";
  	else if(msg == "fileDeleteOk") msg = "파일이 삭제 되었습니다.";
  	else if(msg == "fileDeleteNo") msg = "파일이 삭제 실패~~~";
  	
    alert(msg);
    if(url != "") location.href = url;
  </script>
</head>
<body>

</body>
</html>