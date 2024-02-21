-- -----------------
-- simple queries --
-- -----------------

-- find all employees
SELECT *
FROM employee;

-- find all clients
SELECT *
FROM client;

-- find all employees ordered by salary descending
SELECT *
FROM employee
ORDER BY salary DESC;

-- find all employees by sex then name
SELECT *
FROM employee
ORDER BY sex, first_name, last_name;

-- find the first 5 employees in the table
SELECT *
FROM employee
LIMIT 5;

-- find first and last name of employees
SELECT first_name, last_name
FROM employee;

-- find the forename and surnames of employees
SELECT first_name AS forename, last_name AS surname
FROM employee;

-- find all different genders
SELECT DISTINCT sex
FROM employee;

-- -------------------------
-- queries with functions --
-- -------------------------

-- find the number of employees
SELECT COUNT(emp_id)
FROM employee;

-- find the number of female employees born after 1971
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_date > '1971-01-01';

-- find the average salary of all employees
SELECT AVG(salary)
FROM employee;

-- find the average salary of all male employees
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;

-- --------------
-- aggregation --
-- --------------

-- find out how many males and how many females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- find how much money does every supplier spend
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

-- ------------
-- wildcards -- search for specific patterns
-- ------------

-- find any clients who are an LLC (Limited Liability Company)
SELECT *
FROM client
WHERE client_name LIKE '%LLC'; -- if there is an 'LLC' at the end of any pattern

-- find any branch suppliers that are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name Like '% label%';

-- find any employee born in october
SELECT *
FROM employee
WHERE birth_date LIKE '____-10%'; -- find pattern where there are any FOUR characters followed by a hyphen
                                  -- and then a 10 and further any number of characters

-- find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%school%';

-- --------
-- union -- combine search results
-- --------

-- find a list of employee and branch names
SELECT first_name AS names
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;
-- same amount of columns, same data types

-- find a list of all clients and branch suppliers' names
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- find a list of all money spent or earned by the company
SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

-- --------
-- joins --
-- --------
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

-- find all branches and the names of their managers
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch -- inner join
-- LEFT JOIN branch -- left join also includes all records from left table
-- RIGHT JOIN branch -- right join also includes all records from right table
ON employee.emp_id = branch.mgr_id;

-- -----------------
-- nested queries --
-- -----------------

-- find names of all employees who sold more than 30k to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

-- find all clients who are handled by the branch that Michael Scott manages
-- (assume you know Michael's ID)
SELECT client.client_name
FROM client
WHERE client.branch_id IN (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
);

-- ------------
-- on delete --
-- ------------

-- ON DELETE SET NULL causes referenced fields set to NULL when deleteing record
DELETE FROM employee
WHERE emp_id = 102;

-- revert changes
INSERT INTO employee VALUES(102,  'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

UPDATE employee
SET super_id = 102
WHERE emp_id IN (103, 104, 105);


-- ON DELETE CASCADE causes deleteing the whole row
DELETE FROM branch
WHERE  branch_id = 2;
SELECT * FROM branch;

-- revert changes
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
