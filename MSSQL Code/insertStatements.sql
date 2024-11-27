-- Populating the salaries table
INSERT INTO salaries (jobType, hourlySalary) VALUES
('Chef', 20),
('Waiter', 15),
('Manager', 25);

-- Populating the employee table
INSERT INTO employee (empID, fname, lname, jobType, paycheck, hoursWorked) VALUES
(1, 'John', 'Doe', 'Chef', 2000, 100),
(2, 'Jane', 'Smith', 'Waiter', 1500, 100),
(3, 'Alice', 'Brown', 'Manager', 2500, 100);

-- Populating the reservation table
INSERT INTO reservation (resID, fname, lname, numPeople, datetime, empID, mealPrice, tip) VALUES
(101, 'Michael', 'Scott', 4, '2024-11-26 18:30:00', 2, 100, 20),
(102, 'Dwight', 'Schrute', 2, '2024-11-27 19:00:00', 2, 50, 10),
(103, 'Jim', 'Halpert', 3, '2024-11-28 20:00:00', 3, 75, 15);

-- Populating the customer table
INSERT INTO customer (customerID, resID, fname, lname, birthdate) VALUES
(201, 101, 'Pam', 'Beesly', '1985-03-25'),
(202, 101, 'Oscar', 'Martinez', '1981-02-20'),
(203, 102, 'Angela', 'Martin', '1978-06-11'),
(204, 103, 'Kevin', 'Malone', '1975-05-01');

-- Populating the allergies table
INSERT INTO allergies (allergyID, allergyName) VALUES
(1, 'Peanuts'),
(2, 'Shellfish'),
(3, 'Dairy');

-- Populating the hasAllergy table
INSERT INTO hasAllergy (customerID, allergyID) VALUES
(201, 1), -- Pam is allergic to peanuts
(204, 2); -- Kevin is allergic to shellfish

-- Populating the ingredients table
INSERT INTO ingredients (ingredientID, amount, ingredientType, allergyID) VALUES
(301, 100, 'Peanut Sauce', 1),
(302, 50, 'Shrimp', 2),
(303, 200, 'Cheese', 3),
(304, 150, 'Tomato', NULL); -- No allergy linked

-- Populating the menuItem table
INSERT INTO menuItem (itemID, menuItemName, price, dishType, isAlcoholic, cost) VALUES
(401, 'Peanut Noodles', 12, 'Main', 0, 5),
(402, 'Shrimp Pasta', 15, 'Main', 0, 7),
(403, 'Cheese Pizza', 10, 'Main', 0, 4),
(404, 'Tomato Soup', 8, 'Appetizer', 0, 3),
(405, 'Beer', 5, 'Drink', 1, 2);

-- Populating the usedIn table
INSERT INTO usedIn (ingredientID, dishID) VALUES
(301, 401), -- Peanut Sauce in Peanut Noodles
(302, 402), -- Shrimp in Shrimp Pasta
(303, 403), -- Cheese in Cheese Pizza
(304, 404); -- Tomato in Tomato Soup

-- Populating the ordered table
INSERT INTO ordered (orderID, customerID, itemID, timeOrdered) VALUES
(501, 201, 404, '2024-11-26 18:45:00'), -- Pam orders Tomato Soup (safe for her)
(502, 202, 401, '2024-11-26 18:50:00'), -- Oscar orders Peanut Noodles
(503, 203, 402, '2024-11-27 19:10:00'), -- Angela orders Shrimp Pasta
(504, 204, 404, '2024-11-28 20:10:00'), -- Kevin orders Tomato Soup (safe for him)
(505, 204, 405, '2024-11-28 20:15:00'); -- Kevin orders Beer
