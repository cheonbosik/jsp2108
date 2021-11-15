package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "": request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "": request.getParameter("pwd");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.loginCheck(mid);
		
		if(vo != null) {  // 아이디 검색은 성공... 비밀번호가 맞는지 체크?.....
			// DB에 저장된 암호를 복호화시킨다.(실무에서는 이런작업은 하지 않는다)
			long decPwd;
			long intPwd = Long.parseLong(vo.getPwd());		// DB에 넣었던 strPwd를 다시 불러서 복호화를 위해 정수형으로 변환했다.
			long pwdValue  = (long) dao.getHashTableSearch(vo.getPwdKey());
			decPwd = intPwd ^ pwdValue;
			String strPwd = String.valueOf(decPwd);
			
			String result = "";
			char ch;
			for(int i=0; i<strPwd.length(); i+=2) {
				ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
				result += ch;
			}
			
			if(pwd.equals(result)) {  // 비밀번호 인증 OK!
			  request.setAttribute("msg", "memberLoginOk");
			  request.setAttribute("url", request.getContextPath()+"/memMain.mem");
			}
			else {
				request.setAttribute("msg", "memberLoginPwdNo");
				request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			}
		}
		else {
			request.setAttribute("msg", "memberLoginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}
	}

}
