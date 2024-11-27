CREATE PROCEDURE sp_CalculatePaycheck
    @empID INT
AS
BEGIN
    DECLARE @paycheck INT = 0;
    DECLARE @hoursWorked INT = 0;
    DECLARE @hourlySalary INT = 0;
    DECLARE @totalTips INT = 0;

    BEGIN TRY
        SELECT @hoursWorked = hoursWorked, @hourlySalary = s.hourlySalary
        FROM employee e
        JOIN salaries s ON e.jobType = s.jobType
        WHERE e.empID = @empID;

        SET @paycheck = @hoursWorked * @hourlySalary;

        IF EXISTS (
            SELECT 1
            FROM employee
            WHERE empID = @empID AND jobType = 'waiter'
        )
        BEGIN
            SELECT @totalTips = COALESCE(SUM(r.tip), 0)
            FROM reservation r
            WHERE r.empID = @empID;
            
            SET @paycheck = @paycheck + @totalTips;
        END

        UPDATE employee
        SET paycheck = @paycheck
        WHERE empID = @empID;

        PRINT 'Paycheck calculated successfully.';
        PRINT 'Paycheck Details:';
        PRINT 'Base Pay: ' + CAST(@hoursWorked * @hourlySalary AS NVARCHAR);
        PRINT 'Tips: ' + CAST(@totalTips AS NVARCHAR);
        PRINT 'Total Paycheck: ' + CAST(@paycheck AS NVARCHAR);
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
