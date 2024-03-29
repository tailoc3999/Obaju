<%@page import="java.util.Comparator"%>
<%@page import="utils.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/public/inc/header.jsp" %>
    <div id="all">
      <div id="content">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              <!-- breadcrumb-->
              <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                <%
              		int NumberOfProducts = (int) request.getAttribute("numberofproducts");
              		int NumberOfPages = (int) request.getAttribute("numberofpages");
              		int currentpage = (int) request.getAttribute("currentpage");
                	@SuppressWarnings("unchecked")
              		List<Product> products = (ArrayList<Product>) request.getAttribute("products");
                %>
                  <li class="breadcrumb-item"><a href="<%=request.getContextPath() %>/home">Home</a></li>
                  <li aria-current="page" class="breadcrumb-item active"><%=products.size()>0?products.get(0).getCat().getName():"" %></li>
                </ol>
              </nav>
            </div>
            
            <div class="col-lg-12">
              <div class="box">
                <h1><%=products.size()>0?products.get(0).getCat().getName():"" %></h1>
              </div>
              <div class="box info-bar">
                <div class="row">
                  <div class="col-md-12 col-lg-4 products-showing">Showing <strong>12</strong> of <strong>25</strong> products</div>
                  <div class="col-md-12 col-lg-7 products-number-sort">
                  <%
                  	String cat_id = request.getParameter("id");
                  	String sort_by = request.getParameter("sort_by");
                  %>
                    <form  class="form-inline d-block d-lg-flex justify-content-between flex-column flex-md-row">
                      <div class="products-number"><strong>Show</strong><a href="<%=request.getContextPath() %>/cat?num=4&id=<%=products.size()>0?products.get(0).getCat().getId():"" %>" class="btn btn-outline-secondary btn-sm">4</a><a href="<%=request.getContextPath() %>/cat?num=8&id=<%=products.size()>0?products.get(0).getCat().getId():"" %>" class="btn btn-outline-secondary btn-sm">8</a><a href="<%=request.getContextPath() %>/cat?num=<%=NumberOfProducts!=0?NumberOfProducts:"" %>&id=<%=products.size()>0?products.get(0).getCat().getId():"" %>" class="btn btn-outline-secondary btn-sm">All</a><span>products</span></div>
                      <div class="products-sort-by mt-2 mt-lg-0"><strong>Sort by</strong>
                        <select id="sort-by" name="sort-by" class="form-control">
                          <option value="<%=request.getContextPath() %>/cat?id=<%=cat_id %>">-Change</option>
                          <option <%="price".equals(sort_by)?" selected":"" %> value="<%=request.getContextPath() %>/cat?id=<%=cat_id %>&sort_by=price">Price</option>
                          <option <%="name".equals(sort_by)?" selected":"" %> value="<%=request.getContextPath() %>/cat?id=<%=cat_id %>&sort_by=name">Name</option>
                        </select>
                      </div>
                    </form>
                  </div>
                  <script type="text/javascript">
                  	$(document).ready(function(){
                  		$('#sort-by').on('change',function(){
                  			var url = $(this).val();
                  			if(url){
                  				window.location = url;
                  			}
                  			return false;
                  		});
                  	});
                  </script>
                </div>
              </div>
              <div class="row products">
              <%
              	if(products != null && products.size() > 0) {
              		for(Product item : products) {
              		String urlSlug = request.getContextPath() + "/detail/" + StringUtil.makeSlug(item.getCat().getName()) + "/" + StringUtil.makeSlug(item.getTitle()) + "-" + item.getId() + ".html";
              %>
                <div class="col-lg-3 col-md-4">
                  <div class="product">
                    <div class="flip-container">
                      <div class="flipper">
                        <div class="front"><a href="<%=urlSlug %>"><img src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt="" class="img-fluid"></a></div>
                        <div class="back"><a href="<%=urlSlug %>"><img src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt="" class="img-fluid"></a></div>
                      </div>
                    </div><a href="<%=urlSlug %>" class="invisible"><img src="<%=request.getContextPath() %>/resources/public/img/product1.jpg" alt="" class="img-fluid"></a>
                    <div class="text">
                      <h3><a href="<%=urlSlug %>"><%=item.getTitle() %></a></h3>
                      <p class="price"> 
                        <del></del><span style='color:#4fbfa8;font-weight:bold'><%=StringUtil.FormatMoney(item.getPrice()) %></span>
                      </p>
                      <p class="buttons"><a href="<%=urlSlug %>" class="btn btn-outline-secondary">View detail</a><a href="<%=request.getContextPath() %>/buy?id=<%=item.getId() %>" class="btn btn-primary"><i class="fa fa-shopping-cart"></i>Add to cart</a></p>
                    </div>
                    <!-- /.text-->
                  </div>
                  <!-- /.product            -->
                </div>
              <%
            		}
              	}
              %>
                <!-- /.products-->
              </div>
              <div id="products" class="row products"></div>
              
              <div class="pages">
                <p class="loadMore"><a href="javaScript:void(0)" class="btn btn-primary btn-lg" onclick="return loadMore()"><i class="fa fa-chevron-down"></i> Load more</a></p>
			 <%
			 	if(NumberOfProducts > 4) {
			 %>                
                <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                  <ul class="pagination">
              <%
              	if(currentpage > 1) {
              %>
              		<li class="page-item"><a href="<%=request.getContextPath() %>/cat?page=<%=currentpage - 1 %>&id=<%=products.size()>0?products.get(0).getCat().getId():"" %>&sort_by=<%=sort_by %>" aria-label="Previous" class="page-link"><span aria-hidden="true">Â«</span><span class="sr-only">Previous</span></a></li>
              <%		
              	}
              	for(int i = 1; i <= NumberOfPages; i++) {
              		if(i == currentpage) {
              %>
              		<li class="page-item active"><a href="" class="page-link"><%=i %></a></li>
              			
              <%	
              		} else {
              %>
                	<li class="page-item"><a href="<%=request.getContextPath() %>/cat?page=<%=i %>&id=<%=products.size()>0?products.get(0).getCat().getId():"" %>&sort_by=<%=sort_by %>" class="page-link"><%=i %></a></li>
              <%		}
              	}
              	
              	if(currentpage < NumberOfPages) {
              %>
              		<li class="page-item"><a href="<%=request.getContextPath() %>/cat?page=<%=currentpage + 1 %>&id=<%=products.size()>0?products.get(0).getCat().getId():"" %>" aria-label="Next" class="page-link"><span aria-hidden="true">Â»</span><span class="sr-only">Next</span></a></li>
              <%		
              	}
              %>      
                  </ul>
                </nav>
              <%
			 	}
              %>  
              </div>
            </div>
            <!-- /.col-lg-9-->
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript">
    <!--if else theo cat id ở đây chỉ lấy 1 -->
    <%
    	if(products.size() > 0) {
    		if("Men".equals(products.get(0).getCat().getName()) || 1 == products.get(0).getCat().getId()) {
    %>
    			document.getElementById("Men").classList.add('active');
    		//	document.getElementById("1").classList.add('active');
    			
    <%
    		} else if("Kids".equals(products.get(0).getCat().getName()) || 3 == products.get(0).getCat().getId()) {
    %>
    			document.getElementById("Kids").classList.add('active');
    		//	document.getElementById("3").classList.add('active');
    <%
    		} else {
    %>
    			document.getElementById("Ladies").classList.add('active');
    		//	document.getElementById("2").classList.add('active');
    <%
    		}
    	}
    	
    %>
    	function loadMore(){
    		var offset = <%= (int) request.getAttribute("offset")%>;
    		
    		$.ajax({
    			url: '<%=request.getContextPath() %>/cat?id=<%=products.size()>0?products.get(0).getCat().getId():""  %>&sort_by=<%=sort_by %>',
    			type: 'POST',
    			cache: false,
    			data: {
    				aoffset: offset,
    			},
    			success: function(data){
    				$("#products").html(data);
    			},
    			error: function(){
    				alert('Có lỗi!')
    			}
    		});
    		return false;
    	}
	</script>
<%@ include file="/templates/public/inc/footer.jsp" %>