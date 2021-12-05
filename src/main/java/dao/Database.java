package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import utils.LoadConfig;


public class Database {

    private static final LoadConfig cfg = LoadConfig.getIntanse();
    private static Database instance = null;
    private Connection conn = null;
    private static String DB_URL = "jdbc:mysql://localhost:3306/restaurant?serverTimezone=UTC";
    private static String USER_NAME = "root";
    private static String PASSWORD = "";

    private Database() {
        try {
            String connectProperty = "useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";

            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
            System.out.println("connect successfully!");
            
            System.out.println("Kết nối cơ sở dữ liệu thành công!");
        } catch (ClassNotFoundException e) {
            System.out.println("Chưa cài driver mysql!");
            System.out.println(e.toString());
            System.exit(0);
        } catch (SQLException e) {
            System.out.println("Kết nối cơ sở dữ liệu thất bại:");
            System.out.println(e.toString());
            System.exit(0);
        }

    }

    public Connection getConnection() {
        return this.conn;
    }

    public static Database getInstance() {
        if (instance == null) {
            instance = new Database();
        }
        return instance;
    }

}
