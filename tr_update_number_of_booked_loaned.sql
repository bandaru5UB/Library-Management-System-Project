CREATE OR REPLACE TRIGGER tr_update_number_of_booked_loaned
	AFTER UPDATE OF returned_date ON book_loaned_details
	FOR EACH ROW
	EXECUTE FUNCTION func_update_number_of_booked_loaned();