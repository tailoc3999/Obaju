<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Order Management</title>
<!-- BOOTSTRAP STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/font-awesome.css" rel="stylesheet" />
<!-- MORRIS CHART STYLES-->

<!-- CUSTOM STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<!-- TABLE STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/js/dataTables/dataTables.bootstrap.css"
	rel="stylesheet" />
</head>
<body>
	<div id="wrapper">

		<jsp:include page="/templates/admin/nav-bar.jsp"></jsp:include>

		<!-- /. NAV TOP  -->
		<jsp:include page="/templates/admin/slide-bar.jsp"></jsp:include>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<div class="col-md-12">
						<h2>Order Management</h2>


					</div>
				</div>
				<!-- /. ROW  -->
				<hr />

				<div class="row">
					<div class="col-md-12">
						<!-- Advanced Tables -->
						<div class="panel panel-default">
							<div class="panel-heading">Advanced Tables</div>
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th>index</th>
												<th>ID</th>
												<th>Buyer</th>
												<th>Email</th>
												<th>Date</th>
												<th>Product</th>
												<th>Quantity</th>
												<th>Price</th>
												<th>Sum</th>
												<th>Action</th>


											</tr>
										</thead>
										<tbody>
											</a>
											<c:set var="index" value="${0}" />
											<c:forEach items="${listCartItem }" var="list">
												<tr class="odd gradeX">
													<c:set var="index" value="${index + 1}" />
													<td>${index }</td>
													<td>${list.id }</td>
													<td>${list.cart.buyer.username }</td>
													<td>${list.cart.buyer.email }</td>
													<td>${list.cart.buyDate }</td>
													<td>${list.product.name }</td>
													<td>${list.quantity }</td>
													<td>$ ${list.product.price }</td>
													<td>$ ${ list.quantity * list.product.price }</td>


													<td><a
														href="<c:url value='/admin/order/delete?id=${list.id }'/>"
														class="center">Delete</a></td>

												</tr>
											</c:forEach>

										</tbody>
									</table>
								</div>

							</div>
						</div>
						<!--End Advanced Tables -->
					</div>
				</div>

			</div>

		</div>
		<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery.metisMenu.js"></script>
	<!-- DATA TABLE SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/dataTables/jquery.dataTables.js"></script>
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/dataTables/dataTables.bootstrap.js"></script>
	<script>
		$(document).ready(function() {
			$('#dataTables-example').dataTable();
		});
	</script>
	<!-- CUSTOM SCRIPTS -->
<!--  <script src="<%=request.getContextPath() %>/resources/admin/static/js/custom.js"></script>	-->	

</body>
</html>