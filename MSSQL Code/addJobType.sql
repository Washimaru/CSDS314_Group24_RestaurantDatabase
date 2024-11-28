CREATE PROCEDURE AddJobType
    @jobType VARCHAR(50),
    @hourlySalary INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO salaries (jobType, hourlySalary)
        VALUES (@jobType, @hourlySalary);

        COMMIT TRANSACTION;
        PRINT 'Job title added successfully.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'An error occurred. Job title not added.';
    END CATCH
END;
