package controller.publics;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.AuthUtil;

public class PublicCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public PublicCartController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if(AuthUtil.CheckLogin(request, response)) {
			RequestDispatcher rd = request.getRequestDispatcher("/views/public/basket.jsp");
			rd.forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath()  + "/auth/login");
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
