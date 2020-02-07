package bookshop.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {

	private static CartDBBean instance = new CartDBBean();

	public static CartDBBean getInstance() {
		return instance;
	}

	// constructor
	private CartDBBean() {
	}

	// 커넥션 풀로부터 커넥션 객체를 얻어내는 메소드
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/bookshopdb");

		return ds.getConnection();
	}

	// 장바구니에서 구매자가 선택한 책의 id에 해당하는 수량을 구한다.
	public byte getBookIdCount(String buyer, int bookId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		byte rtnCount = 0;

		try {
			conn = getConnection();
			// 한사람의 구매자가 같은 book_id를 여러개의 cart_id에 가지고 있을 수 있다.
			pstmt = conn.prepareStatement(sql);
			sql = "select sum(buy_count) ";
			sql += "from cart ";
			sql += "where buyer=? and book_id=?";
			pstmt.setString(1, buyer);
			pstmt.setInt(2, bookId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rtnCount = rs.getByte(1);
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
		return rtnCount;
	} // getBookIdCount() method

	// [장바구니에 담기] 버튼을 누르면 수행되는 메소드
	public void insertCart(CartDataBean cart) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "insert into cart ";
			sql += "(book_id, buyer, book_title, buy_price, buy_count, book_image) ";
			sql += "values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, cart.getBook_id());
			pstmt.setString(2, cart.getBuyer());
			pstmt.setString(3, cart.getBook_title());
			pstmt.setInt(4, cart.getBuy_price());
			pstmt.setByte(5, cart.getBuy_count());
			pstmt.setString(6, cart.getBook_image());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
	} // insertCart() method

	// buyer_id에 해당하는 레코드의 수를 구하는 메소드
	public int getListCount(String buyer_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int rtnCount = 0;

		try {
			conn = getConnection();
			sql = "select count(*) from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				rtnCount = rs.getInt(1);
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
		return rtnCount;
	} // getListCount() method

	// buyer_id에 해당하는 모든 레코드의 자료를 추출하는 메소드
	public List<CartDataBean> getCart(String buyer_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		CartDataBean cart = null;
		List<CartDataBean> lists = null;

		try {
			conn = getConnection();
			sql = "select * from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer_id);
			rs = pstmt.executeQuery();
			lists = new ArrayList<CartDataBean>();

			while (rs.next()) {
				cart = new CartDataBean();
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setBook_id(rs.getInt("book_id"));
				cart.setBook_title(rs.getString("book_title"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getByte("buy_count"));
				cart.setBook_image(rs.getString("book_image"));

				lists.add(cart);
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
		return lists;
	} // getCart() method

	// 장바구니에서 수량을 수정할 때 사용하는 메서드
	public void updateCount(int cart_id, byte count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "update cart set buy_count=? where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setByte(1, count);
			pstmt.setInt(2, cart_id);

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
	} // end - public void updateCount(int cart_id, byte count)

	// 구매자에 해당하는 모든 장바구니 비우기
	public void deleteAll(String buyer) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "delete from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			int rtnVal = pstmt.executeUpdate();

			if (rtnVal > 0) {
				System.out.println(rtnVal + "건이 삭제되었습니다.");
			} else {
				System.out.println("삭제하는데 문제가 발생하였습니다.");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
	} // end - public void deleteAll(String id)

	// 선택한 하나의 장바구니만 비우기
	public void deleteList(int cart_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			conn = getConnection();
			sql = "delete from cart where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			int rtnVal = pstmt.executeUpdate();

			if (rtnVal > 0) {
				System.out.println(rtnVal + "건이 삭제되었습니다.");
			} else {
				System.out.println("삭제하는데 문제가 발생하였습니다.");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
	} // end - public void deleteList(int cart_id)
}