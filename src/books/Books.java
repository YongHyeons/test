package books;

public class Books {

	private int booksID;
	private String booksName;
	private String author;
	private String publisher;
	private String price;
	private int booksAvailable;
	public int getBooksID() {
		return booksID;
	}
	public void setBooksID(int booksID) {
		this.booksID = booksID;
	}
	public String getBooksName() {
		return booksName;
	}
	public void setBooksName(String booksName) {
		this.booksName = booksName;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getBooksAvailable() {
		return booksAvailable;
	}
	public void setBooksAvailable(int booksAvailable) {
		this.booksAvailable = booksAvailable;
	}

}
