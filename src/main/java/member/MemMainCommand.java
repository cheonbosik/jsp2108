package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemMainCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99: (int) session.getAttribute("sLevel");
		String mid = session.getAttribute("sMid")==null ? "": (String) session.getAttribute("sMid");
		
	  String strLevel = "";
	  if(level == 0) strLevel = "관리자";
	  else if(level == 1) strLevel = "준회원";
	  else if(level == 2) strLevel = "정회원";
	  else if(level == 3) strLevel = "우수회원";
	  session.setAttribute("strLevel", strLevel);
	  
	  MemberDAO dao = new MemberDAO();
	  
	  // 총 방문횟수와 오늘방문횟수 가져오기
	  MemberVO vo = dao.getUserInfor(mid);
	  request.setAttribute("visitCnt", vo.getVisitCnt());
	  request.setAttribute("todayCnt", vo.getTodayCnt());
	  request.setAttribute("point", vo.getPoint());
	}

}
