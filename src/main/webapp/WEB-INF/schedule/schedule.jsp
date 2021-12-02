<%@page import="schedule.ScheduleVO"%>
<%@page import="schedule.ScheduleDAO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
  String mid = session.getAttribute("sMid")==null ? "" : (String) session.getAttribute("sMid");
  String ymd = request.getParameter("ymd")==null ? "" : request.getParameter("ymd");
  
  // Calendar.Month 값? 0~11  ==>> 1월~12월
  // Calendar.DAY_OF_WEEK 값? 1~7 ==>> 일~토요일
  
  Calendar calToday = Calendar.getInstance(); // 오늘 날짜를 저장할 변수
  Calendar cal = Calendar.getInstance();			// 화면에 표시되는 오늘날짜기준으로 사용하는 변수
  
  int yy = request.getParameter("yy")==null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
  int mm = request.getParameter("mm")==null ? cal.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
  
  if(!ymd.equals("")) {    // ymd : 2024-2-23
  	String[] ymdArray = ymd.split("-");
  	yy = Integer.parseInt(ymdArray[0]);
  	mm = Integer.parseInt(ymdArray[1])-1;
  }
  
  cal.set(yy, mm, 1);
  int startWeek = cal.get(Calendar.DAY_OF_WEEK);
  
  /*
  int prevYear = yy; 	// 전년도
  int nextYear = yy; 	// 다음년도
  int prevMonth = mm - 1; 	// 전월
  int nextMonth = mm + 1; 	// 다음월
  
  if(prevMonth < 0) {
  	prevYear--;
  	prevMonth = 11;
  }
  if(nextMonth > 11) {
  	nextYear++;
  	nextMonth = 0;
  }
  */
  if(mm < 0) {
  	yy--;
  	mm = 11;
  }
  if(mm > 11) {
  	yy++;
  	mm = 0;
  }
  
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>schedule.jsp</title>
  <%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <font size="5">일정관리</font> &nbsp; &nbsp;
<%--
<%  if(mm == 0) { %>
      <a href="${ctp}/schedule.sc?yy=<%=prevYear%>&mm=<%=mm%>" title="이전년도">◁◁</a>
<%  } else { %>
			<a href="${ctp}/schedule.sc?yy=<%=prevYear-1%>&mm=<%=mm%>" title="이전년도">◁◁</a>
<%  } %>
    <a href="${ctp}/schedule.sc?yy=<%=prevYear%>&mm=<%=prevMonth%>" title="전월">◀</a>
    (<%=yy%>년 <%=mm+1%>월)
    <a href="${ctp}/schedule.sc?yy=<%=nextYear%>&mm=<%=nextMonth%>" title="다음월">▶</a>
<%  if(mm == 11) { %>
    	<a href="${ctp}/schedule.sc?yy=<%=nextYear%>&mm=<%=mm%>" title="다음년도">▷▷</a>
<%  } else { %>
			<a href="${ctp}/schedule.sc?yy=<%=nextYear+1%>&mm=<%=mm%>" title="다음년도">▷▷</a>
<%  } %>
--%>
    <a href="${ctp}/schedule.sc?yy=<%=yy-1%>&mm=<%=mm%>" title="이전년도">◁◁</a>
    <a href="${ctp}/schedule.sc?yy=<%=yy%>&mm=<%=mm-1%>" title="이전월">◀</a>
    (<%=yy%>년 <%=mm+1%>월)
    <a href="${ctp}/schedule.sc?yy=<%=yy%>&mm=<%=mm+1%>" title="다음월">▶</a>
    <a href="${ctp}/schedule.sc?yy=<%=yy+1%>&mm=<%=mm%>" title="다음년도">▷▷</a>
    &nbsp; &nbsp;
    <a href="${ctp}/schedule.sc" title="오늘날짜">■</a>
  <br/>
  <table class="table table-bordered text-left align-top">
  	<tr class="table-secondary text-center">
  	  <th><font color="red">일</font></th>
  	  <th>월</th>
  	  <th>화</th>
  	  <th>수</th>
  	  <th>목</th>
  	  <th>금</th>
  	  <th><font color="blue">토</font></th>
  	</tr>
  	<tr style="height:80px;">
<%
		for(int i=1; i<startWeek; i++) {
			out.println("<td>&nbsp;</td>");
		}

		ScheduleDAO dao = new ScheduleDAO();
		
		while(cal.get(Calendar.MONTH) == mm) {
			String part = "", content = "";
			ymd = cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DATE);  // 화면에 표시되는 일자(년월일)를 ymd변수로 셋팅
			ScheduleVO vo = dao.getScContent(ymd, mid);
			
			if(vo.getPart() != null) part = vo.getPart();
			if(vo.getContent() != null) {
				if(vo.getContent().length() >= 10) content = vo.getContent().substring(0,10);
			}
			
			if(cal.get(Calendar.DAY_OF_WEEK) == 1) {
				out.println("<td><a href='scContent.sc?ymd="+ymd+"'><font color='red'>"+cal.get(Calendar.DATE)+"</font></a><br/><span title='"+content+" ...'>"+part+"</span></td>");
			}
			else if(cal.get(Calendar.DAY_OF_WEEK) == 7) {
				out.println("<td><a href='scContent.sc?ymd="+ymd+"'><font color='blue'>"+cal.get(Calendar.DATE)+"</font></a><br/><span title='"+content+" ...'>"+part+"</span></td>");
			}
			else if(cal.get(Calendar.YEAR)==calToday.get(Calendar.YEAR) && cal.get(Calendar.MONTH)==calToday.get(Calendar.MONTH) && cal.get(Calendar.DATE)==calToday.get(Calendar.DATE)) {
				out.println("<td style='background-color:skyblue'><a href='scContent.sc?ymd="+ymd+"'><b>"+cal.get(Calendar.DATE)+"</b></a><br/><span title='"+content+" ...'>"+part+"</span></td>");
			}
			else {
				out.println("<td><a href='scContent.sc?ymd="+ymd+"'><font color='#000'>"+cal.get(Calendar.DATE)+"</font></a><br/><span title='"+content+" ...'>"+part+"</span></td>");
			}
			
			if(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
				out.println("</tr><tr style='height:80px;'>");
			}
			
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE)+1);
		}
		if(cal.get(Calendar.DAY_OF_WEEK) <= 7) {
			for(int i=cal.get(Calendar.DAY_OF_WEEK); i<=7; i++) {
				out.println("<td>&nbsp;</td>");
			}
		}
%>
  	</tr>
  </table>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>