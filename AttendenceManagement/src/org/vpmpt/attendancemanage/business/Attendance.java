package org.vpmpt.attendancemanage.business;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.vpmpt.attendancemanage.beans.AttendanceDTO;
import org.vpmpt.attendancemanage.utilities.DBRawConnection;

public class Attendance {

	public void addAttendance(List<String> userIdList, java.util.Date presentDate){
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedStatement = null;
		try{
			for(String userId : userIdList){
				preparedStatement = conn.prepareStatement("insert into attendance (present_date, user_id, added_date) values (?, ?, ?)");
				preparedStatement.setDate(1, new Date(presentDate.getTime()));
				preparedStatement.setString(2, userId);
				preparedStatement.setDate(3, new Date(new java.util.Date().getTime()));
				preparedStatement.execute();
			}
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

	public void addBulkAttendance(String userIdList, AttendanceDTO attendaceDTO, String classId, int subjectId) {
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedStatement = null;
		Statement statement =  null;
		ResultSet rs = null;
		String sqlString = "select student_id from student where student_id not in ("+userIdList+") and class_id = (select class_id from class where name ='"+classId+"')";
		String insertString = "insert into attendance (present_date, user_id, subject_id, from_time, to_time, added_date) values (?,?, ?, ?, ?,?)";
		try{
				statement = conn.createStatement();
				rs = statement.executeQuery(sqlString);
				preparedStatement = conn.prepareStatement(insertString);
				if(null !=rs && rs.next()){
					do{
						preparedStatement.setDate(1, new Date(attendaceDTO.getPresentDate().getTime()));
						preparedStatement.setInt(2, rs.getInt(1));
						preparedStatement.setInt(3, subjectId);
						preparedStatement.setString(4, attendaceDTO.getFromTime());
						preparedStatement.setString(5, attendaceDTO.getToTime());
						preparedStatement.setDate(6, new Date(new java.util.Date().getTime()));
						preparedStatement.addBatch();
					}while(rs.next());
				}
				preparedStatement.executeBatch();
				
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if( null != preparedStatement){
					preparedStatement.close();
				}
				if( null != statement){
					statement.close();
				}
				if( null != rs){
					rs.close();
				}
				if( null != conn){
					conn.close();
				}
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
