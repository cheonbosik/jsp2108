package study.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.mapping2.UserDAO;
import study.mapping2.UserVO;

@WebServlet("/userUpdateOk")
public class UserUpdateOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		
		UserDAO dao = new UserDAO();
		UserVO vo = new UserVO();
		
		vo.setIdx(idx);
		vo.setName(name);
		vo.setAge(age);
		
		dao.setUserUpdateOk(vo);
		
		response.getWriter().write("1");
	}
}
