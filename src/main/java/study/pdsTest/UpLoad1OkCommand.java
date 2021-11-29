package study.pdsTest;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import study.StudyInterface;

public class UpLoad1OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  // MultipartRequest(저장소이름(request),"서버에 저장될 파일의 경로","최대용량","코드변환방식",옵션...(클래스))
		// 서버에 저장될 파일의 실제 ContextPath경로의 Root폴더? getRealPath()  ==> application객체에 포함되어 있다.
		
		ServletContext application = request.getServletContext();
		String realPath = application.getRealPath("/data/pdsTest");	// 파일 업로드 위치는 ContextPath아래 '/data/pdsTest'로 한다.
		int maxSize = 1024 * 1024 * 10;	// 업로드할 최대 용량은 10MByte로 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());	// 파일 업로드 완료...
		
		String originalFileName = multipartRequest.getOriginalFileName("fName");	// 업로드 시킬때의 업로드 파일명
		String filesystemName = multipartRequest.getFilesystemName("fName");			// 실제 서버에 저장되는 파일명
		
		System.out.println("서버에 저장되는 실제 경로 : " + application.getRealPath("/"));
		System.out.println("원본 파일명 : " + originalFileName);
		System.out.println("서버에 저장된 파일명 : " + filesystemName);
		
		if(filesystemName != null) {
			request.setAttribute("msg", "upLoad1Ok");
		}
		else {
			request.setAttribute("msg", "upLoad1No");
		}
		request.setAttribute("url", request.getContextPath()+"/pdsTest1.st");
	}

}
