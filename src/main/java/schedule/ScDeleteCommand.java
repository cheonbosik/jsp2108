package schedule;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ScDeleteCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String sDate = request.getParameter("ymd")==null? "" : request.getParameter("ymd");
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		
		ScheduleDAO dao = new ScheduleDAO();
		
		int res = dao.setScDelete(idx);
		
		if(res == 1) {
			request.setAttribute("msg", "scDeleteOk");
		}
		else {
			request.setAttribute("msg", "scDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/schedule.sc?ymd="+sDate+"&mid="+mid);
	}

}
