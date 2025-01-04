package pack;
import java.sql.*;
import com.mysql.jdbc.Connection;

public class Dbconnection {
	public Connection getConnection() {
		Connection con=null;
		try {
            Class.forName("com.mysql.jdbc.Driver");
			con=(Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/todolist","root","");
		}
		catch (Exception e){
			e.printStackTrace();
			
		}
		return con;
	}

}