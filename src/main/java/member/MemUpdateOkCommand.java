package member;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class MemUpdateOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/member");
		int maxSize = 1024 * 1024 * 2;	// 업로드할 최대 용량은 2MByte로 한다.
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());	// 파일 업로드 완료...
		
		String mid = multipartRequest.getParameter("mid")==null ? "": multipartRequest.getParameter("mid").trim();
		String pwd = multipartRequest.getParameter("pwd")==null ? "": multipartRequest.getParameter("pwd").trim();
		String nickName = multipartRequest.getParameter("nickName")==null ? "": multipartRequest.getParameter("nickName").trim();
		String name = multipartRequest.getParameter("name")==null ? "": multipartRequest.getParameter("name").trim();
		String name_ = name;
		String email1 = multipartRequest.getParameter("email1")==null ? "": multipartRequest.getParameter("email1").trim();
		String email2 = multipartRequest.getParameter("email2")==null ? "": multipartRequest.getParameter("email2").trim();
		String email = email1 + "@" + email2;
		String gender = multipartRequest.getParameter("gender")==null ? "": multipartRequest.getParameter("gender").trim();
		String birthday = multipartRequest.getParameter("birthday")==null ? "": multipartRequest.getParameter("birthday");
		String tel1 = multipartRequest.getParameter("tel1")==null ? "": multipartRequest.getParameter("tel1").trim();
		String tel2 = multipartRequest.getParameter("tel2")==null ? "": multipartRequest.getParameter("tel3").trim();
		String tel3 = multipartRequest.getParameter("tel3")==null ? "": multipartRequest.getParameter("tel3").trim();
		String tel = tel1 + "/" + tel2 + "/" + tel3;
		String address = multipartRequest.getParameter("address")==null ? "": multipartRequest.getParameter("address");
		String homePage = multipartRequest.getParameter("homePage")==null ? "": multipartRequest.getParameter("homePage").trim();
		String job = multipartRequest.getParameter("job")==null ? "": multipartRequest.getParameter("job").trim();
		String userInfor = multipartRequest.getParameter("userInfor")==null ? "": multipartRequest.getParameter("userInfor");
		String[] hobbys = multipartRequest.getParameterValues("hobby");
		String hobby = "";
		for(int i=0; i<hobbys.length; i++) {
			hobby += hobbys[i] + "/";
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		String content = multipartRequest.getParameter("content")==null ? "": multipartRequest.getParameter("content");
		
		MemberDAO dao = new MemberDAO();
		
		// 비밀번호 암호화 처리
		long intPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			intPwd = (long) pwd.charAt(i);
			strPwd += intPwd;
		}
		intPwd = Long.parseLong(strPwd);
		
		int pwdKey = (int) (Math.random()*20);
		long pwdValue = dao.getHashTableSearch(pwdKey);
		
		long encPwd;
		
		// 암호화 작업(인코딩)
		encPwd = intPwd ^ pwdValue;		// 원본비번과 암호키값을 배타적OR(exclusive OR)시킨다.
		strPwd = String.valueOf(encPwd);	// DB에 저장하기위해 문자료 변환했다.
		
		// 모든 체크 완료후 정확한 회원정보를 DB에 저장할 준비(vo)를 한다.
		MemberVO vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(strPwd);
		vo.setPwdKey(pwdKey);
		vo.setNickName(nickName);
		vo.setName(name_);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		
  	// 회원사진이 업로드(갱신)처리 되었을때 처리
		String fName = multipartRequest.getFilesystemName("fName");
		String photo = multipartRequest.getParameter("photo");
		if(fName != null) {
			vo.setPhoto(fName);
			if(!photo.equals("noimage.jpg")) {
				new File(realPath + "/" + photo).delete();
			}
		}
		else {
			vo.setPhoto(photo);
		}
		
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberUpdateOk(vo);
		
		if(res == 1) {  // 정상적으로 회원정보수정처리완료
			request.setAttribute("msg", "memberUpdateOk");
		}
		else {
			request.setAttribute("msg", "memberUpdateNo");
		}
		request.setAttribute("url", request.getContextPath()+"/memMain.mem");
	}
}
