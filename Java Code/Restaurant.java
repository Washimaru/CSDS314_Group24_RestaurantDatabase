import java.sql.*;
import java.util.Scanner;

public class Restaurant {
    public static void main(String[] args) {
        String connectionUrl =
            "jdbc:sqlserver://cxp-sql-02\\jxs1902;" +
            "database=restaurant;" +
            "user=dbuser;" +
            "password=csds341143sdsc;" +
            "encrypt=true;" +
            "trustServerCertificate=true;" +
            "loginTimeout=900;";

        Scanner scanner = new Scanner(System.in);
        try (Connection connection = DriverManager.getConnection(connectionUrl)) {
            System.out.println("Connected to the database.");
            System.out.print("Enter the stored procedure name: ");
            String procedureName = scanner.nextLine();

            
        } 
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
