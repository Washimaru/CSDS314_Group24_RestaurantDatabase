CREATE PROCEDURE sp_AddJobTitle
    @jobType NVARCHAR(20),
    @hourlySalary INT
AS
BEGIN
    BEGIN TRY
        -- Insert job type
        INSERT INTO salaries (jobType, hourlySalary)
        VALUES (@jobType, @hourlySalary);

        -- Verify insertion
        PRINT 'Job Title Added: ' + @jobType;
        PRINT 'Hourly Salary: $' + CAST(@hourlySalary AS NVARCHAR(10));
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
