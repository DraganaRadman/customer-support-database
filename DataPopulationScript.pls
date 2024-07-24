/* 
An exemplary dataset for a Customer Support Database to practice versatile SQL 
queries across multiple tables.

Note: For optimal data integrity and error management, please execute each 
INSERT ALL statement separately for each table. This approach ensures that 
any issues can be addressed more effectively and that data is accurately 
inserted into each table without impacting the entire dataset. Additionally, 
it facilitates easier updates and modifications to the data population script.
*/

-- Initial set of sample data for the Departments table
INSERT ALL
INTO Departments (DepartmentName, DepartmentHead, DepartmentEmail, Location, PhoneNumber, Description) 
VALUES ('Technical Support', NULL, 'techsupport@example.com', 'Building A', '123-456-7890', 'Handles technical issues and troubleshooting')
INTO Departments (DepartmentName, DepartmentHead, DepartmentEmail, Location, PhoneNumber, Description) 
VALUES ('Customer Service', NULL, 'customerservice@example.com', 'Building B', '098-765-4321', 'Handles general customer inquiries and support')
INTO Departments (DepartmentName, DepartmentHead, DepartmentEmail, Location, PhoneNumber, Description)
VALUES ('Billing', NULL, 'billing@example.com', 'Building C', '111-222-3333', 'Handles billing and payment issues')
INTO Departments (DepartmentName, DepartmentHead, DepartmentEmail, Location, PhoneNumber, Description)
VALUES ('Sales', NULL, 'sales@example.com', 'Building D', '444-555-6666', 'Handles sales inquiries and orders')
SELECT * FROM dual;
COMMIT;

-- Initial set of sample data for the Agents table
INSERT ALL
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID) 
VALUES ('Alice', 'Johnson', 'Available', 1)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID) 
VALUES ('Bob', 'Smith', 'Available', 1)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID) 
VALUES ('Charlie', 'Brown', 'Unavailable', 2)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID) 
VALUES ('David', 'Williams', 'Available', 3)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID) 
VALUES ('Eve', 'Davis', 'Available', 4)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID) 
VALUES ('Frank', 'Miller', 'Unavailable', 3)
SELECT * FROM dual;
COMMIT;

-- Update Departments with DepartmentHead
UPDATE departments SET departmenthead = (SELECT AgentID FROM Agents WHERE FirstName = 'Alice') 
WHERE DepartmentName = 'Technical Support';
UPDATE Departments SET DepartmentHead = (SELECT AgentID FROM Agents WHERE FirstName = 'Charlie') 
WHERE DepartmentName = 'Customer Service';
UPDATE Departments SET DepartmentHead = (SELECT AgentID FROM Agents WHERE FirstName = 'David') 
WHERE DepartmentName = 'Billing';
UPDATE Departments SET DepartmentHead = (SELECT AgentID FROM Agents WHERE FirstName = 'Eve') 
WHERE DepartmentName = 'Sales';
COMMIT;

-- Initial set of sample data for the Customers table
INSERT ALL
INTO Customers (FirstName, LastName, Email, Phone, Address, City) 
VALUES ('Daniel', 'Williams', 'daniel.williams@example.com', '555-6789', '202 Birch St', 'Shelbyville')
INTO Customers (FirstName, LastName, Email, Phone, Address, City) 
VALUES ('Jessica', 'Brown', 'jessica.brown@example.com', '555-9876', '303 Cedar St', 'Springfield')
INTO Customers (FirstName, LastName, Email, Phone, Address, City)
VALUES ('Chris', 'Miller', 'chris.miller@example.com', '555-5432', '404 Walnut St', 'Shelbyville')
INTO Customers (FirstName, LastName, Email, Phone, Address, City)
VALUES ('Laura', 'Wilson', 'laura.wilson@example.com', '555-7654', '505 Cherry St', 'Capital City')
SELECT * FROM dual;
COMMIT;

-- Initial set of sample data for the Tickets table
INSERT ALL 
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (1, 1, 'Cannot login to account', 'I am unable to login to my account using my credentials.', 'Open', 'High', 
TO_TIMESTAMP('2024-07-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (2, 4, 'Payment issue', 'I was charged twice for my order.', 'Open', 'Medium', 
TO_TIMESTAMP('2024-07-05 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 10:30:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (3, 1, 'Technical issue with software', 'The software crashes when I try to open it.', 'Open', 'High', 
TO_TIMESTAMP('2024-07-05 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 11:45:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (4, 3, 'Order not received', 'I have not received my order placed 2 weeks ago.', 'Pending', 'Low', 
TO_TIMESTAMP('2024-07-05 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (1, 4, 'Billing error', 'I was billed incorrectly for my last purchase.', 'Resolved', 'High', 
TO_TIMESTAMP('2024-07-05 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 13:15:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (2, 5, 'Product inquiry', 'Can you provide more information about product X?', 'Open', 'Low', 
TO_TIMESTAMP('2024-07-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (3, 6, 'Subscription cancellation', 'I want to cancel my subscription.', 'Open', 'Medium', 
TO_TIMESTAMP('2024-07-05 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (1, 1, 'Password reset', 'I need to reset my password.', 'Resolved', 'Medium', 
TO_TIMESTAMP('2024-07-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (4, 6, 'Refund request', 'I want a refund for my last purchase.', 'Resolved', 'High', 
TO_TIMESTAMP('2024-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (3, 3, 'Shipping delay', 'My order is delayed.', 'Pending', 'Low', 
TO_TIMESTAMP('2024-07-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM dual;
COMMIT;

-- Initial set of sample data for the TicketHistory table
INSERT ALL
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (1, 'Open', 1, NULL, TO_TIMESTAMP('2024-07-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Alice.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (2, 'Open', 4, NULL, TO_TIMESTAMP('2024-07-05 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to David.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (3, 'Open', 1, NULL, TO_TIMESTAMP('2024-07-05 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Alice.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (4, 'Pending', 3, NULL, TO_TIMESTAMP('2024-07-05 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Charlie.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (5, 'Resolved', 4, NULL, TO_TIMESTAMP('2024-07-05 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket resolved by David.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (6, 'Open', 5, NULL, TO_TIMESTAMP('2024-07-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Eve.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (7, 'Open', 6, NULL, TO_TIMESTAMP('2024-07-05 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Frank.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (8, 'Resolved', 1, NULL, TO_TIMESTAMP('2024-07-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket resolved by Alice.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (9, 'Resolved', 6, NULL, TO_TIMESTAMP('2024-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket resolved by Frank.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (10, 'Pending', 3, NULL, TO_TIMESTAMP('2024-07-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Charlie.')
SELECT * FROM dual;
COMMIT;

-- Initial set of sample data for the Comments table
INSERT ALL
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (1, 1, NULL, 'I have reset your password, please check your email.', TO_TIMESTAMP('2024-07-05 09:30:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (2, 4, NULL, 'We are looking into the payment issue.', TO_TIMESTAMP('2024-07-05 11:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (3, 1, NULL, 'Please provide more details about the software issue.', TO_TIMESTAMP('2024-07-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (4, 3, NULL, 'We are checking the order status.', TO_TIMESTAMP('2024-07-05 13:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (5, 4, NULL, 'Billing issue has been resolved.', TO_TIMESTAMP('2024-07-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (6, 5, NULL, 'Product information sent via email.', TO_TIMESTAMP('2024-07-05 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (7, 6, NULL, 'Subscription cancellation process initiated.', TO_TIMESTAMP('2024-07-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (8, 1, NULL, 'Password reset instructions sent.', TO_TIMESTAMP('2024-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (9, 6, NULL, 'Refund processed.', TO_TIMESTAMP('2024-07-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (10, 3, NULL, 'Shipping delay due to high demand.', TO_TIMESTAMP('2024-07-05 19:00:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM dual;
COMMIT;

-- Initial set of sample data for the Attachments table
INSERT ALL
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath) 
VALUES (1, 'login_issue_screenshot.png', 'image/png', 204800, NULL, 1, TO_TIMESTAMP('2024-07-05 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_1/login_issue_screenshot.png')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (2, 'payment_receipt.pdf', 'application/pdf', 102400, NULL, 2, TO_TIMESTAMP('2024-07-05 10:45:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_2/payment_receipt.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (3, 'error_log.txt', 'text/plain', 51200, NULL, 3, TO_TIMESTAMP('2024-07-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_3/error_log.txt')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (4, 'order_confirmation.pdf', 'application/pdf', 102400, NULL, 4, TO_TIMESTAMP('2024-07-05 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_4/order_confirmation.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (5, 'billing_statement.pdf', 'application/pdf', 102400, NULL, 1, TO_TIMESTAMP('2024-07-05 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_5/billing_statement.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (6, 'product_brochure.pdf', 'application/pdf', 102400, 5, NULL, TO_TIMESTAMP('2024-07-05 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_6/product_brochure.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (7, 'subscription_details.pdf', 'application/pdf', 102400, NULL, 3, TO_TIMESTAMP('2024-07-05 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_7/subscription_details.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (8, 'password_reset_instructions.pdf', 'application/pdf', 102400, 1, NULL, TO_TIMESTAMP('2024-07-05 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_8/password_reset_instructions.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (9, 'refund_receipt.pdf', 'application/pdf', 102400, 6, NULL, TO_TIMESTAMP('2024-07-05 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_9/refund_receipt.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath) 
VALUES (10, 'shipping_update.pdf', 'application/pdf', 102400, 3, NULL, TO_TIMESTAMP('2024-07-05 18:15:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_10/shipping_update.pdf')
SELECT * FROM dual;
COMMIT;

-- Additional set of sample data for the Agents table.
-- This set includes new agents added to the database.
INSERT ALL
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID)
VALUES ('Grace', 'Moore', 'Available', 2)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID)
VALUES ('Henry', 'Taylor', 'Unavailable', 3)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID)
VALUES ('Isabella', 'Anderson', 'Available', 4)
INTO Agents (FirstName, LastName, AvailabilityStatus, DepartmentID)
VALUES ('Jack', 'Thomas', 'Available', 1)
SELECT * FROM dual;
COMMIT;

-- Additional set of sample data for the Customers table.
-- This set includes new customers added to the database.
INSERT ALL
INTO Customers (FirstName, LastName, Email, Phone, Address, City)
VALUES ('Emma', 'White', 'emma.white@example.com', '555-1122', '606 Pine St', 'Springfield')
INTO Customers (FirstName, LastName, Email, Phone, Address, City)
VALUES ('Michael', 'Green', 'michael.green@example.com', '555-3344', '707 Oak St', 'Capital City')
INTO Customers (FirstName, LastName, Email, Phone, Address, City) 
VALUES ('Olivia', 'Black', 'olivia.black@example.com', '555-5566', '808 Maple St', 'Shelbyville')
INTO Customers (FirstName, LastName, Email, Phone, Address, City) 
VALUES ('Ethan', 'Clark', 'ethan.clark@example.com', '555-7788', '909 Elm St', 'Springfield')
SELECT * FROM dual;
COMMIT;

-- Additional set of sample data for the Tickets table.
-- This set includes new tickets added to the database.
INSERT ALL
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (5, 2, 'Account locked', 'My account has been locked after multiple failed login attempts.', 'Open', 'High', 
TO_TIMESTAMP('2024-07-06 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 08:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (6, 7, 'Refund status', 'I have not received my refund yet.', 'Pending', 'Medium', 
TO_TIMESTAMP('2024-07-06 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 09:15:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (7, 8, 'Incorrect billing', 'I was billed for an item I did not purchase.', 'Open', 'High', 
TO_TIMESTAMP('2024-07-06 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 10:30:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (8, 9, 'Product not delivered', 'My product was not delivered as expected.', 'Pending', 'Low', 
TO_TIMESTAMP('2024-07-06 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 11:45:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (1, 10, 'Login issue', 'Unable to login after password reset.', 'Resolved', 'Medium', 
TO_TIMESTAMP('2024-07-06 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 12:30:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (2, 1, 'Shipping address update', 'I need to update my shipping address for my order.', 'Open', 'Low', 
TO_TIMESTAMP('2024-07-06 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 13:45:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (3, 3, 'Payment not processed', 'My payment for the order was not processed.', 'Open', 'High', 
TO_TIMESTAMP('2024-07-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (4, 5, 'Product return request', 'I want to return the product I purchased.', 'Resolved', 'Medium', 
TO_TIMESTAMP('2024-07-06 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 16:15:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (5, 4, 'Duplicate charge', 'I was charged twice for the same order.', 'Pending', 'High', 
TO_TIMESTAMP('2024-07-06 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Tickets (CustomerID, AgentID, Subject, Description, Status, Priority, CreatedAt, LastUpdated) 
VALUES (6, 6, 'Subscription renewal', 'I need help with renewing my subscription.', 'Open', 'Medium', 
TO_TIMESTAMP('2024-07-06 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 18:45:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM dual;
COMMIT;

-- Additional set of sample data for the TicketHistory table.
-- This set includes new ticket history entries added to the database.
INSERT ALL
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (11, 'Open', 2, NULL, TO_TIMESTAMP('2024-07-06 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Bob.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (12, 'Pending', 7, NULL, TO_TIMESTAMP('2024-07-06 09:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Grace.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (13, 'Open', 8, NULL, TO_TIMESTAMP('2024-07-06 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Henry.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (14, 'Pending', 9, NULL, TO_TIMESTAMP('2024-07-06 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Isabella.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (15, 'Resolved', 10, NULL, TO_TIMESTAMP('2024-07-06 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket resolved by Jack.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (16, 'Open', 1, NULL, TO_TIMESTAMP('2024-07-06 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Alice.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (17, 'Open', 3, NULL, TO_TIMESTAMP('2024-07-06 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Charlie.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (18, 'Resolved', 5, NULL, TO_TIMESTAMP('2024-07-06 16:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket resolved by Eve.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (19, 'Pending', 4, NULL, TO_TIMESTAMP('2024-07-06 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to David.')
INTO TicketHistory (TicketID, Status, AgentID, CustomerID, ChangedAt, Description) 
VALUES (20, 'Open', 6, NULL, TO_TIMESTAMP('2024-07-06 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), 'Ticket created and assigned to Frank.')
SELECT * FROM dual;
COMMIT;

-- Additional set of sample data for the Comments table.
-- This set includes new comments added to the database.
INSERT ALL
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (11, 11, 2, NULL, 'Please verify your identity by answering the security questions.', TO_TIMESTAMP('2024-07-06 08:05:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (12, 12, 7, NULL, 'We are looking into your refund request and will update you shortly.', TO_TIMESTAMP('2024-07-06 09:20:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (13, 13, 8, NULL, 'Please provide additional details about the incorrect billing.', TO_TIMESTAMP('2024-07-06 10:35:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (14, 14, 9, NULL, 'We are investigating the delay in your product delivery.', TO_TIMESTAMP('2024-07-06 11:50:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (15, 15, 10, NULL, 'Your login issue has been resolved. Please try logging in again.', TO_TIMESTAMP('2024-07-06 12:35:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (16, 16, 1, NULL, 'Please provide your new shipping address.', TO_TIMESTAMP('2024-07-06 13:50:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (17, 17, 3, NULL, 'We are processing your payment. Please wait for a confirmation.', TO_TIMESTAMP('2024-07-06 15:05:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (18, 18, 5, NULL, 'Your product return request has been approved.', TO_TIMESTAMP('2024-07-06 16:20:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (19, 19, 4, NULL, 'We are looking into the duplicate charge issue.', TO_TIMESTAMP('2024-07-06 17:35:00', 'YYYY-MM-DD HH24:MI:SS'))
INTO Comments (CommentID, TicketID, AgentID, CustomerID, CommentText, CreatedAt) 
VALUES (20, 20, 6, NULL, 'Your subscription renewal request is being processed.', TO_TIMESTAMP('2024-07-06 18:50:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM dual;
COMMIT;

-- Additional set of sample data for the Attachments table.
-- This set includes new attachments added to the database.
INSERT ALL
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath) 
VALUES (11, 'account_locked_screenshot.png', 'image/png', 204800, NULL, 5, TO_TIMESTAMP('2024-07-06 08:10:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_11/account_locked_screenshot.png')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (12, 'refund_status_receipt.pdf', 'application/pdf', 102400, 7, NULL, TO_TIMESTAMP('2024-07-06 09:25:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_12/refund_status_receipt.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (13, 'incorrect_billing_screenshot.png', 'image/png', 204800, NULL, 7, TO_TIMESTAMP('2024-07-06 10:40:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_13/incorrect_billing_screenshot.png')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (14, 'product_not_delivered_proof.pdf', 'application/pdf', 102400, 9, NULL, TO_TIMESTAMP('2024-07-06 11:50:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_14/product_not_delivered_proof.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (15, 'login_issue_instructions.pdf', 'application/pdf', 102400, 10, NULL, TO_TIMESTAMP('2024-07-06 12:35:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_15/login_issue_instructions.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (16, 'shipping_address_update.pdf', 'application/pdf', 102400, 1, NULL, TO_TIMESTAMP('2024-07-06 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_16/shipping_address_update.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (17, 'payment_not_processed_receipt.pdf', 'application/pdf', 102400, 3, NULL, TO_TIMESTAMP('2024-07-06 15:05:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_17/payment_not_processed_receipt.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (18, 'product_return_request.pdf', 'application/pdf', 102400, 5, NULL, TO_TIMESTAMP('2024-07-06 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_18/product_return_request.pdf')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (19, 'duplicate_charge_screenshot.png', 'image/png', 204800, 4, NULL, TO_TIMESTAMP('2024-07-06 17:35:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_19/duplicate_charge_screenshot.png')
INTO Attachments (TicketID, FileName, FileType, FileSize, AgentID, CustomerID, UploadedAt, FilePath)
VALUES (20, 'subscription_renewal_instructions.pdf', 'application/pdf', 102400, 6, NULL, TO_TIMESTAMP('2024-07-06 18:50:00', 'YYYY-MM-DD HH24:MI:SS'), '/attachments/ticket_20/subscription_renewal_instructions.pdf')
SELECT * FROM dual;
COMMIT;

-- Additional sample data: Insert a new agent into the Agents table
INSERT INTO agents (firstname, lastname, availabilitystatus, departmentid)
VALUES ('Vera', 'Bolkvadze', 'Available', 2);
COMMIT;


