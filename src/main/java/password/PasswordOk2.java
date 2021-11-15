package password;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/passwordOk2")
public class PasswordOk2 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 입력한 아이디와 비밀번호 받기
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd").toUpperCase();
		
		System.out.println("========================");
		System.out.println("입력된 아이디 : " + mid);
		System.out.println("입력된 비밀번호 : " + pwd);
		System.out.println("------------------------");
		
		// 입력된 비밀번호 변환
		long intPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			intPwd = (long) pwd.charAt(i);
			strPwd += intPwd;
		}
		System.out.println("strPwd(아스키코드문자로변환된비밀번호) : " + strPwd);
		
		intPwd = Long.parseLong(strPwd);  // 연산할 준비 완료...
		
		long key = 0x1234ABCD;  // 암호화를 위한 키(0x1234ABCD)
		long encPwd;
		
		// 암호화 작업(인코딩)
		encPwd = intPwd ^ key;		// 원본비번과 암호키값을 배타적OR(exclusive OR)시킨다.
		strPwd = String.valueOf(encPwd);	// DB에 저장하기위해 문자료 변환했다.
		System.out.println("인코딩된 비밀번호(DB저장값이다) : " + strPwd);  // DB에 저장시킬 비밀번호
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~");
		
		// DB에 저장된 암호를 다시 복호화(디코딩) 시킨다.
		long decPwd;
		intPwd = Long.parseLong(strPwd);		// DB에 넣었던 strPwd를 다시 불러서 복호화를 위해 정수형으로 변환했다.
		decPwd = intPwd ^ key;
		System.out.println("디코딩된 비밀번호 : " + decPwd);  // DB저장된 암호를 복호화
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~");
		
		// 복원된 비밀번호는 숫자로된 비밀번호이기에 문자로 변경후 2개씩 분리후 다시 문자로 변환시켜준다.
		strPwd = String.valueOf(decPwd);
		
		String result = "";
		char ch;
		
		for(int i=0; i<strPwd.length(); i+=2) {
			ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
			result += ch;
		}
		
		System.out.println("최종 변환된 비밀번호 : " + result);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('콘솔창을 확인하세요');");
		out.println("location.href='"+request.getContextPath()+"/password';");
		out.println("</script>");
		
	}
}
