package study.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ajax2Do")
public class Ajax2Do extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String dodo = request.getParameter("dodo");
		
		ArrayList<String> vos = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("강북구");
			vos.add("강동구");
			vos.add("강서구");
			vos.add("종로구");
			vos.add("서대문구");
			vos.add("영등포구");
			vos.add("관악구");
			vos.add("성북구");
		}
		else if(dodo.equals("경기")) {
			vos.add("수원시");
			vos.add("부천시");
			vos.add("안성시");
			vos.add("평택시");
			vos.add("하남시");
			vos.add("성남시");
			vos.add("안양시");
			vos.add("광명시");
			vos.add("남양주시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("충주시");
			vos.add("제천시");
			vos.add("단양군");
			vos.add("영동군");
			vos.add("옥천군");
			vos.add("음성군");
			vos.add("진천군");
			vos.add("증평군");
		}
		else if(dodo.equals("충남")) {
			vos.add("천안시");
			vos.add("아산시");
			vos.add("공주시");
			vos.add("태안군");
			vos.add("보령시");
			vos.add("당진시");
			vos.add("홍성군");
			vos.add("부여시");
			vos.add("논산시");
		}
		
		PrintWriter out = response.getWriter();
		out.println(vos);
	}
}
