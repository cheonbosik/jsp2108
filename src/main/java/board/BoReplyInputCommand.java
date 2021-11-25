package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoReplyInputCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = request.getParameter("boardIdx")==null? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String mid = request.getParameter("mid")==null? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null? "" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp")==null? "" : request.getParameter("hostIp");
		String content = request.getParameter("content")==null? "" : request.getParameter("content");
		int pag = request.getParameter("pag")==null? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null? 0 : Integer.parseInt(request.getParameter("pageSize"));
		int lately = request.getParameter("lately")==null? 0 : Integer.parseInt(request.getParameter("lately"));
		
		ReplyBoardVO replyVO = new ReplyBoardVO();
		replyVO.setBoardIdx(boardIdx);
		replyVO.setMid(mid);
		replyVO.setNickName(nickName);
		replyVO.setHostIp(hostIp);
		replyVO.setContent(content);
	  
		BoardDAO dao = new BoardDAO();
		dao.replyInput(replyVO);
		
		request.setAttribute("msg", "replyBoardInputOk");
		request.setAttribute("url", request.getContextPath()+"/boContent.bo?idx="+boardIdx+"&pag="+pag+"&pageSize="+pageSize+"&lately="+lately);
	}
}
