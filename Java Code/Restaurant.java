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

            if (procedureName.equalsIgnoreCase("addCustomer")) {
                addCustomer(connection, scanner);
            } 
            else if (procedureName.equalsIgnoreCase("addEmployee")) {
                addEmployee(connection, scanner);
            } 
            else if (procedureName.equalsIgnoreCase("addReservation")) {
                addReservation(connection, scanner);
            } 
            else if (procedureName.equalsIgnoreCase("addTime")) {
                addTime(connection, scanner);
            } 
            else if (procedureName.equalsIgnoreCase("addTip")) {
                addTip(connection, scanner);
            } 
            else if (procedureName.equalsIgnoreCase("calculatePaycheck"))
            {
                calculatePaycheck(connection, scanner);
            }
            else {
                System.out.println("Unknown stored procedure.");
            }
            
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }

    }

    private static void addCustomer(Connection connection, Scanner scanner) {
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
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setString(1, fname);
            stmt.setString(2, lname);
            stmt.setDate(3, birthdate);
            stmt.setInt(4, resID);

            stmt.execute();
            System.out.println("Customer added successfully.");
        } 
        catch (SQLException e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
        }
    }

    private static void addEmployee(Connection connection, Scanner scanner) {
        System.out.print("Enter first name: ");
        String fname = scanner.nextLine();
        System.out.print("Enter last name: ");
        String lname = scanner.nextLine();
        System.out.print("Enter job type: ");
        String jobType = scanner.nextLine();
        System.out.print("Enter hours worked: ");
        int hoursWorked = scanner.nextInt();
        System.out.print("Enter paycheck: ");
        int paycheck = scanner.nextInt();

        String sql = "{CALL sp_AddEmployee(?, ?, ?, ?, ?)}";
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setString(1, fname);
            stmt.setString(2, lname);
            stmt.setString(3, jobType);
            stmt.setInt(4, hoursWorked);
            stmt.setInt(5, paycheck);

            stmt.execute();
            System.out.println("Employee added successfully.");
        } 
        catch (SQLException e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
        }
    }

    private static void addReservation(Connection connection, Scanner scanner) {
        System.out.print("Enter reserver first name: ");
        String reserverFname = scanner.nextLine();
        System.out.print("Enter reserver last name: ");
        String reserverLname = scanner.nextLine();
        System.out.print("Enter number of people: ");
        int numPeople = scanner.nextInt();
        scanner.nextLine();  // Clear the buffer
        System.out.print("Enter reservation date (YYYY-MM-DD): ");
        String resDate = scanner.nextLine();
        System.out.print("Enter reservation time (HH:mm:ss): ");
        String resTime = scanner.nextLine();
        System.out.print("Enter meal price (in cents): ");
        int mealPrice = scanner.nextInt();
        System.out.print("Enter tip (in cents): ");
        int tip = scanner.nextInt();

        String sql = "{CALL sp_AddReservation(?, ?, ?, ?, ?, ?, ?)}";
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setString(1, reserverFname);
            stmt.setString(2, reserverLname);
            stmt.setInt(3, numPeople);
            stmt.setDate(4, Date.valueOf(resDate)); // convert String to Date
            stmt.setTime(5, Time.valueOf(resTime)); // convert String to Time
            stmt.setInt(6, mealPrice);
            stmt.setInt(7, tip);

            stmt.execute();
            System.out.println("Reservation added successfully.");
        } 
        catch (SQLException e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
        }
    }

    private static void addTime(Connection connection, Scanner scanner) {
        System.out.print("Enter employee ID: ");
        int empID = scanner.nextInt();
        System.out.print("Enter hours to add: ");
        int hoursToAdd = scanner.nextInt();

        String sql = "{CALL sp_AddTime(?, ?)}";
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, empID);
            stmt.setInt(2, hoursToAdd);

            stmt.execute();
            System.out.println("Time added successfully.");
        } 
        catch (SQLException e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
        }
    }

    private static void addTip(Connection connection, Scanner scanner) {
        System.out.print("Enter reservation ID: ");
        int resID = scanner.nextInt();
        System.out.print("Enter tip (in cents): ");
        int tip = scanner.nextInt();

        String sql = "{CALL sp_AddTip(?, ?)}";
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, resID);
            stmt.setInt(2, tip);

            stmt.execute();
            System.out.println("Tip added successfully.");
        } 
        catch (SQLException e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
        }
    }

    private static void calculatePaycheck(Connection connection, Scanner scanner) {
        System.out.print("Enter employee ID: ");
        int empID = scanner.nextInt();
    
        String sql = "{CALL sp_CalculatePaycheck(?)}";
        try (CallableStatement stmt = connection.prepareCall(sql)) {
            stmt.setInt(1, empID); // Set the empID parameter
    
            // Execute the stored procedure
            stmt.execute();
            System.out.println("Paycheck calculated successfully.");
        } 
        catch (SQLException e) {
            System.out.println("Error executing stored procedure: " + e.getMessage());
        }
    }
}
