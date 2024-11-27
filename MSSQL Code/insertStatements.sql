CREATE TABLE salaries (
    jobType VARCHAR(50) PRIMARY KEY,
    hourlySalary INT NOT NULL
);




CREATE TABLE employee (
    empID INT IDENTITY(1,1) PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    jobType VARCHAR(50) NOT NULL,
    paycheck INT NOT NULL,
    hoursWorked INT NOT NULL,
    FOREIGN KEY (jobType) REFERENCES salaries(jobType)
);




CREATE TABLE reservation (
    resID INT IDENTITY(1,1) PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    numPeople INT NOT NULL,
    time TIME NOT NULL,
    date DATE NOT NULL,
    empID INT NOT NULL,
    mealPrice INT NOT NULL,
    tip INT NOT NULL,
    FOREIGN KEY (empID) REFERENCES employee(empID)
);




CREATE TABLE customer (
    customerID INT IDENTITY(1,1) PRIMARY KEY,
    resID INT NOT NULL,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    FOREIGN KEY (resID) REFERENCES reservation(resID)
);




CREATE TABLE allergies (
    allergyID INT IDENTITY(1,1) PRIMARY KEY,
    allergyName VARCHAR(50) NOT NULL
);




CREATE TABLE hasAllergy (
    customerID INT,
    allergyID INT,
    PRIMARY KEY (customerID, allergyID),
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    FOREIGN KEY (allergyID) REFERENCES allergies(allergyID)
);




CREATE TABLE ingredients (
    ingredientID INT IDENTITY(1,1) PRIMARY KEY,
    amount INT NOT NULL,
    ingredientType VARCHAR(50) NOT NULL,
    allergyID INT,
    FOREIGN KEY (allergyID) REFERENCES allergies(allergyID)
);




CREATE TABLE menuItem (
    itemID INT IDENTITY(1,1) PRIMARY KEY,
    menuItemName VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    dishType VARCHAR(50) NOT NULL,
    isAlcoholic BIT NOT NULL,
    cost INT NOT NULL
);




CREATE TABLE usedIn (
    ingredientID INT,
    dishID INT,
    PRIMARY KEY (ingredientID, dishID),
    FOREIGN KEY (ingredientID) REFERENCES ingredients(ingredientID),
    FOREIGN KEY (dishID) REFERENCES menuItem(itemID)
);




CREATE TABLE ordered (
    orderID INT IDENTITY(1,1) PRIMARY KEY,
    customerID INT NOT NULL,
    itemID INT NOT NULL,
    timeOrdered TIMESTAMP NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    FOREIGN KEY (itemID) REFERENCES menuItem(itemID)
);


-- 1. Insert into salaries table
INSERT INTO salaries (jobType, hourlySalary) VALUES
('Waiter', 15),
('Chef', 20),
('Manager', 25),
('Bartender', 18),
('Cleaner', 12);


-- 2. Insert into employee table
INSERT INTO employee (fname, lname, jobType, paycheck, hoursWorked) VALUES
('John', 'Doe', 'Waiter', 300, 20),
('Jane', 'Smith', 'Chef', 400, 20),
('Emily', 'Johnson', 'Manager', 500, 20),
('Chris', 'Lee', 'Bartender', 360, 20),
('Anna', 'Kim', 'Waiter', 290, 20),
('David', 'Brown', 'Chef', 420, 20),
('Sophia', 'Davis', 'Cleaner', 240, 20),
('Michael', 'Martinez', 'Manager', 550, 20);


-- 3. Insert into reservation table
INSERT INTO reservation (fname, lname, numPeople, time, date, empID, mealPrice, tip) VALUES
('Alice', 'Walker', 4, '18:30:00', '2024-11-26', 1, 100, 15),
('Bob', 'Williams', 2, '20:00:00', '2024-11-26', 2, 50, 10),
('Charlie', 'Miller', 6, '19:00:00', '2024-11-26', 3, 150, 20),
('Diana', 'Taylor', 3, '21:00:00', '2024-11-26', 4, 80, 12),
('Ella', 'Anderson', 2, '18:00:00', '2024-11-26', 5, 60, 8),
('Frank', 'Thomas', 5, '19:30:00', '2024-11-26', 6, 120, 18),
('Grace', 'Jackson', 4, '20:30:00', '2024-11-26', 7, 110, 14);


-- 4. Insert into allergies table
INSERT INTO allergies (allergyName) VALUES
('Peanuts'),
('Shellfish'),
('Dairy'),
('Gluten');


-- 5. Insert into customer table
INSERT INTO customer (resID, fname, lname, birthdate) VALUES
(1, 'Alice', 'Walker', '1990-04-15'),
(2, 'Bob', 'Williams', '1985-02-22'),
(3, 'Charlie', 'Miller', '1992-08-10'),
(4, 'Diana', 'Taylor', '1980-12-30'),
(5, 'Ella', 'Anderson', '1995-01-01'),
(6, 'Frank', 'Thomas', '1987-05-10'),
(7, 'Grace', 'Jackson', '2006-07-20'),
(1, 'Hannah', 'Martinez', '1993-11-11'),
(3, 'Ian', 'White', '1991-06-25'),
(2, 'Jack', 'King', '1994-09-13');


-- 6. Insert into hasAllergy table
INSERT INTO hasAllergy (customerID, allergyID) VALUES
(1, 1),  -- Alice has Peanuts allergy
(3, 2),  -- Charlie has Shellfish allergy
(5, 3),  -- Ella has Dairy allergy
(7, 4),  -- Grace has Gluten allergy
(9, 1),  -- Ian has Peanuts allergy
(10, 3); -- Jack has Dairy allergy


-- 7. Insert into ingredients table
INSERT INTO ingredients (amount, ingredientType, allergyID) VALUES
(100, 'Peanut Butter', 1),  -- Peanuts ingredient with Peanuts allergy
(50, 'Shrimp', 2),          -- Shellfish ingredient with Shellfish allergy
(200, 'Milk', 3),           -- Dairy ingredient with Dairy allergy
(120, 'Wheat Flour', 4),    -- Gluten ingredient with Gluten allergy
(80, 'Chicken', NULL),      -- Chicken without allergies
(100, 'Lettuce', NULL);     -- Lettuce without allergies


-- 8. Insert into menuItem table
INSERT INTO menuItem (menuItemName, price, dishType, isAlcoholic, cost) VALUES
('Peanut Butter Sandwich', 8, 'Snack', 0, 3),
('Shrimp Cocktail', 15, 'Appetizer', 0, 5),
('Grilled Chicken', 20, 'Main', 0, 8),
('Caesar Salad', 10, 'Side', 0, 4),
('Lettuce Wrap', 12, 'Side', 0, 5),
('Beer', 5, 'Drink', 1, 1),
('Wine', 8, 'Drink', 1, 2);


-- 9. Insert into usedIn table
INSERT INTO usedIn (ingredientID, dishID) VALUES
(1, 1),  -- Peanut Butter Sandwich uses Peanut Butter
(2, 2),  -- Shrimp Cocktail uses Shrimp
(3, 3),  -- Grilled Chicken uses Milk
(4, 4),  -- Caesar Salad uses Wheat Flour
(5, 5),  -- Lettuce Wrap uses Chicken
(6, 5),  -- Lettuce Wrap uses Lettuce
(3, 6);  -- Wine uses Milk (for wine with dairy-based sauce)


-- 10. Insert into ordered table
INSERT INTO ordered (customerID, itemID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 3),
(7, 6),
(8, 7),
(9, 2),
(10, 5);





