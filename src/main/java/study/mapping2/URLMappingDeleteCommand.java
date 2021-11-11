package study.mapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class URLMappingDeleteCommand implements URLInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		UserDAO dao = new UserDAO();
		
		int res = dao.setUserDel(idx);
		
		if(res == 1) {
			request.setAttribute("msg", "userDeleteOk");
		}
		else {
			request.setAttribute("msg", "userDeleteNo");
		}
		request.setAttribute("url", request.getContextPath()+"/urlMappingList.um");
	}

}
