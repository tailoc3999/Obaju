<%@page import="java.util.ArrayList"%>
<%@page import="models.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>List User</title>
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
						<h2>List User</h2>
						<h5>You can edit , add, delete User</h5>

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
												<th>ID</th>
												<th>Fullname</th>
												<th>Email</th>
												<th>Phone number</th>
												<th>Address</th>
												<th>Role</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
										<%
											@SuppressWarnings("unchecked")
											List<User> users = (ArrayList<User>)request.getAttribute("users");
											if(users != null && users.size() > 0) {
												for(User user : users) {
													
												
										%>
												<tr class="odd gradeX">
													<td><%=user.getId() %></td>
													<td><%=user.getFullname() %></td>
													<td><%=user.getEmail() %></td>
													<td><%=user.getPhone_number() %></td>
													<td><%=user.getAddress() %></td>
													<td class="center"><%=user.getRole().getName() %></td>
													<td>
														<a href="<c:url value='/admin/user/edit?id=${list.id }'/>"
														class="center">Edit</a> | 
														<a href="<c:url value='/admin/user/delete?id=${list.id }'/>"
														class="center">Delete</a>
													</td>

												</tr>
										<% 		}
											}%>		

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
<!-- 	<script src="<%=request.getContextPath() %>/resources/admin/static/js/custom.js"></script>  -->

</body>
</html>