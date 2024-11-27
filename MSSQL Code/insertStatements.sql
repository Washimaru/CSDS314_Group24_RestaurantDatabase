-- Insert into salaries table
INSERT INTO salaries (jobType, hourlySalary) VALUES
('Waiter', 15),
('Chef', 20),
('Manager', 25),
('Bartender', 18),
('Cleaner', 12);

-- Insert into employee table
INSERT INTO employee (empID, fname, lname, jobType, paycheck, hoursWorked) VALUES
(1, 'John', 'Doe', 'Waiter', 300, 20),
(2, 'Jane', 'Smith', 'Chef', 400, 20),
(3, 'Emily', 'Johnson', 'Manager', 500, 20),
(4, 'Chris', 'Lee', 'Bartender', 360, 20),
(5, 'Anna', 'Kim', 'Waiter', 290, 20),
(6, 'David', 'Brown', 'Chef', 420, 20),
(7, 'Sophia', 'Davis', 'Cleaner', 240, 20),
(8, 'Michael', 'Martinez', 'Manager', 550, 20);

-- Insert into reservation table
INSERT INTO reservation (resID, fname, lname, numPeople, time, date, empID, mealPrice, tip) VALUES
(1, 'Alice', 'Walker', 4, '18:30:00', '2024-11-26', 1, 100, 15),
(2, 'Bob', 'Williams', 2, '20:00:00', '2024-11-26', 2, 50, 10),
(3, 'Charlie', 'Miller', 6, '19:00:00', '2024-11-26', 3, 150, 20),
(4, 'Diana', 'Taylor', 3, '21:00:00', '2024-11-26', 4, 80, 12),
(5, 'Ella', 'Anderson', 2, '18:00:00', '2024-11-26', 5, 60, 8),
(6, 'Frank', 'Thomas', 5, '19:30:00', '2024-11-26', 6, 120, 18),
(7, 'Grace', 'Jackson', 4, '20:30:00', '2024-11-26', 7, 110, 14);

-- Insert into customer table
INSERT INTO customer (customerID, resID, fname, lname, birthdate) VALUES
(1, 1, 'Alice', 'Walker', '1990-04-15'),
(2, 2, 'Bob', 'Williams', '1985-02-22'),
(3, 3, 'Charlie', 'Miller', '1992-08-10'),
(4, 4, 'Diana', 'Taylor', '1980-12-30'),
(5, 5, 'Ella', 'Anderson', '1995-01-01'),
(6, 6, 'Frank', 'Thomas', '1987-05-10'),
(7, 7, 'Grace', 'Jackson', '2000-07-20'),
(8, 1, 'Hannah', 'Martinez', '1993-11-11'),
(9, 3, 'Ian', 'White', '1991-06-25'),
(10, 2, 'Jack', 'King', '1994-09-13');

-- Insert into allergies table
INSERT INTO allergies (allergyID, allergyName) VALUES
(1, 'Peanuts'),
(2, 'Shellfish'),
(3, 'Dairy'),
(4, 'Gluten');

-- Insert into hasAllergy table
INSERT INTO hasAllergy (customerID, allergyID) VALUES
(1, 1),  -- Alice has Peanuts allergy
(3, 2),  -- Charlie has Shellfish allergy
(5, 3),  -- Ella has Dairy allergy
(7, 4),  -- Grace has Gluten allergy
(9, 1),  -- Ian has Peanuts allergy
(10, 3); -- Jack has Dairy allergy

-- Insert into ingredients table
INSERT INTO ingredients (ingredientID, amount, ingredientType, allergyID) VALUES
(1, 100, 'Peanut Butter', 1),  -- Peanuts ingredient with Peanuts allergy
(2, 50, 'Shrimp', 2),          -- Shellfish ingredient with Shellfish allergy
(3, 200, 'Milk', 3),           -- Dairy ingredient with Dairy allergy
(4, 120, 'Wheat Flour', 4),    -- Gluten ingredient with Gluten allergy
(5, 80, 'Chicken', NULL),      -- Chicken without allergies
(6, 100, 'Lettuce', NULL);     -- Lettuce without allergies

-- Insert into menuItem table
INSERT INTO menuItem (itemID, menuItemName, price, dishType, isAlcoholic, cost) VALUES
(1, 'Peanut Butter Sandwich', 8, 'Snack', 0, 3),
(2, 'Shrimp Cocktail', 15, 'Appetizer', 0, 5),
(3, 'Grilled Chicken', 20, 'Main', 0, 8),
(4, 'Caesar Salad', 10, 'Side', 0, 4),
(5, 'Lettuce Wrap', 12, 'Side', 0, 5),
(6, 'Beer', 5, 'Drink', 1, 1),
(7, 'Wine', 8, 'Drink', 1, 2);

-- Insert into usedIn table
INSERT INTO usedIn (ingredientID, dishID) VALUES
(1, 1),  -- Peanut Butter Sandwich uses Peanut Butter
(2, 2),  -- Shrimp Cocktail uses Shrimp
(3, 3),  -- Grilled Chicken uses Milk
(4, 4),  -- Caesar Salad uses Wheat Flour
(5, 5),  -- Lettuce Wrap uses Chicken
(6, 5),  -- Lettuce Wrap uses Lettuce
(3, 6);  -- Wine uses Milk (for wine with dairy-based sauce)

-- Insert into ordered table
INSERT INTO ordered (orderID, customerID, itemID, timeOrdered) VALUES
(1, 1, 1, '2024-11-26 18:30:00'),
(2, 2, 2, '2024-11-26 20:00:00'),
(3, 3, 3, '2024-11-26 19:00:00'),
(4, 4, 4, '2024-11-26 21:00:00'),
(5, 5, 5, '2024-11-26 18:00:00'),
(6, 6, 3, '2024-11-26 19:30:00'),
(7, 7, 6, '2024-11-26 20:30:00'),
(8, 8, 7, '2024-11-26 18:30:00'),
(9, 9, 2, '2024-11-26 19:00:00'),
(10, 10, 5, '2024-11-26 20:00:00');
