package org.vpmpt.attendancemanage.business;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.vpmpt.attendancemanage.beans.HolidayDTO;
import org.vpmpt.attendancemanage.utilities.DBRawConnection;

public class Holiday {
	
	private String year;
	
	public Holiday(){
	}
	
	public Holiday(String year){
		this.year = year;
	}

	public void addHoliday(HolidayDTO holidayDTO){
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedStatement = null;
		try{
			preparedStatement = conn.prepareStatement("insert into holidays (holiday_date, discription, added_date) values(?, ?, ?)");
			preparedStatement.setDate(1, new Date(holidayDTO.getHolidayDate().getTime()));
			preparedStatement.setString(2, holidayDTO.getDiscription());
			preparedStatement.setDate(3, new Date(new java.util.Date().getTime()));
			preparedStatement.execute();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if( null != preparedStatement){
					preparedStatement.close();
				}
				if( null != conn){
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public List<HolidayDTO> getHolidays(){
		String startDate = "01/01/"+year;
		String endDate = "31/12/"+year;

		Connection conn = DBRawConnection.getInstance().getConnection();
		StringBuilder queryString = new StringBuilder("select * from holidays where holiday_date between STR_TO_DATE('"+startDate+"', '%d/%m/%Y') and STR_TO_DATE('"+endDate+"', '%d/%m/%Y')");
		List<HolidayDTO> holidayList = new ArrayList<HolidayDTO>(); 
		Statement statement = null;
		ResultSet rs = null;
		try{
			statement = conn.createStatement();
			rs =  statement.executeQuery(queryString.toString());
			if(null != rs){
				while (rs.next()) {
					HolidayDTO holidayDTO = new HolidayDTO();
					holidayDTO.setId(rs.getInt(1));
					holidayDTO.setHolidayDate(rs.getDate(2));
					holidayDTO.setDiscription(rs.getString(3));
					holidayDTO.setCreatedDate(rs.getDate(4));

					holidayList.add(holidayDTO);
				}
				System.out.println("getHoliday query string is .."+queryString.toString()+" Holiday list size is .."+holidayList.size()+" year is .."+year);
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if(null != rs){
					rs.close();
				}
				if(null != statement){
					statement.close();
				}
				if( null != conn){
					conn.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return holidayList;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}
}


