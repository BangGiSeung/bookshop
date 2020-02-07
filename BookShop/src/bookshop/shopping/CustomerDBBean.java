package bookshop.shopping;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CustomerDBBean {

	private static CustomerDBBean instance = new CustomerDBBean();

	public static CustomerDBBean getInstance() {
		return instance;
	}

	// 생성자
	public CustomerDBBean() {
	}

	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/bookshopdb");

		return ds.getConnection();
	}

	// id가 존재하는 지 검사
	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rtnVal = 0;
		String sql = "";

		try {
			conn = getConnection();
			sql = "SELECT id FROM member WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rtnVal = 1; // id에 해당하는 회원이 존재하면
			} else {
				rtnVal = -1; // id에 해당하는 회원이 존재하지 않으면
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		}
		return rtnVal;

	} // end - public int confirmId(String id) throws Exception

	// 회원가입
	public void insertMember(CustomerDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "INSERT INTO member VALUES(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setTimestamp(4, member.getReg_date());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
					pstmt.close();
			if (conn != null)
					conn.close();
		}
	} // End - public void insertMember(CustomerDBBean member) throws Exception

	// 등록된 회원인지 검사한다.
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int rtnVal = -1;
		String dbpasswd = "";

		try {
			conn = getConnection();
			sql = "SELECT passwd FROM member WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) { // id에 해당하는 자료가 있으면
				dbpasswd = rs.getString("passwd");

				if (dbpasswd.equals(passwd)) { // 비밀번호가 맞으면
					rtnVal = 1; // 인증성공
				} else {
					rtnVal = 0; // 비밀번호 틀림
				}
			} else {
				// id에 해당하는 자료가 없으면 등록된 회원이 아니다.
				rtnVal = -1;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
					rs.close();
			if (pstmt != null)
					pstmt.close();
			if (conn != null)
					conn.close();
		}
		return rtnVal;
	} // End - public int userCheck(String id, String passwd) throws Exception

	// id에 해당하는 정보를 추출한다.
	public CustomerDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		CustomerDataBean member = null;

		try {
			conn = getConnection();
			sql = "SELECT * FROM member WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new CustomerDataBean();

				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
					rs.close();
			if (pstmt != null)
					pstmt.close();
			if (conn != null)
					conn.close();
		}
		return member;
	} // End - public CustomerDataBean getMember(String id) throws Exception

	// 회원정보 수정
	public void updateMember(CustomerDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "UPDATE member SET passwd=?, name=?, tel=?, address=? " + "WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getTel());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getId());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
					pstmt.close();
			if (conn != null)
					conn.close();
		}
	} // End - public void updateMember(CustomerDataBean member) throws
		// Exception

	// 회원 탈퇴
	public int deleteMember(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String dbpasswd = "";
		int rtnVal = -1;

		try {
			conn = getConnection();
			sql = "SELECT passwd FROM member WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(passwd)) {
					sql = "";
					sql = "DELETE FROM member WHERE id=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					rtnVal = 1;
				} else {
					rtnVal = 0;
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
					rs.close();
			if (pstmt != null)
					pstmt.close();
			if (conn != null)
					conn.close();
		}
		return rtnVal;
	} // End - public int deleteMember(String id, String passwd) throws
		// Exception

}