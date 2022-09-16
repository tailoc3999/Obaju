<%@page import="utils.StringUtil"%>
<%@page import="models.Item"%>
<%@page import="models.Cart"%>
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
                  <li class="breadcrumb-item"><a href="/Fashion2/home">Home</a></li>
                  <li aria-current="page" class="breadcrumb-item active">Checkout - Order review</li>
                </ol>
              </nav>
            </div>
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
            <div id="checkout" class="col-lg-12">
              <div class="box">
                <form method="POST" action="<%=request.getContextPath()%>/checkout2">
                  <h1>Checkout - Order review</h1>
                  <div class="nav flex-column flex-sm-row nav-pills"><a href="/Fashion2/checkout1" class="nav-link flex-sm-fill text-sm-center"> <i class="fa fa-map-marker">                  </i>Address</a><a href="#" class="nav-link flex-sm-fill text-sm-center active disabled"> <i class="fa fa-eye">                     </i>Order Review</a></div>
                  <div class="content">
                    <div class="table-responsive">
                      <table class="table">
                        <thead>
                          <tr>
                            <th colspan="2">Product</th>
                            <th>Quantity</th>
                            <th>Unit price</th>
                            <th>Discount</th>
                            <th>Total</th>
                          </tr>
                        </thead>
                        <tbody>
                    <%
                    	for(Item item : list) {
                    %>    
                          <tr>
                            <td><a href="<%=request.getContextPath() %>/detail?id=<%=item.getProduct().getId() %>"><img src="<%=request.getContextPath() %>/files/<%=item.getProduct().getThumbnail() %>" alt="<%=item.getProduct().getTitle() %>"></a></td>
                            <td><a href="<%=request.getContextPath() %>/detail?id=<%=item.getProduct().getId() %>"><%=item.getProduct().getTitle() %></a></td>
                            <td><%=item.getQuantity() %></td>
                            <td><%=StringUtil.FormatMoney(item.getPrice()) %></td>
                            <td>0₫</td>
                            <td><%=StringUtil.FormatMoney(item.getPrice() * item.getQuantity()) %></td>
                          </tr>
                    <%
            			}
                    %>      
                        </tbody>
                        <tfoot>
                          <tr>
                            <th colspan="5">Total</th>
                            <th><%=StringUtil.FormatMoney(cart.TotalMoney(u)) %></th>
                          </tr>
                        </tfoot>
                      </table>
                    </div>
                    <!-- /.table-responsive-->
                  </div>
                  <!-- /.content-->
                  <div class="box-footer d-flex justify-content-between"><a href="<%=request.getContextPath() %>/checkout1" class="btn btn-outline-secondary"><i class="fa fa-chevron-left"></i>Back to payment method</a>
                    <button type="submit" class="btn btn-primary">Place an order<i class="fa fa-chevron-right"></i></button>
          <!--         <div>
                    	<div id="paypal-button"></div>
						<script src="https://www.paypalobjects.com/api/checkout.js"></script>
						<script>
  							paypal.Button.render({
   							// Configure environment
    						env: 'sandbox',
    						client: {
      							sandbox: 'AfZdfp1zYmIXdD_N27AEwoa0gPhJEkJWkfF9KRWiS03_KGsFanmqaCeIQFW-JeVEEaSdryMT8_4Zuk2A',
      							production: 'demo_production_client_id'
    						},
    						// Customize button (optional)
    						locale: 'en_US',
    						style: {
      							size: 'small',
      							color: 'gold',
      							shape: 'pill',
    						},

							// Enable Pay Now checkout flow (optional)
    						commit: true,

    						// Set up a payment
    						payment: function(data, actions) {
      							return actions.payment.create({
        							transactions: [{
          								amount: {
            								total: '1',
            								currency: 'USD'
          								}
        							}],
        							redirect_urls: {
        						          return_url: '/Fashion2/checkout2',
        						          cancel_url: 'https://example.com'
        						    }
      							});
    						},
    						// Execute the payment
    						onAuthorize: function(data, actions) {
      							return actions.payment.execute().then(function() {
        						// Show a confirmation message to the buyer
        						actions.redirect();
        						window.alert('Thank you for your purchase!');
      							});
    						}
  							}, '#paypal-button');

						</script>
                    </div>
                     --> 
                  </div>
                </form>
              </div> 
              <!-- /.box-->
            </div>
          <%
            	}
          %>  
            <!-- /.col-lg-9-->
            
            <!-- /.col-lg-3-->
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/templates/public/inc/footer.jsp" %>