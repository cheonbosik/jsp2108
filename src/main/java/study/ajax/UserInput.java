package study.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping2.UserDAO;
import study.mapping2.UserVO;

@WebServlet("/userInput")
public class UserInput extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		UserDAO dao = new UserDAO();
		UserVO vo = new UserVO();
		
		vo.setName(name);
		vo.setAge(age);
		
		dao.setUserInputOk(vo);
		
		response.getWriter().write("1");
	}
}
