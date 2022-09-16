<%@page import="utils.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Order"%>
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
                  <li aria-current="page" class="breadcrumb-item active">My orders</li>
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
            <div id="customer-orders" class="col-lg-9">
              <div class="box">
                <h1>My orders</h1>
                <p class="lead">Your orders on one place.</p>
                <p class="text-muted">If you have any questions, please feel free to <a href="contact.html">contact us</a>, our customer service center is working for you 24/7.</p>
                <hr>
                <div class="table-responsive">
                <%
                	@SuppressWarnings("unchecked")
                	List<Order> orderList = (ArrayList<Order>) request.getAttribute("orderList");
                	if(orderList != null && orderList.size() > 0) {
                %>
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>Order</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                    <%
                    	for(Order order : orderList) {
                    %>
                      <tr>
                        <th># <%=order.getCode() %></th>
                        <td><%=order.getOrder_date() %></td>
                        <td><%=StringUtil.FormatMoney(order.getTotal_money()) %></td>
                        <td><span class="badge <%=order.getStatus().getClass_name()%>"><%=order.getStatus().getName() %></span></td>
                        <td><a href="<%=request.getContextPath() %>/purchase/order?id=<%=order.getId() %>" class="btn btn-primary btn-sm">View</a></td>
                      </tr>
                    <%
                		}
                    %>  
                     
                    </tbody>
                  </table>
              <%
              	}
              %>    
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/templates/public/inc/footer.jsp" %>