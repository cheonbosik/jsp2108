package study;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.st")
public class StudyController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StudyInterface command = null;
		String viewPage = "/WEB-INF/study";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(com.equals("/el1")) {
			viewPage += "/el/el1.jsp"; 
		}
		else if(com.equals("/el2")) {
			viewPage += "/el/el2.jsp"; 
		}
		else if(com.equals("/jstl1")) {
			viewPage += "/jstl/jstl1.jsp"; 
		}
		else if(com.equals("/jstl2")) {
			command = new Jstl2Command();
			command.execute(request, response);
			viewPage += "/jstl/jstl2.jsp"; 
		}
		else if(com.equals("/jstl3")) {
			viewPage += "/jstl/jstl3.jsp"; 
		}
		else if(com.equals("/noimage")) {
			viewPage = "/WEB-INF/message/noimage.jpg"; 
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
