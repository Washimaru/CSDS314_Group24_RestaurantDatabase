import java.sql.*;

public class Restaurant {
    public static void main(String[] args) {
        String connectionUrl =
            "jdbc:sqlserver://cxp-sql-02\\jfs145;" +
            "database=university;" +
            "user=dbuser;" +
            "password=csds341143sdsc;" +
            "encrypt=true;" +
            "trustServerCertificate=true;" +
            "loginTimeout=900;";

        try (Connection connection = DriverManager.getConnection(connectionUrl)) {
            System.out.println("Connected to the database.");

            String sql = "{CALL insertStudent2(?, ?, ?)}";
            try (CallableStatement stmt = connection.prepareCall(sql)) {

                stmt.setString(1, "Kyle Kaufman");
                stmt.setString(2, "Comp. Sci.");
                stmt.setInt(3, 100);

                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    int newId = rs.getInt("new_id");
                    System.out.println("Inserted student ID: " + newId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
