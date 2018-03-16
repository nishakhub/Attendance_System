package org.vpmpt.attendancemanage.utilities;

public class Constant {

	//DB Params
	public final static String DB_PROPERTY_FILE = "report_db.properties";
	public final static String TENANT_DB_PROPERTY_FILE = "TenantDB.properties";
	public final static String BACKUP_DB_PROPERTY_FILE = "BackUpDB.properties";
	public final static String BACKOFFICE_DB_PROPERTY_FILE = "BackOfficeDB.properties";
	public final static String DB_DRIVER = "driver";
	public final static String DB_URL = "db_url";
	public final static String DB_USER_NAME = "username";
	public final static String USER_PASSWORD = "password";
	public final static String TENANT_DB_URL = "tanant_db_url";
	public final static String BACKOFFICE_DB_URL = "backoffice_db_url";
	public final static String BACKUP_DB_URL = "backup_db_url";
	
	//pool properties
	public final static String  CONNECTION_RETRY_COUNT = "connection_retry_count";
	public final static String  CONNECTION_RETRY_WAIT = "connection_retry_wait";
	
	public final static String  MAX_POOL_SIZE = "max_pool_size";
	public final static String  MIN_POOL_SIZE = "min_pool_size";
	public final static String  MAX_IDLE_TIME = "max_idle_time";
	
	//pool test param
	public final static String  TEST_QUERY = "testQuery";
	public final static String  TEST_ON_CHECKOUT = "testConnectionOnCheckout";
	
	
	public final static String  MAX_ACTIVE_CONNECTION = "max_active_connections";
	public final static String  INITIAL_POOL_SIZE = "initial_pool_size";
	public final static String  MIN_IDLE_CONN = "min_idle_connections";
	public final static String  CONN_VALIDATION_INTERVAL = "conn_validation_interval";
	public final static String  IDLE_CONNECTION_TEST_PERIOD = "idle_connection_test_period";
	
	//DATE Formats
	
	public final static String  USER_DATE_FORMAT = "dd MMMM, yyyy";
	public final static String QUERY_DATE_FORMAT = "yyyy-MM-dd";
	
	//EPS Report constants
	
	public final static int  ANTI_MALWARE_REPORT = 101;
	public final static int  APPLICATION_CONTROL_REPORT = 102;
	public final static int  DDOS_ATTACK_REPORT = 103;
	public final static int  DEVICE_CONTROL_REPORT = 104;
	public final static int  IPS_REPORT = 105;
	public final static int  PORT_SCAN_REPORT = 106;
	public final static int  VIRUS_SCAN_REPORT = 107;
	public final static int  VULNERABILITY_SCAN_REPORT = 108;
	public final static int  WEB_SECURITY_REPORT = 109;
	
	//UTM Report constants
	
	public final static int  INTERNET_USAGE_REPORT = 201;
	public final static int  INTRUSION_PREVENTION_REPORT = 202;
	public final static int  MAIL_PROTECTION_REPORT = 203;
	public final static int  POLICY_BREACH_ATTEMPTS_REPORT = 204;
	public final static int  WEB_ACCESS_REPORT = 205;
	public final static int  WEB_PROTECTION_REPORT = 206;
	
	 
	public final static int  NOTIFICATIONS = 301;
	public final static int  ACTIVITY_LOGS = 302;
	
	//ERROR constant
	
	public final static int  INTERNAL_SERVER_ERROR = 500;
	public final static int  RESOURCE_NOT_FOUND = 404;
	public final static int  PARAMETERS_EMPTY = 1001;
	public final static int  DATE_EMPTY = 1002;
	public final static int  INVALID_DATE_FORMAT = 1003;
	public final static int  INVALID_FILE_TYPE = 1004;
	public final static int  INVALID_REPORT_NAME = 1005;
	public final static int  INVALID_NUMBER = 1006;
	
	
}
