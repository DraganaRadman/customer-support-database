/*
Customer Support Database

Description:
This script creates the schema for a Customer Support database, designed to manage and track
customer support tickets, agent assignments, and departmental responsibilities. 

Tables Included:
  - Customers: Stores customer information.
  - Agents: Stores information about support agents.
  - Departments: Stores information about support departments.
  - Tickets: Stores customer support tickets.
  - Comments: Stores comments made on support tickets by both agents and customers.
  - TicketHistory: Tracks changes and updates to support tickets.
  - Attachments: Stores files attached to support tickets.

Each table is designed with relevant constraints to ensure data integrity and enforce
relationships between entities, supporting efficient management and querying of
customer support activities.
*/

/* 
Table: Customers

Description: This table stores information about customers who interact with the customer support system.
Each customer has a unique identifier and associated personal information including first name, last name,
email, phone number, address, and city. The table ensures that each customer has a unique identifier and
primary contact details.
*/

CREATE TABLE Customers (
  CustomerID number NOT NULL,
  FirstName varchar2(50) NOT NULL,
  LastName varchar2(50) NOT NULL,
  Email varchar2(254) NOT NULL,
  Phone varchar2(50),
  Address varchar2(255),
  City varchar2(100),
  CONSTRAINT CustPK PRIMARY KEY (CustomerID)  
);

/*
Table: Agents

Description: Stores information about support agents who handle customer inquiries.
Each agent is associated with a department and has a unique identifier, first name, last name,
and availability status.
*/

CREATE TABLE Agents (
  AgentID number NOT NULL,
  FirstName varchar2(50) NOT NULL,
  LastName varchar2(50) NOT NULL,
  AvailabilityStatus varchar2(50) NOT NULL,
  DepartmentID number NOT NULL,
  CONSTRAINT AgtPK PRIMARY KEY (AgentID)  
);

/*
Table: Departments

Description: Stores information about departments responsible for handling customer support.
Each department has a unique identifier, name, head, contact email, location, phone number,
and description.
*/

CREATE TABLE Departments (
  DepartmentID number NOT NULL,
  DepartmentName varchar2(150) NOT NULL,
  DepartmentHead number,
  DepartmentEmail varchar2(254),
  Location varchar2(200),
  PhoneNumber varchar2(50),
  Description varchar2(500),
  CONSTRAINT DeptPK PRIMARY KEY (DepartmentID)
  ); 

-- Adds foreigns key constraint to Agents table referencing Departments
-- AgtDeptFK (FOREIGN KEY): Links the agent to the department they belong to.
ALTER TABLE Agents
ADD CONSTRAINT AgtDeptFK FOREIGN KEY (DepartmentID) REFERENCES Departments (DepartmentID);

-- Adds foreign key constraint to Departments table referencing Agents
-- DeptAgtFK (FOREIGN KEY): Links the department to its head agent.
ALTER TABLE Departments
ADD CONSTRAINT DeptAgtFK FOREIGN KEY (DepartmentHead) REFERENCES Agents (AgentID);

/*
Table: Tickets

Description: Stores customer support tickets with details such as customer, agent, subject,
description, status, priority, creation time, and last update time.

Constraints:
  TktPK (PRIMARY KEY): Ensures each ticket has a unique identifier.
  TktCustFK (FOREIGN KEY): Links the ticket to the customer who created it.
  TktAgtFK (FOREIGN KEY): Links the ticket to the agent assigned to it.
*/

CREATE TABLE Tickets (
  TicketID number NOT NULL,
  CustomerID number NOT NULL,
  AgentID number,
  Subject varchar2(255) NOT NULL,
  Description varchar2(500), 
  Status varchar2(50) NOT NULL,
  Priority varchar2(50) NOT NULL,
  CreatedAt TIMESTAMP NOT NULL,
  LastUpdated TIMESTAMP,
  CONSTRAINT TktPK PRIMARY KEY (TicketID),
  CONSTRAINT TktCustFK FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
  CONSTRAINT TktAgtFK FOREIGN KEY (AgentID) REFERENCES Agents (AgentID)
);

/*
Table: TicketHistory

Description: Tracks changes and updates to support tickets, including status changes and modifications.

Constraints:
  HisPK (PRIMARY KEY): Ensures each history entry has a unique identifier.
  HisTktFK (FOREIGN KEY): Links the history entry to the ticket it belongs to.
  HisAgtFK (FOREIGN KEY): Links the history entry to the agent involved in the change.
  HisCustFK (FOREIGN KEY): Links the history entry to the customer involved in the change.
  changeMadeByCheck (CHECK): Ensures that a change is made either by an agent or a customer, but not both.
*/

CREATE TABLE TicketHistory (
  HistoryID number NOT NULL,
  TicketID number NOT NULL,
  Status varchar2(50) NOT NULL,
  AgentID number,
  CustomerID number,
  ChangedAt TIMESTAMP NOT NULL,
  Description varchar2(500),
  CONSTRAINT HisPK PRIMARY KEY (HistoryID),
  CONSTRAINT HisTktFK FOREIGN KEY (TicketID) REFERENCES Tickets (TicketID) ON DELETE CASCADE,
  CONSTRAINT HisAgtFK FOREIGN KEY (AgentID) REFERENCES Agents (AgentID),
  CONSTRAINT HisCustFK FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
  CONSTRAINT changeMadeByCheck CHECK (
    (AgentID IS NOT NULL AND CustomerID IS NULL) OR
    (CustomerID IS NOT NULL AND AgentID IS NULL)
  )
); 

/*
Table: Comments

Description: Stores comments made on support tickets by agents and customers.

Constraints:
  CmtPK (PRIMARY KEY): Ensures each comment has a unique identifier.
  CmtTktFK (FOREIGN KEY): Links the comment to the ticket it belongs to.
  CmtAgtFK (FOREIGN KEY): Links the comment to the agent who made it.
  CmtCustFK (FOREIGN KEY): Links the comment to the customer who made it.
  CmtMadeByCheck (CHECK): Ensures that a comment is made either by an agent or a customer, but not both.
*/

CREATE TABLE Comments (
  CommentID number NOT NULL,
  TicketID number NOT NULL,
  AgentID number,
  CustomerID number,
  CommentText varchar2(2000),
  CreatedAt TIMESTAMP NOT NULL,
  CONSTRAINT CmtPK PRIMARY KEY (CommentID),
  CONSTRAINT CmtTktFK FOREIGN KEY (TicketID) REFERENCES Tickets (TicketID) ON DELETE CASCADE,
  CONSTRAINT CmtAgtFK FOREIGN KEY (AgentID) REFERENCES Agents (AgentID),
  CONSTRAINT CmtCustFK FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
  CONSTRAINT CmtMadeByCheck CHECK (
    (AgentID IS NOT NULL AND CustomerID IS NULL) OR
    (CustomerID IS NOT NULL AND AgentID IS NULL)
  )
);

/*
Table: Attachments

Description: Stores files attached to support tickets by agents and customers.

Constraints:
  AtchPK (PRIMARY KEY): Ensures each attachment has a unique identifier.
  AtchTktFK (FOREIGN KEY): Links the attachment to the ticket it belongs to.
  AtchAgtFK (FOREIGN KEY): Links the attachment to the agent who uploaded it.
  AtchCustFK (FOREIGN KEY): Links the attachment to the customer who uploaded it.
  AtchUploadedByCheck (CHECK): Ensures that an attachment is uploaded either by an agent or a customer, but not both.
*/

CREATE TABLE Attachments (
  AttachmentID number NOT NULL,
  TicketID number NOT NULL,
  FileName varchar2(255) NOT NULL,
  FileType varchar2(50) NOT NULL,
  FileSize number NOT NULL,
  AgentID number,
  CustomerID number,
  UploadedAt TIMESTAMP NOT NULL,
  FilePath varchar2(255) NOT NULL,
  AttachmentDescription varchar2(255),
  CONSTRAINT AtchPK PRIMARY KEY (AttachmentID),
  CONSTRAINT AtchTktFK FOREIGN KEY (TicketID) REFERENCES Tickets (TicketID) ON DELETE CASCADE,
  CONSTRAINT AtchAgtFK FOREIGN KEY (AgentID) REFERENCES Agents (AgentID),
  CONSTRAINT AtchCustFK FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
  CONSTRAINT AtchUploadedByCheck CHECK (
    (AgentID IS NOT NULL AND CustomerID IS NULL) OR
    (CustomerID IS NOT NULL AND AgentID IS NULL)
  )
);

/*
We use ON DELETE CASCADE for TicketID in related tables like TicketHistory, Comments, and Attachments.
If a ticket is deleted, associated history entries, comments, and attachments should also be deleted 
because they are closely tied to the ticket and are not meaningful without it.
*/

-- Create the sequences
-- Used to generate unique, sequential values for primary key columns

-- Create a sequence to generate unique CustomerID values
CREATE SEQUENCE cust_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;

-- Create a sequence to generate unique AgentID values
CREATE SEQUENCE agt_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;

-- Create a sequence to generate unique DepartmentID values
CREATE SEQUENCE dept_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;

-- Create a sequence to generate unique TicketID values
CREATE SEQUENCE tkt_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;

-- Create a sequence to generate unique HistoryID values
CREATE SEQUENCE his_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;

-- Create a sequence to generate unique CommentID values
CREATE SEQUENCE cmt_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;

-- Create a sequence to generate unique AttachmentID values
CREATE SEQUENCE atch_seq
MINVALUE 1
START WITH 1 
INCREMENT BY 1
CACHE 20;


-- Create the triggers
-- Auto-generating primary key values using sequences before inserting rows into tables

-- Create a trigger to automatically assign a unique CustomerID before inserting a new row in the Customers table
CREATE OR REPLACE TRIGGER cust_on_insert
  BEFORE INSERT ON Customers
  FOR EACH ROW
BEGIN
  SELECT cust_seq.nextval
  INTO :new.CustomerID
  FROM dual;
END;
/

-- Create a trigger to automatically assign a unique AgentID before inserting a new row in the Agents table
CREATE OR REPLACE TRIGGER agt_on_insert
  BEFORE INSERT ON Agents
  FOR EACH ROW
BEGIN
  SELECT agt_seq.nextval
  INTO :new.AgentID
  FROM dual;
END;
/

-- Create a trigger to automatically assign a unique DepartmentID before inserting a new row in the Departments table
CREATE OR REPLACE TRIGGER dept_on_insert
  BEFORE INSERT ON Departments
  FOR EACH ROW
BEGIN
  SELECT dept_seq.nextval
  INTO :new.DepartmentID
  FROM dual;
END;
/

-- Create a trigger to automatically assign a unique TicketID before inserting a new row in the Tickets table
CREATE OR REPLACE TRIGGER tkt_on_insert
  BEFORE INSERT ON Tickets
  FOR EACH ROW
BEGIN
  SELECT tkt_seq.nextval
  INTO :new.TicketID
  FROM dual;
END;
/

-- Create a trigger to automatically assign a unique HistoryID before inserting a new row in the TicketHistory table
CREATE OR REPLACE TRIGGER his_on_insert
  BEFORE INSERT ON TicketHistory
  FOR EACH ROW
BEGIN
  SELECT his_seq.nextval
  INTO :new.HistoryID
  FROM dual;
END;
/

-- Create a trigger to automatically assign a unique CommentID before inserting a new row in the Comments table
CREATE OR REPLACE TRIGGER cmt_on_insert
  BEFORE INSERT ON Comments
  FOR EACH ROW
BEGIN
  SELECT cmt_seq.nextval
  INTO :new.CommentID
  FROM dual;
END;
/

-- Create a trigger to automatically assign a unique AttachmentID before inserting a new row in the Attachments table
CREATE OR REPLACE TRIGGER atch_on_insert
  BEFORE INSERT ON Attachments
  FOR EACH ROW
BEGIN
  SELECT atch_seq.nextval
  INTO :new.AttachmentID
  FROM dual;
END;
/



