package password;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;
import study.StudyInterface;

public class ShaTestOkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		SecurityUtil security = new SecurityUtil();
		String shaPwd = security.encryptSHA256(pwd);
		
		response.getWriter().write(shaPwd);
	}

}
