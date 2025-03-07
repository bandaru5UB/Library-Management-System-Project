CREATE OR REPLACE FUNCTION func_update_number_of_booked_loaned()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
	$$
	BEGIN
		----update that the book is not loaned anymore--
		UPDATE book_details SET is_loaned=FALSE WHERE book_id=NEW.book_id;
		
		--- update borrower details,by reducing the number of book on the student name--
		IF (NEW.returned_date-OLD.due_date)>0 THEN
			UPDATE borrower_details 
			set books_loaned=books_loaned-1,due_amount=due_amount-(NEW.returned_date-OLD.due_date)*5 
			WHERE student_id=NEW.student_id;
		END IF;
		IF (NEW.returned_date-OLD.due_date)<0 THEN
			UPDATE borrower_details 
			set books_loaned=books_loaned-1 
			WHERE student_id=NEW.student_id;
		END IF;
		RETURN NEW;
	END;
	$$		