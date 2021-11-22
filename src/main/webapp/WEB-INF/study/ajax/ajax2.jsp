<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ajax2.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
  <script>
    //$(document).ready(function() {});
    $(function() {
    	$("#do").change(function() {
    		//var dodo = myform.do.value;
    		//var dodo = $("#do").val();
    		var dodo = $(this).val();
    		if(dodo == "") {
    			alert("지역을 선택하세요");
    			return false;
    		}
    		
    		var query = {
    				dodo : dodo
    		}
    		
    		$.ajax({
    			type : "post",
    			url  : "${ctp}/ajax2Do",
    			//data : query,
    			//success: function(data) {
    				// server처리후 넘어온 값을 처리하는 부분
    				// <option>영등포구</option>
    			//	var str = "";
    			//	str += "";
    			//}
    			data : query,
    			success : function(data) {
    			  //alert(data);
    				var dataStr = data.substring(1,data.length-3);
    				var dataArr = dataStr.split(",");
    				
    				var str = "";
    				str += "<option value=''>도시선택</option>";
    				for(var i=0;i<dataArr.length; i++) {
    				  str += "<option>"+dataArr[i]+"</option>";
    				}
    				$("#city").html(str);
    				
    			}
    		});
    	});
    });
    
    function fCheck() {
    	var do2 = $("#do").val();
    	var city = $("#city").val();
    	
    	alert("선책하신 지역은? " + do2 + " / " + city);
    }
  </script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <h2>aJax를 활용한 값의 전달1(ajax2.jsp)</h2>
  <hr/>
  <h3>도시를 선택하세요</h3>
  <form name="myform">
    <select name="do" id="do">
      <option value="">지역선택</option>
      <option value="서울">서울</option>
      <option value="경기">경기</option>
      <option value="충북">충북</option>
      <option value="충남">충남</option>
    </select>
    <select id="city">
      <option value="">도시선택</option>
    </select>
    <input type="button" value="선택" onclick="fCheck()"/>
  </form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>