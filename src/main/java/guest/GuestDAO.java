package guest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	GuestVO vo = null;
	
	private String url = "jdbc:mysql://localhost:3306/javacourse";
	private String user = "root";
	private String password = "1234";
	
	// 객체 생성시 DB연동하기
	public GuestDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색실패~~");
		} catch (SQLException e) {
			System.out.println("데이터베이스 연동실패~~~");
		}
	}
	
	// 객체 소멸시키기
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
				pstmtClose();
			} catch (SQLException e) {}
		}
	}
	
	// 전체 자료 검색
	public List<GuestVO> gList(int startIndexNo, int pageSize) {
		List<GuestVO> vos = new ArrayList<GuestVO>();
		try {
			sql = "select * from guest order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new GuestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setHomepage(rs.getString("homepage"));
				vo.setvDate(rs.getString("vDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		
		return vos;
	}

	// 방명록에 방문소감 등록하기
	public boolean gInputOk(GuestVO vo) {
		boolean res = false;
		try {
			sql = "insert into guest values (default,?,?,?,default,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomepage());
			pstmt.setString(4, vo.getHostIp());
			pstmt.setString(5, vo.getContent());
			pstmt.executeUpdate();
			res = true;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 방문소감 삭제처리
	public boolean gDelete(int idx) {
		boolean res = false;
		try {
			sql = "delete from guest where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = true;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	// 전체 레코드 건수
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			// sql = "select count(*) as cnt from guest";
			sql = "select count(*) from guest";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 사용자가 방명록에 올린 글의 수를 구해온다.
	public int getWriteCnt(String mid, String nickName, String name) {
		int guestCnt = 0;
		try {
			sql = "select count(*) from guest where name like ? or name like ? or name like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+mid+"%");
			pstmt.setString(2, "%"+nickName+"%");
			pstmt.setString(3, "%"+name+"%");
			rs = pstmt.executeQuery();
			rs.next();
			guestCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return guestCnt;
	}
}
