CREATE TABLE IF NOT EXISTS student(
    id INT NOT NULL auto_increment PRIMARY KEY,
    last_name CHAR(255) NOT NULL,
    first_name CHAR(255) NOT NULL,
    paternal_name CHAR(255) NOT NULL,
    git CHAR(255),
    phone CHAR(255),
    email CHAR(255),
    telegram CHAR(255)
);