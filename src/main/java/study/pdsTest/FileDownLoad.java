package study.pdsTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileDownLoad")
public class FileDownLoad extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fName = request.getParameter("file");
		
		// 아래로 파일 다운로드 처리부분이다.
		// ServletContext application = request.getServletContext();
		// String realPath = application.getRealPath("/data/pdsTest");
		// 위의 두줄을 아래 1줄로 표시할 수 있다.
		String realPath = request.getServletContext().getRealPath("/data/pdsTest/");
		
		File file = new File(realPath+fName);
		
		String mimeType = getServletContext().getMimeType(file.toString());
		if(mimeType == null) {
			response.setContentType("application/octet-stream");  // 2진 바이너리파일로 전송하겠다는것...
		}
		
		String downLoadName = "";
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) { // 사용자 브라우저가 익스플로서가 아니라면?
			downLoadName = new String(fName.getBytes("UTF-8"), "8859_1");
		}
		else {
			downLoadName = new String(fName.getBytes("EUC-KR"), "8859_1");
		}
		
		// 다운로드할 파일명과 형식을 헤더파일에 담아서 클라이언트에 전송한다.
		response.setHeader("Content-Disposition", "attachment;filename=" + downLoadName);
		
		// Java에 의해서 실제로 업(다운)로드를 하기위한 객체(FileInputStream/FileOutputStream)를 생성한다.
		FileInputStream fileInputStream = new FileInputStream(file);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		// 생성된 객체에 실제로 파일을 전송처리한다.
		byte[] b = new byte[2048];
		int data = 0;
		
		while((data = fileInputStream.read(b, 0, b.length)) != -1) {
			servletOutputStream.write(b, 0, data);
		}
		servletOutputStream.flush();
		// 여기까지 파일 다운로드 처리이다.
		
		servletOutputStream.close();
		fileInputStream.close();
	}
}
