<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/templates/admin/inc/header.jsp" %>
<%@ include file="/templates/admin/inc/leftbar.jsp" %>
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2>TRANG QUẢN TRỊ VIÊN</h2>
            </div>
        </div>
        <!-- /. ROW  -->
        <hr />
        <div class="row">
        <%
        	int numberOfProducts = (int) request.getAttribute("numberofproducts");
        	int numberOfUsers = (int) request.getAttribute("numberofusers");
        	int numberOfOrders = (int) request.getAttribute("numberoforders");
        %>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-green set-icon">
                    <i class="fa fa-bars"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/product/index" title="">Quản lý sản phẩm</a></p>
                        <p class="text-muted">Có <%=numberOfProducts %> sản phẩm</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-blue set-icon">
                    <i class="fa fa-bell-o"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/order/index" title="">Quản lý đơn hàng</a></p>
                        <p class="text-muted">Có <%=numberOfOrders %> đơn hàng</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-4">
                <div class="panel panel-back noti-box">
                    <span class="icon-box bg-color-brown set-icon">
                    <i class="fa fa-rocket"></i>
                </span>
                    <div class="text-box">
                        <p class="main-text"><a href="<%=request.getContextPath() %>/admin/user/index" title="">Quản lý người dùng</a></p>
                        <p class="text-muted">Có <%=numberOfUsers %> người dùng</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    document.getElementById("index").classList.add('active-menu');
</script>
<!-- /. PAGE WRAPPER  -->
<%@ include file="/templates/admin/inc/footer.jsp" %>