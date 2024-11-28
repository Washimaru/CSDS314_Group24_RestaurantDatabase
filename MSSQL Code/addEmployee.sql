CREATE OR ALTER PROCEDURE sp_AddEmployee
    @fname NVARCHAR(50),
    @lname NVARCHAR(50),
    @jobType NVARCHAR(20),
    @hoursWorked INT = 0,
    @paycheck INT = 0
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate or insert job type in salaries
        IF NOT EXISTS (SELECT 1 FROM salaries WHERE jobType = @jobType)
        BEGIN
            INSERT INTO salaries (jobType, hourlySalary)
            VALUES (@jobType, 0); -- Default hourly salary is 0
            PRINT 'New job type added to salaries table.';
        END

        -- Insert new employee
        INSERT INTO employee (fname, lname, jobType, hoursWorked, paycheck)
        VALUES (@fname, @lname, @jobType, @hoursWorked, @paycheck);

        COMMIT Transaction;

        PRINT 'Employee added successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTIon;
        PRINT 'Error adding employee: ' + ERROR_MESSAGE();
    END CATCH;
END;
