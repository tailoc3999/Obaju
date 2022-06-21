<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- BOOTSTRAP STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/font-awesome.css" rel="stylesheet" />
<!-- MORRIS CHART STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="<%=request.getContextPath() %>/resources/admin/static/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
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
						<h2>Admin Dashboard</h2>
						<h5>Welcome : ${username }</h5>

					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
				<div class="row">
					<div class="col-md-3 col-sm-6 col-xs-6">
						<div class="panel panel-back noti-box">
							<span class="icon-box bg-color-red set-icon"> <i
								class="fa fa-envelope-o"></i>
							</span>
							<div class="text-box">
								<p class="main-text">120 New</p>
								<p class="text-muted">Messages</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 col-xs-6">
						<div class="panel panel-back noti-box">
							<span class="icon-box bg-color-green set-icon"> <i
								class="fa fa-bars"></i>
							</span>
							<div class="text-box">

								<p class="main-text">30 Tasks</p>
								<p class="text-muted">Remaining</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 col-xs-6">
						<div class="panel panel-back noti-box">
							<span class="icon-box bg-color-blue set-icon"> <i
								class="fa fa-bell-o"></i>
							</span>
							<div class="text-box">
								<p class="main-text">240 New</p>
								<p class="text-muted">Notifications</p>
							</div>
						</div>
					</div>
					<div class="col-md-3 col-sm-6 col-xs-6">
						<div class="panel panel-back noti-box">
							<span class="icon-box bg-color-brown set-icon"> <i
								class="fa fa-rocket"></i>
							</span>
							<div class="text-box">
								<p class="main-text">3 Orders</p>
								<p class="text-muted">Pending</p>
							</div>
						</div>
					</div>
				</div>
				<!-- /. ROW  -->
				<hr />
				<script type="text/javascript"
					src="https://google.com">
					
				</script>
				<noscript>
					Vui lÃ²ng báº­t javascript Äá» xem <a href="http://giavangvn.org">giÃ¡
						vÃ ng</a>
				</noscript>
				<!-- /. ROW  -->
				<div class="row">


					<div class="col-md-9 col-sm-12 col-xs-12"></div>
					<div class="col-md-3 col-sm-12 col-xs-12"></div>

				</div>

			</div>
			<!-- /. ROW  -->
			<div class="row">
				<div class="col-md-3 col-sm-12 col-xs-12">
					<div
						class="panel panel-primary text-center no-boder bg-color-green">
						<div class="panel-body">
							<i class="fa fa-comments-o fa-5x"></i>
							<h4>200 New Comments</h4>
							<h4>See All Comments</h4>
						</div>
						<div class="panel-footer back-footer-green">
							<i class="fa fa-rocket fa-5x"></i> Lorem ipsum dolor sit amet sit
							sit, consectetur adipiscing elitsit sit gthn ipsum dolor sit amet
							ipsum dolor sit amet

						</div>
					</div>
				</div>
				<div class="col-md-9 col-sm-12 col-xs-12">

					<div class="panel panel-default">
						<div class="panel-heading">Responsive Table Example</div>
						<div class="panel-body">
							<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover">
									<thead>
										<tr>
											<th>#</th>
											<th>First Name</th>
											<th>Last Name</th>
											<th>Username</th>
											<th>User No.</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>Mark</td>
											<td>Otto</td>
											<td>@mdo</td>
											<td>100090</td>
										</tr>
										<tr>
											<td>2</td>
											<td>Jacob</td>
											<td>Thornton</td>
											<td>@fat</td>
											<td>100090</td>
										</tr>
										<tr>
											<td>3</td>
											<td>Larry</td>
											<td>the Bird</td>
											<td>@twitter</td>
											<td>100090</td>
										</tr>
										<tr>
											<td>1</td>
											<td>Mark</td>
											<td>Otto</td>
											<td>@mdo</td>
											<td>100090</td>
										</tr>
										<tr>
											<td>2</td>
											<td>Jacob</td>
											<td>Thornton</td>
											<td>@fat</td>
											<td>100090</td>
										</tr>
										<tr>
											<td>3</td>
											<td>Larry</td>
											<td>the Bird</td>
											<td>@twitter</td>
											<td>100090</td>
										</tr>

									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
			<!-- /. ROW  -->
		
			<!-- /. ROW  -->
		</div>
		<!-- /. PAGE INNER  -->
	</div>
	<script>
    	document.getElementById("index").classList.add('active-menu');
	</script>
	<!-- /. PAGE WRAPPER  -->
	
	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/jquery.metisMenu.js"></script>
	<!-- MORRIS CHART SCRIPTS -->
<%-- 	<script src="<%=request.getContextPath() %>/resources/admin/static/js/morris/raphael-2.1.0.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/morris/morris.js"></script>
	<!-- CUSTOM SCRIPTS -->
	<script src="<%=request.getContextPath() %>/resources/admin/static/js/custom.js"></script>
 --%>

</body>

</html>