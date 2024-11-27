CREATE PROCEDURE sp_AddCustomer
    @fname NVARCHAR(50),
    @lname NVARCHAR(50),
    @birthdate DATE,
    @resID INT
AS
BEGIN
    DECLARE @customerID INT;
    DECLARE @numPeopleInReservation INT;
    DECLARE @numPeopleAlreadyAdded INT;
    DECLARE @remainingCapacity INT;

    BEGIN TRY
        -- Get the total number of people allowed for this reservation
        SELECT @numPeopleInReservation = numPeople 
        FROM reservation
        WHERE resID = @resID;

        -- Get the total number of people already added to this reservation
        SELECT @numPeopleAlreadyAdded = COUNT(*)
        FROM customer
        WHERE resID = @resID;

        -- Calculate remaining capacity
        SET @remainingCapacity = @numPeopleInReservation - @numPeopleAlreadyAdded;

        -- Check if there is enough capacity for this customer
        IF @remainingCapacity <= 0
        BEGIN
            PRINT 'Reservation has reached its maximum capacity. Cannot add more customers.';
            RETURN;  -- Exit the procedure if capacity exceeded
        END

        -- Insert the customer into the customer table
        INSERT INTO customer (fname, lname, birthdate, resID)
        VALUES (@fname, @lname, @birthdate, @resID);

        -- Get the customerID of the newly inserted customer
        SET @customerID = SCOPE_IDENTITY();

        PRINT 'Customer successfully added. Customer ID: ' + CAST(@customerID AS NVARCHAR(10));
        PRINT 'Customer Details:';
        PRINT 'Name: ' + @fname + ' ' + @lname;
        PRINT 'Birthdate: ' + CONVERT(VARCHAR(10), @birthdate);
        PRINT 'Reservation ID: ' + CAST(@resID AS NVARCHAR(10));

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;