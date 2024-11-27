CREATE PROCEDURE sp_AddTip
    @resID INT,
    @tip INT
AS
BEGIN
    DECLARE @mealPrice INT;
    DECLARE @totalAmount INT;

    BEGIN TRY
        IF @tip < 0
        BEGIN
            THROW 51005, 'Tip cannot be negative.', 1;
        END

        SELECT @mealPrice = mealPrice
        FROM reservation
        WHERE resID = @resID;

        IF @mealPrice IS NULL
        BEGIN
            THROW 51002, 'Reservation not found.', 1;
        END

        SET @totalAmount = @mealPrice + @tip;

        UPDATE reservation
        SET tip = @tip
        WHERE resID = @resID;

        PRINT 'Meal Price: $' + CAST(@mealPrice / 100.0 AS NVARCHAR(10));
        PRINT 'Tip: $' + CAST(@tip / 100.0 AS NVARCHAR(10));
        PRINT 'Total (Meal + Tip): $' + CAST(@totalAmount / 100.0 AS NVARCHAR(10));
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
