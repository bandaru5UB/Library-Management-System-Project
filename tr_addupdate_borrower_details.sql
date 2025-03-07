CREATE OR REPLACE TRIGGER tr_addupdate_borrower_details
	AFTER INSERT ON book_loaned_details
	FOR EACH ROW
	EXECUTE FUNCTION func_addupdate_borrower_details();
	