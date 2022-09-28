<%@page import="constants.DefineConstants"%>
<%@page import="utils.StringUtil"%>
<%@page import="models.Status"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Quản lý đơn hàng</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <div class="row">
            <div class="col-md-12">
                <!-- Advanced Tables -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="table-responsive">
                            <div class="row">
                                <div class="col-sm-6" style="left: 555px;">
                                    <form method="get" action="/Fashion2/admin/order/index">
                                        <input type="submit" name="searchh" value="Tìm kiếm" class="btn btn-warning btn-sm" style="float:right" />
                                        <input type="search" name="search" class="form-control input-sm" placeholder="Nhập mã đơn hàng" style="float:right; width: 300px;" />
                                        <div style="clear:both"></div>
                                    </form><br />
                                </div>
                            </div>
						<%
							String msg = request.getParameter("msg");
							String err = request.getParameter("err");
							if("1".equals(msg)) {
								out.print("<h4 style='color:green; font-weight:bold;'>Thay đổi trạng thái đơn hàng thành công</h4>");
							}
							if("1".equals(err)) {
								out.print("<h4 style='color:red; font-weight:bold;'>Có lỗi khi thay đổi trạng thái đơn hàng</h4>");
							}
						%>
                            <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Mã đơn hàng</th>
                                        <th>Người đặt hàng</th>
                                        <th>Trạng thái đơn hàng</th>
                                        <th>Tổng số tiền</th>
                                        <th width="80px">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                	@SuppressWarnings("unchecked")
                                	List<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
                                	if(orders != null && orders.size() > 0) {
                                		int stt = 0;
                                		for(Order item : orders) {
                                			stt++;
                                %>
                                    <tr>
                                        <td><%=stt %></td>
                                        <td class="center"><%=item.getCode() %></td>
                                        <td class="center"><%=item.getUser().getFullname() %></td>
                                        <td class="center">
											<form method="POST" action="">
												<select class="status">
												<%
													@SuppressWarnings("unchecked")
													List<Status> status = (ArrayList<Status>) request.getAttribute("status");
													if(status != null && status.size() > 0) {
														for(Status i : status) {
															if(i.getId() == item.getStatus().getId()) {
												%>
																<option selected><%=i.getName() %></option>
												<%				
															} else {
												%>
																<option value="<%=request.getContextPath()%>/admin/order/index?id=<%=item.getId() %>&sid=<%=i.getId()%>"><%=i.getName() %></option>
												<%				
															}
														}
													}
												%>
												</select>
											</form>
										</td>
                                        <td class="center"><%=StringUtil.FormatMoney(item.getTotal_money()) %></td>
                                        <td class="center">
                                            <a href="<%=request.getContextPath() %>/admin/order/detail?id=<%=item.getId() %>" title="" class="btn btn-primary"><i class="fa fa-eye "></i> Chi tiết</a>
                                        </td>
                                    </tr>
                                <%
                                		}
                                	}
                                %>    
                                </tbody>
                            </table>
                            <script type="text/javascript">
                  				$(document).ready(function(){
                  					$('.status').on('change',function(){
                  						var url = $(this).val();
                  						if(url){
                  							var form = document.createElement('form');
                  						    document.body.appendChild(form);
                  						    form.method = 'post';
                  						    form.action = url;
                  						    form.submit();
                  						}
                  						return false;
                  					});
                  				});
                  			</script>
						<%
							int currentPage = (int) request.getAttribute("currentpage");
							int numberOfPages = (int) request.getAttribute("numberofpages");
							int numberOfOrder = (int) request.getAttribute("numberoforders");
						%>                  			
                            <div class="row">
                                <div class="col-sm-6">
                                <%
                                	if(numberOfPages > 0) {
                                %>
                                    <div class="dataTables_info" id="dataTables-example_info" style="margin-top:27px"><%=(currentPage - 1) * DefineConstants.NUMBER_PER_PAGE_ORDER + 1 %> đến <%=currentPage==numberOfPages?numberOfOrder:DefineConstants.NUMBER_PER_PAGE_ORDER*currentPage %> của <%=numberOfOrder %></div>
                                <%
                                	}
                                %>
                                </div>
                                <div class="col-sm-6" style="text-align: right;">
                                    <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
                                        <ul class="pagination">
                                        <%
                                        	if(currentPage > 1) {
                                        %>
                                            <li class="paginate_button previous" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous"><a href="<%=request.getContextPath() %>/admin/order/index?page=<%=currentPage - 1%>">Trang trước</a></li>
                                        <%
                                        	}
                                        	for(int i = 1; i <= numberOfPages; i++) {
                                        		if(i == currentPage) {
                                        %>
                                        			<li class="paginate_button active" aria-controls="dataTables-example" tabindex="0"><a href=""><%=i %></a></li>
                                        <%			
                                        		} else {
                                        %>
                                        			<li class="paginate_button" aria-controls="dataTables-example" tabindex="0"><a href="<%=request.getContextPath() %>/admin/order/index?page=<%=i%>"><%=i %></a></li>
                                        <%			
                                        		}
                                        	}
                                        	if(currentPage < numberOfPages) {
                                        %>    
                                            <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next"><a href="<%=request.getContextPath() %>/admin/order/index?page=<%=currentPage + 1%>">Trang tiếp</a></li>
                                        <%
                                        	}
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
    document.getElementById("order").classList.add('active-menu');
</script>
<!-- /. PAGE INNER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>