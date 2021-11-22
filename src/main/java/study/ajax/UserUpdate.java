package study.ajax;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping2.UserDAO;
import study.mapping2.UserVO;

@WebServlet("/userUpdate")
public class UserUpdate extends HttpServlet {
	@Override	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		UserDAO dao = new UserDAO();
		
		UserVO vo = dao.getIdxSearch(idx);
		request.setAttribute("vo", vo);
		//System.out.println("vo : " + vo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/study/ajax/userUpdate.jsp");
		dispatcher.forward(request, response);
	}
}
