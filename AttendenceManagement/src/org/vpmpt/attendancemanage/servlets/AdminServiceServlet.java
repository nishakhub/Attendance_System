package org.vpmpt.attendancemanage.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.vpmpt.attendancemanage.beans.AttendanceDTO;
import org.vpmpt.attendancemanage.beans.HolidayDTO;
import org.vpmpt.attendancemanage.beans.NotificationDTO;
import org.vpmpt.attendancemanage.beans.ReportDTO;
import org.vpmpt.attendancemanage.beans.UserDTO;
import org.vpmpt.attendancemanage.business.Attendance;
import org.vpmpt.attendancemanage.business.ExcelGenerator;
import org.vpmpt.attendancemanage.business.Holiday;
import org.vpmpt.attendancemanage.business.Notification;
import org.vpmpt.attendancemanage.business.Report;
import org.vpmpt.attendancemanage.business.User;
import org.vpmpt.attendancemanage.utilities.AMException;
import org.vpmpt.attendancemanage.utilities.DateUtil;
import org.vpmpt.attendancemanage.utilities.Constant;


/**
 * Servlet implementation class AdminServiceServlet
 */
@WebServlet("/adminService")
public class AdminServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminServiceServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		String requestType = request.getParameter("requestType");
		try{
			if(requestType.equalsIgnoreCase("addUser")){
				UserDTO userDTO = new UserDTO();
				userDTO.setFirstName(request.getParameter("firstName"));
				userDTO.setLastName(request.getParameter("lastName"));
				userDTO.setAge(Integer.parseInt(request.getParameter("age")));
				userDTO.setEmailId(request.getParameter("emailId"));
				userDTO.setSex(request.getParameter("sex").charAt(0));
				Date dob = DateUtil.stringToDate(request.getParameter("dob"), "dd/MM/yyyy");
				userDTO.setDob(dob);
				userDTO.setAddress(request.getParameter("address"));
				userDTO.setRole(Integer.parseInt(request.getParameter("role")));
				User user = new User();
				user.addUser(userDTO);
				System.out.println("Request dispatched Successfully to add user..");
				out.print("success");

			}else if(requestType.equalsIgnoreCase("getUsers")){
				Map<String, Object> criteriaMap = new HashMap<String, Object>();
				if(null != request.getParameter("userId") && !"".equalsIgnoreCase(request.getParameter("userId").trim()))
					criteriaMap.put("user_id", request.getParameter("userId"));
				if(null != request.getParameter("firstName") && !"".equalsIgnoreCase(request.getParameter("firstName").trim()))
					criteriaMap.put("first_name", "'"+request.getParameter("firstName")+"'");
				if(null != request.getParameter("lastName") && !"".equalsIgnoreCase(request.getParameter("lastName").trim()))
					criteriaMap.put("last_name", "'"+request.getParameter("lastName")+"'");
				if(null != request.getParameter("emailId") && !"".equalsIgnoreCase(request.getParameter("emailId").trim()))
					criteriaMap.put("email_id", "'"+request.getParameter("emailId")+"'");

				request.setAttribute("criteriaMap", criteriaMap);

				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/admin/all_user_table.jsp");
				dispatcher.forward(request, response);
				System.out.println("Request dispatched Successfully to get Users List");

			}else if(requestType.equalsIgnoreCase("deleteUsers")){
				System.out.println("ID's recieved from UI are .."+ request.getParameter("usersToBeDeleted"));
				User user = new User();
				user.deleteUser(request.getParameter("usersToBeDeleted"));
				System.out.println("User(s) "+request.getParameter("usersToBeDeleted") +" deleted successfully..");

			}else if (requestType.equalsIgnoreCase("addAttendance")) {
				Attendance attendance = new Attendance();
				System.out.println("addAttendance: User Ids - "+request.getParameter("userIdsPresent")+" Date - "+request.getParameter("attendanceDate"));
				List<String> userIdList = Arrays.asList(request.getParameter("userIdsPresent").split(","));
				Date presentDate = DateUtil.stringToDate(request.getParameter("attendanceDate"), "dd/MM/yyyy");
				attendance.addAttendance(userIdList, presentDate);
				System.out.println("Request dispatched Successfully for add Attendance..");

			}else if (requestType.equalsIgnoreCase("addHoliday")) {
				HolidayDTO holidayDTO = new HolidayDTO();
				Date holidayDate = DateUtil.stringToDate(request.getParameter("holidayDate"), "dd/MM/yyyy");
				System.out.println("Request dispatched Successfully for add Holiday.."+request.getParameter("holidayDate")+" Formatted date is.."+holidayDate);
				holidayDTO.setHolidayDate(holidayDate);
				holidayDTO.setDiscription(request.getParameter("holidayDiscription"));

				Holiday holiday = new Holiday();
				holiday.addHoliday(holidayDTO);
				System.out.println("Holiday added successfully...");

			}else if(requestType.equalsIgnoreCase("getHolidays")){
				System.out.println("Year in get holidays is ..."+request.getParameter("year"));
				request.setAttribute("year", request.getParameter("year"));

				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/admin/holiday_table.jsp");
				dispatcher.forward(request, response);
				System.out.println("Request dispatched Successfully to get Holidays List");
			}else if (requestType.equalsIgnoreCase("attendanceReport")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("");
				dispatcher.forward(request, response);
				System.out.println("Request dispatched Successfully for add Attendance..");

			}else if (requestType.equalsIgnoreCase("sendNotification")) {

				NotificationDTO notificationDTO = new NotificationDTO();
				notificationDTO.setSubject(request.getParameter("subject"));
				notificationDTO.setContent(request.getParameter("content"));
				notificationDTO.setUserId(Long.parseLong(request.getParameter("userId")));
				notificationDTO.setType(request.getParameter("type"));

				Notification notification = new Notification();
				notification.sendNotification(notificationDTO);
				System.out.println("Request dispatched Successfully  for send Notification messages..");

			}else if (requestType.equalsIgnoreCase("sendBroadcast")) {
				NotificationDTO notificationDTO = new NotificationDTO();
				notificationDTO.setSubject(request.getParameter("subject"));
				notificationDTO.setContent(request.getParameter("content"));
				notificationDTO.setType(request.getParameter("type"));

				Notification notification = new Notification();
				notification.sendBroadcast(notificationDTO);
				System.out.println("Request dispatched Successfully for send Broadcast messages..");

			}else if (requestType.equalsIgnoreCase("getUsersForAttendance")) {
				Map<String, Object> criteriaMap = new HashMap<String, Object>();
				if(null != request.getParameter("userType") && !"".equalsIgnoreCase(request.getParameter("userType").trim()))
					criteriaMap.put("user_id", request.getParameter("userId"));
				if(null != request.getParameter("studentClass") && !"".equalsIgnoreCase(request.getParameter("studentClass").trim()))
					criteriaMap.put("first_name", "'"+request.getParameter("firstName")+"'");

				request.setAttribute("criteriaMap", criteriaMap);

				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/admin/attendance_user_table.jsp");
				dispatcher.forward(request, response);
				System.out.println("Request dispatched Successfully to get Users for attendance.");

			}else if (requestType.equalsIgnoreCase("submitAttendance")) {
				
				
				System.out.println("Request dispatched Successfully to submit attendance.");
			}else if(requestType.equalsIgnoreCase("getReport")){
				String className = request.getParameter("className");
				String subectId = request.getParameter("subject");
				Map<String, String> paramMap = new HashMap<String, String>();
				paramMap.put("className", className);
				paramMap.put("subjectId", subectId);
				request.setAttribute("paramMap", paramMap);
				RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/admin/report_table.jsp");
				dispatcher.forward(request, response);
				System.out.println("Request dispatched Successfully to get Report.");
			}else if(requestType.equalsIgnoreCase("exportReport")){
				String className = request.getParameter("className");
				String subectId = request.getParameter("subject");
				Map<String, String> paramMap = new HashMap<String, String>();
				paramMap.put("className", className);
				paramMap.put("subjectId", subectId);
				request.setAttribute("paramMap", paramMap);
				Report report = new Report();
				report.setUserDTO((UserDTO)request.getSession().getAttribute("user"));
				report.setParamMap(paramMap);
				List<ReportDTO> reportList = report.getReportList();
				ExcelGenerator excelGen = new ExcelGenerator();
				String fileName = excelGen.getExcelSheet(reportList);
				String url = "http://localhost:8181/AttendenceManagement/download?file="+fileName;
				out.append(url);
				System.out.println("Request dispatched Successfully to get Report.");
			}
			else if(requestType.equalsIgnoreCase("addBulkAttendance")){
				Attendance attendance = new Attendance();
				String userIdList = "0";
				System.out.println("addBulkAttendance: User Ids - "+request.getParameter("userIdsAbsent")+" Date - "+request.getParameter("attendanceDate"));
				if(null != request.getParameter("userIdsAbsent")){
					userIdList = request.getParameter("userIdsAbsent");
				}
				String fromTime = request.getParameter("fromTime");
				String toTime = request.getParameter("toTime");
				String className = request.getParameter("classId");
				int subjectId = Integer.parseInt(request.getParameter("subjectId"));
				Date presentDate = DateUtil.stringToDate(request.getParameter("attendanceDate"), "dd/MM/yyyy");
				AttendanceDTO attendanceDTO = new AttendanceDTO();
				attendanceDTO.setFromTime(fromTime);
				attendanceDTO.setToTime(toTime);
				attendanceDTO.setPresentDate(presentDate);
				
				attendance.addBulkAttendance(userIdList, attendanceDTO, className, subjectId);
				System.out.println("Request dispatched Successfully for add Attendance..");
			}else if(requestType.equalsIgnoreCase("changePassword")){
				User user = new User();
				UserDTO userDTO = (UserDTO)request.getSession().getAttribute("user");
				String newPass = request.getParameter("newPassword");
				String oldPass = request.getParameter("oldPassword");
				
				if(userDTO.getPassword().equalsIgnoreCase(oldPass)){
					userDTO.setPassword(newPass);
					user.changePassword(userDTO);
					String contextPath = getServletContext().getContextPath();

					if(userDTO.getRole()==1){
						out.print(contextPath+"/jsp/admin/index.jsp");
					}else if(userDTO.getRole()==2){
						out.print(contextPath+"/jsp/staff/manage_leaves.jsp");
					}else if(userDTO.getRole()==3){
						out.print(contextPath+"/jsp/student/manage_leaves.jsp");
					}
				}else {
					response.sendError(1001);
				}
			}
			
		}catch (AMException e) {
			response.setStatus(e.getStatus());
		}catch (NumberFormatException e) {
			e.printStackTrace();
			response.setStatus(Constant.INVALID_NUMBER);
		}finally{
			out.flush();
			out.close();
		}
	}
}
