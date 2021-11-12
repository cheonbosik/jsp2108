package password;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/passwordOk")
public class PasswordOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 입력한 아이디와 비밀번호 받기
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		int pwd = request.getParameter("pwd")==null ? 0 : Integer.parseInt(request.getParameter("pwd"));
		
		System.out.println("========================");
		System.out.println("입력된 아이디 : " + mid);
		System.out.println("입력된 비밀번호 : " + pwd);
		System.out.println("------------------------");
		
		// 암호화를 위한 키(0x1234ABCD)
		int key = 0x1234ABCD;
		int encPwd, decPwd;
		
		encPwd = pwd ^ key;		// 원본비번과 암호키값을 배타적OR(exclusive OR)시킨다.
		System.out.println("인코딩된 비밀번호 : " + encPwd);  // DB에 저장시킬 비밀번호
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~");
		
		// DB에 저장된 암호를 다시 복호화 시킨다. 
		decPwd = encPwd ^ key;
		System.out.println("디코딩된 비밀번호 : " + decPwd);  // 복호화 되어서 기존비밀번호와 비교한다.
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~");
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('콘솔창을 확인하세요');");
		out.println("location.href='"+request.getContextPath()+"/password';");
		out.println("</script>");
		
	}
}
