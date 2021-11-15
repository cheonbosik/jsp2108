package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;

	// 아이디 중복체크 처리
	public String idCheck(String mid) {
		String name = "";
		try {
			sql = "select * from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	// 닉네임 중복체크
	public String nickCheck(String nickName) {
		String name = "";
		try {
			sql = "select * from member where nickName = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	// hashTable에서 pwdKey에 해당하는 pwdValue을 찾아서 돌려준다. 
	public long getHashTableSearch(int pwdKey) {
		long pwdValue = 0;
		try {
			sql = "select * from hashTable where pwdKey = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pwdKey);
			rs = pstmt.executeQuery();
			rs.next();
			pwdValue = rs.getLong("pwdValue");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return pwdValue;
	}

	// 신규 회원 가입처리
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values (default,?,?,?,?,?,default,default,?,?,?,?,?,?,default,?,?,default,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setInt(3, vo.getPwdKey());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getName());
			pstmt.setString(6, vo.getTel());
			pstmt.setString(7, vo.getAddress());
			pstmt.setString(8, vo.getEmail());
			pstmt.setString(9, vo.getHomePage());
			pstmt.setString(10, vo.getJob());
			pstmt.setString(11, vo.getHobby());
			pstmt.setString(12, vo.getContent());
			pstmt.setString(13, vo.getUserInfor());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return res;
	}
			
}
