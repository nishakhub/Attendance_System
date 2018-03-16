package org.vpmpt.attendancemanage.servlets;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DownloadServlet
 */
@WebServlet("/download")
public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DownloadServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/ms-excel");
		String fileName = request.getParameter("file");
		response.setHeader("Content-Disposition", "attachment; filename=\""+fileName+"\"");
		System.out.println("In Down load servlet");
		ServletOutputStream outputStream = response.getOutputStream();
		if(fileName!= null && !fileName.equalsIgnoreCase("")){
			String filePath = "D:/"+fileName;
			File file = new File(filePath);
			System.out.println("File created in Down load servlet");
			BufferedInputStream input = null;
			BufferedOutputStream output = null;
			
			try {
				input = new BufferedInputStream(new FileInputStream(file));
				output = new BufferedOutputStream(outputStream);

				byte[] buffer = new byte[8192];
				for (int length = 0; (length = input.read(buffer)) > 0;) {
					output.write(buffer, 0, length);
				}
				
			} finally {
				if (output != null) try { output.close(); } catch (IOException ignore) {}
				if (input != null) try { input.close(); } catch (IOException ignore) {}
			}
		}
		outputStream.flush();
		outputStream.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);	
	}
}
