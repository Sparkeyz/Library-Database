USE Library
-- This query initializes and fills the system with information

IF Exists (SELECT 1 FROM INFORMATION_SCHEMA.TABLES tbl_bookLoans)
		DROP TABLE  tbl_bookCopies, tbl_bookLoans, tbl_bookAuthors, tbl_book, tbl_publisher, tbl_borrower, tbl_libraryBranch;

CREATE TABLE tbl_publisher(
	publisher_name VARCHAR(50) PRIMARY KEY NOT NULL,
	publisher_address VARCHAR(50) NOT NULL,
	publisher_phone VARCHAR(50) NOT NULL
);

INSERT INTO tbl_publisher(publisher_name, publisher_address, publisher_phone)
	VALUES
	('Penguin Publishers', '2974 Southeast Polar Street', '642-237-8954'),
	('Bright Books', '3608 Northwest Blaze Avenue', '297-259-1536')
;

CREATE TABLE tbl_libraryBranch(
	branch_id INT PRIMARY KEY NOT NULL,
	branch_name VARCHAR(50) NOT NULL,
	branch_address VARCHAR(50) NOT NULL
);

INSERT INTO tbl_libraryBranch(branch_id, branch_name, branch_address)
	VALUES
	(1, 'Sharpstown', '1704 Point Place'),
	(2, 'Central', '1024 Clark Circle'),
	(3, 'Furton', '2018 Spring Street'),
	(4, 'Cascade', '1073 Fall Avenue')
;

CREATE TABLE tbl_book(
	book_id INT PRIMARY KEY NOT NULL,
	book_title VARCHAR(50) NOT NULL,
	book_publisherName VARCHAR(50) NOT NULL CONSTRAINT fk_publisherName FOREIGN KEY REFERENCES tbl_publisher(publisher_name) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO tbl_book (book_id, book_title, book_publisherName)
	VALUES
	(1, 'The Lost Tribe', 'Penguin Publishers'),
	(2, 'The Hobbit', 'Penguin Publishers'),
	(3, 'The Fellowship of the Ring', 'Penguin Publishers'),
	(4, 'The Two Towers', 'Penguin Publishers'),
	(5, 'The Return of the King', 'Penguin Publishers'),
	(6, 'Elantris', 'Penguin Publishers'),
	(7, 'Mistborn: The Final Empire', 'Penguin Publishers'),
	(8, 'The Way of Kings', 'Penguin Publishers'),
	(9, 'Words of Radiance', 'Penguin Publishers'),
	(10, 'The Lion, the Witch, and the Wardrobe', 'Penguin Publishers'),
	(11, 'Finders Keepers', 'Bright Books'),
	(12, 'Fahrenheit 451', 'Bright Books'),
	(13, '1984', 'Bright Books'),
	(14, 'Pride and Prejudice', 'Bright Books'),
	(15, 'Moby Dick', 'Bright Books'),
	(16, 'To Kill a Mockingbird', 'Bright Books'),
	(17, 'The Great Gatsby', 'Bright Books'),
	(18, 'Brave New World', 'Bright Books'),
	(19, 'A Clockwork Orange', 'Bright Books'),
	(20, 'Of Mice and Men', 'Bright Books')
;

CREATE TABLE tbl_bookAuthors (
	authors_bookId INT NOT NULL CONSTRAINT fk_bookId FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	authors_name VARCHAR(50) NOT NULL
);

INSERT INTO tbl_bookAuthors(authors_bookId, authors_name)
	VALUES
	(1, 'Mark Lee'),
	(2, 'J. R. R. Tolkien'),
	(3, 'J. R. R. Tolkien'),
	(4, 'J. R. R. Tolkien'),
	(5, 'J. R. R. Tolkien'),
	(6, 'Brandon Sanderson'),
	(7, 'Brandon Sanderson'),
	(8, 'Brandon Sanderson'),
	(9, 'Brandon Sanderson'),
	(10, 'C. S. Lewis'),
	(11, 'Stephen King'),
	(12, 'Ray Bradbury'),
	(13, 'George Orwell'),
	(14, 'Jane Austen'),
	(15, 'Herman Melville'),
	(16, 'Harper Lee'),
	(17, 'F. Scott Fitzgerald'),
	(18, 'Aldous Huxley'),
	(19, 'Anthony Burgess'),
	(20, 'John Steinbeck')
;

CREATE TABLE tbl_borrower (
	borrower_cardNo INT PRIMARY KEY NOT NULL,
	borrower_name VARCHAR(50) NOT NULL,
	borrower_address VARCHAR(50) NOT NULL,
	borrower_phone VARCHAR(50) NOT NULL
);

INSERT INTO tbl_borrower(borrower_cardNo, borrower_name, borrower_address, borrower_phone)
	VALUES
	(101, 'Bob', '808 St. James Place', '290-846-3512'),
	(102, 'Joe', '642 Atlantic Avenue', '654-334-2897'),
	(103, 'Sue', '264 Baltic Avenue', '032-897-4456'),
	(104, 'Sam', '658 Park Place', '401-289-6737'),
	(105, 'Ana', '185 Vetnor Avenue', '893-751-3428'),
	(106, 'Lux', '235 Marvin Gardens', '120-398-3747'),
	(107, 'Ren', '253 Boardwalk', '109-263-1654'),
	(108, 'Tet', '529 Pacific Avenue', '120-398-3324')
;

CREATE TABLE tbl_bookLoans (
	loans_bookId INT NOT NULL CONSTRAINT fk_bookId2 FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	loans_branchId INT NOT NULL CONSTRAINT fk_branchId FOREIGN KEY REFERENCES tbl_libraryBranch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	loans_cardNo INT NOT NULL CONSTRAINT fk_cardNo FOREIGN KEY REFERENCES tbl_borrower(borrower_cardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	loans_dateOut VARCHAR(50) NOT NULL,
	loans_dueDate VARCHAR(50) NOT NULL
);

INSERT INTO tbl_bookLoans(loans_bookId, loans_branchId, loans_cardNo, loans_dateOut, loans_dueDate)
	VALUES
	(1, '1', '101', '6-15', '6-22'), (1, '2', '103', '6-21', '6-28'),
	(1, '3', '104', '6-22', '6-29'), (2, '4', '105', '6-19', '6-26'),
	(2, '1', '102', '6-10', '6-17'), (2, '2', '107', '6-12', '6-19'),
	(3, '3', '105', '6-21', '6-28'), (3, '4', '107', '6-15', '6-22'),
	(3, '1', '101', '6-21', '6-28'), (4, '2', '102', '6-14', '6-21'),
	(4, '3', '103', '6-22', '6-29'), (4, '4', '104', '6-21', '6-28'),
	(5, '1', '106', '6-16', '6-23'), (6, '2', '106', '6-15', '6-22'),
	(6, '3', '103', '6-22', '6-29'), (6, '4', '102', '6-15', '6-22'),
	(6, '1', '101', '6-17', '6-24'), (7, '2', '102', '6-17', '6-24'),
	(7, '3', '104', '6-13', '6-20'), (8, '4', '105', '6-21', '6-28'),
	(8, '1', '107', '6-22', '6-29'), (8, '2', '103', '6-15', '6-22'),
	(9, '3', '102', '6-19', '6-26'), (9, '4', '103', '6-18', '6-25'),
	(9, '1', '101', '6-21', '6-28'), (10, '2', '105', '6-22', '6-29'),
	(11, '3', '106', '6-14', '6-21'), (11, '4', '107', '6-17', '6-24'),
	(11, '1', '105', '6-15', '6-22'), (12, '2', '101', '6-19', '6-26'),
	(12, '3', '103', '6-21', '6-28'), (13, '4', '105', '6-22', '6-29'),
	(14, '1', '106', '6-21', '6-28'), (15, '2', '107', '6-15', '6-22'),
	(16, '3', '103', '6-19', '6-26'), (16, '4', '102', '6-16', '6-23'),
	(16, '1', '101', '6-20', '6-27'), (17, '2', '102', '6-21', '6-28'),
	(17, '3', '104', '6-15', '6-22'), (18, '4', '102', '6-17', '6-24'),
	(18, '1', '101', '6-21', '6-28'), (18, '2', '103', '6-19', '6-26'),
	(18, '3', '104', '6-18', '6-25'), (19, '4', '106', '6-17', '6-24'),
	(19, '1', '107', '6-21', '6-28'), (20, '2', '106', '6-22', '6-29'),
	(20, '1', '104', '6-21', '6-28'), (20, '4', '102', '6-15', '6-22'),
	(20, '2', '101', '6-19', '6-26'), (20, '2', '107', '6-21', '6-28')
;

CREATE TABLE tbl_bookCopies (
	copies_bookId INT NOT NULL CONSTRAINT fk_bookId3 FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	copies_branchId INT NOT NULL CONSTRAINT fk_branchId2 FOREIGN KEY REFERENCES tbl_libraryBranch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	copies_noOfCopies INT NOT NULL
);

INSERT INTO tbl_bookCopies(copies_bookId, copies_branchId, copies_noOfCopies)
	VALUES
	(1, 1, 3), (1, 2, 5), (1, 3, 2), (1, 4, 4),
	(2, 1, 4), (2, 2, 5), (2, 3, 2), (2, 4, 4),
	(3, 1, 5), (3, 2, 5), (3, 3, 2), (3, 4, 4),
	(4, 1, 2), (4, 2, 5), (4, 3, 2), (4, 4, 4),
	(5, 1, 3), (5, 2, 5), (5, 3, 2), (5, 4, 4),
	(6, 1, 4), (6, 2, 5), (6, 3, 2), (6, 4, 4),
	(7, 1, 5), (7, 2, 5), (7, 3, 2), (7, 4, 4),
	(8, 1, 3), (8, 2, 5), (8, 3, 2), (8, 4, 4),
	(9, 1, 4), (9, 2, 5), (9, 3, 2), (9, 4, 4),
	(10, 1, 2), (10, 2, 5), (10, 3, 3), (10, 4, 5),
	(11, 1, 4), (11, 2, 5), (11, 3, 3), (11, 4, 5),
	(12, 1, 5), (12, 2, 5), (12, 3, 3), (12, 4, 5),
	(13, 1, 2), (13, 2, 5), (13, 3, 3), (13, 4, 5),
	(14, 1, 3), (14, 2, 5), (14, 3, 3), (14, 4, 5),
	(15, 1, 4), (15, 2, 5), (15, 3, 3), (15, 4, 5),
	(16, 1, 2), (16, 2, 5), (16, 3, 3), (16, 4, 5),
	(17, 1, 3), (17, 2, 5), (17, 3, 3), (17, 4, 5),
	(18, 1, 3), (18, 2, 5), (18, 3, 3), (18, 4, 5),
	(19, 1, 4), (19, 2, 5), (19, 3, 3), (19, 4, 5),
	(20, 1, 2), (20, 2, 5), (20, 3, 3), (20, 4, 5)
;

SELECT * FROM tbl_book;
SELECT * FROM tbl_bookAuthors;
SELECT * FROM tbl_bookCopies;
SELECT * FROM tbl_bookLoans;
SELECT * FROM tbl_borrower;
SELECT * FROM tbl_libraryBranch;
SELECT * FROM tbl_publisher;