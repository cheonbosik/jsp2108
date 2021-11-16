<%@page import="member.MemberDAO"%>
<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../include/sCheck.jsp" %>
<%
  String mid = (String) session.getAttribute("sMid");

  MemberDAO dao = new MemberDAO();
  MemberVO vo = dao.loginCheck(mid);
  
  long decPwd;
	long intPwd = Long.parseLong(vo.getPwd());		// DB에 넣었던 strPwd를 다시 불러서 복호화를 위해 정수형으로 변환했다.
	long pwdValue  = (long) dao.getHashTableSearch(vo.getPwdKey());
	decPwd = intPwd ^ pwdValue;
	String strPwd = String.valueOf(decPwd);
	
	String result = "";
	char ch;
	for(int i=0; i<strPwd.length(); i+=2) {
		ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
		result += ch;
	}
	
	// 이메일 처리
	String[] email = vo.getEmail().split("@");
	String email1 = email[0];
	String email2 = email[1];
	
	// 전화번호
	String[] tel = vo.getTel().split("/");
	String tel1 = tel[0];
	String tel2 = (tel.length >= 2) ? tel[1] : "";
	String tel3 = (tel.length >= 3) ? tel[2] : "";
	
	// 주소
	String[] address = vo.getAddress().split("/");
	String address1 = address[0].trim();
	String address2 = address[1].trim();
	String address3 = address[2].trim();
	String address4 = address[3].trim();
	
	// 취미
	String[] hobby = {"등산","낚시","수영","독서","영화감상","바둑","축구","기타"};
	String[] hobbys = vo.getHobby().split("/");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memUpdate.jsp</title>
  <%@ include file="../../include/bs4.jsp" %>
  <!-- 아래는 다음 주소 API를 활용한 우편번호검색 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="<%=request.getContextPath()%>/js/woo.js"></script>
  <script>
  	var nickCheckOn = 0;
  	var nickCheckSw = 0;
  
  	// 닉네임 중복체크
    function nickCheck() {
    	var nickName = myform.nickName.value;
    	var url = "<%=request.getContextPath()%>/nickCheck.mem?nickName="+nickName;
    	
    	if(nickName=="") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
    	}
    	else {
    		nickCheckOn = 1;
    		nickCheckSw = 1;
    		window.open(url,"nWin","width=500px,height=250px");
    	}
    }
  	
  	function nickReset() {
  		nickCheckOn = 0;
  	}
    
  	// 회원수정폼 체크
    function fCheck() {
    	var pwd = myform.pwd.value;
    	var nickName = myform.nickName.value;
    	var name = myform.name.value;
    	var email1 = myform.email1.value;
    	
    	if(pwd == "") {
    		alert("비밀번호를 입력하세요");
    		myform.pwd.focus();
    	}
    	else if(nickName == "") {
    		alert("닉네임을 입력하세요");
    		myform.nickName.focus();
    	}
    	else if(name == "") {
    		alert("성명을 입력하세요");
    		myform.name.focus();
    	}
    	else if(email1 == "") {
    		alert("이메일을 입력하세요");
    		myform.email1.focus();
    	}
    	// 기타 추가 체크해야 할 항목들을 모두 체크하세요.
    	else {
    		if(nickCheckOn == 1 || nickCheckSw == 0) {
    			var postcode = myform.postcode.value;
    			var roadAddress = myform.roadAddress.value;
    			var detailAddress = myform.detailAddress.value;
    			var extraAddress = myform.extraAddress.value;
    			myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress
    			myform.submit();
    		}
    		else {
    			if(nickCheckOn == 0) {
    				alert("닉네임, 중복체크버튼을 눌러주세요!");
    			}
    		}
    	}
    }
  </script>
</head>
<body>
<%@ include file="../../include/header_home.jsp" %>
<%@ include file="../../include/nav.jsp" %>
<div class="container" style="padding:30px">
  <form name="myform" method="post" action="<%=request.getContextPath()%>/memUpdateOk.mem" class="was-validated">
    <h2>회 원 정 보 수 정</h2>
    <br/>
    <div class="form-group">
      아이디 : ${sMid}
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :<%=result%></label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" value="<%=result%>" maxlength="9" required/>    </div>
    <div class="form-group">
      <label for="nickname">닉네임 : &nbsp; &nbsp;<input type="button" value="닉네임 중복체크" class="btn btn-secondary" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" onkeyup="nickReset()"  placeholder="별명을 입력하세요." name="nickName" value="<%=vo.getNickName()%>" required/>
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" value="<%=vo.getName()%>" required/>
    </div>
    <div class="form-group">
      <label for="email">Email address:</label>
				<div class="input-group mb-3">
				  <input type="text" class="form-control" placeholder="Email" id="email1" name="email1" value="<%=email1%>" required/>
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="naver.com" <% if(email2.equals("naver.com")) { %>selected <% } %>>naver.com</option>
					    <option value="hanmail.net" <% if(email2.equals("hanmail.net")) { %>selected <% } %>>hanmail.net</option>
					    <option value="hotmail.com" <% if(email2.equals("hotmail.com")) { %>selected <% } %>>hotmail.com</option>
					    <option value="gmail.com" <% if(email2.equals("gmail.com")) { %>selected <% } %>>gmail.com</option>
					    <option value="nate.com" <% if(email2.equals("nate.com")) { %>selected <% } %>>nate.com</option>
					    <option value="yahoo.com" <% if(email2.equals("yahoo.com")) { %>selected <% } %>>yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" <% if(vo.getGender().equals("남자")) { %>checked<% } %>>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자" <% if(vo.getGender().equals("여자")) { %>checked<% } %>>여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
			<input type="date" name="birthday" value="<%=vo.getBirthday().substring(0, 10)%>" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" <% if(tel1.equals("010")) { %>selected<% } %>>010</option>
					    <option value="02" <% if(tel1.equals("02")) { %>selected<% } %>>서울</option>
					    <option value="031" <% if(tel1.equals("031")) { %>selected<% } %>>경기</option>
					    <option value="032" <% if(tel1.equals("032")) { %>selected<% } %>>인천</option>
					    <option value="041" <% if(tel1.equals("041")) { %>selected<% } %>>충남</option>
					    <option value="042" <% if(tel1.equals("042")) { %>selected<% } %>>대전</option>
					    <option value="043" <% if(tel1.equals("043")) { %>selected<% } %>>충북</option>
			        <option value="051" <% if(tel1.equals("051")) { %>selected<% } %>>부산</option>
			        <option value="052" <% if(tel1.equals("052")) { %>selected<% } %>>울산</option>
			        <option value="061" <% if(tel1.equals("061")) { %>selected<% } %>>전북</option>
			        <option value="062" <% if(tel1.equals("062")) { %>selected<% } %>>광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" value="<%=tel2%>" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" value="<%=tel3%>" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <input type="hidden" class="form-control" name="address"/>
      <input type="text" name="postcode" value="<%=address1%>" id="sample4_postcode" placeholder="우편번호">
			<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="roadAddress" value="<%=address2%>" id="sample4_roadAddress" size="50" placeholder="도로명주소">
			<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" name="detailAddress" value="<%=address3%>" id="sample4_detailAddress" size="30" placeholder="상세주소">
			<input type="text" name="extraAddress" value="<%=address4%>" id="sample4_extraAddress" placeholder="참고항목">
    </div>
    <div class="form-group">
	    <label for="homepage">Homepage address:</label>
	    <input type="text" class="form-control" name="homePage" value="<%=vo.getHomePage()%>" placeholder="이메일을 입력하세요." id="homePage"/>
	  </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <option <% if(vo.getJob().equals("학생")) { %>selected<% } %>>학생</option>
        <option <% if(vo.getJob().equals("회사원")) { %>selected<% } %>>회사원</option>
        <option <% if(vo.getJob().equals("공무원")) { %>selected<% } %>>공무원</option>
        <option <% if(vo.getJob().equals("군인")) { %>selected<% } %>>군인</option>
        <option <% if(vo.getJob().equals("의사")) { %>selected<% } %>>의사</option>
        <option <% if(vo.getJob().equals("법조인")) { %>selected<% } %>>법조인</option>
        <option <% if(vo.getJob().equals("세무인")) { %>selected<% } %>>세무인</option>
        <option <% if(vo.getJob().equals("자영업")) { %>selected<% } %>>자영업</option>
        <option <% if(vo.getJob().equals("기타")) { %>selected<% } %>>기타</option>
      </select>
    </div>
    <div class="form-group">
<!-- 
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="등산" name="hobby" />등산
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
 -->
      취미 : 
<%		for(int i=0; i<hobby.length; i++) { %>
				<input type="checkbox" name="hobby" value="<%=hobby[i]%>"
<%
				for(int j=0; j<hobbys.length; j++) {
					if(hobby[i].equals(hobbys[j])) {
%>
						checked
<%					break;
					}
				}
%>
				/><%=hobby[i]%> &nbsp;
<%		} %>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content"><%=vo.getContent()%></textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" <% if(vo.getUserInfor().equals("공개")) { %>checked<% } %>/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개" <% if(vo.getUserInfor().equals("비공개")) { %>checked<% } %>/>비공개
			  </label>
			</div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원정보수정</button>
    <button type="reset" class="btn btn-secondary">다시작성</button>
    <button type="button" class="btn btn-secondary" onclick="location.href='<%=request.getContextPath()%>/memMain.mem';">돌아가기</button>
    <input type="hidden" name="mid" value="${sMid}"/>
  </form>
  <p><br/></p>
</div>
<br/>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>