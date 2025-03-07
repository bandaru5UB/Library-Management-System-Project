CREATE OR REPLACE FUNCTION func_addupdate_borrower_details()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
	$$
	BEGIN
		UPDATE book_details set is_loaned=TRUE WHERE book_id=NEW.book_id;
		IF NEW.student_id IN (SELECT DISTINCT student_id FROM borrower_details) THEN
			UPDATE borrower_details set books_loaned=books_loaned+1 WHERE student_id=NEW.student_id;
		END IF;
		IF NEW.student_id NOT IN (SELECT DISTINCT student_id FROM borrower_details) THEN
			INSERT INTO borrower_details(student_id,due_amount,books_loaned) values(NEW.student_id,0,1);
		END IF;
		
		RETURN NEW;
	END;
	$$		