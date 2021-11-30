package study;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import password.ShaTestOkCommand;
import study.ajax.Ajax1Command;
import study.jstl.Jstl2Command;
import study.pdsTest.DownLoad1Command;
import study.pdsTest.FileDeleteCommand;
import study.pdsTest.UpLoad1OkCommand;
import study.pdsTest.UpLoad2OkCommand;

@WebServlet("*.st")
public class StudyController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StudyInterface command = null;
		String viewPage = "/WEB-INF/study";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		if(level == 1 || level >= 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
			return;
		}
		else if(com.equals("/el1")) {
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
		else if(com.equals("/ajax1")) {
			command = new Ajax1Command();
			command.execute(request, response);
			viewPage += "/ajax/ajax1.jsp";
		}
		else if(com.equals("/ajax2")) {
			viewPage += "/ajax/ajax2.jsp";
		}
		else if(com.equals("/pdsTest1")) {
			viewPage += "/pdsTest/upLoad1.jsp";
		}
		else if(com.equals("/upLoad1Ok")) {
			command = new UpLoad1OkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/downLoad1")) {
			command = new DownLoad1Command();
			command.execute(request, response);
			viewPage += "/pdsTest/downLoad1.jsp";
		}
		else if(com.equals("/pdsTest2")) {
			viewPage += "/pdsTest/upLoad2.jsp";
		}
		else if(com.equals("/upLoad2Ok")) {
			command = new UpLoad2OkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/pdsTest3")) {
			viewPage += "/pdsTest/upLoad3.jsp";
		}
		else if(com.equals("/fileDelete")) {
			command = new FileDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/dynamicForm")) {
			viewPage += "/dynamicForm/dynamicForm.jsp";
		}
		else if(com.equals("/shaTest")) {
			viewPage += "/password/shaTest.jsp";
		}
		else if(com.equals("/shaTestOk")) {
			command = new ShaTestOkCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
