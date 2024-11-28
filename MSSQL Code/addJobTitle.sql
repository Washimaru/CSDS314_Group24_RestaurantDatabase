CREATE OR ALTER PROCEDURE sp_AddJobTitle
    @jobType NVARCHAR(20),
    @hourlySalary INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if the job type already exists
        IF EXISTS (SELECT 1 FROM salaries WHERE jobType = @jobType)
        BEGIN
            THROW 50006, 'Job type already exists in the salaries table.', 1;
        END

        -- Insert the new job title into salaries
        INSERT INTO salaries (jobType, hourlySalary)
        VALUES (@jobType, @hourlySalary);

        UPDATE employee
        SET jobType = @jobType
        WHERE jobType IS NULL OR jobType = 'Default';

        COMMIT Transaction;

        PRINT 'Job title added successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK Transaction;
        PRINT 'Error adding job title: ' + ERROR_MESSAGE();
    END CATCH;
END;
