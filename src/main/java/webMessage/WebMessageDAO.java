package webMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;

public class WebMessageDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	WebMessageVO vo = null;

	// 메세지 가져오기...(전체메세지/새메지/보낸메세지/휴지통....)
	public List<WebMessageVO> getWebMessageList(String mid, int mSw, int startIndexNo, int pageSize) {
		List<WebMessageVO> vos = new ArrayList<WebMessageVO>();
		try {
			if(mSw == 1) {	// 받은메세지처리(전체메세지 가져오기)
				sql = "select * from webMessage where receiveId=? and (receiveSw='n' or receiveSw='r') order by idx desc limit ?,?";
			}
			else if(mSw == 2) {	// 새 메세지처리
				sql = "select * from webMessage where receiveId=? and receiveSw='n' order by idx desc limit ?,?";
			}
			else if(mSw == 3) {	// 보낸 메세지처리
				sql = "select * from webMessage where sendId=? and sendSw='s' order by idx desc limit ?,?";
			}
			else if(mSw == 4) {	// 수신 메세지 확인처리
				sql = "select * from webMessage where sendId=? and receiveSw='n' order by idx desc limit ?,?";
			}
			else if(mSw == 5) {	// 휴지통 메세지 확인처리
				sql = "select * from webMessage where (receiveId=? and receiveSw='g') or (sendId=? and sendSw='g') order by idx desc limit ?,?";
			}
			else {	// mSw가 0일때는 새메세지 작성처리임...
				return vos;
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if(mSw == 5) {
				pstmt.setString(2, mid);
				pstmt.setInt(3, startIndexNo);
				pstmt.setInt(4, pageSize);
			}
			else {
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new WebMessageVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveDate(rs.getString("receiveDate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 메세지 저장하기(전송하기)
	public int setWmInputOk(WebMessageVO vo) {
		int res = 0;
		try {
			sql = "select mid from member where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getReceiveId());
			rs = pstmt.executeQuery();
			if(!rs.next()) return res;
			getConn.pstmtClose();
			
			sql = "insert into webMessage values (default,?,?,?,'s',default,?,'n',default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getSendId());
			pstmt.setString(4, vo.getReceiveId());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 한건의 메세지 내용 보기
	public WebMessageVO getWmMessageOne(int idx, String mid) {
		vo = new WebMessageVO();
		try {
			// 신규메세지를 읽게되면 receiveSw의 'n'을 'r'로 변경처리
			sql = "update webMessage set receiveSw='r', receiveDate=now() where idx=? and receiveId=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "select * from webMessage where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveDate(rs.getString("receiveDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 휴지통으로 이동하기
	// 받은메세지를 휴지통으로 이동시킬때는 receiveSw를 'g'로 변경처리
//	public int wmDeleteCheck(int idx, String mFlag) {
	public int wmDeleteCheck(int idx, int mSw) {
		int res = 0;
		try {
//			if(mSw.equals("s")) {
			if(mSw == 11) {
				sql = "update webMessage set sendSw = 'g' where idx = ?";
			}
			else {
				sql = "update webMessage set receiveSw = 'g' where idx = ?";
			}
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

	// 메세지 휴지통에서 삭제처리(receiveSw의 'g'를 'x'로 변경처리, sendeSw의 'g'를 'x'로 변경처리
	public void wmDeleteAll(String mid) {
		try {
			sql = "update webMessage set receiveSw = 'x' where receiveId = ? and receiveSw = 'g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "update webMessage set sendSw = 'x' where sendId = ? and sendSw = 'g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 새 메세지의 개수 담아오기
	public int getnewMessageCnt(String mid) {
		int getnewMessageCnt = 0;
		try {
			sql = "select count(*) from webMessage where receiveId=? and receiveSw='n'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			rs.next();
			getnewMessageCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return getnewMessageCnt;
	}

	// 페이징처리를 위한 총 레코드건수 구해오기
	public int totRecCnt(String mid, int mSw) {
		int totRecCnt = 0;
		try {
			if(mSw == 1) {			// 받은메세지처리(전체메세지 가져오기)
				sql = "select count(*) from webMessage where receiveId=? and (receiveSw='n' or receiveSw='r') order by idx desc";
			}
			else if(mSw == 2) {	// 새 메세지처리
				sql = "select count(*) from webMessage where receiveId=? and receiveSw='n' order by idx desc";
			}
			else if(mSw == 3) {	// 보낸 메세지처리
				sql = "select count(*) from webMessage where sendId=? and sendSw='s' order by idx desc";
			}
			else if(mSw == 4) {	// 수신 메세지 확인처리
				sql = "select count(*) from webMessage where sendId=? and receiveSw='n' order by idx desc";
			}
			else if(mSw == 5) {	// 휴지통 메세지 확인처리
				sql = "select count(*) from webMessage where (receiveId=? and receiveSw='g') or (sendId=? and sendSw='g') order by idx desc";
			}
			else { return totRecCnt; }	// mSw=0 일때는 입력처리임..
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if(mSw == 5) pstmt.setString(2, mid);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}
	
}
