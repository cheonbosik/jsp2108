package webMessage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoListCommand;

@WebServlet("*.wm")
public class WebMessageController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		WebMessageInterface command = null;
		String viewPage = "/WEB-INF/webMessage";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		if(level == 1 || level >= 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
			return;
		}
		else if(com.equals("/wmMessage")) {
			command = new WmMessageCommand();
			command.execute(request, response);
			viewPage += "/wmMessage.jsp";
		}
		else if(com.equals("/wmInputOk")) {
			command = new WmInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/wmDeleteCheck")) {
			command = new WmDeleteCheckCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/wmDeleteAll")) {
			command = new WmDeleteAllCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/wmMsgDel")) {
			command = new WmMsgDelCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
