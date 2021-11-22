package study.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping2.UserDAO;

@WebServlet("/userDelete")
public class UserDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		UserDAO dao = new UserDAO();
		int res = dao.setUserDel(idx);
		
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/study/ajax/ajax1.jsp");
//		dispatcher.forward(request, response);
//		response.sendRedirect(request.getContextPath()+"/ajax1.st");
		
		response.getWriter().write(res+"");
	}
}
