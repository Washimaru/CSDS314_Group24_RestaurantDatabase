CREATE PROCEDURE sp_PromoteEmployee
    @empID INT,
    @newJobType NVARCHAR(20)
AS
BEGIN
    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM salaries WHERE jobType = @newJobType)
        BEGIN
            THROW 50002, 'Invalid new job type. Please provide a valid job type from the salaries table.', 1;
        END

        DECLARE @newHourlySalary INT;
        SELECT @newHourlySalary = hourlySalary FROM salaries WHERE jobType = @newJobType;

        UPDATE employee
        SET jobType = @newJobType, paycheck = paycheck + (@newHourlySalary * hoursWorked)
        WHERE empID = @empID;

        PRINT 'Employee ID ' + CAST(@empID AS NVARCHAR(10)) + ' promoted to ' + @newJobType;
        PRINT 'New Hourly Salary: $' + CAST(@newHourlySalary AS NVARCHAR(10));
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
