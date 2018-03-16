package org.vpmpt.attendancemanage.utilities;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static Date stringToDate(String date, String format) throws AMException{
		Date d = null;
		try {
			SimpleDateFormat formatter = new SimpleDateFormat(format); 
			d = formatter.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			throw new AMException(Constant.INVALID_DATE_FORMAT);
		}
		return d;
	}

}
