package org.vpmpt.attendancemanage.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.vpmpt.attendancemanage.beans.AdminDTO;
import org.vpmpt.attendancemanage.beans.StudentDTO;
import org.vpmpt.attendancemanage.beans.TeacherDTO;
import org.vpmpt.attendancemanage.beans.UserDTO;

public class CommonUtil {
	public UserDTO validateUser(String username, String password) throws AMException{
		UserDTO userDTO = null;
		try{
			Connection connection =	DBRawConnection.getInstance().getConnection();
			if(connection!= null){
				String sql="select password, first_name, last_name, email_id, role, age, sex, address, password_auto from users where user_id=?";

				PreparedStatement pst = connection.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
				pst.setInt(1, Integer.parseInt(username));
				ResultSet rs=pst.executeQuery();
				if(!rs.next()){
					throw new AMException();
				}/*else{
					rs.beforeFirst();*/
					do{
						if(rs.getString(1).equals(password)){
							if(rs.getInt(5)==1){
								userDTO = new AdminDTO();
							}else if(rs.getInt(5)==2){
								userDTO = new TeacherDTO();
							}else if(rs.getInt(5)==3){
								userDTO = new StudentDTO();
							}
							userDTO.setUserId(Long.parseLong(username));
							userDTO.setPassword(rs.getString(1));
							userDTO.setFirstName(rs.getString(2));
							userDTO.setLastName(rs.getString(3));
							userDTO.setEmailId(rs.getString(4));
							userDTO.setRole(rs.getInt(5));
							userDTO.setAge(rs.getInt(6));
							userDTO.setSex(rs.getString(7).charAt(0));
							userDTO.setAddress(rs.getString(8));
							userDTO.setPasswordAuto(rs.getString(9).charAt(0));
						}else{
							throw new AMException();
						}
					}while(rs.next());
//				}
			}else{
				throw new AMException();
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			throw new AMException();
		}
		return userDTO;
	}

}
