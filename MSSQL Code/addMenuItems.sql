CREATE TRIGGER AddMenuItemOrders
ON ordered
INSTEAD OF INSERT
AS
BEGIN
    -- Declare variables to store input data
    DECLARE @customerID INT, @itemID INT, @timeOrdered DATETIME;
    DECLARE @birthdate DATE, @age INT, @isAlcoholic BIT;

    -- Fetch the values being inserted
    SELECT @customerID = customerID, 
           @itemID = itemID, 
           @timeOrdered = timeOrdered
    FROM inserted;

    -- Get customer's birthdate
    SELECT @birthdate = birthdate
    FROM customer
    WHERE customerID = @customerID;

    -- Calculate customer's age
    SET @age = DATEDIFF(YEAR, @birthdate, GETDATE()) - 
               CASE WHEN MONTH(@birthdate) > MONTH(GETDATE()) OR 
                         (MONTH(@birthdate) = MONTH(GETDATE()) AND DAY(@birthdate) > DAY(GETDATE())) 
                    THEN 1 ELSE 0 END;

    -- Check if the item is alcoholic
    SELECT @isAlcoholic = isAlcoholic
    FROM menuItem
    WHERE itemID = @itemID;

    -- Check if the customer is allergic to any ingredient in the menu item
    IF EXISTS (
        SELECT 1
        FROM usedIn
        JOIN ingredients ON usedIn.ingredientID = ingredients.ingredientID
        WHERE usedIn.dishID = @itemID
          AND ingredients.allergyID IN (
              SELECT allergyID
              FROM hasAllergy
              WHERE customerID = @customerID
          )
    )
    BEGIN
        RAISERROR ('Order denied: Customer is allergic to this menu item.', 16, 1);
        RETURN;
    END;

    -- Check if the menu item has sufficient ingredients
    IF EXISTS (
        SELECT 1
        FROM usedIn
        JOIN ingredients ON usedIn.ingredientID = ingredients.ingredientID
        WHERE usedIn.dishID = @itemID AND ingredients.amount <= 0
    )
    BEGIN
        RAISERROR ('Order denied: Insufficient ingredients for this menu item.', 16, 1);
        RETURN;
    END;

    -- Check age restriction for alcoholic items
    IF @isAlcoholic = 1 AND @age < 21
    BEGIN
        RAISERROR ('Order denied: Customer is under 21 and cannot order alcoholic items.', 16, 1);
        RETURN;
    END;

    -- If all conditions are met, insert the order into the ordered table
    INSERT INTO ordered (customerID, itemID, timeOrdered)
    VALUES (@customerID, @itemID, @timeOrdered);
END;
