<%@page import="models.Galery"%>
<%@page import="models.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Sửa sản phẩm</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <%
        	Product product = (Product)request.getAttribute("product");
        	String err = request.getParameter("err");
        	if("1".equals(err)) {
        		out.print("<span style='color:red; font-weight:bold'>Có lỗi khi sửa</span>");
        	}
        %>
        <div class="row">
            <div class="col-md-12">
                <!-- Form Elements -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <form role="form" method="post" enctype="multipart/form-data" id="form">
                                    <div class="form-group">
                                        <label for="title">Tên sản phẩm</label>
                                        <input type="text" id="title" value="<%=product!=null?product.getTitle():"" %>" name="title" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="category">Danh mục sản phẩm</label>
                                        <select id="category" name="category" class="form-control">
                                        <%
                                        	@SuppressWarnings("unchecked")
                                        	List<Category> catList = (ArrayList<Category>)request.getAttribute("catlist");
                                        	if(catList != null && catList.size() > 0) {
                                        		for(Category item : catList) {
                                        			if(product != null && item.getId() == product.getCat().getId()) {
                                        %>
                                        	<option selected="selected" value="<%=item.getId() %>"><%=item.getName() %></option>				
                                        <%			} else {
                                        %>	
                                         	<option value="<%=item.getId() %>"><%=item.getName() %></option>
                                        <%			}
												}
                                        	} 
                                        %>	
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="picture">Hình ảnh</label>
                                        <div>
                                    <%
                                    	@SuppressWarnings("unchecked")
                                    	List<Galery> images = (ArrayList<Galery>) request.getAttribute("images");
                                        	if(images != null && images.size() > 0) {
                                        		for(int i = 0; i < 3; i++) {
                                    %>    
                                        	<div class="img-container">
                                        		<input type="file" name="picture" />
                                        		<img width="200px" height="200px" src="<%=request.getContextPath() %>/files/<%=i<=images.size()-1?images.get(i).getThumbnail():"" %>" alt=""/>
                                        	</div>
                                    <%
                                        		}
                                        	}
                                    %>    	
                                        </div>                                     
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Giá</label>
                                        <input type="text" id="price" value="<%=product!=null?product.getPrice():"" %>" name="price" class="form-control" />
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Chi tiết</label>
                                        <textarea id="description" class="form-control" id="description" rows="5" name="description"><%=product!=null?product.getDescription():"" %></textarea>
                                    </div>
                                    <button type="submit" name="submit" class="btn btn-success btn-md">Sửa</button>
                                </form>
                                <script type="text/javascript">
									$(document).ready(function () {
										$('#form').validate({
											rules: {
												"title": {
													required: true,
													minlength: 10,
							 						maxlength: 100,
												},
												"price": {
													required: true,
												},
												"description": {
													required: true,
													minlength: 20,
												},
												
											},
											messages: {
												"title": {
													required: "Vui lòng nhập tên sản phẩm",
													minlength: "Tên sản phẩm ít nhất 10 kí tự",
													maxlength: "Tên sản phẩm nhiều nhất 100 kí tự",
												},
												"price": {
													required: "Vui lòng nhập giá",
												},
												"description": {
													required: "Vui lòng nhập mô tả sản phẩm",
													minlength: "Mô tả ít nhất 20 ký tự",
												},
											},
										});
									});	
								</script>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Form Elements -->
            </div>
        </div>
        <!-- /. ROW  -->
    </div>
    <!-- /. PAGE INNER  -->
</div>
<script>
    var editor = CKEDITOR.replace('description');
</script>
<script>
    document.getElementById("product").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>