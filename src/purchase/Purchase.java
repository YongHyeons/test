package purchase;

public class Purchase {

	private int purchaseNUM;
	private int booksID;
	private String userID;
	private int volumes;
	private String purchaseDate;
	private int status;
	private int purchaseAvailable;
	public int getPurchaseNUM() {
		return purchaseNUM;
	}
	public void setPurchaseNUM(int purchaseNUM) {
		this.purchaseNUM = purchaseNUM;
	}
	public int getBooksID() {
		return booksID;
	}
	public void setBooksID(int booksID) {
		this.booksID = booksID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getVolumes() {
		return volumes;
	}
	public void setVolumes(int volumes) {
		this.volumes = volumes;
	}
	public String getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getPurchaseAvailable() {
		return purchaseAvailable;
	}
	public void setPurchaseAvailable(int purchaseAvailable) {
		this.purchaseAvailable = purchaseAvailable;
	}
	
	
}
