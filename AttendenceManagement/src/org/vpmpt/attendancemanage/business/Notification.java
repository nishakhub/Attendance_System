package org.vpmpt.attendancemanage.business;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.vpmpt.attendancemanage.beans.NotificationDTO;
import org.vpmpt.attendancemanage.beans.UserDTO;
import org.vpmpt.attendancemanage.utilities.DBRawConnection;

public class Notification {
	
	private UserDTO user;

	public void sendNotification(NotificationDTO notificationDTO){
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedStatement = null;
		try{
			preparedStatement = conn.prepareStatement("insert into notifications (subject, content, notification_type, user_id, sent_date) values (?, ?, ?, ?, ?)");
			preparedStatement.setString(1, notificationDTO.getSubject());
			preparedStatement.setString(2, notificationDTO.getContent());
			preparedStatement.setString(3, notificationDTO.getType()+"");
			preparedStatement.setLong(4, notificationDTO.getUserId());
			preparedStatement.setDate(5, new Date(new java.util.Date().getTime()));
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
	
	public void sendBroadcast(NotificationDTO notificationDTO){
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedStatement = null;
		try{
			preparedStatement = conn.prepareStatement("insert into notifications (subject, content, notification_type, user_id, sent_date) values (?, ?, ?, ?, ?)");
			preparedStatement.setString(1, notificationDTO.getSubject());
			preparedStatement.setString(2, notificationDTO.getContent());
			preparedStatement.setString(3, notificationDTO.getType()+"");
			preparedStatement.setLong(4, 0l);
			preparedStatement.setDate(5, new Date(new java.util.Date().getTime()));
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
	
	public List<NotificationDTO> getNotifications(){
		List<NotificationDTO> notificationList = new ArrayList<NotificationDTO>();
	
		
		return notificationList;
	}
	
	public List<NotificationDTO> getBroadcasts(){
		List<NotificationDTO> broadcastList = new ArrayList<NotificationDTO>();
		
		return broadcastList;
	}
	
	public List<NotificationDTO> getAllNotificationsForUser(){
		List<NotificationDTO> userNotificationsList = new ArrayList<NotificationDTO>();
		Connection conn = DBRawConnection.getInstance().getConnection();
		StringBuilder queryString = new StringBuilder("select * from notifications where user_id="+user.getUserId());
		String query = queryString.toString();
		System.out.println("Created query String is ... "+query);
		Statement statement = null;
		ResultSet rs = null;
		try{
			statement = conn.createStatement();
			rs =  statement.executeQuery(queryString.toString());
			if(null != rs){
				while (rs.next()) {
					NotificationDTO notificationDTO = new NotificationDTO();
					notificationDTO.setNotificationId(rs.getInt(1));
					notificationDTO.setSubject(rs.getString(2));
					notificationDTO.setContent(rs.getString(3));
					notificationDTO.setType(rs.getString(4));
					notificationDTO.setUserId(rs.getInt(5));
					notificationDTO.setSentDate(rs.getDate(6));
					
					userNotificationsList.add(notificationDTO);
				}
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
		return userNotificationsList;
	}

	public UserDTO getUser() {
		return user;
	}

	public void setUser(UserDTO user) {
		this.user = user;
	}
	
}
