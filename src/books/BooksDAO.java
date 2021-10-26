package books;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BooksDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BooksDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT NOW";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
				return rs.getString(1);
		}catch (Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public int getNext() {
		String SQL = "SELECT booksID FROM BOOKS ORDER BY booksID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int booksEnrollment(String booksName, String author, String publisher, String price) {
		String SQL = "INSERT INTO BOOKS VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, booksName);
			pstmt.setString(3, author);
			pstmt.setString(4, publisher);
			pstmt.setString(5, price);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Books> getList(int pageNumber){
		String SQL = "SELECT * FROM BOOKS WHERE booksID < ? AND booksAvailable = 1 ORDER BY booksID DESC LIMIT 10";
		ArrayList<Books> list = new ArrayList<Books>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) *10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Books books = new Books();
				books.setBooksID(rs.getInt(1));
				books.setBooksName(rs.getString(2));
				books.setAuthor(rs.getString(3));
				books.setPublisher(rs.getString(4));
				books.setPrice(rs.getString(5));
				books.setBooksAvailable(rs.getInt(6));
				list.add(books);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BOOKS WHERE booksID < ? AND booksAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) *10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public Books getBooks(int booksID) {
		String SQL = "SELECT * FROM BOOKS WHERE booksID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, booksID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Books books = new Books();
				books.setBooksID(rs.getInt(1));
				books.setBooksName(rs.getString(2));
				books.setAuthor(rs.getString(3));
				books.setPublisher(rs.getString(4));
				books.setPrice(rs.getString(5));
				books.setBooksAvailable(rs.getInt(6));
				return books;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public int update(int booksID, String booksName, String author, String publisher, String price) {
		String SQL = "UPDATE BOOKS SET booksName = ?, author =?, publisher = ?, price = ? WHERE booksID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, booksName);
			pstmt.setString(2, author);
			pstmt.setString(3, publisher);
			pstmt.setString(4, price);
			pstmt.setInt(5, booksID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int booksID) {
		String SQL = "UPDATE BOOKS SET booksAvailable = 0 WHERE booksID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, booksID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
