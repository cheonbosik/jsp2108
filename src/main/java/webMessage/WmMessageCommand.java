package webMessage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class WmMessageCommand implements WebMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		int mSw = request.getParameter("mSw")==null? 1 : Integer.parseInt(request.getParameter("mSw"));
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		
		WebMessageDAO dao = new WebMessageDAO();
		WebMessageVO vo = null;
		
		if(mSw == 6) {	// (한건의) 메세지 내용보기처리
			vo = dao.getWmMessageOne(idx, mid);
			request.setAttribute("vo", vo);
		}
		else {
			// 처음에는 무조건 모든 메세지 확인을 하도록 한다.(받은메세지함으로 처리한다.)
			List<WebMessageVO> vos = dao.getWebMessageList(mid, mSw);
			request.setAttribute("vos", vos);
		}
		
		request.setAttribute("mSw", mSw);
	}

}
