<%@page import="models.Galery"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utils.StringUtil"%>
<%@page import="models.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/templates/public/inc/header.jsp" %>
    <div id="all">
      <div id="content">
        <div class="container">
          <div class="row">
          	<%
            	Product product = (Product) request.getAttribute("product");
            %>
            <div class="col-lg-12">
              <!-- breadcrumb-->
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/resources/public/#">Home</a></li>
                  <li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/cat?id=<%=product!=null?product.getCat().getId():"" %>"><%=product!=null?product.getCat().getName():"" %></a></li>
                  <li aria-current="page" class="breadcrumb-item active"><%=product!=null?product.getTitle():"" %></li>
                </ol>
              </nav>
            </div>
            <div class="col-lg-12 order-1 order-lg-2">
              <div id="productMain" class="row">
            <%
            	@SuppressWarnings("unchecked")
            	List<Galery> images = (ArrayList<Galery>) request.getAttribute("images");
            	if(images != null && images.size() > 0) {
            
            %>  
                <div class="col-md-4">
                  <div data-slider-id="1" class="owl-carousel shop-detail-carousel">
                <%
                	for(Galery item : images) {
                %>  
                    <div class="item"> <img src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt="" class="img-fluid"></div>
                <%
                	}
                %>
                  </div>
                  <!-- /.ribbon-->
                  <!-- /.ribbon-->
                </div>
                <div class="col-md-8">
                  <div class="box">
                    <h1 class="text-center"><%=product.getTitle() %></h1>
                    <p class="goToDescription"><a href="<%=request.getContextPath() %>/resources/public/#details" class="scroll-to">Scroll to product details, material &amp; care and sizing</a></p>
                    <p class="price"><span style='color:#4fbfa8'><%=StringUtil.FormatMoney(product.getPrice()) %></span></p>
                    <p class="text-center buttons"><a href="<%=request.getContextPath() %>/buy?id=<%=product.getId() %>" class="btn btn-primary"><i class="fa fa-shopping-cart"></i> Add to cart</a><a href="<%=request.getContextPath() %>/resources/public/basket.html" class="btn btn-outline-primary"><i class="fa fa-heart"></i> Add to wishlist</a></p>
                  </div>
                  <div data-slider-id="1" class="owl-thumbs">
                <%
                	for(Galery galery : images) {
                %>  
                    <button class="owl-thumb-item"><img src="<%=request.getContextPath() %>/files/<%=galery.getThumbnail() %>" alt="" class="img-fluid"></button>
                <%
                	}
                %>
                  </div>
                </div>
            <%
            	}
            %>    
              </div>
              <div id="details" class="box">
                <p><%=product.getDescription() %></p>
                
                <hr>
                <div class="social">
                  <h4>Show it to your friends</h4>
                  <p><a href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse" class="external facebook"><i class="fa fa-facebook"></i></a><a href="https://twitter.com/intent/tweet?original_referer=https%3A%2F%2Fshopee.vn%2Fvicenzo.official%2F15340013295&amp;text=" class="external twitter"><i class="fa fa-twitter"></i></a><a href="mailto:?subject=I wanted you to see this site&amp;body=Check out this site http://www.website.com." class="email"><i class="fa fa-envelope"></i></a></p>
                </div>
              </div>
              <div class="row same-height-row">
                <div class="col-md-3 col-sm-6">
                  <div class="box same-height">
                    <h3>You may also like these products</h3>
                  </div>
                </div>
              <%
              	@SuppressWarnings("unchecked")
              	List<Product> recentList = (ArrayList<Product>) request.getAttribute("recentlist");
              	if(recentList != null && recentList.size() > 0){
              		for(Product item : recentList) {
              			String urlSlug = request.getContextPath() + "/detail/" + StringUtil.makeSlug(item.getCat().getName()) + "/" + StringUtil.makeSlug(item.getTitle()) + "-" + item.getId() + ".html";
              %>  
                <div class="col-md-3 col-sm-6">
                  <div class="product same-height">
                    <div class="flip-container">
                      <div class="flipper">
                        <div class="front"><a href="<%=urlSlug %>"><img src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt="" class="img-fluid"></a></div>
                        <div class="back"><a href="<%=urlSlug %>"><img src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt="" class="img-fluid"></a></div>
                      </div>
                    </div><a href="<%=urlSlug %>" class="invisible"><img src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt="" class="img-fluid"></a>
                    <div class="text">
                      <h3><%=item.getTitle() %></h3>
                      <p class="price" style='color:#4fbfa8;font-weight:bold'><%=StringUtil.FormatMoney(item.getPrice()) %></p>
                    </div>
                  </div>
                  <!-- /.product-->
                </div>
              <%
              		}
              	}
              %>  
              </div>
            </div>
            <!-- /.col-md-9-->
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
    <%
		if(product != null) {
			if("Men".equals(product.getCat().getName()) || 1 == product.getCat().getId()) {
	%>
			document.getElementById("Men").classList.add('active');
			document.getElementById("1").classList.add('active');
			
	<%
		} else if("Kids".equals(product.getCat().getName()) || 3 == product.getCat().getId()) {
	%>
			document.getElementById("Kids").classList.add('active');
			document.getElementById("3").classList.add('active');
	<%
		} else {
	%>
			document.getElementById("Ladies").classList.add('active');
			document.getElementById("2").classList.add('active');
	<%
		}
	}
	%>
	
	</script>
    <%@ include file="/templates/public/inc/footer.jsp" %>