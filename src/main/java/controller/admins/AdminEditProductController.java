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
import utils.FileUtil;

@MultipartConfig
public class AdminEditProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;
	private CategoryDAO categoryDAO;

	public AdminEditProductController() {
		super();
		productDAO = new ProductDAO();
		categoryDAO = new CategoryDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=1");
			return;
		}
		
		Product product = productDAO.getbyId(id);
		List<Category> catList = categoryDAO.getAll();
		
		request.setAttribute("product", product);
		request.setAttribute("catlist", catList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/product/edit.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int id;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/admin/product/index?err=1");
			return;
		}
		// lấy dữ liệu cũ
		Product oldProduct = productDAO.getbyId(id);
		
		String title = request.getParameter("title");
		int cat_id = Integer.parseInt(request.getParameter("category"));
		int price = Integer.parseInt(request.getParameter("price"));
		String descreiption = request.getParameter("description");
		Part filePart = request.getPart("picture");
		
		final String dirPartName = request.getServletContext().getRealPath("/files");
		File dirFile = new File(dirPartName);
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}
		// láº¥y tÃªn file tá»« part
		String fileName = FileUtil.getName(filePart);
		// Ä‘á»•i tÃªn file
		String picture = "";
		String oldPicture = "";
		if(oldProduct != null) {
			oldPicture = oldProduct.getThumbnail();
			if (fileName.isEmpty()) {
				picture = oldProduct.getThumbnail();
			} else {
				picture = FileUtil.rename(fileName);
			}
			
			oldProduct.setTitle(title);
			oldProduct.setCat(new Category(cat_id));
			oldProduct.setPrice(price);
			oldProduct.setDescription(descreiption);
			oldProduct.setThumbnail(picture);
		}
		// Ä‘Æ°á»�ng dáº«n file
		String filePartName = dirPartName + File.separator + picture;
		
		if (productDAO.edit(oldProduct) > 0) {
			// success
			if (!fileName.isEmpty()) {
				// del old file
				String oldFilePartName = dirPartName + File.separator + oldPicture;
				System.out.println(oldFilePartName);
				File oldFile = new File(oldFilePartName);
				if (oldFile.exists()) {
					oldFile.delete();
				//	System.out.println("Ä‘Ã£ xÃ³a");
				} else {
				//	System.out.println("chÆ°a xÃ³a");
				}
				// ghi file
				filePart.write(filePartName);
			}
			response.sendRedirect(request.getContextPath() + "/admin/product/index?msg=2");
			return;
		} else {
			// fail
			List<Category> catList = categoryDAO.getAll();
			request.setAttribute("catlist", catList);
			
			RequestDispatcher rd = request.getRequestDispatcher("/views/admin/product/edit.jsp?err=1&id=" + id);
			rd.forward(request, response);
			return;
		}
	}

}
