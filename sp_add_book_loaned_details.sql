CREATE OR REPLACE PROCEDURE sp_add_book_loaned_details(book_title VARCHAR(200), branch VARCHAR(100), student_id VARCHAR(10))
LANGUAGE plpgsql
AS
$$
DECLARE bookid INTEGER; branchid INTEGER;
BEGIN
	--- GET branch_id------
	SELECT branch_id INTO branchid
	FROM library_branch_details 
	WHERE branch_name=branch;
	
	-----GET the book_id--------------									
	SELECT book_id INTO bookid
	FROM book_details 
	WHERE title=book_title
	and branch_id =branchid 
	and is_loaned=FALSE
	ORDER BY book_id desc
	FETCH FIRST 1 ROWS ONLY;
	
	INSERT INTO book_loaned_details(book_id,branch_id,student_id,issue_date,due_date) 
	VALUES (bookid,branchid,student_id,CURRENT_DATE,CURRENT_DATE+7);
	
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'book not available';
END
$$;