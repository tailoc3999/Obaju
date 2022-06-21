<%@page import="constants.DefineConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý sản phẩm</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <%
        	String msg = request.getParameter("msg");
            if ("1".equals(msg)) {
        		out.print("<span style='color:green; font-weight:bold'>Thêm sản phẩm thành công</span>");
        	}
            if ("2".equals(msg)) {
        		out.print("<span style='color:green; font-weight:bold'>Sửa sản phẩm thành công</span>");
        	}
            String err = request.getParameter("err");
            if ("1".equals(err)) {
        		out.print("<span style='color:red; font-weight:bold'>ID không tồn tại</span>");
        	}
        %>
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <div class="row">
                                <div class="col-sm-6">
                                    <a href="<%=request.getContextPath() %>/admin/product/add" class="btn btn-success btn-md">Thêm</a>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <form method="post" action="">
                                        <input type="submit" name="search" value="Tìm kiếm" class="btn btn-warning btn-sm" style="float:right" />
                                        <input type="search" class="form-control input-sm" placeholder="Nhập tên sản phẩm" style="float:right; width: 300px;" />
                                        <div style="clear:both"></div>
                                    </form><br />
                                </div>
                            </div>

                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Hình ảnh</th>
                                        <th>Title</th>
                                        <th>Danh mục</th>
                                        <th>Giá</th>
                                        <th>Mô tả</th>
                                        <th width="160px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                	@SuppressWarnings("unchecked")
                                	List<Product> products = (ArrayList<Product>) request.getAttribute("products");
                                	if(products != null && products.size() > 0) {
                                		for(Product item : products) {
                                %>
                                
                                    <tr>
                                        <td><%=item.getId() %></td>
                                        <td class="center">
											<img width="200px" height="200px" src="<%=request.getContextPath() %>/files/<%=item.getThumbnail() %>" alt=""/>
                                        </td>
                                        <td class="center"><%=item.getTitle() %></td>
                                        <td class="center"><%=item.getCat().getName() %></td>	
                                        <td class="center"><%=item.getPrice() %>đ</td>
                                        <td class="center"><%=item.getDescription().length()<200?item.getDescription():item.getDescription().substring(0, 200) %> ...</td>
                                        <td class="center">
                                            <a href="<%=request.getContextPath() %>/admin/product/edit?id=<%=item.getId() %>" title="" class="btn btn-primary"><i class="fa fa-edit "></i> Sửa</a>
                                            <a href="<%=request.getContextPath() %>/admin/product/del?id=<%=item.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?');" title="" class="btn btn-danger"><i class="fa fa-pencil"></i> Xóa</a>
                                        </td>
                                <%		}
                                	}
                                %>   
                                    </tr>
                                </tbody>
                            </table>
                            <div class="row">
                            <%
                            	int NumberOfProducts = (int)request.getAttribute("numberofproducts");
                            	int NumberOfPages = (int)request.getAttribute("numberofpages");
                            	int currentpage = (int)request.getAttribute("currentpage");
                            %>
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="dataTables-example_info" style="margin-top:27px">Hiển thị từ <%=(currentpage - 1)*DefineConstants.NUMBER_PER_PAGE_PRODUCT + 1%> đến <%=currentpage==NumberOfPages?NumberOfProducts:DefineConstants.NUMBER_PER_PAGE_PRODUCT*currentpage%> của <%=NumberOfProducts %> sản phẩm</div>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                        <ul class="pagination">
                                        <%
                            			if(currentpage != 1) {
                            %>
                            				<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="<%=request.getContextPath()%>/admin/product/index?page=<%=currentpage - 1%>">Trang trước</a></li>
                            <%			
                            			}
                            %>
                                            
                            <%
                            		for(int i = 1; i <= NumberOfPages; i++){
                            			if(currentpage == i) {
                            %>	
                            				<li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href=""><%=i %></a></li>	
                            <%			} else {
                            %>			
                            				<li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/product/index?page=<%=i%>"><%=i %></a></li>
                            <%			}
                            		}
                            %>                 
                                            
							<%
								if(currentpage != NumberOfPages) {
							%>
									<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><a href="<%=request.getContextPath()%>/admin/product/index?page=<%=currentpage + 1%>">Trang tiếp</a></li>
							<%	}
							%>				
                                 
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <!--End Advanced Tables -->
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("product").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>