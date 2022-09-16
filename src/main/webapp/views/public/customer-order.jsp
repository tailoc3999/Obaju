<%@page import="utils.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.OrderDetail"%>
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
                  <li class="breadcrumb-item"><a href="#">Home</a></li>
                  <li aria-current="page" class="breadcrumb-item"><a href="<%=request.getContextPath() %>/purchase">My orders</a></li>
                  <li aria-current="page" class="breadcrumb-item active">Order # 1735</li>
                </ol>
              </nav>
            </div>
            <div class="col-lg-3">
              <!--
              *** CUSTOMER MENU ***
              _________________________________________________________
              -->
              <div class="card sidebar-menu">
                <div class="card-header">
                  <h3 class="h4 card-title">Customer section</h3>
                </div>
                <div class="card-body">
                  <ul class="nav nav-pills flex-column"><a href="/Fashion2/purchase" class="nav-link active"><i class="fa fa-list"></i> My orders</a><a href="<%=request.getContextPath() %>/profile" class="nav-link"><i class="fa fa-user"></i> My account</a><a href="<%=request.getContextPath() %>/logout" class="nav-link"><i class="fa fa-sign-out"></i> Logout</a></ul>
                </div>
              </div>
              <!-- /.col-lg-3-->
              <!-- *** CUSTOMER MENU END ***-->
            </div>
            <div id="customer-order" class="col-lg-9">
              <div class="box">
              <%
              	@SuppressWarnings("unchecked")
              	List<OrderDetail> odlist = (ArrayList<OrderDetail>) request.getAttribute("odList");
              	if(odlist != null && odlist.size() > 0) {
              %>
                <p class="lead">Order #<%=odlist.get(0).getOrder().getCode() %> was placed on <strong><%=odlist.get(0).getOrder().getOrder_date() %></strong> and is currently <strong><%=odlist.get(0).getOrder().getStatus().getName() %></strong>.</p>
                <p class="text-muted">If you have any questions, please feel free to <a href="<%=request.getContextPath() %>/contact">contact us</a>, our customer service center is working for you 24/7.</p>
                <hr>
                <div class="table-responsive mb-4">
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
                  	  for(OrderDetail item : odlist) {
                  	%>  
                      <tr>
                        <td><a href="<%=request.getContextPath() %>/detail?id=<%=item.getProduct().getId() %>"><img src="<%=request.getContextPath() %>/files/<%=item.getProduct().getThumbnail() %>" alt="<%=item.getProduct().getTitle() %>"></a></td>
                        <td><a href="<%=request.getContextPath() %>/detail?id=<%=item.getProduct().getId() %>"><%=item.getProduct().getTitle() %></a></td>
                        <td><%=item.getQuantity() %></td>
                        <td><%=StringUtil.FormatMoney(item.getPrice()) %></td>
                        <td>0 ₫</td>
                        <td><%=StringUtil.FormatMoney(item.getTotal_money()) %></td>
                      </tr>
                    <%
              		  }
                    %>  
                    </tbody>
                    <tfoot>
                      <tr>
                        <th colspan="5" class="text-right">Order subtotal</th>
                        <th><%=StringUtil.FormatMoney(odlist.get(0).getOrder().getTotal_money()) %></th>
                      </tr>
                      <tr>
                        <th colspan="5" class="text-right">Shipping and handling</th>
                        <th>0 ₫</th>
                      </tr>
                      <tr>
                        <th colspan="5" class="text-right">Tax</th>
                        <th>0 ₫</th>
                      </tr>
                      <tr>
                        <th colspan="5" class="text-right">Total</th>
                        <th><%=StringUtil.FormatMoney(odlist.get(0).getOrder().getTotal_money()) %></th>
                      </tr>
                    </tfoot>
                  </table>
                </div>
                <!-- /.table-responsive-->
                <div class="row addresses">
                  <div class="col-lg-6">
                    <h2>Invoice address</h2>
                    <p>John Brown<br>13/25 New Avenue<br>New Heaven<br>45Y 73J<br>England<br>Great Britain</p>
                  </div>
                  <div class="col-lg-6">
                    <h2>Shipping address</h2>
                    <p><%=odlist.get(0).getOrder().getAddress() %><br>Việt Nam</p>
                  </div>
                </div>
              <%
              	}
              %>  
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/templates/public/inc/footer.jsp" %>