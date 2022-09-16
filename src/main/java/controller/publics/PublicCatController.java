package controller.publics;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.ProductDAO;
import models.Product;

public class PublicCatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ProductDAO productDAO;
	private static int offset = 0;

	public PublicCatController() {
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
			response.sendRedirect(request.getContextPath() + "/404");
			return;
		}
		
		int numberPerPage = 4;
		try {
			numberPerPage = Integer.parseInt(request.getParameter("num"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		if(numberPerPage < 1) {
			numberPerPage = 4;
		}
		
		int NumberOfProducts = productDAO.getNumberOfProducts(id);
		int NumberOfPages = (int) Math.ceil((float) NumberOfProducts / numberPerPage);
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		if(currentPage < 1 || currentPage > NumberOfPages) {
			currentPage = 1;
		}
		int offset = (currentPage - 1) * numberPerPage;

		//sort
		String sort_by = "";
		if(request.getParameter("sort_by") != null) {
			sort_by = request.getParameter("sort_by");
		}
		
		List<Product> products = productDAO.getPaginationByCatId(offset, id, numberPerPage, sort_by);
		
		//search
		if(request.getParameter("search") != null) {
			String search = request.getParameter("search");
			List<Product> listSearch = productDAO.findAllByName(search);
			NumberOfProducts = 0;
			
			products = listSearch;
		}
		
		request.setAttribute("products", products);
		request.setAttribute("numberofproducts", NumberOfProducts);
		request.setAttribute("numberofpages", NumberOfPages);
		request.setAttribute("currentpage", currentPage);
		request.setAttribute("offset", offset);

		RequestDispatcher rd = request.getRequestDispatcher("/views/public/category.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Load More
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		
		try {
		//	offset = Integer.parseInt(request.getParameter("aoffset"));
			offset = offset + 4;
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		System.out.println(offset);
		
		List<Product> products = productDAO.getPaginationByCatId(offset, id, 3, "");
		request.setAttribute("offset", offset);
		
		for(Product item : products) {
			response.getWriter().print(
				"<div class=\"col-lg-3 col-md-4\">"
				+ "<div class=\"product\">"
				+ "  <div class=\"flip-container\">"
				+ "    <div class=\"flipper\">"
				+ "      <div class=\"front\"><a href=\""+request.getContextPath() + "/detail?id=" + item.getId() + "\"><img src=\"" + request.getContextPath() +"/files/" + item.getThumbnail() + "\" alt=\"\" class=\"img-fluid\"></a></div>"
				+ "        <div class=\"back\"><a href=\"" + request.getContextPath() + "/detail?id=" + item.getId() + "\"><img src=\"" + request.getContextPath() + "/files/" + item.getThumbnail() + "\" alt=\"\" class=\"img-fluid\"></a></div>"
				+ "        </div>"
				+ "      </div><a href=\"" + request.getContextPath() + "/detail?id=" + item.getId() + "\" class=\"invisible\"><img src=\"" + request.getContextPath() + "/resources/public/img/product1.jpg\" alt=\"\" class=\"img-fluid\"></a>"
				+ "    <div class=\"text\">"
				+ "    <h3><a href=\"" + request.getContextPath() + "/detail?id=" +item.getId() + "\">" + item.getTitle() + "</a></h3>"
				+ "        <p class=\"price\"> "
				+ "         <del></del><span style='color:#4fbfa8;font-weight:bold'>" + item.getPrice() + "₫</span>"
				+ "                      </p>"
				+ "                      <p class=\"buttons\"><a href=\"" + request.getContextPath() + "/detail?id=" + item.getId() + "\" class=\"btn btn-outline-secondary\">View detail</a><a href=\"basket.html\" class=\"btn btn-primary\"><i class=\"fa fa-shopping-cart\"></i>Add to cart</a></p>"
				+ "                    </div>"
				+ "                    <!-- /.text-->"
				+ "                  </div>"
				+ "                  <!-- /.product            -->"
				+ "</div>"
			);
		}
	}

}
