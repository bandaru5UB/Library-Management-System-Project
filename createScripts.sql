
CREATE TABLE publisher_details (
		publisher_name VARCHAR(100) PRIMARY KEY NOT NULL,
		publisher_address VARCHAR(200) NOT NULL,
		contact_number VARCHAR(50) NOT NULL
	);
	
CREATE TABLE library_branch_details (
		branch_id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
		branch_name VARCHAR(100) NOT NULL,
		branch_address VARCHAR(200) NOT NULL
	);
	
CREATE TABLE book_details (
		book_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
		title VARCHAR(200) NOT NULL,
		publisher_name VARCHAR(100) NOT NULL,
		branch_id INT NOT NULL,
		is_loaned BOOLEAN DEFAULT FALSE,
		CONSTRAINT fk_book_details_publisher_name FOREIGN KEY(publisher_name) REFERENCES publisher_details(publisher_name) ON UPDATE RESTRICT ON DELETE RESTRICT,
		CONSTRAINT fk_book_details_branchid FOREIGN KEY(branch_id) REFERENCES library_branch_details(branch_id) ON UPDATE RESTRICT ON DELETE RESTRICT
	);
	
CREATE TABLE student_details(
		student_id VARCHAR(10) PRIMARY KEY NOT NULL,
		first_name VARCHAR(50) NOT NULL,
		last_name VARCHAR(50) NOT NULL,
		email VARCHAR(30) NOT NULL,
		phone_number VARCHAR(20),
		dept_name VARCHAR(20) NOT NULL
		
	);
 

CREATE TABLE borrower_details (
		id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
		student_id VARCHAR(10) NOT NULL,
		due_amount INT NOT NULL DEFAULT 0,
		books_loaned INT NOT NULL DEFAULT 0,
		CONSTRAINT fk_borrower_details_student_id FOREIGN KEY(student_id) REFERENCES student_details(student_id) ON UPDATE RESTRICT ON DELETE RESTRICT
	);
	
	
CREATE TABLE book_loaned_details (
		loan_id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
		book_id INT NOT NULL ,
		branch_id INT NOT NULL ,
		student_id VARCHAR(10) NOT NULL,
		issue_date DATE NOT NULL,
		due_date DATE NOT NULL,
		returned_date DATE,
		CONSTRAINT fk_book_loaned_details_book_id FOREIGN KEY(book_id) REFERENCES book_details(book_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
		CONSTRAINT fk_book_loaned_details_branch_id FOREIGN KEY(branch_id) REFERENCES library_branch_details(branch_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
		CONSTRAINT fk_book_loaned_details_student_id FOREIGN KEY(student_id) REFERENCES student_details(student_id) ON UPDATE RESTRICT ON DELETE RESTRICT
	);