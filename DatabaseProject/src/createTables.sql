CREATE TABLE employee (
    empID INT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    jobType VARCHAR(50) NOT NULL,
    paycheck INT NOT NULL,
    hoursWorked INT NOT NULL,
    FOREIGN KEY (type) REFERENCES salaries(type)
);

CREATE TABLE salaries (
    jobType VARCHAR(50) PRIMARY KEY,
    hourlySalary INT NOT NULL
);

CREATE TABLE reservation (
    resID INT PRIMARY KEY,
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
    customerID INT PRIMARY KEY,
    resID INT NOT NULL,
    fname VARCHAR(50) NOT NULL,
    lname VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    FOREIGN KEY (resID) REFERENCES reservation(resID)
);

CREATE TABLE hasAllergy (
    customerID INT,
    allergyID INT,
    PRIMARY KEY (customerID, allergyID),
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    FOREIGN KEY (allergyID) REFERENCES allergies(allergyID)
);

CREATE TABLE allergies (
    allergyID INT PRIMARY KEY,
    allergyName VARCHAR(50) NOT NULL
);

CREATE TABLE ingredients (
    ingredientID INT PRIMARY KEY,
    amount INT NOT NULL,
    ingredientType VARCHAR(50) NOT NULL,
    allergyID INT,
    FOREIGN KEY (allergyID) REFERENCES allergies(allergyID)
);

CREATE TABLE usedIn (
    ingredientID INT,
    dishID INT,
    PRIMARY KEY (ingredientID, dishID),
    FOREIGN KEY (ingredientID) REFERENCES ingredients(ingredientID),
    FOREIGN KEY (dishID) REFERENCES menuItem(itemID)
);

CREATE TABLE menuItem (
    itemID INT PRIMARY KEY,
    menuItemName VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    dishType VARCHAR(50) NOT NULL,
    isAlcoholic BOOLEAN NOT NULL,
    cost INT NOT NULL
);

CREATE TABLE ordered (
    orderID INT PRIMARY KEY,
    customerID INT NOT NULL,
    itemID INT NOT NULL,
    timeOrdered TIMESTAMP NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    FOREIGN KEY (itemID) REFERENCES menuItem(itemID)
);
