/*
   Description:
   This script contains SQL queries designed for practice with the customer support database. 
   It includes a variety of operations such as data selection, filtering, aggregation, analysis, 
   and JOINs to combine data from multiple tables.

   Instructions:
   - Ensure that the customer support database is set up and populated with the necessary tables 
     and data before running this script.
   - Execute each query to practice different SQL techniques and operations.
   - Review and modify queries as necessary to fit your practice goals and database schema.

   Notes:
   - Queries are written for Oracle SQL and may need adjustments for other SQL dialects.
*/

-- Retrieve the first and last names of customers along with the number of tickets they have submitted, ordered by the number of tickets in descending order.
SELECT c.firstname, c.lastname, COUNT(t.ticketid) AS TicketCount 
FROM customers c INNER JOIN tickets t
ON c.customerid = t.customerid
GROUP BY c.firstname, c.lastname
ORDER BY COUNT(t.ticketid) DESC;

-- List all customers who have submitted more than 2 support tickets in the last year.
SELECT c.customerid, c.firstname, c.lastname, COUNT(t.ticketid) AS TicketCount  
FROM customers c INNER JOIN tickets t
ON c.customerid = t.customerid 
WHERE t.createdat >= ADD_MONTHS(SYSDATE, -12)
GROUP BY c.customerid, c.firstname, c.lastname
HAVING COUNT(t.ticketid) > 2;

-- Retrieve the ticket details along with the customer’s first name and last name for tickets that are still in progress.
SELECT t.ticketid, c.firstname || ' ' || c.lastname CustomerName, t.subject, t.description, t.status, t.priority, t.createdat, t.lastupdated  
FROM customers c INNER JOIN tickets t
ON c.customerid = t.customerid
WHERE t.status IN ('Open', 'Pending')
ORDER BY t.ticketid;

-- Retrieve the information of customers who have multiple unresolved tickets.
SELECT c.customerid, c.firstname, c.lastname, c.email, c.phone, c.address, c.city, COUNT(t.ticketid) AS UnresolvedTickets 
FROM customers c INNER JOIN tickets t
ON c.customerid = t.customerid
WHERE t.status IN ('Open', 'Pending')
GROUP BY c.customerid, c.firstname, c.lastname, c.email, c.phone, c.address, c.city
HAVING COUNT(t.ticketid) > 1;

-- Find the number of tickets handled by each agent.
SELECT a.agentid, a.firstname, a.lastname, COUNT(t.ticketid) AS TicketCount
FROM agents a INNER JOIN tickets t
ON a.agentid = t.agentid
GROUP BY a.agentid, a.firstname, a.lastname;

-- Get the details of all tickets assigned to a particular agent by their agent_id.
SELECT a.agentid, a.firstname || ' ' || a.lastname AS AgentName, t.ticketid, t.subject, t.customerid, t.description, t.status, t.priority, t.createdat, t.lastupdated
FROM agents a INNER JOIN tickets t
ON a.agentid = t.agentid
ORDER BY a.agentid, t.ticketid;

-- Find the agents who have not been assigned any tickets.
SELECT a.agentid, a.firstname, a.lastname, COUNT(t.ticketid) AS AssignedTickets
FROM agents a LEFT JOIN tickets t
ON a.agentid = t.agentid
GROUP BY a.agentid, a.firstname, a.lastname
HAVING COUNT(t.ticketid) = 0;

-- Retrieve the names of agents along with the total number of tickets they have closed.
SELECT a.firstname || ' ' || a.lastname AS AgentName, COUNT(t.ticketid) AS ResolvedTickets
FROM agents a INNER JOIN tickets t
ON a.agentid = t.agentid 
WHERE t.status = 'Resolved'
GROUP BY a.agentid, a.firstname, a.lastname;


-- Retrieve the department with the highest number of unresolved tickets.
SELECT d.departmentid, d.departmentname, COUNT(t.ticketid) UnresolvedTickets
FROM departments d JOIN agents a ON d.departmentid = a.departmentid
JOIN tickets t ON a.agentid = t.agentid
WHERE status IN ('Open', 'Pending')
GROUP BY d.departmentid, d.departmentname
ORDER BY COUNT(t.ticketid) DESC
FETCH FIRST 1 ROW ONLY;

-- List all tickets along with their current status and the agent handling them.
SELECT t.ticketid, t.subject, t.status, t.agentid, a.firstname || ' ' || a.lastname AS AgentName
FROM tickets t INNER JOIN agents a
ON t.agentid = a.agentid;

-- Find the total number of tickets per status (e.g., how many are open, closed, in progress).
SELECT status, COUNT(ticketid) TicketsPerStatus
FROM tickets 
GROUP BY status;

-- Retrieve all tickets that are currently open.
SELECT ticketid, subject,status
FROM tickets
WHERE status = 'Open';

-- Get the list of tickets created within the last 30 days.
SELECT ticketid, subject, createdat
FROM tickets
WHERE createdat >= SYSDATE - INTERVAL '30' DAY;

-- Retrieve all closed tickets and include the agent's first name and last name who handled each ticket.
SELECT t.ticketid, t.subject, t.status, a.firstname AgentFirstName, a.lastname AgentLastName
FROM tickets t INNER JOIN agents a ON t.agentid = a.agentid
WHERE t.status = 'Resolved'
ORDER BY t.ticketid, a.agentid;

-- Get the ticket details where the subject contains the word "error".
SELECT * FROM tickets
WHERE subject LIKE '%error%';

-- List all tickets with the highest priority that are still unresolved.
SELECT * FROM tickets
WHERE priority = 'High'
AND status IN ('Open', 'Pending');

-- Find the average number of comments per ticket by agents.
SELECT AVG(CommentCount) AS "Average Number of Comments per Ticket"
FROM (
    SELECT COUNT(commentid) AS CommentCount
    FROM comments
    WHERE agentid IS NOT NULL
    GROUP BY ticketid
);

-- Retrieve comments made on tickets that were resolved within 24 hours.
SELECT c.commentid, c.ticketid, t.status AS TicketStatus, c.commenttext, t.createdat TicketCreationDate, c.createdat ResolvedAt
FROM comments c INNER JOIN tickets t
ON c.ticketid = t.ticketid
WHERE t.status = 'Resolved';

-- Find the average time a ticket remains open before it is closed.
SELECT 
    FLOOR(AVG(
        EXTRACT(DAY FROM (c.createdat - t.createdat)) * 24 +
        EXTRACT(HOUR FROM (c.createdat - t.createdat)) +
        EXTRACT(MINUTE FROM (c.createdat - t.createdat)) / 60 +
        EXTRACT(SECOND FROM (c.createdat - t.createdat)) / 3600
    )) || 'h ' ||
    FLOOR(MOD(
            AVG(
              EXTRACT(DAY FROM (c.createdat - t.createdat)) * 24 * 3600 +
              EXTRACT(HOUR FROM (c.createdat - t.createdat)) * 3600 + 
              EXTRACT(MINUTE FROM (c.createdat - t.createdat)) * 60 +
              EXTRACT(SECOND FROM (c.createdat - t.createdat))
            ), 3600
         ) / 60
    ) || 'min' AS "Average Time Open" 
FROM tickets t
INNER JOIN comments c ON t.ticketid = c.ticketid
WHERE t.status = 'Resolved';

-- Retrieve tickets with attachments of more than 200 KB in size.
SELECT t.ticketid, t.subject, a.filename, a.filesize / 1000 || ' KB' AS FileSize 
FROM tickets t INNER JOIN attachments a
ON t.ticketid = a.ticketid
WHERE a.filesize > 200000;

-- Find tickets with attachments uploaded by agents and not by customers.
SELECT t.ticketid, t.subject, a.filename Attachment, a.agentid
FROM tickets t INNER JOIN attachments a 
ON t.ticketid = a.ticketid
WHERE a.agentid IS NOT NULL;

-- List all tickets with image attachments (assuming you have a way to differentiate file types).
SELECT t.ticketid, t.subject, a.filename, a.filetype
FROM tickets t INNER JOIN attachments a 
ON t.ticketid = a.ticketid
WHERE a.filetype LIKE 'image%';

-- Retrieve all unresolved tickets along with the customer's name, the assigned agent's name, and the department responsible.
SELECT t.ticketid, t.subject, t.status, c.firstname || ' ' || c.lastname AS CustomerName, a.firstname || ' ' || a.lastname AS AssignedAgent, a.departmentid, d.departmentname
FROM customers c JOIN tickets t ON c.customerid = t.customerid
JOIN agents a ON a.agentid = t.agentid
JOIN departments d ON d.departmentid = a.departmentid
WHERE t.status IN ('Open', 'Pending')
ORDER BY t.ticketid;

-- Get the average resolution time for tickets handled by each department.
SELECT d.departmentid, d.departmentname, 
    FLOOR(AVG(
        EXTRACT(DAY FROM (c.createdat - t.createdat)) * 24 +
        EXTRACT(HOUR FROM (c.createdat - t.createdat)) +
        EXTRACT(MINUTE FROM (c.createdat - t.createdat)) / 60 +
        EXTRACT(SECOND FROM (c.createdat - t.createdat)) / 3600
    )) || 'h ' ||
    FLOOR(MOD(
            AVG(
              EXTRACT(DAY FROM (c.createdat - t.createdat)) * 24 * 3600 +
              EXTRACT(HOUR FROM (c.createdat - t.createdat)) * 3600 + 
              EXTRACT(MINUTE FROM (c.createdat - t.createdat)) * 60 +
              EXTRACT(SECOND FROM (c.createdat - t.createdat))
            ), 3600
         ) / 60
    ) || 'min' AS "Average Ticket Resolution Time" 
FROM comments c
JOIN tickets t ON c.ticketid = t.ticketid
JOIN agents a ON t.agentid = a.agentid
JOIN departments d ON a.departmentid = d.departmentid
WHERE t.status = 'Resolved'
GROUP BY d.departmentid, d.departmentname
ORDER BY d.departmentid;