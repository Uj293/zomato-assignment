CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderDetails (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);




SELECT Books.title, SUM(OrderDetails.quantity) as total_sold
FROM OrderDetails
JOIN Books ON OrderDetails.book_id = Books.book_id
GROUP BY Books.title
ORDER BY total_sold DESC
LIMIT 10;

SELECT SUM(Books.price * OrderDetails.quantity) as total_revenue
FROM OrderDetails
JOIN Books ON OrderDetails.book_id = Books.book_id
JOIN Orders ON OrderDetails.order_id = Orders.order_id
WHERE Orders.order_date BETWEEN 'start_date' AND 'end_date';
