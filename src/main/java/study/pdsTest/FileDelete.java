package study.pdsTest;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/fileDelete")
public class FileDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("file");
		
		String realPath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		File file = new File(realPath + fileName);
		
		if(file.exists()) {
			file.delete();	// 서버의 파일시스템에서 생성된 객체파일이 삭제된다.(실제파일 삭제)
			request.setAttribute("msg", "fileDeleteOk");
		}
		else {
			request.setAttribute("msg", "fileDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/downLoad1.st");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/message/message.jsp");
		dispatcher.forward(request, response);
	}
}
