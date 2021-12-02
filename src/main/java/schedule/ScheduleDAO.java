package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class ScheduleDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	ScheduleVO vo = null;

	// 스케줄관리 등록후 조회/수정
	public ScheduleVO getScContent(String ymd, String mid) {
		vo = new ScheduleVO();
	  try {
			sql = "select * from schedule where date(sDate) = ? and mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ymd);
			pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(mid);
				vo.setPart(rs.getString("part"));
				vo.setsDate(rs.getString("sDate"));
				vo.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 일정관리 등록 및 수정 처리하기
	public int setScContentOk(ScheduleVO vo) {
		int res = 0;
		try {
			if(vo.getIdx() == 0) {
				sql = "insert into schedule values (default,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMid());
				pstmt.setString(2, vo.getsDate());
				pstmt.setString(3, vo.getPart());
				pstmt.setString(4, vo.getContent());
			}
			else {
				sql = "update schedule set part=?, content=? where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getPart());
				pstmt.setString(2, vo.getContent());
				pstmt.setInt(3, vo.getIdx());
			}
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 일정 삭제하기
	public int setScDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from schedule where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
}
