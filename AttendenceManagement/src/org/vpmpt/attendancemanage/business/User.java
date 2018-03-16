package org.vpmpt.attendancemanage.business;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.sql.PreparedStatement;

import org.vpmpt.attendancemanage.beans.UserDTO;
import org.vpmpt.attendancemanage.utilities.DBRawConnection;

public class User {
	
	private Map<String, Object> criteriaMap;
	
	public User(){
		
	}
	
	public User(Map<String, Object> criteriaMap){
		this.criteriaMap = criteriaMap;
	}

	public void addUser(UserDTO userDto){
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedStatement = null;
		try{
			preparedStatement = conn.prepareStatement("insert into users (password, first_name, last_name, email_id, role, age, sex, address, dob, updated_date, created_date) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			preparedStatement.setString(1, "temppass");
			preparedStatement.setString(2, userDto.getFirstName());
			preparedStatement.setString(3, userDto.getLastName());
			preparedStatement.setString(4, userDto.getEmailId());
			preparedStatement.setInt(5, userDto.getRole());
			preparedStatement.setInt(6, userDto.getAge());
			preparedStatement.setString(7, userDto.getSex()+"");
			preparedStatement.setString(8, userDto.getAddress());
			preparedStatement.setDate(9, new Date(userDto.getDob().getTime()));
			preparedStatement.setDate(10, new Date(new java.util.Date().getTime()));
			preparedStatement.setDate(11, new Date(new java.util.Date().getTime()));
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

	public void updateUser(UserDTO usetDto){
		Connection conn = DBRawConnection.getInstance().getConnection();
		try{
			PreparedStatement preparedStatement = conn.prepareStatement("insert into users () values (?, ?, ?, ?, ?, ?, ?, )");
			preparedStatement.setString(1, "temppass");
			preparedStatement.setString(2, usetDto.getFirstName());
			preparedStatement.setString(3, usetDto.getLastName());
			preparedStatement.setString(4, usetDto.getEmailId());
			preparedStatement.setInt(5, usetDto.getRole());
			preparedStatement.setInt(6, usetDto.getAge());
			preparedStatement.setString(7, usetDto.getSex()+"");
			preparedStatement.setString(8, usetDto.getAddress());
			preparedStatement.setDate(9, new Date(new java.util.Date().getTime()));
			preparedStatement.setInt(6, usetDto.getAge());
			preparedStatement.execute();
		}catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public String getRandomPassword() {
		String randomPassword = "";

		return randomPassword;
	}

	public UserDTO getUser(){

		return null;
	}

	public void deleteUser(UserDTO usetDto){

	}
	
	public void deleteUser(String userIds){
		Connection conn = DBRawConnection.getInstance().getConnection();
		PreparedStatement preparedSattement = null;
		try{
			preparedSattement = conn.prepareStatement("delete from users where user_id in (?)");
			preparedSattement.setString(1, userIds);
			preparedSattement.execute();
			
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if( null != preparedSattement){
					preparedSattement.close();
				}
				if( null != conn){
					conn.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

	public List<UserDTO> getUserList(){
		Connection conn = DBRawConnection.getInstance().getConnection();
		StringBuilder queryString = new StringBuilder("select * from users");
		List<UserDTO> userList = new ArrayList<UserDTO>(); 
		System.out.println("Map is ... "+criteriaMap);
		if(null != criteriaMap && criteriaMap.size()> 0){
			queryString.append(" where ");
			String mapString = criteriaMap.toString().replace("{", "").replace("}", "");
			queryString.append(mapString.replaceAll(",", " and"));
		}
		String query = queryString.toString();
		System.out.println("Created query String is ... "+query);
		Statement statement = null;
		ResultSet rs = null;
		try{
			statement = conn.createStatement();
			rs =  statement.executeQuery(queryString.toString());
			if(null != rs){
				while (rs.next()) {
					UserDTO userDto = new UserDTO();
					userDto.setUserId(rs.getInt(1));
					userDto.setFirstName(rs.getString(3));
					userDto.setLastName(rs.getString(4));
					userDto.setEmailId(rs.getString(5));
					userDto.setRole(rs.getInt(6));
					userDto.setAge(rs.getInt(7));
					userDto.setSex(rs.getString(8).charAt(0));
					userDto.setAddress(rs.getString(9));
					userDto.setDob(rs.getDate(10));
					userDto.setDesignation(rs.getString(11));
					
					userList.add(userDto);
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
		return userList;
	}
	
	public void changePassword(UserDTO userDTO){
		Connection conn = DBRawConnection.getInstance().getConnection();
		Statement statement = null;
		try{
			statement = conn.createStatement();
			statement.executeUpdate("update users set password= '"+userDTO.getPassword()+"', password_auto = 'N' where user_id ="+userDTO.getUserId());
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if( null != statement){
					statement.close();
				}
				if( null != conn){
					conn.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

	public Map<String, Object> getCriteriaMap() {
		return criteriaMap;
	}

	public void setCriteriaMap(Map<String, Object> criteriaMap) {
		this.criteriaMap = criteriaMap;
	}
	
	
	
}
