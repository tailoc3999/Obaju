package controller.admins;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import daos.CategoryDAO;
import daos.ProductDAO;
import models.Category;
import models.Product;

@MultipartConfig
public class AdminAddProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CategoryDAO catDAO;
	private ProductDAO productDAO;

	public AdminAddProductController() {
		super();
		catDAO = new CategoryDAO();
		productDAO = new ProductDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Category> catList = catDAO.getAll();

		request.setAttribute("catlist", catList);

		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/product/add.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String title = request.getParameter("title");
		int cat_id = 0;
		try {
			cat_id = Integer.parseInt(request.getParameter("category"));
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		int price = 0;
		try {
			price = Integer.parseInt(request.getParameter("price"));
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		String description = request.getParameter("description");

		Part filePart = request.getPart("picture");
		String fileName = filePart.getSubmittedFileName();
		if (!"".equals(fileName)) {
			String rootPath = request.getServletContext().getRealPath("");
			String dirUploadPath = rootPath + "files";
			File createDir = new File(dirUploadPath);

			if (!createDir.exists()) {
				createDir.mkdir();
			}
			// string, string builder
			StringBuilder sb = new StringBuilder();
			String filePath = sb.append(dirUploadPath).append(File.separator).append(fileName).toString();
			filePart.write(filePath); // Truy???????n v????o ????????????????ng d??????n upload file
			System.out.println("dirUploadPath :" + dirUploadPath);
		}

		Product product = new Product(cat_id, title, price, fileName, description);

		if (productDAO.add(product) > 0) {
			// success
			response.sendRedirect(request.getContextPath() + "/admin/product/index?msg=1");
			return;
		} else {
			// fail
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/product/add?err=1");
			rd.forward(request, response);
			return;
		}
	}

}
