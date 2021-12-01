package pds;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class PdsDeleteCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String[] fSNames = request.getParameter("fSName").split("/");
		
		PdsDAO dao = new PdsDAO();
		
		// 비밀번호검색후 일치하면 삭제처리한다.
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		PdsVO vo = dao.getPdsContent(idx);
		
		if(vo.getPwd().equals(pwd)) {
			String realPath = request.getServletContext().getRealPath("/data/pds/");
			
			// 서버 파이시스템에 존재하는 실제파일을 삭제처리한다.
			for(String fSName : fSNames) {
				new File(realPath + fSName).delete();
			}
			
			// 삭제된 파일의 정보를 DB에서 완전시 삭제처리한다.
			dao.pdsDelete(idx);
			response.getWriter().write("pdsDeleteOk");
		}
		else {
			response.getWriter().write("pdsDeleteNo");
		}
	}

}
