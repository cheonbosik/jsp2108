package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoLatelyCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
	  int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
	  
	  // 최근글 수정시 아래 두줄 삽입/수정
	  int lately = request.getParameter("lately")==null ? 0 : Integer.parseInt(request.getParameter("lately"));
	  int totRecCnt = 0;
	  if(lately == 0) totRecCnt = dao.totRecCnt();		// 전체자료검색
	  else totRecCnt = dao.totRecCntLately(lately);		// 지정된 최근자료검색
	  
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		
	  // 최근글수정시 아래 1줄 수정
	  List<BoardVO> vos = null;
	  if(lately == 0) vos = dao.getBoardList(startIndexNo, pageSize);  		// 전체자료검색
	  else vos = dao.getBoardListLately(startIndexNo, pageSize, lately); 	// 지정된 최근자료검색
		
		request.setAttribute("vos", vos);
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStrarNo", curScrStrarNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		request.setAttribute("pageSize", pageSize);
		
		// 최근게시글에서 추가
		request.setAttribute("lately", lately);
	}

}
