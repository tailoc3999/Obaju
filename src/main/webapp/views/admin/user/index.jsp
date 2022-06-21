<%@page import="constants.DefineConstants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý người dùng</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <%
        	String msg = request.getParameter("msg");
        	if("1".equals(msg)) {
        		out.print("<span style='color:green; font-weight:bold'>Thêm người dùng thành công!!</span>");
        	}
        	if("2".equals(msg)) {
        		out.print("<span style='color:green; font-weight:bold'>Sửa người dùng thành công!!</span>");
        	}
        	if("3".equals(msg)) {
        		out.print("<span style='color:green; font-weight:bold'>Xóa người dùng thành công!!</span>");
        	}
        	
        	String err = request.getParameter("err");
        	if("1".equals(err)) {
        		out.print("<span style='color:red; font-weight:bold'>Tài khoản không tồn tại</span>");
        	}
        	if("2".equals(err)) {
        		out.print("<span style='color:red; font-weight:bold'>Có lỗi khi xóa</span>");
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
                                    <a href="<%=request.getContextPath() %>/admin/user/add" class="btn btn-success btn-md">Thêm</a>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <form method="post" action="">
                                        <input type="submit" name="search" value="Tìm kiếm" class="btn btn-warning btn-sm" style="float:right" />
                                        <input type="search" class="form-control input-sm" placeholder="Nhập tên người dùng" style="float:right; width: 300px;" />
                                        <div style="clear:both"></div>
                                    </form><br />
                                </div>
                            </div>

                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa chỉ</th>
                                        <th>Role</th>
                                        <th width="160px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                	@SuppressWarnings("unchecked")
                                	List<User> users = (ArrayList<User>) request.getAttribute("users");
                                	if(users != null && users.size() > 0) {
                                		for(User item : users) {
                                			
                                %>
                                    <tr>
                                        <td><%=item.getId() %></td>
                                        <td class="center"><%=item.getFullname() %></td>
                                        <td class="center"><%=item.getEmail() %></td>
                                        <td class="center"><%=item.getPhone_number() %></td>
                                        <td class="center"><%=item.getAddress() %></td>
                                        <td><%=item.getRole().getName() %></td>
                                        <td class="center">
                                            <a href="<%=request.getContextPath() %>/admin/user/edit?id=<%=item.getId() %>" title="" class="btn btn-primary"><i class="fa fa-edit "></i> Sửa</a>
                                            <a href="<%=request.getContextPath() %>/admin/user/del?id=<%=item.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa?');" title="" class="btn btn-danger"><i class="fa fa-pencil"></i> Xóa</a>
                                        </td>
                                    </tr>
                                <% 		}
                                	}
                                %>  
                                </tbody>
                            </table>
                            <div class="row">
                            <%
                            	int numberOfUsers = (int)request.getAttribute("numberOfUsers");
                            	int numberOfPages = (int)request.getAttribute("numberOfPages");
                            	int currentPage = (int)request.getAttribute("currentPage");
                            %>
                                <div class="col-sm-6">
                                    <div class="dataTables_info" id="dataTables-example_info" style="margin-top:27px">Hiển thị từ <%=(currentPage - 1)*DefineConstants.NUMBER_PER_PAGE_USER + 1%> đến <%=currentPage==numberOfPages?numberOfUsers:DefineConstants.NUMBER_PER_PAGE_USER*currentPage%> của <%=numberOfUsers %> người dùng</div>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                        <ul class="pagination">
                            <%
                            			if(currentPage != 1) {
                            %>
                            				<li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="<%=request.getContextPath()%>/admin/user/index?page=<%=currentPage - 1%>">Trang trước</a></li>
                            <%			
                            			}
                            %>
                                            
                            <%
                            		for(int i = 1; i <= numberOfPages; i++){
                            			if(currentPage == i) {
                            %>	
                            				<li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href=""><%=i %></a></li>	
                            <%			} else {
                            %>			
                            				<li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath()%>/admin/user/index?page=<%=i%>"><%=i %></a></li>
                            <%			}
                            		}
                            %>                 
                                            
							<%
								if(currentPage != numberOfPages) {
							%>
									<li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><a href="<%=request.getContextPath()%>/admin/user/index?page=<%=currentPage + 1%>">Trang tiếp</a></li>
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
    document.getElementById("user").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>