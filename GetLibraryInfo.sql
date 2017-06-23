-- USE Library

CREATE PROCEDURE getLibraryInfo
AS
BEGIN


	-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
	SELECT 
		a3.copies_noOfCopies AS 'Copies of "The Lost Tribe" at Sharpstown'
		FROM tbl_bookCopies a3 
		INNER JOIN tbl_libraryBranch a6 ON a3.copies_branchId = a6.branch_id
		INNER JOIN tbl_book a1 ON a3.copies_bookId = a1.book_id
		WHERE a6.branch_name = 'Sharpstown' AND a1.book_title = 'The Lost Tribe';

	-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?
	SELECT 
		a6.branch_name AS 'Library Branch', a3.copies_noOfCopies AS 'Copies of "The Lost Tribe"'
		FROM tbl_bookCopies a3 
		INNER JOIN tbl_libraryBranch a6 ON a3.copies_branchId = a6.branch_id
		INNER JOIN tbl_book a1 ON a3.copies_bookId = a1.book_id
		WHERE a1.book_title = 'The Lost Tribe';

	-- Retrieve the names of all borrowers who do not have any books checked out.
	SELECT DISTINCT
		borrower_name AS 'Borrowers with no books checked out'
		FROM tbl_borrower
		WHERE borrower_cardNo NOT IN(SELECT DISTINCT loans_cardNo FROM tbl_bookLoans);

	/*  For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the 
		book title, the borrower's name, and the borrower's address. */
	SELECT 
		a1.book_title AS 'Book Title', a5.borrower_name AS 'Borrower Name', a5.borrower_address AS 'Borrower Address'
		FROM tbl_bookLoans a4
		INNER JOIN tbl_book a1 ON a4.loans_bookId = a1.book_id
		INNER JOIN tbl_borrower a5 ON a4.loans_cardNo = a5.borrower_cardNo
		INNER JOIN tbl_libraryBranch a6 ON a4.loans_branchId = a6.branch_id
		WHERE a6.branch_name = 'Sharpstown' AND a4.loans_dueDate = '6-22'; -- Today is June 22nd, 2017

	-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
	SELECT DISTINCT
		a6.branch_name AS 'Library Branch', c.counting AS 'Books lent out'
		FROM tbl_bookLoans a4
		INNER JOIN tbl_libraryBranch a6 ON a4.loans_branchId = a6.branch_id
		INNER JOIN (SELECT loans_branchId, count(*) AS counting FROM tbl_bookLoans GROUP BY loans_branchId) 
		c ON a4.loans_branchId = c.loans_branchId;

	-- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
	SELECT DISTINCT
		a5.borrower_name AS 'Borrower Name', a5.borrower_address AS 'Borrower Address', c.counting AS 'Books lent out'
		FROM tbl_bookLoans a4
		INNER JOIN tbl_borrower a5 ON a4.loans_cardNo = a5.borrower_cardNo
		INNER JOIN (SELECT loans_cardNo, count(*) AS counting FROM tbl_bookLoans GROUP BY loans_cardNo) 
		c ON a4.loans_cardNo = c.loans_cardNo;

	/*  For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the 
		library branch whose name is "Central". */
	SELECT 
		a1.book_title AS 'Book Title', a3.copies_noOfCopies AS 'Number of Copies at Central'
		FROM tbl_bookCopies a3
		INNER JOIN tbl_book a1 ON a3.copies_bookId = a1.book_id
		INNER JOIN tbl_libraryBranch a6 ON a3.copies_branchId = a6.branch_id
		INNER JOIN tbl_bookAuthors a2 ON a2.authors_bookId = a1.book_id
		WHERE a6.branch_name = 'Central' AND a2.authors_name = 'Stephen King';
END

EXECUTE [dbo].[getLibraryInfo]