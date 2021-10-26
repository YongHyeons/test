package purchase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import books.Books;

public class PurchaseDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public PurchaseDAO() {
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
	
	public int pcsgetNext() {
		String SQL = "SELECT purchaseNUM FROM PURCHASE ORDER BY purchaseNUM DESC";
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
	
	public int putCount(int booksID, String userID) {
		String SQL;
		PreparedStatement pstmt;
		SQL = "SELECT COUNT(*) FROM PURCHASE WHERE booksID = ? AND userID =  ? AND purchaseAvailable = 1 AND status = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, booksID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getInt(1) >= 1) {
				return 1;
			}
			else {
				return 2;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}return -1;
	}
	
	public int put(int booksID, String userID) {
		int check = putCount(booksID, userID);
		
		String SQL = "INSERT INTO PURCHASE VALUES (?, ?, ?, ?, now(), ?, ?)";
		try {
			PreparedStatement pstmt;
			if(check == 1 ) {
				SQL = "UPDATE PURCHASE SET volumes = volumes + 1 WHERE booksID = ? AND userID = ?";
				pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, booksID);
				pstmt.setString(2, userID);
				return pstmt.executeUpdate();
			}else if(check == 2) {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pcsgetNext());
			pstmt.setInt(2, booksID);
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setInt(5, 1);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int payment(int booksID, String userID) {
		String SQL = "INSERT INTO PURCHASE VALUES (?, ?, ?, ?, now(), ?, ?)";
		try {
			PreparedStatement pstmt;
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pcsgetNext());
			pstmt.setInt(2, booksID);
			pstmt.setString(3, userID);
			pstmt.setInt(4, 1);
			pstmt.setInt(5, 2);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int paymentAll(String userID) {
		String SQL = "UPDATE PURCHASE SET status = 2, purchaseDate = now() WHERE userID = ? AND status=1 AND purchaseAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Purchase> getListp(String userID){
		String SQL = "SELECT * FROM PURCHASE WHERE userID =  ? AND status = 2 AND purchaseAvailable = 1";
		ArrayList<Purchase> list = new ArrayList<Purchase>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Purchase purchase = new Purchase();
				purchase.setPurchaseNUM(rs.getInt(1));
				purchase.setBooksID(rs.getInt(2));
				purchase.setUserID(rs.getString(3));
				purchase.setVolumes(rs.getInt(4));
				purchase.setPurchaseDate(rs.getString(5));
				purchase.setStatus(rs.getInt(6));
				purchase.setPurchaseAvailable(rs.getInt(7));
				list.add(purchase);	
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Books> getbookList(String userID, int available, int status) {
		String SQL = "SELECT * from BOOKS WHERE booksID IN (SELECT booksID from PURCHASE WHERE userID = ? AND purchaseAvailable = ? AND status = ?);";
		
		ArrayList<Books> booklist = new ArrayList<Books>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);			
			pstmt.setString(1, userID);
			pstmt.setInt(2, available);
			pstmt.setInt(3, status);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Books books = new Books();
				books.setBooksID(rs.getInt(1));
				books.setBooksName(rs.getString(2));
				books.setAuthor(rs.getString(3));
				books.setPublisher(rs.getString(4));
				books.setPrice(rs.getString(5));
				books.setBooksAvailable(rs.getInt(6));
				booklist.add(books);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return booklist;
	}
	
	public int volumesget(int booksID, String userID, int available, int status) {
		String SQL= "SELECT volumes FROM PURCHASE WHERE booksID = ? AND userID = ? AND purchaseAvailable = ? AND status = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, booksID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, available);
			pstmt.setInt(4, status);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public String dateget(int booksID, String userID, int available, int status) {
		String SQL = "SELECT purchaseDate FROM PURCHASE WHERE booksID = ? AND userID = ? AND purchaseAvailable = ? AND status = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, booksID);
			pstmt.setString(2, userID);
			pstmt.setInt(3, available);
			pstmt.setInt(4, status);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getString(1);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}


	public int paytotal(int booksID, String userID) {
		String SQL = "SELECT volumes, bookID FROM PURCHASE WHERE userID = ? purchaseAvailable = 1";
		int c = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
			c = rs.getInt(1);
			}
			return c;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int deletebasket(int booksID, String userID) {
		String SQL = "UPDATE PURCHASE SET purchaseAvailable = 0 WHERE booksID =? AND userID = ? AND status=1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, booksID);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
