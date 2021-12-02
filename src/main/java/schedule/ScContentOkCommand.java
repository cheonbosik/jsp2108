package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ScContentOkCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String sDate = request.getParameter("sDate")==null ? "" : request.getParameter("sDate");
		String part = request.getParameter("part")==null ? "" : request.getParameter("part");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		ScheduleVO vo = new ScheduleVO();
		vo.setIdx(idx);
		vo.setMid(mid);
		vo.setsDate(sDate);
		vo.setPart(part);
		vo.setContent(content);
		
		ScheduleDAO dao = new ScheduleDAO();
		int res = dao.setScContentOk(vo);		// 일정등록과 일정수정처리
		
		if(res == 1) {
			request.setAttribute("msg", "scContentOk");
		}
		else {
			request.setAttribute("msg", "scContentNo");
		}
		request.setAttribute("url", request.getContextPath()+"/schedule.sc?ymd="+sDate+"&mid="+mid);
	}

}
