package controller.admins;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import daos.CategoryDAO;
import daos.GaleryDAO;
import daos.ProductDAO;
import models.Category;
import models.Galery;
import models.Product;
import utils.FileUtil;

@MultipartConfig
public class AdminEditProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;
	private CategoryDAO categoryDAO;
	private GaleryDAO galeryDAO;

	public AdminEditProductController() {
		super();
		productDAO = new ProductDAO();
		categoryDAO = new CategoryDAO();
		galeryDAO = new GaleryDAO();
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
		List<Galery> images = galeryDAO.getByProductId(id);

		request.setAttribute("images", images);
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
		List<Galery> oldGalery = galeryDAO.getByProductId(id);
		

		String title = request.getParameter("title");
		int cat_id = Integer.parseInt(request.getParameter("category"));
		int price = Integer.parseInt(request.getParameter("price"));
		String descreiption = request.getParameter("description");

		// process image
		try {
			final String dirPartName = request.getServletContext().getRealPath("/files");
			File dirFile = new File(dirPartName);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}

			// get new images
			List<Galery> galery = new ArrayList<Galery>();
			Collection<Part> parts = request.getParts();
			int j = 0;
			for (Part filePart : parts) {
				String fileName2 = FileUtil.getName(filePart);
				if (fileName2 != null) {
					fileName2 = FileUtil.rename(fileName2);
					if(oldGalery.size() > galery.size()) {
						Galery a =  new Galery(oldGalery.get(j).getId(), new Product(id), fileName2);
						galery.add(a);
					} else {
						Galery a =  new Galery(new Product(id), fileName2);
						galery.add(a);
					}
					
					// write file
					if(!fileName2.isEmpty()) {
						String filePartName = dirPartName + File.separator + fileName2;
						System.out.println(filePartName);
						filePart.write(filePartName);
					}
					j++;
				}
			}

			String picture = "";
			if (oldProduct != null) {
				if (galery.get(0).getThumbnail().isEmpty()) {
					picture = oldProduct.getThumbnail();
				} else {
					picture = galery.get(0).getThumbnail();
				}

				oldProduct.setTitle(title);
				oldProduct.setCat(new Category(cat_id));
				oldProduct.setPrice(price);
				oldProduct.setDescription(descreiption);
				oldProduct.setThumbnail(picture);
			}
			//productDAO.edit(oldProduct, galery)
			if (productDAO.edit(oldProduct, galery) > 0) {
				// success
				int i = 0;
				for (Galery item : galery) {
					if (!item.getThumbnail().isEmpty() && i < oldGalery.size()) {
						// delete old file
						String oldFilePartName = dirPartName + File.separator + oldGalery.get(i).getThumbnail();
						System.out.println(oldFilePartName);
						File oldFile = new File(oldFilePartName);
						if (oldFile.exists()) {
							System.out.println("del success");
							oldFile.delete();
						} else {
							System.out.println("del error");
						}
					}
					i++;
					System.out.println(item);
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
		} catch (Exception e) {
			System.out.println("error");
			e.printStackTrace();
		}
	}

}
