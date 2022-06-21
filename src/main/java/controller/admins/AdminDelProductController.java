package controller.admins;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.ProductDAO;
import models.Product;

public class AdminDelProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;

	public AdminDelProductController() {
		super();
		productDAO = new ProductDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=3");
			return;
		}
		
		Product product = productDAO.getbyId(id);
		if (product == null) {
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=2");
			return;
		}
		
		if(productDAO.del(id) > 0) {
			// success
			// xóa ảnh
			final String dirPartName = request.getServletContext().getRealPath("/files");
			String picture = product.getThumbnail();
			if (!picture.isEmpty()) {
				String filePartName = dirPartName + File.separator + picture;
				System.out.println(filePartName);
				File file = new File(filePartName);
				if (file.exists()) {
					file.delete();
				}
			}
			response.sendRedirect(request.getContextPath() + "/admin/product/index?msg=3");
			return;
		} else {
			//fail
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=3");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
