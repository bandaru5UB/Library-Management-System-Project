# 📚 Library Management System

## 📌 **Abstract**
This project presents a SQL-based **Library Management System** designed to streamline essential library functions.  
It provides **efficient record management** for students, books, and overdue records.  

---

## 🚀 **Problem Statement**
### **Inefficient Library Management and Record Keeping with Inaccurate Inventory Tracking**
Library systems often fail to provide **accurate real-time inventory data**, making it difficult to track book availability and overdue items.

This project **eliminates redundancy, improves maintenance, and ensures data consistency**.

**🎯 Project Goals**
- ✅ Provide **real-time book availability tracking**.
- ✅ Automate **borrowing and return transactions**.
- ✅ Prevent **data inconsistencies**.
- ✅ Enhance **security and data integrity**.

---

## 👥 **Target Users**
### **1. Who will use the database?**
- **📖 Students**: Borrow and return books.
- **🧑‍💻 Librarians**: Manage books and users.
- **🖥️ Automated Jobs & Triggers**: Handle overdue fines.

### **2. Who will administer the database?**
- **Library Management Team** 🎓
- **IT & Support Team** 💻
- **Data Analysts** 📊

---

## 📌 **Database Schema (BCNF Compliance)**
We verified that the database follows **Boyce-Codd Normal Form (BCNF)**:

| **Table**              | **Primary Key** | **Functional Dependencies (BCNF Check)** ✅ |
|------------------------|---------------|---------------------------------------------|
| `book_details`         | `book_id`     | `book_id → title, publisher_name, branch_id, is_loaned` |
| `student_details`      | `student_id`  | `student_id → first_name, last_name, email, phone_number, dept_name` |
| `publisher_details`    | `publisher_name` | `publisher_name → publisher_address, contact_number` |
| `library_branch_details` | `branch_id`  | `branch_id → branch_name, branch_address` |
| `book_loaned_details`  | `loan_id`     | `loan_id → book_id, branch_id, student_id, issue_date, due_date, returned_date` |
| `borrower_details`     | `id`          | `id → student_id, due_amount, books_loaned` |

> ✅ **All determinants are superkeys, ensuring BCNF compliance.**

---

## **🛠️ Components**
### **📄 Tables**
- 📘 `student_details` – Student information.
- 📕 `publisher_details` – Publisher records.
- 📚 `book_details` – Books in the library.
- 🏢 `library_branch_details` – Library branches.
- 🔖 `book_loaned_details` – Loaned book tracking.
- 🔄 `borrower_details` – Borrowers and dues.

### **🔧 Functions**
- `func_addupdate_borrower_details()` – Auto-updates borrower details.
- `func_update_number_of_booked_loaned()` – Updates books when returned.

### **🔥 Triggers**
- `tr_addupdate_borrower_details` – Fires when a book is loaned.
- `tr_update_number_of_booked_loaned` – Fires when a book is returned.

### **⏰ Scheduled Jobs**
- `refreshBorrowerDetails` – Updates overdue books daily.

### **⚡ Stored Procedures**
- `sp_updatedues()` – Updates overdue fines.
- `sp_add_book_loaned_details()` – Handles book loans.

---

## 📌 **SQL Queries**
### **1️⃣ Return a Book**
```sql
UPDATE book_loaned_details 
SET returned_date = (SELECT CURRENT_DATE) 
WHERE student_id = 'ST0402' AND book_id = 5087 AND returned_date IS NULL;

