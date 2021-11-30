package study.pdsTest;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study.StudyInterface;

public class FileDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fileName = request.getParameter("file");
		
		String realPath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		File file = new File(realPath + fileName);
		
		if(file.exists()) {
			file.delete();
			response.getWriter().write("fileDeleteOk");
		}
		else {
			response.getWriter().write("fileDeleteNo");
		}
	}

}
