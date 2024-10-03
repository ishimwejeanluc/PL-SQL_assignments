-- Creating the database
CREATE DATABASE librarymanagemebtsystem;

--Creating tables
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    ISBN VARCHAR(13) UNIQUE,
    PublishedDate DATE,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255)
);
CREATE TABLE BorrowingRecords (
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert a new category
INSERT INTO Category (CategoryID, CategoryName)
VALUES (1, 'Thriller');
INSERT INTO Category (CategoryID, CategoryName)
VALUES (2, 'Action');

-- Insert a new book
INSERT INTO Books (BookID, Title, Author, ISBN, PublishedDate, CategoryID)
VALUES (1, 'Jack ryan', 'F. Scott Fitzgerald', '9780743273565', '2017-04-10', 1);
INSERT INTO Books (BookID, Title, Author, ISBN, PublishedDate, CategoryID)
VALUES (2, 'Dead in the river', 'Tom clancy', '9780743273565', '2019-04-10', 2);
-- Update the author's name for a specific book
UPDATE Books
SET Author = 'Fitzgerald'
WHERE BookID = 1;
-- Delete a book record
DELETE FROM Books
WHERE BookID = 1;
-- Retrieve a list of books along with their category names
SELECT B.Title, B.Author, C.CategoryName
FROM Books B
JOIN Category C ON B.CategoryID = C.CategoryID;

-- retrieve book records
SELECT * FROM Books
-- Using a subquery to find books borrowed by a specific member
SELECT B.Title
FROM Books B
WHERE B.BookID IN (
    SELECT BR.BookID
    FROM BorrowingRecords BR
    WHERE BR.MemberID = 1
);
