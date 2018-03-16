package org.vpmpt.attendancemanage.utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBRawConnection {

	private Connection conn;
	private static DBRawConnection dbConn;

	public static DBRawConnection getInstance() {
		if (dbConn == null) {
			dbConn = new DBRawConnection();
			return dbConn;
		} else {
			return dbConn;
		}

	}

	public Connection getConnection(){

		try{
			Class.forName(DBPoolProperties.getDriver());
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
		try{
			conn = DriverManager.getConnection(DBPoolProperties.getDbURL(), DBPoolProperties.getDbUserName(), DBPoolProperties.getDbPassword());

		}catch(SQLException se){
			se.printStackTrace();
		}
		return conn;
	}
}
