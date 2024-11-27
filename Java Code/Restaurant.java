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
        try (Connection connection = DriverManager.getConnection(connectionUrl)) 
        {
            System.out.println("Connected to the database.");
            System.out.print("Enter the stored procedure name: ");
            String procedureName = scanner.nextLine();
            if (procedureName.equals("addCustomer")) 
            {
                System.out.print("Enter first name: ");
                String fname = scanner.nextLine();
                System.out.print("Enter last name: ");
                String lname = scanner.nextLine();
                System.out.print("Enter birthdate (YYYY-MM-DD): ");
                String birthdateStr = scanner.nextLine();
                Date birthdate = Date.valueOf(birthdateStr); 
                System.out.print("Enter reservation ID: ");
                int resID = scanner.nextInt();

                String sql = "{CALL sp_AddCustomer(?, ?, ?, ?)}";
                try (CallableStatement stmt = connection.prepareCall(sql)) 
                {
                    stmt.setString(1, fname);
                    stmt.setString(2, lname);
                    stmt.setDate(3, birthdate);
                    stmt.setInt(4, resID);

                    stmt.execute();
                    System.out.println("Customer added successfully.");
                } 
                catch (SQLException e) 
                {
                    System.out.println("Error executing stored procedure: " + e.getMessage());
                }
            } 
            else 
            {
                System.out.println("Unknown stored procedure.");
            }
            
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
    }
}
