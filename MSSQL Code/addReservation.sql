CREATE PROCEDURE sp_AddReservation
    @reserverFname NVARCHAR(50),
    @reserverLname NVARCHAR(50),
    @numPeople INT,
    @resDate DATE,
    @resTime TIME,
    @mealPrice INT = 0,
    @tip INT = 0
AS
BEGIN
    DECLARE @maxCapacity INT = 100;
    DECLARE @openingTime TIME = '09:00:00';
    DECLARE @closingTime TIME = '22:00:00';
    DECLARE @empID INT;
    DECLARE @resID INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        SELECT TOP 1 @empID = empID
        FROM employee
        WHERE jobType = 'waiter'
        ORDER BY NEWID();

        IF @empID IS NULL
        BEGIN
            THROW 51002, 'No available waiter to assign to the reservation.', 1;
        END

        IF EXISTS (
            SELECT 1
            FROM reservation
            WHERE date = @resDate
            GROUP BY date
            HAVING SUM(numPeople) + @numPeople > @maxCapacity
        )
        BEGIN
            THROW 51000, 'Reservation exceeds the restaurant capacity.', 1;
        END

        IF NOT (@resTime >= @openingTime AND @resTime <= @closingTime)
        BEGIN
            THROW 51001, 'Reservation time is outside of service hours.', 1;
        END

        INSERT INTO reservation (fname, lname, numPeople, time, date, empID, mealPrice, tip)
        VALUES (@reserverFname, @reserverLname, @numPeople, @resTime, @resDate, @empID, @mealPrice, @tip);

        SET @resID = SCOPE_IDENTITY(); 

        COMMIT TRANSACTION;

        PRINT 'Reservation successfully added. Reservation ID: ' + CAST(@resID AS NVARCHAR(10));
        PRINT 'Reservation Details:';
        PRINT 'Reserver Name: ' + @reserverFname + ' ' + @reserverLname;
        PRINT 'Number of People: ' + CAST(@numPeople AS NVARCHAR(10));
        PRINT 'Date: ' + CONVERT(VARCHAR(10), @resDate);
        PRINT 'Time: ' + CONVERT(VARCHAR(8), @resTime);

        DECLARE @employeeName NVARCHAR(100);
        SELECT @employeeName = fname + ' ' + lname
        FROM employee
        WHERE empID = @empID;

        PRINT 'Employee Name: ' + @employeeName;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT 'An error occurred. Transaction has been rolled back.';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
