package study;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Jstl2Command implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int[] arr1 = new int[] {10,20,30,40,50,60};
		request.setAttribute("arr1", arr1);
		
		int[][] arr2 = new int[][] {
			{10,20},
			{30,40},
			{50,60}
		};
		request.setAttribute("arr2", arr2);
		
		String[][] tel = new String[][] {
			{"02","서울"},
			{"031","경기도"},
			{"032","인천"},
			{"041","충남"},
			{"042","대전"},
			{"043","충북"}
		};
		request.setAttribute("tel", tel);
	}

}
