package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LogoutController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		// admin
		int role = 0;
		try {
			role = Integer.parseInt(request.getParameter("role"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		if(role == 1) {
			session.removeAttribute("userAdmin");
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		
		// client
		session.removeAttribute("userInfo");
		session.removeAttribute("size");
		
	//	response.sendRedirect(request.getContextPath() + "/buy");
		response.sendRedirect(request.getContextPath() + "/home");
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
