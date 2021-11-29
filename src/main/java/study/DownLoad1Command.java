package study;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownLoad1Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pdsTest");
		
		String[] files = new File(realPath).list();	// 서버의 저장폴더에 존재하는 모든 파일의 정보를 배열로 읽어서 배열변수에 담는다.
		
		request.setAttribute("files", files);
	}

}
