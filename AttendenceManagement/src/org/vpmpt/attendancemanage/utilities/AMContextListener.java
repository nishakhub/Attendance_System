package org.vpmpt.attendancemanage.utilities;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.apache.log4j.Logger;

@WebListener
public class AMContextListener implements ServletContextListener {

	private static Logger log = Logger.getLogger(AMContextListener.class);
	public AMContextListener() {

	}

	public void contextInitialized(ServletContextEvent eve) {
		try{
			log.debug("Intiallizing database properties...");
			
			//DBConnection.initProperties();
			log.info("All database properties initialized.");
		}catch(Exception e){
			log.error("Failed to initiallize database properties.", e);
		}
	}

	public void contextDestroyed(ServletContextEvent eve) {
		log.info("Distroying connection pool.");
		log.info("Report Application Context destroyed.");
	}
}
