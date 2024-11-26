CREATE OR ALTER PROCEDURE DisplayMenuItems
    @customerID INT
AS
BEGIN
    -- Declare the current date for age calculation
    DECLARE @currentDate DATE = GETDATE();

    -- Step 1: Get the customer's birthdate
    DECLARE @birthdate DATE;
    SELECT @birthdate = birthdate
    FROM customer
    WHERE customerID = @customerID;

    -- Calculate age
    DECLARE @age INT;
    SET @age = DATEDIFF(YEAR, @birthdate, @currentDate) - 
               CASE WHEN MONTH(@birthdate) > MONTH(@currentDate) OR 
                         (MONTH(@birthdate) = MONTH(@currentDate) AND DAY(@birthdate) > DAY(@currentDate)) 
                    THEN 1 ELSE 0 END;

    -- Step 2: Display all menu items the customer is allowed to see
    SELECT menuItem.itemID, menuItem.menuItemName, menuItem.price, menuItem.dishType, menuItem.isAlcoholic
    FROM menuItem
    WHERE NOT EXISTS (
        -- Exclude items with insufficient ingredients
        SELECT 1
        FROM usedIn
        JOIN ingredients ON usedIn.ingredientID = ingredients.ingredientID
        WHERE usedIn.dishID = menuItem.itemID AND ingredients.amount <= 0
    )
    AND NOT EXISTS (
        -- Exclude items that have ingredients the customer is allergic to
        SELECT 1
        FROM usedIn
        JOIN ingredients ON usedIn.ingredientID = ingredients.ingredientID
        WHERE usedIn.dishID = menuItem.itemID AND ingredients.allergyID IN (
            SELECT hasAllergy.allergyID
            FROM hasAllergy
            WHERE hasAllergy.customerID = @customerID
        )
    )
    AND (@age >= 21 OR menuItem.isAlcoholic = 0); -- Exclude alcoholic items for customers under 21
END;
