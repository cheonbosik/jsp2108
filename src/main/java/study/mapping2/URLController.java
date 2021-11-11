package study.mapping2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.um")
public class URLController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		URLInterface command = null;
		String viewPage = "";
		
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(com.equals("/urlMappingList")) {
			command = new URLMappingListCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study/mapping/urlMappingList.jsp";
		}
		else if(com.equals("/urlMappingDelete")) {
			command = new URLMappingDeleteCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study/mapping/message.jsp";
		}
		else if(com.equals("/urlMappingInputOk")) {
			command = new URLMappingInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study/mapping/message.jsp";
		}
		else if(com.equals("/urlMappingInput")) {
			viewPage = "/WEB-INF/study/mapping/urlMappingInput.jsp";
		}
		else if(com.equals("/urlMappingUpdate")) {
			command = new URLMappingUpdateCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study/mapping/urlMappingUpdate.jsp";
		}
		else if(com.equals("/urlMappingUpdateOk")) {
			command = new URLMappingUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/study/mapping/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
