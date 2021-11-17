<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>el2.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>el2.jsp(Form값 전달받아 출력)</h2>
  <p>스크립틀릿을 이용할경우는?</p>
<%
  // 한글처리한다.
  //String mid = request.getParameter("mid");
  //String pwd = request.getParameter("pwd");
  //String name = request.getParameter("name");
  //String mbc = request.getParameter("mbc");
%>
  아이디 : <%//=mid %><br/>
  비밀번호 : <%//=pwd %><br/>
  성명 : <%//=name %><br/>
  mbc : <%//=mbc %><br/>
  <hr/>
  <p>EL을 사용한 값을 전송받을때는 $ {param.xxx}사용</p>
  아이디 : ${param.mid}<br/>
  비밀번호 : ${param.pwd}<br/>
  성명 : ${param.name}<br/>
  mbc : ${param.mbc}<br/>
  <p><a href="<%=request.getContextPath()%>/el1.st" class="btn btn-secondary">돌아가기</a>
  <hr/>
<%
	int[] atom1 = new int[5];
  int atom2[] = new int[5];
  String[] atom3 = new String[]{"일","월","화","수","목","금","토"};
  int[] atom4 = {100,200,300,400,500};
%>
<%
	out.println("atom3 : "); 	 
  for(int i=0; i<atom3.length; i++) {
  	out.println(atom3[i] + " / "); 	 
  }
%>
  <h3>EL표기법을 활용한 배열값 처리</h3>
<%
  pageContext.setAttribute("atom4", atom4);
%>
  <p>전달받은 배열값 출력?</p>
  atom4 : ${atom4}<br/>
  atom4[0] : ${atom4[0]}<br/>
  atom4[1] : ${atom4[1]}<br/>
  atom4[2] : ${atom4[2]}<br/>
  atom4[3] : ${atom4[3]}<br/>
  atom4[4] : ${atom4[4]}<br/><br/>
  atom4[0] > atom4[1] : ${atom4[0] > atom4[1]}<br/>
  atom4[0] > atom4[1] : ${atom4[0] > atom4[1] ? atom4[0] : atom4[1]}<br/><br/>
  atom4[0] gt atom4[1] : ${atom4[0] gt atom4[1]}<br/>
  atom4[0] gt atom4[1] : ${atom4[0] gt atom4[1] ? atom4[0] : atom4[1]}<br/><br/>
  atom4[0] == atom4[1] : ${atom4[0] == atom4[1]}<br/>
  atom4[0] eq atom4[1] : ${atom4[0] eq atom4[1]}<br/><br/>
  atom4[0] < atom4[1] : ${atom4[0] < atom4[1]}<br/>
  atom4[0] lt atom4[1] : ${atom4[0] lt atom4[1]}<br/><br/>
  atom4[0] <= atom4[1] : ${atom4[0] <= atom4[1]}<br/>
  atom4[0] le atom4[1] : ${atom4[0] le atom4[1]}<br/><br/>
  atom4[0] >= atom4[1] : ${atom4[0] >= atom4[1]}<br/>
  atom4[0] ge atom4[1] : ${atom4[0] ge atom4[1]}<br/><br/>
  atom4[0] != atom4[1] : ${atom4[0] != atom4[1]}<br/>
  atom4[0] ne atom4[1] : ${atom4[0] ne atom4[1]}<br/><br/>
  
  hobby : ${param.hobby}<br/>
  <!-- JSTL을 사용하여 배열값을 변수에 저장후 출력해야한다.
  hobby[0] : $ {param.hobby[0]}<br/>
  hobby[1] : $ {param.hobby[1]}<br/>
  -->
  <hr/>
  <h3>객체를 전달받기</h3>
<%
	ArrayList<String> arrVos = new ArrayList<>();
  arrVos.add("홍길동");
  arrVos.add("김말숙");
  arrVos.add("이기자");
  arrVos.add("오하늘");
  
  pageContext.setAttribute("arrVos", arrVos);
%>
  <h4>ArrayList자료를 저장후 출력?</h4>
  arrVos : ${arrVos}<br/>
  arrVos[0] : ${arrVos[0]}<br/>
  arrVos[1] : ${arrVos[1]}<br/>
  arrVos[2] : ${arrVos[2]}<br/>
  arrVos[3] : ${arrVos[3]}<br/><br/>
<%
	HashMap<String, String> mapVos = new HashMap<>();
  mapVos.put("1", "월요일");
  mapVos.put("화", "화요일");
  mapVos.put("3", "수요일");
  mapVos.put("목", "목요일");
  pageContext.setAttribute("mapVos", mapVos);
%>
  <h4>HashMap자료를 저장후 출력?</h4>
  mapVos : ${mapVos}<br/>
  mapVos["1"] : ${mapVos["1"]}<br/>
  mapVos["화"] : ${mapVos["화"]}<br/>
  mapVos["3"] : ${mapVos["3"]}<br/>
  mapVos["목"] : ${mapVos["목"]}<br/><br/>
  <hr/>
  <h3>Null(널)값의 비교/처리 - 연산</h3>
<%
  pageContext.setAttribute("var1", "문자");
  pageContext.setAttribute("var2", "");
  pageContext.setAttribute("var3", null);
%>
  var1 : ${var1}<br/>
  var2 : ${var2}<br/>
  var3 : ${var3}<br/><br/>
  연산자1(== "") : ${var1 == ""}<br/>
  연산자2(== "") : ${var2 == ""}<br/>
  연산자3(== "") : ${var3 == ""}<br/>
  연산자1(== null) : ${var1 == null}<br/>
  연산자2(== null) : ${var2 == null}<br/>
  연산자3(== null) : ${var3 == null}<br/>
  연산자(eq) : ${var1 eq null}<br/>
  연산자(== 과 null을 동시에 비교) : ${var1 == "" || var1 == null}<br/>
  연산자(== 과 null을 동시에 비교는 EL에서는 empty) : ${empty var1}<br/>
  연산자(!= 과 not null을 동시에 비교는 EL에서는 not empty) : ${not empty var1}<br/>
  연산자(!= 과 not null을 동시에 비교는 EL에서는 !empty) : ${!empty var1}<br/>
  연산자(empty를 이용하면 ""나 null을 따로 비교할 필요가 없다.) : ${empty var2}<br/>
  연산자(empty를 이용하면 ""나 null을 따로 비교할 필요가 없다.) : ${empty var3}<br/><br/>
  var1 == null 또는 var1 == "" 인지? ${empty var1 ? "OK" : var1}<br/>
  var2 == null 또는 var2 == "" 인지? ${empty var2 ? "OK" : var2}<br/>
  var3 == null 또는 var3 == "" 인지? ${empty var3 ? "OK" : var3}<br/>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>