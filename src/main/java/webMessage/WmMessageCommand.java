package webMessage;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardVO;

public class WmMessageCommand implements WebMessageInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
												
		int mSw = request.getParameter("mSw")==null? 1 : Integer.parseInt(request.getParameter("mSw"));
		int idx = request.getParameter("idx")==null? 0 : Integer.parseInt(request.getParameter("idx"));	// idx는 메세지내용 확인때 넘어오는 고유번호값이다.
		
		WebMessageDAO dao = new WebMessageDAO();
		WebMessageVO vo = null;
		
		if(mSw == 6) {	// (한건의) 메세지 내용보기때는 mSW가 6이 넘어온다.
			vo = dao.getWmMessageOne(idx, mid);	// 한건의 메세지 내용가져오기
			request.setAttribute("vo", vo);
		}
		else {
			/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		  int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		  int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		  int totRecCnt = dao.totRecCnt(mid, mSw);		// 전체자료검색
		  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		  int startIndexNo = (pag - 1) * pageSize;
		  int curScrStrarNo = totRecCnt - startIndexNo;
		  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
		  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
		  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		  /* 블록페이징처리 끝 */
			
		  List<WebMessageVO> vos = dao.getWebMessageList(mid, mSw, startIndexNo, pageSize);	// 전체자료검색
			
			request.setAttribute("vos", vos);
			request.setAttribute("pag", pag);
			request.setAttribute("totPage", totPage);
			request.setAttribute("curScrStrarNo", curScrStrarNo);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("curBlock", curBlock);
			request.setAttribute("lastBlock", lastBlock);
		}
		
		request.setAttribute("mSw", mSw);
	}

}
