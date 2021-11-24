package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardInterface command = null;
		String viewPage = "/WEB-INF/board";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		if(level == 1 || level >= 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/");
			dispatcher.forward(request, response);
			return;
		}
		else if(com.equals("/boList")) {
			command = new BoListCommand();
			command.execute(request, response);
			viewPage += "/boList.jsp";
		}
		else if(com.equals("/boInput")) {
			command = new BoInputCommand();
			command.execute(request, response);
			viewPage += "/boInput.jsp";
		}
		else if(com.equals("/boInputOk")) {
			command = new BoInputOkCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/boContent")) {
			command = new BoContentCommand();
			command.execute(request, response);
			viewPage += "/boContent.jsp";
		}
		else if(com.equals("/boDelete")) {
			command = new BoDeleteCommand();
			command.execute(request, response);
			viewPage = "/WEB-INF/message/message.jsp";
		}
		else if(com.equals("/boGood")) {
			command = new BoGoodCommand();
			command.execute(request, response);
			viewPage += "/boContent.jsp";
		}
		else if(com.equals("/boGood2")) {
			// 아래는 중복처리를 하지 않았기에 좋아요수가 '증가/감소' 를 계속하게 된다.
			int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
			int flag = request.getParameter("flag")==null ? 0 : Integer.parseInt(request.getParameter("flag"));
			System.out.println("flag : " + flag);
			BoardDAO dao = new BoardDAO();
			dao.setGoodUpdate2(idx,flag);
			return;
		}
//		else if(com.equals("/boLately")) {
//			command = new BoListCommand();
//			command.execute(request, response);
//			viewPage += "/boList.jsp";
//		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
