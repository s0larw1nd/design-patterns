CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    patronymics VARCHAR(100) NOT NULL,
    telegram VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(30),
    birth_date DATE,
    git VARCHAR(100)
);