package util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DBConnectionUtil {
    // Singleton instance
    private static DBConnectionUtil instance;
    
    // ThreadLocal for connections and reference counting
    private ThreadLocal<Connection> threadLocalConnection;
    private ThreadLocal<Integer> connectionRefCount;
    
    // Private constructor for singleton
    private DBConnectionUtil() {
        threadLocalConnection = new ThreadLocal<>();
        connectionRefCount = new ThreadLocal<>();
    }
    
    public static synchronized DBConnectionUtil getInstance() {
        if (instance == null) {
            instance = new DBConnectionUtil();
        }
        return instance;
    }
    
    private Connection getConnectionInternal() {
        try {
            Connection conn = threadLocalConnection.get();
            if (conn == null || conn.isClosed()) {
                ResourceBundle rb = ResourceBundle.getBundle("application");
                String url = rb.getString("url");
                String driverName = rb.getString("driverName");
                String username = rb.getString("username");
                String password = rb.getString("password");
                try {
                    Class.forName(driverName);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                conn = DriverManager.getConnection(url, username, password);
                threadLocalConnection.set(conn);
                connectionRefCount.set(1);
            } else {
                Integer count = connectionRefCount.get();
                connectionRefCount.set(count != null ? count + 1 : 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return threadLocalConnection.get();
    }
    
    private void closeConnectionInternal() {
        Connection conn = threadLocalConnection.get();
        if (conn != null) {
            Integer count = connectionRefCount.get();
            if (count == null || count <= 1) {
                try {
                    conn.close();
                    threadLocalConnection.remove();
                    connectionRefCount.remove();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } else {
                connectionRefCount.set(count - 1);
            }
        }
    }
    
    private void closeConnectionInternal(Connection conn) {
        if (conn != null) {
            try {
                Connection threadConn = threadLocalConnection.get();
                if (conn != threadConn) {
                    conn.close();
                } else {
                    closeConnectionInternal();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static Connection getConnection() {
        return getInstance().getConnectionInternal();
    }
    
    public static void closeConnection() {
        getInstance().closeConnectionInternal();
    }
    
    public static void closeConnection(Connection conn) {
        getInstance().closeConnectionInternal(conn);
    }
}
