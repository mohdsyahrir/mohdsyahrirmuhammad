<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false" %>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="resources/css/dataTables.jqueryui.css">
	<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui.css">
	<meta charset="utf-8">
	<title>Home</title>
	<style type="text/css">
		.ui-label {
		  float:left;
		  width:25%;
		  margin-right:0.5em;
		  padding-top:none;
		  text-align:right;
		  font-weight: bold;
		  } 
	</style>
</head>
<body>
<form action="save" method='POST' name="testStudentForm" id="testStudentForm" >
<fieldset>
		<legend>Insert new student</legend>
		<div>
			<label for="name" class="ui-label">Name : </label><input type="text" placeholder="" required="required" maxlength="45" oninvalid="this.setCustomValidity('This field is required')" onkeypress="this.setCustomValidity('')" id="name" name="name" value="${testStudentForm.name}"/>
		</div>
		<div>
			<label for="address" class="ui-label">Address : </label><textarea id="address" rows="2" cols="50" maxlength="45" name="address" >${testStudentForm.address}</textarea>
		</div>
		<div>
			<label for="gender" class="ui-label">Gender : </label><select id="gender" name="gender"><option value="M">Male</option><option value="F">Female</option></select>
		</div>
		<div>
			<label for="dob" class="ui-label">Dob : </label><input type="text" placeholder="mm/dd/yyyy" id="dob" name="dob" >
		</div>
		<div>
			<label for="email" class="ui-label">Email : </label><input type="text"  placeholder="" id="email" maxlength="45" name="email" value="${testStudentForm.email}"/>
		</div>
		<div>
			<label for="mobile" class="ui-label">Mobile : </label><input type="text"  placeholder="" id="mobile" maxlength="15" name="mobile" value="${testStudentForm.mobile}"/>
		</div>
		<div>
			<label for="phone" class="ui-label">Phone : </label><input type="text"  placeholder="" id="phone" maxlength="15" name="phone" value="${testStudentForm.phone}"/>
		</div>
		<div class="ui-label">
			<input type="submit" id="submit" value="Save"  style="float: center;"  />
		</div>
		<input type="hidden" name="id" id="id" value="${testStudentForm.id}">
		<input type="hidden" id="bodHidden" value="${testStudentForm.dob}">
		
</fieldset>	

<fieldset>
		<legend>Student List</legend>
		<table id="studentListTable" class="display">
		    <thead>
		        <tr>
		        	<th>No</th>
		            <th>ID</th>
					<th>NAME</th>
					<th>ADDRESS</th>
					<th>GENDER</th>
					<th>DOB</th>
					<th>EMAIL</th>
					<th>MOBILE</th>
					<th>PHONE</th>
					<th></th>
		        </tr>
		    </thead>
		    <tbody>
		    	
		    </tbody>
		</table>
</fieldset>	
</form>
	   <script type="text/javascript" charset="utf8" src="resources/js/dataTables.jqueryui.js"></script>
		<script type="text/javascript" charset="utf8" src="resources/js/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" charset="utf8" src="resources/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript">
		$(document).ready(function() {
			
			otable = $('#studentListTable').dataTable({
		    	jQueryUI: true,
		    	"aoColumns": [null,null,null,null,null,null,null,null,null,null
				              ],
				"fnRowCallback":function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
				$('td:eq(0)', nRow).html('<center>'+ (iDisplayIndexFull + 1)+'</center>');
				}
		    });
			
			
			 myUrl = '${pageContext.request.contextPath}/findAll';
			$.get(myUrl, function(data) {
				otable.fnClearTable();
				$.each(data, function(i,x){
					var gender = "Male";
					if(x[7] != "M"){
						gender = "Female";
					}

					$("#studentListTable").dataTable().fnAddData(
				    		[
				    		 ''
				    		,x[0]
				    		,x[1]
				    		,x[2]
				    		,gender
				    		,dateFormatter(x[4])
				    		,x[3]
				    		,x[5]
				    		,x[6]
				    		 ,'<input type="button" class="btnEdit" value="Edit" /><br><input type="button" class="btnDelete" value="Delete" />'
				    		]
				   );
				});
			}); 
			
			
			$(document).on("click","#submit",function() {
				window.location='${pageContext.request.contextPath}/#'
			});
			
			
			$(document).on("click",".btnDelete",function() {
				var row_selected = $(this).closest('tr');
				nRow = row_selected[0];
				aData = $("#studentListTable").dataTable().fnGetData(nRow);
				myUrl = '${pageContext.request.contextPath}/delete/'+aData[1];
				$.get(myUrl, function(data) {
					alert(data);
					window.location='${pageContext.request.contextPath}/';
				});
				
			});
			
			$(document).on("click",".btnEdit",function() {
				var row_selected = $(this).closest('tr');
				nRow = row_selected[0];
				aData = $("#studentListTable").dataTable().fnGetData(nRow);
				window.location='${pageContext.request.contextPath}/'+aData[1];
			});
			
			if($("#bodHidden").val() != ""){
				$("#dob").val(dateFormatter($("#bodHidden").val()));
			}
		});
		
		
		function dateFormatter(x){
			var formattedDate = new Date(x);
			var d = formattedDate.getDate();
			var m =  formattedDate.getMonth();
			m += 1;  // JavaScript months are 0-11
			var y = formattedDate.getFullYear();
			return d + "/" + m + "/" + y;
		}
		
		</script>	
</body>
</html>
