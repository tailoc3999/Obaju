<%@page import="models.Product"%>
<%@page import="daos.ProductDAO"%>
<%@page import="utils.StringUtil"%>
<%@page import="models.Cart"%>
<%@page import="models.Item"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>
    <div id="all">
      <div id="content">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              <!-- breadcrumb-->
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Home</a></li>
                  <li aria-current="page" class="breadcrumb-item active">Shopping cart</li>
                </ol>
              </nav>
            </div>
            <div id="basket" class="col-lg-12">
            <%
            	Cart cart = null;
            	Object o = session.getAttribute("cart");
    			if (o != null) {
    				cart = (Cart) o;
    			} else {
    				cart = new Cart();
    			}
            	User u = null;
            	if((User) session.getAttribute("userInfo") != null) {
            		u = (User) session.getAttribute("userInfo");
            	}
            	List<Item> list = cart.getItemsByUser(u);
            	if(list != null && list.size() > 0){
            		
            %>
              <div class="box">
                <form name="f" method="post" action="<%=request.getContextPath() %>/checkout1">
                  <h1>Shopping cart</h1>
                  <p class="text-muted">You currently have <%=session.getAttribute("size") %> item(s) in your cart.</p>
                  <div class="table-responsive">
                    <table class="table">
                      <thead>
                        <tr>
                          <th colspan="2">Product</th>
                          <th>Quantity</th>
                          <th>Unit price</th>
                          <th>Discount</th>
                          <th colspan="2">Total</th>
                        </tr>
                      </thead>
                      <tbody>
                      <%
                      	for(Item item : list) {
                      %>
                        <tr>
                          <td><a href="<%=request.getContextPath() %>/detail?id=<%=item.getProduct().getId()%>"><img src="<%=request.getContextPath() %>/files/<%=item.getProduct().getThumbnail() %>" alt="<%=item.getProduct().getTitle()%>"></a></td>
                          <td><a href="<%=request.getContextPath() %>/detail?id=<%=item.getProduct().getId()%>"><%=item.getProduct().getTitle().length()>30?item.getProduct().getTitle().substring(0, 30):item.getProduct().getTitle() %></a></td>
                          <td>
                            <input name="<%=item.getProduct().getId() %>" type="number" value="<%=item.getQuantity() %>" class="form-control">
                          </td>
                          <td><%=StringUtil.FormatMoney(item.getPrice()) %></td>
                          <td>0₫</td>
                          <td><%=StringUtil.FormatMoney(item.getPrice() * item.getQuantity()) %></td>
                          <td><a href="<%=request.getContextPath() %>/process?id=<%=item.getProduct().getId() %>"><i class="fa fa-trash-o"></i></a></td>
                        </tr>
                      <% 
                      	}
                      %>
                      </tbody>
                      <tfoot>
                        <tr>
                          <th colspan="5">Total</th>
                          <th colspan="2"><%=StringUtil.FormatMoney(cart.TotalMoney()) %></th>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                  <!-- /.table-responsive-->
                  <div class="box-footer d-flex justify-content-between flex-column flex-lg-row">
                    <div class="left"><a href="<%=request.getContextPath() %>/home" class="btn btn-outline-secondary"><i class="fa fa-chevron-left"></i> Continue shopping</a></div>
                    <div class="right">
                      <button onclick="process()" class="btn btn-outline-secondary"><i class="fa fa-refresh"></i> Update cart</button>
                      <button type="submit" class="btn btn-primary">Proceed to checkout <i class="fa fa-chevron-right"></i></button>
                    </div>
                  </div>
                </form>
              </div>
              <!-- /.box-->
              <div class="row same-height-row">
                <div class="col-lg-3 col-md-6">
                  <div class="box same-height">
                    <h3>You may also like these products</h3>
                  </div>
                </div>
              <%
              	ProductDAO productDAO = new ProductDAO();
              	List<Product> relatedP = productDAO.getByCatId2(list.get(0).getProduct().getCat().getId(), list.get(0).getProduct().getId());
              	for(Product product : relatedP) {
              		
              %>  
                <div class="col-md-3 col-sm-6">
                  <div class="product same-height">
                    <div class="flip-container">
                      <div class="flipper">
                        <div class="front"><a href="<%=request.getContextPath() %>/detail?id=<%=product.getId() %>"><img src="<%=request.getContextPath() %>/files/<%=product.getThumbnail() %>" alt="" class="img-fluid"></a></div>
                        <div class="back"><a href="<%=request.getContextPath() %>/detail?id=<%=product.getId() %>"><img src="<%=request.getContextPath() %>/files/<%=product.getThumbnail() %>" alt="" class="img-fluid"></a></div>
                      </div>
                    </div><a href="<%=request.getContextPath() %>/detail?id=<%=product.getId() %>" class="invisible"><img src="<%=request.getContextPath() %>/files/<%=product.getThumbnail() %>" alt="" class="img-fluid"></a>
                    <div class="text">
                      <h3><%=product.getTitle() %></h3>
                      <p style="color:#4fbfa8;font-weight:bold" class="price"><%=StringUtil.FormatMoney(product.getPrice()) %></p>
                    </div>
                  </div>
                  <!-- /.product-->
                </div>
              <%
              	}
              %>  
                </div>
              </div>
            <%
            	} else {
            %>
            	<h1>Empty</h1>
            <%
            	}
            %>
            </div>
            <!-- /.col-lg-9-->
            <!-- /.col-md-3-->
          </div>
        </div>
      </div>
      <script type="text/javascript">
		function process() { 
			document.f.action = "/Fashion2" + "/process";
			document.f.submit();
		}
	  </script>
    </div>
   <%@ include file="/templates/public/inc/footer.jsp" %>