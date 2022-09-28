package controller.admins;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.GaleryDAO;
import daos.ProductDAO;
import models.Galery;
import models.Product;

public class AdminDelProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;
	private GaleryDAO galeryDAO;

	public AdminDelProductController() {
		super();
		productDAO = new ProductDAO();
		galeryDAO = new GaleryDAO();
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
		List<Galery> images = galeryDAO.getByProductId(id);
		if (product == null) {
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=2");
			return;
		}
		
		if(productDAO.del(id) > 0) {
			// success
			// xóa ảnh
			final String dirPartName = request.getServletContext().getRealPath("/files");
			for(Galery image : images) {
				if(!image.getThumbnail().isEmpty()) {
					String filePartName = dirPartName + File.separator + image.getThumbnail();
					System.out.println(filePartName);
					File file = new File(filePartName);
					if (file.exists()) {
						System.out.println("success");
						file.delete();
					}
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
