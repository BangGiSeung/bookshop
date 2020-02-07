package bookshop.shopping;

public class BuyBookKindDataBean {
	private int bookQty100;
	private int bookQty200;
	private int bookQty300;
	private int total;

	public int getBookQty100() {
		return bookQty100;
	}

	public void setBookQty100(int bookQty100) {
		this.bookQty100 = bookQty100;
	}

	public int getBookQty200() {
		return bookQty200;
	}

	public void setBookQty200(int bookQty200) {
		this.bookQty200 = bookQty200;
	}

	public int getBookQty300() {
		return bookQty300;
	}

	public void setBookQty300(int bookQty300) {
		this.bookQty300 = bookQty300;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	@Override
	public String toString() {
		return "[" + bookQty100 + ", " + bookQty200 + ", " + bookQty300 + ", " + total + "]";
	}

}
