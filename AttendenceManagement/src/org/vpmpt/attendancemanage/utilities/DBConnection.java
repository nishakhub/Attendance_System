package org.vpmpt.attendancemanage.utilities;

import java.sql.Connection;

import org.apache.log4j.Logger;

public class DBConnection {
	
	private static DBConnection dbConn;

	private static Logger log = Logger.getLogger(DBConnection.class);
	
	private DBConnection(){
	}
	
	public static void initBackOfficeDB(){
		log.debug("Creating Backoffice DataSource.");
		
		log.info("Backoffice DataSource created.");
	}
	

	public static DBConnection getInstance() {
		if (dbConn == null) {
			dbConn = new DBConnection();
			return dbConn;
		} else {
			return dbConn;
		}

	}

	public Connection getTenantDBConnection(){
		return null;
	}


}
