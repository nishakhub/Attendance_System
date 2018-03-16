package org.vpmpt.attendancemanage.servlets;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class LoginCheckFilter
 */
//@WebFilter("/LoginCheckFilter")
public class LoginCheckFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginCheckFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("Filter called before calling JSP...");
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		HttpSession session = (HttpSession)httpRequest.getSession(false);
		if((null!= session && null!= session.getAttribute("user")) || httpRequest.getRequestURL().toString().endsWith("/login.jsp")
				||httpRequest.getRequestURL().toString().endsWith("/login") || httpRequest.getRequestURL().toString().endsWith(".js") || httpRequest.getRequestURL().toString().endsWith(".css")){
//			UserDTO user = (UserDTO);
			System.out.println("In if part...");
//			if(null!= session && null!= session.getAttribute("user")){
			chain.doFilter(httpRequest, httpResponse);
//			}else{
//				httpResponse.sendRedirect("login.jsp");
//			}
		}else{
			System.out.println("In else part...");
			httpResponse.sendRedirect("login.jsp");
		}
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
