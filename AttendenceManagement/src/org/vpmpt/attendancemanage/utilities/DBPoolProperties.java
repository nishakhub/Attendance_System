package org.vpmpt.attendancemanage.utilities;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

public class DBPoolProperties {

	// Tenant database configuration
	private static String driver     = null;
	private static String engine     = null;
	private static String dbHost     = null;
	private static int    port       = -1;
	private static String dbUserName   = null;
	private static String dbPassword = null;
	private static String dbType = null;
	private static String dbURL = null;

	private static int cPoolMaxActive=100;
	private static int cPoolInitialSize=10;
	private static int cPoolMinIdleConnections=10;
	private static int cPoolValidationInterval = 30000; //30 seconds
	private static int connectionRetryTimeOut = 3;
	private static int connectionRetryWait = 2;
	
	private static Logger log = Logger.getLogger(DBPoolProperties.class);
	static{
		initialize();
	}

	public static void initialize(){
		Properties properties = new Properties();
		try {
			properties.load(DBPoolProperties.class.getClassLoader().getResourceAsStream("/Database.properties"));
		} 
		catch (FileNotFoundException e ) {
			log.error("DB properties file Not Found at specified location.", e);
		}catch (IOException e ) {
			log.error("Failed to read DB properties file.", e);
		}
		try{
			driver = properties.getProperty(Constant.DB_DRIVER).trim();
			//engine = properties.getProperty(Constant.DB_TYPE).trim();
			//dbHost = properties.getProperty(Constant.DB_HOST).trim();
			//String port_string = properties.getProperty(Constant.DB_PORT).trim();
			dbUserName = properties.getProperty(Constant.DB_USER_NAME).trim();
			dbPassword = properties.getProperty(Constant.USER_PASSWORD).trim();
			String cPoolMaxActive_s = properties.getProperty(Constant.MAX_ACTIVE_CONNECTION).trim();
			//tenant_dbname = properties.getProperty(Constant.TENANT_DB_NAME);
			String cPoolInitialSize_s = properties.getProperty(Constant.INITIAL_POOL_SIZE).trim();
			String cPoolMinIdleConnections_s = properties.getProperty(Constant.MIN_IDLE_CONN).trim();
			String cPoolValidationInterval_s = properties.getProperty(Constant.CONNECTION_RETRY_COUNT).trim();
			String connectionRetryTimeOut_s = properties.getProperty(Constant.CONN_VALIDATION_INTERVAL).trim();

			//dbType = properties.getProperty(Constant.DB_TYPE);
			//port = Integer.parseInt(port_string);
			dbURL = properties.getProperty(Constant.DB_URL).trim();
			cPoolInitialSize = Integer.parseInt(cPoolInitialSize_s);
			cPoolMinIdleConnections = Integer.parseInt(cPoolMinIdleConnections_s);
			cPoolMaxActive = Integer.parseInt(cPoolMaxActive_s);
			cPoolValidationInterval = Integer.parseInt(cPoolValidationInterval_s);
			connectionRetryTimeOut = Integer.parseInt(connectionRetryTimeOut_s);

		}
		catch(NumberFormatException e){
			log.error("Failed to parse database properties.", e);
		}
	}

	public static int getConnectionRetryTimeOut() {
		return connectionRetryTimeOut;
	}

	public static void setConnectionRetryTimeOut(int connectionRetryTimeOut) {
		DBPoolProperties.connectionRetryTimeOut = connectionRetryTimeOut;
	}

	public static int getConnectionRetryWait() {
		return connectionRetryWait;
	}
	
	public static void setConnectionRetryWait(int connectionRetryWait) {
		DBPoolProperties.connectionRetryWait = connectionRetryWait;
	}

	public static String getDBUsername() {
		return dbUserName;
	}

	public static void setDriver(final String driverIn) {
		driver = driverIn;
	}

	public static String getDriver() {
		return driver;
	}

	public static String getEngine() {
		return engine;
	}
	public static void setEngine(String engine) {
		DBPoolProperties.engine = engine;
	}

	public static String getDbHost() {
		return dbHost;
	}
	public static void setDbHost(String dbHost) {
		DBPoolProperties.dbHost = dbHost;
	}

	public static int getPort() {
		return port;
	}
	public static void setPort(int port) {
		DBPoolProperties.port = port;
	}
	
	public static String getDbUserName() {
		return dbUserName;
	}

	public static void setDbUserName(String dbUserName) {
		DBPoolProperties.dbUserName = dbUserName;
	}

	public static String getDbPassword() {
		return dbPassword;
	}

	public static void setDbPassword(String dbPassword) {
		DBPoolProperties.dbPassword = dbPassword;
	}

	public static int getcPoolMaxActive() {
		return cPoolMaxActive;
	}

	public static void setcPoolMaxActive(int cPoolMaxActive) {
		DBPoolProperties.cPoolMaxActive = cPoolMaxActive;
	}

	public static int getcPoolInitialSize() {
		return cPoolInitialSize;
	}

	public static void setcPoolInitialSize(int cPoolInitialSize) {
		DBPoolProperties.cPoolInitialSize = cPoolInitialSize;
	}

	public static int getcPoolMinIdleConnections() {
		return cPoolMinIdleConnections;
	}

	public static void setcPoolMinIdleConnections(int cPoolMinIdleConnections) {
		DBPoolProperties.cPoolMinIdleConnections = cPoolMinIdleConnections;
	}

	public static int getcPoolValidationInterval() {
		return cPoolValidationInterval;
	}

	public static void setcPoolValidationInterval(int cPoolValidationInterval) {
		DBPoolProperties.cPoolValidationInterval = cPoolValidationInterval;
	}
	
	public static void setDbType(String dbType) {
		DBPoolProperties.dbType = dbType;
	}

	public static String getDbType() {
		return dbType;
	}

	public static String getDbURL() {
		return dbURL;
	}

	public static void setDbURL(String dbURL) {
		DBPoolProperties.dbURL = dbURL;
	}
	
}
