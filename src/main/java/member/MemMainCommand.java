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
	  
	  String strLevel = "";
	  if(level == 0) strLevel = "관리자";
	  else if(level == 1) strLevel = "준회원";
	  else if(level == 2) strLevel = "정회원";
	  else if(level == 3) strLevel = "우수회원";
	  
	  session.setAttribute("strLevel", strLevel);
	}

}
