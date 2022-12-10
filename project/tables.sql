CREATE TABLE publisher(
name VARCHAR(50) NOT NULL PRIMARY KEY,
address VARCHAR(200),
email VARCHAR(50),
banking_account VARCHAR(20)
);

CREATE TABLE publisher_phone(
publisher_name VARCHAR(50) NOT NULL,
phone VARCHAR(15) NOT NULL,
PRIMARY KEY(publisher_name, phone),
CONSTRAINT FK_publisher_phone FOREIGN KEY(phone)
REFERENCES publisher(name)
);

CREATE TABLE book(
isbn VARCHAR(18) NOT NULL PRIMARY KEY,
book_name VARCHAR(30) NOT NULL,
publisher_name VARCHAR(50),
pages int CHECK(pages > 0),
purchase_price numeric(6,2) CHECK(purchase_price > 0),
sale_price numeric(6,2) CHECK(sale_price > 0),
transfer_percentage numeric(4,2) CHECK(transfer_percentage >0 and transfer_percentage < 1),
stock_quantity int CHECK(stock_quantity >= 0),
CONSTRAINT FK_book_publisher_name FOREIGN KEY(publisher_name)
REFERENCES publisher(name)
);

CREATE TABLE purchase(
purchase_id INT AUTO_INCREMENT,
book_isbn VARCHAR(18) NOT NULL,
purchase_date DATE DEFAULT NOW(),
quantity int CHECK(quantity > 0),
CONSTRAINT FK_purchase_book_isbn FOREIGN KEY(book_isbn)
REFERENCES book(isbn)
);

CREATE TABLE genre(
book_isbn VARCHAR(18),
genre VARCHAR(30),
PRIMARY KEY(book_isbn, genre),
CONSTRAINT FK_genre_book_isbn FOREIGN KEY(book_isbn)
REFERENCES genre(isbn)
);

CREATE TABLE author(
book_isbn VARCHAR(18),
author_name VARCHAR(50),
PRIMARY KEY(book_isbn, author),
CONSTRAINT FK_author_book_isbn FOREIGN KEY(book_isbn)
REFERENCES book(isbn)
);

CREATE TABLE user(
user_id VARCHAR(30) PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
phone VARCHAR(15) NOT NULL,
email VARCHAR(50),
address VARCHAR(200),
pwd VARCHAR(30) NOT NULL,
user_type VARCHAR(6) CHECK(user_type in ('admin','customer'))
);

CREATE TABLE orders(
order_id VARCHAR(150) PRIMARY KEY,
user_id VARCHAR(30),
order_date DATE NOT NULL,
amount NUMERIC(8,2),
shipping_date DATE,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
shipping_address VARCHAR(200) NOT NULL,
shipping_status VARCHAR(50),
transfer_status VARCHAR(10) CHECK (transfer_status in ('wait','payment')),
CONSTRAINT FK_order_user_id FOREIGN KEY(user_id)
REFERENCES user(user_id)
);

CREATE TABLE order_detail(
order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
order_id VARCHAR(150) NOT NULL,
book_isbn VARCHAR(18),
quantity INT CHECK(quanitty > 0),
CONSTRAINT FK_order_detail_order_id FOREIGN KEY(order_id)
REFERENCES orders(order_id),
CONSTRAINT FK_order_detail_book_isbn FOREIGN KEY(book_isbn)
REFERENCES book(isbn)
);




