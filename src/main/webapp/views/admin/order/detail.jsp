<%@page import="utils.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.OrderDetail"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>Chi tiết đơn hàng</h2>
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
                    <%
                    	@SuppressWarnings("unchecked")
                    	List<OrderDetail> list = (ArrayList<OrderDetail>) request.getAttribute("orderDetailList");
                    	if(list != null && list.size() > 0) {
                    %>    
                        	<h3>1. Thông tin đơn hàng</h3><br>
                            <table class="table table-striped  table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>Ngày mua hàng</th>
                                        <th>Mã đơn hàng</th>
                                        <th>Trạng thái đơn hàng</th>
                                        <th>Tổng tiền</th>
                                        <th>Phương thức thanh toán</th>
                                        <th>Lời nhắn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%=list.get(0).getOrder().getOrder_date() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getCode() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getStatus().getName() %></td>
                                        <td class="center"><%=StringUtil.FormatMoney(list.get(0).getOrder().getTotal_money()) %></td>
                                        <td class="center">Thanh toán khi nhận hàng</td>
                                        <td class="center"><%=list.get(0).getOrder().getNote() %></td>
                                    </tr>
                                </tbody>
                            </table><br>
                            <h3>2. Thông tin người mua</h3><br>
                            <table class="table table-striped  table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>Họ tên</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa chỉ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%=list.get(0).getOrder().getUser().getFullname() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getUser().getEmail() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getUser().getPhone_number() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getUser().getAddress() %></td>
                                    </tr>
                                </tbody>
                            </table><br>
                            <h3>3. Thông tin người nhận</h3><br>
                            <table class="table table-striped  table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>Họ tên</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa chỉ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%=list.get(0).getOrder().getFullname() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getPhone_number() %></td>
                                        <td class="center"><%=list.get(0).getOrder().getAddress() %></td>
                                    </tr>
                                </tbody>
                            </table><br>
                            <h3>4. Danh sách đơn hàng</h3><br>
                            <table class="table table-striped  table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Tên sản phẩm</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Tổng tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                	int stt = 0;
                                	for(OrderDetail item : list) {
                                		stt++;
                                %>
                                    <tr>
                                        <td><%=stt %></td>
                                        <td class="center"><%=item.getProduct().getTitle() %></td>
                                        <td class="center"><%=item.getQuantity() %></td>
                                        <td class="center"><%=StringUtil.FormatMoney(item.getPrice()) %></td>
                                        <td class="center"><%=StringUtil.FormatMoney(item.getTotal_money()) %></td>
                                    </tr>
                                <%
                                	}
                                %>
                                    <tr>
                                        <td colspan="4" style='text-align: right; padding-right: 150px;'>Thanh toán</td>
                                        <td class="center"><%=StringUtil.FormatMoney(list.get(0).getOrder().getTotal_money()) %></td>
                                    </tr>
                                </tbody>
                            </table>
                    <%
                    	}
                    %>   
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