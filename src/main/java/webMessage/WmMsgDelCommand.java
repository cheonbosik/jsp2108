package webMessage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WmMsgDelCommand implements WebMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String mFlag = request.getParameter("mFlag")==null? "" : request.getParameter("mFlag");
		int mSw = request.getParameter("mFlag")==null? 1 : Integer.parseInt(request.getParameter("mFlag"));
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		WebMessageDAO dao = new WebMessageDAO();
		dao.wmDeleteCheck(idx,mSw);
	}

}
