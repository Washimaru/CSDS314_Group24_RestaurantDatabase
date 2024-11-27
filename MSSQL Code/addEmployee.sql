CREATE PROCEDURE sp_AddEmployee
    @fname NVARCHAR(50),
    @lname NVARCHAR(50),
    @jobType NVARCHAR(20),
    @hoursWorked INT = 0,
	@paycheck INT = 0
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (
            SELECT 1
            FROM salaries
            WHERE jobType = @jobType
        )
        BEGIN
            THROW 51005, 'Invalid employee type. Please provide a valid type with a salary defined in the salaries table.', 1;
        END

        DECLARE @hourlySalary INT;
        SELECT @hourlySalary = hourlySalary
        FROM salaries
        WHERE jobType = @jobType;

        INSERT INTO employee (fname, lname, jobType, hoursWorked, paycheck)
        VALUES (@fname, @lname, @jobType, @hoursWorked, @paycheck);

        DECLARE @newEmpID INT;
        SET @newEmpID = SCOPE_IDENTITY(); 

        PRINT 'Employee successfully added. Employee ID: ' + CAST(@newEmpID AS NVARCHAR(10));
        PRINT 'Employee Details:';
        PRINT 'Name: ' + @fname + ' ' + @lname;
        PRINT 'Job Type: ' + @jobType;
        PRINT 'Hourly Salary: ' + CAST(@hourlySalary AS NVARCHAR(10));
        PRINT 'Hours Worked: ' + CAST(@hoursWorked AS NVARCHAR(10));

    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
