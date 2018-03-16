package org.vpmpt.attendancemanage.business;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.vpmpt.attendancemanage.beans.AdminDTO;
import org.vpmpt.attendancemanage.beans.ReportDTO;
import org.vpmpt.attendancemanage.beans.UserDTO;
import org.vpmpt.attendancemanage.utilities.DBRawConnection;

public class Report {

	private UserDTO userDTO;
	private Map<String, String> paramMap;

	public Map<String, String> getParamMap() {
		return paramMap;
	}

	public void setParamMap(Map<String, String> paramMap) {
		this.paramMap = paramMap;
	}

	public UserDTO getUserDTO() {
		return userDTO;
	}

	public void setUserDTO(UserDTO userDTO) {
		this.userDTO = userDTO;
	}

	public AdminDTO getTeacherInfo(){
		AdminDTO teacherDTO = (AdminDTO)userDTO;
		Map<String, List<String>> classSubjectMap = new HashMap<String, List<String>>();
		Connection conn = DBRawConnection.getInstance().getConnection();
		StringBuilder queryString = new StringBuilder("select cl.name, su.subject_name from class cl, subject su where teacher_id = 10000 and su.class_id = cl.class_id order by cl.name");
		System.out.println("Created query String is for getting teacher subjects... "+queryString);
		Statement statement = null;
		ResultSet rs = null;
		try{
			statement = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs =  statement.executeQuery(queryString.toString());
			if(null != rs && rs.next()){
				String className = rs.getString(1);
				String subject = rs.getString(2);
				List<String> subList = new ArrayList<String>();
				while (rs.next()) {
					subList.add(subject);
					if(className!=null &&  className.equalsIgnoreCase(rs.getString(1))){
						subject=rs.getString(2);
					}else{
						classSubjectMap.put(className, subList);
						className = rs.getString(1);
						subject=rs.getString(2);
						subList = new ArrayList<String>();
					}
				}
				subList.add(subject);
				classSubjectMap.put(className, subList);
				for(String class1 : classSubjectMap.keySet()){
					System.out.println("class is "+class1+". List is "+classSubjectMap.get(class1));
				}
				teacherDTO.setClassSubjectMap(classSubjectMap);
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
		return teacherDTO;
	}

	public List<String> getClassList(){


		return null;
	}

	public List<ReportDTO> getReportList(){
		List<ReportDTO> reportList = new ArrayList<>();
		Connection conn = DBRawConnection.getInstance().getConnection();
		StringBuilder queryString = new StringBuilder("SELECT u.user_id, concat(u.first_name, ' ', u.last_name) from users u where u.user_id in (SELECT s.student_id from  student s where s.class_id = (select class_id from class where name = '"+paramMap.get("className")+"'))");
		System.out.println("Created query String is for getting teacher subjects... "+queryString);
		String totalDayCountQuery = "select count(distinct present_date) from attendance where subject_id = 4";
		Statement statement = null;
		Statement statement2 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;	
		try{
			statement = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			statement2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs =  statement.executeQuery(totalDayCountQuery);
			rs.next();
			float totatDaysCount = rs.getFloat(1);
			rs1 = statement.executeQuery(queryString.toString());
			String percentQuery = "select count(distinct present_date), user_id from attendance where subject_id = "+Integer.parseInt(paramMap.get("subjectId"))+" and user_id in (SELECT s.student_id from  student s where s.class_id = (select class_id from class where name = '"+paramMap.get("className")+"')) group by user_id";
			rs2 = statement2.executeQuery(percentQuery);

			if(null != rs1 && rs1.next()){
				do{
					ReportDTO reportDTO = new ReportDTO();
					reportDTO.setUserId(rs1.getLong(1));
					reportDTO.setStudentName(rs1.getString(2));
					long userIdFromUsers = rs1.getLong(1);
					reportDTO.setTotalDays((int)totatDaysCount);
					if(null !=rs2 && rs2.next()){
						inner : do{
							long userIdFromAttendance = rs2.getLong(2);
							if(userIdFromUsers==userIdFromAttendance){
								float userAttendanceCount = rs2.getInt(1);
								float percentage = (userAttendanceCount/totatDaysCount)*100;
								reportDTO.setPresentDays((int)userAttendanceCount);
								reportDTO.setPercentage(percentage);
								break inner;
							}
						}while(rs2.next());
					reportList.add(reportDTO);
					rs2.beforeFirst();
					}
				}while(rs1.next());

			}
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if(null != rs){
					rs.close();
				}
				if(null != rs1){
					rs1.close();
				}
				if(null != rs2){
					rs2.close();
				}
				if(null != statement){
					statement.close();
				}
				if(null != statement2){
					statement2.close();
				}
				if( null != conn){
					conn.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}

		return reportList;
	}
}

