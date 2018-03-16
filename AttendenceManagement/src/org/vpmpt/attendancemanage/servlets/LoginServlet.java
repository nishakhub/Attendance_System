package org.vpmpt.attendancemanage.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.vpmpt.attendancemanage.beans.UserDTO;
import org.vpmpt.attendancemanage.utilities.CommonUtil;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			UserDTO userDTO = new CommonUtil().validateUser(request.getParameter("userName"), request.getParameter("password"));
			if(null!=userDTO){
				HttpSession session = request.getSession(true);
				session.setAttribute("user", userDTO);
//				out.write("username "+user.getUser_id()+". Address .. "+user.getAddress()+". UserDTO age.. "+user.getAge()+". user password.. "+user.getPassword());
				String contextPath = getServletContext().getContextPath();
				if(userDTO.getPasswordAuto().equals("N".charAt(0))){
					if(userDTO.getRole()==1){
						response.sendRedirect(contextPath+"/jsp/admin/index.jsp");
					}else if(userDTO.getRole()==2){
						response.sendRedirect(contextPath+"/jsp/staff/manage_leaves.jsp");
					}else if(userDTO.getRole()==3){
						response.sendRedirect(contextPath+"/jsp/student/manage_leaves.jsp");
					}
				}else if(userDTO.getPasswordAuto().equals("Y".charAt(0))) {
					response.sendRedirect(contextPath+"/change_password.jsp");
				}
			}else{
				System.out.println("UserDTO is null");
			}
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("UserDTO is null");
		}
	}

}
