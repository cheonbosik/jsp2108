package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoReplyUpdateCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = request.getParameter("boardIdx")==null? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null? 0 : Integer.parseInt(request.getParameter("pageSize"));
		int lately = request.getParameter("lately")==null? 0 : Integer.parseInt(request.getParameter("lately"));
		
		BoardDAO dao = new BoardDAO();
		//ReplyBoardVO replyBoardVO = dao.getReply(idx);
		
		request.setAttribute("msg", "replyBoardUpdateOk");
		request.setAttribute("url", request.getContextPath()+"/boContent.bo?idx="+boardIdx+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately);
	}

}
