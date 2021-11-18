package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;

public class AdMemberLevelCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		int level = Integer.parseInt(request.getParameter("level"));
		
		AdminDAO memberDAO = new AdminDAO();
		memberDAO.setMemberLevelChange(idx, level);
		
		request.setAttribute("msg", "memberLevelChangeOk");
		request.setAttribute("url", request.getContextPath()+"/adMemberList.ad");
	}

}
