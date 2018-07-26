
<%
'On Error Resume Next

' ************ Eliminaci�n de cache *****************
Response.Expires = 0
Response.ExpiresAbsolute = Now() - 1
Response.AddHeader "pragma","no-cache"
Response.AddHeader "cache-control","private"
Response.AddHeader "cache-control","no-cache"
Response.AddHeader "cache-control","no-store"
Response.CacheControl = "no-cache"

'// Validar si es un usuario con registro previo de acceso //
If (Session("UserFP"&Session.SessionID) = "") And Trim(Request.QueryString("Session")) = "" And Trim(Request.QueryString("Categoria")) = "" Then
  Response.Redirect("login.asp")
End If

strActiveMenu = "Finanzas"
strActiveSubMenu = "articles"
%>
<!--#include virtual="/fp_mx_nl_linares_lkq_keystone/Connections/conn.asp" -->
<!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/functions.asp" -->
<!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/RFC1321.asp" -->
<%
'// Codigo para traer la lista de departamentos //
set cmdDepartamentos = Server.CreateObject("ADODB.Command")
cmdDepartamentos.ActiveConnection = MM_conn_STRING
cmdDepartamentos.CommandText = "spSys_deptos"
cmdDepartamentos.CommandType = 4
cmdDepartamentos.CommandTimeout = 0
cmdDepartamentos.Prepared = true
cmdDepartamentos.Parameters.Append cmdDepartamentos.CreateParameter("@RETURN_VALUE", 3, 4)
cmdDepartamentos.Parameters.Append cmdDepartamentos.CreateParameter("@Opcion", 200, 1, 10, "clave")
cmdDepartamentos.Parameters.Append cmdDepartamentos.CreateParameter("@SessionId", 200, 1,100,Trim(Session("UserFP"&Session.SessionID)))
set rsDepartamentos = cmdDepartamentos.Execute
rsDepartamentos_numRows = 0
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
<meta charset="utf-8" />
<!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/title.asp"-->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN THEME GLOBAL STYLES -->
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
<!-- END THEME GLOBAL STYLES -->
<!-- BEGIN THEME LAYOUT STYLES -->
<link href="/fp_mx_nl_linares_lkq_keystone/assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/layouts/layout/css/themes/darkblue.min.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="/fp_mx_nl_linares_lkq_keystone/assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
<!-- END THEME LAYOUT STYLES -->
<link rel="shortcut icon" href="/fp_mx_nl_linares_lkq_keystone/assets/global/img/fp-favicon.png" />
</head><!-- END HEAD -->
<body class="page-header-fixed page-full-width page-sidebar-closed-hide-logo page-content-white">
<!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/header.asp"-->
<!-- BEGIN HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"></div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
  <!-- BEGIN SIDEBAR -->
  <div class="page-sidebar-wrapper">
    <div class="page-sidebar navbar-collapse collapse">
      <!-- BEGIN SIDEBAR MENU -->
      <ul class="page-sidebar-menu" data-auto-scroll="true" data-slide-speed="200">
        <!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/subMenus.asp"-->
      </ul>
      <!-- END SIDEBAR MENU -->
    </div>
  </div>
  <!-- END SIDEBAR -->
  <!-- BEGIN CONTENT -->
  <div class="page-content-wrapper">
    <div class="page-content">
      <!-- BEGIN PAGE HEADER-->
      <!-- BEGIN THEME PANEL -->
      <!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/customizer.asp"-->
      <!-- END THEME PANEL -->
      <!-- BEGIN PAGE BAR -->
      <div class="page-bar">
        <ul class="page-breadcrumb">
          <li> <i class="fa fa-home"></i> <a href="../welcome.asp">Bienvenida</a><!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/navBar.asp"-->
          </li>
        </ul>
      </div>
      <h3 class="page-title"> Bienvenido(a) <%=Trim(rsUserInfo("Nombres"))%>&nbsp;<%=Trim(rsUserInfo("ApellidoPaterno"))%> </h3>
      <!-- END PAGE TITLE-->
      <!-- END PAGE HEADER-->
      <!-- BEGIN PAGE CONTENT-->
      <div class="row">
        <div class="col-md-3">
          <div class="form-group form-md-line-input form-md-floating-label">
            <button type="button" name="btnBuscar" class="btn blue" id="btnBuscar" data-toggle="modal" href="#pro1"><i class="fa fa-plus" ></i>&nbsp;Agregar Articulo</button>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" id="contadores"> </div>
      </div>
      <div class="row">
        <div class="col-md-12" id="main">
        <div class="portlet light bordered">
          <div class="portlet-title">
            <div class="caption font-dark"> <i class="icon-list font-dark"></i> <span class="caption-subject bold uppercase">Resultados</span> </div>
            <div class="tools"> </div>
          </div>
          <div class="portlet-body">
        <table class="table table-striped table-bordered table-hover" id="table_datos">
        <thead>
          <tr>
            <th>Artículo</th>
            <th>Descripción</th>
            <th>Cuenta</th>
            <th>Departamento</th>
          </tr>
        </thead>
        <tbody>
        <%
            cmd.CommandText = "SELECT * FROM Plant_articles"
            cmd.Prepared = true
            Set rsArticulos = cmd.Execute
        		While (Not rsArticulos.EOF)
        %>

          <tr>
            <td><%=Trim(rsArticulos.Fields.Item("NumeroArticulo").Value)%></td>
        		<td><%=Trim(rsArticulos.Fields.Item("Descripcion").Value)%></a></td>
            <td><%=Trim(rsArticulos.Fields.Item("cuenta").Value)%></td>
            <td><%=Trim(rsArticulos.Fields.Item("departamento").Value)%></td>
          </tr>

        <%
        			intTope = intTope + 1
        			rsArticulos.MoveNext()
        		Wend

        		Set fs = nothing
        		rsArticulos.Close()
        		Set rsArticulos = Nothing
        %>
        </tbody>
        </table>
        </div>
        </div>

        <script type="text/javascript">
        if (App.isAngularJsApp() === false) {
        	jQuery(document).ready(function() {
        		TableDatatablesButtons.init();
        	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        		$.fn.dataTable.tables({visible: true, api: true}).columns.adjust();
        	});

        	});
        }
        </script>

        </div>
      </div>
    </div>
    <!-- END CONTENT BODY -->
  </div>
  <!-- END CONTENT -->
</div>
<!-- END PAGE BAR -->
<!-- BEGIN PAGE TITLE-->
<div class="modal fade" id="pro1" role="basic" aria-hidden="true" style="display: none;">
  <div class="modal-dialog ">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
        <h4 class="modal-title">Agregar Articulo</h4>
      </div>
      <div class="modal-body">
        <form class="" action="procesas/addarticle.asp" method="post">
          <div class="col-md-12">
            <div class="form-group form-md-line-input form-md-floating-label">
              <input class="form-control" name="articulo" type="text" id="NombreCampo" maxlength="50" required/>
              <label for="NombreCampo">Articulo</label>
            </div>
          </div>
          <div class="col-md-12">
            <br>
            <select class="select2" name="cuenta" id="cuenta" style="z-index: 10055; required">
            <option value="0">SELECCIONAR CUENTA</option>

            <% cmd.CommandText = "SELECT * FROM Finances_Accounts"
            cmd.Prepared = true
            Set rsCuentas = cmd.Execute
            %>
            <%
            While (Not rsCuentas.EOF)
            %>
            <option value="<%=Trim(rsCuentas.Fields.Item("Cuenta").Value)%>"><%=Trim(rsCuentas.Fields.Item("Cuenta").Value)%></option>
            <%
            rsCuentas.MoveNext()
            Wend
            rsCuentas.Close()
            Set rsCuentas = Nothing %>
            </select>
            <br>
          </div>
          <br><br>
          <div class="col-md-12">
            <br>
            <select class="form-control select2" name="departamento" required>
              <option value="0">DEPARTAMENTO</option>
              <option value="PRODUCCION">PRODUCCION</option>
              <option value="PROCESOS">PROCESOS</option>
              <option value="MANTENIMIENTO">MANTENIMIENTO</option>
              <option value="LOGISTICA">LOGISTICA</option>
              <option value="RECURSOS HUMANOS">RECURSOS HUMANOS</option>
              <option value="FINANZAS">FINANZAS</option>
              <option value="CALIDAD">CALIDAD</option>
              <option value="SEGURIDAD">SEGURIDAD</option>
              <option value="SISTEMAS">SISTEMAS</option>
            </select>
            <br>
          </div>
          <div class="col-md-12">
            <input type="submit" class="btn btn-primary btn-block" id="Guardar" value="Guardar" />
          </div>
        </form>
      </div>
      <div class="modal-footer">
      </div>
    </div>
  </div>
</div>
<!--#include virtual="/fp_mx_nl_linares_lkq_keystone/assets/includes/footer.asp" -->
<!--[if lt IE 9]>
<script src="assets/global/plugins/respond.min.js"></script>
<script src="assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap-sessiontimeout/bootstrap-session-timeout.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/scripts/datatable.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/counterup/jquery.waypoints.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/plugins/counterup/jquery.counterup.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="/fp_mx_nl_linares_lkq_keystone/assets/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="/fp_mx_nl_linares_lkq_keystone/assets/pages/scripts/components-select2.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/pages/scripts/ui-session-timeout.js" type="text/javascript"></script>
<script type="text/javascript">
var TableDatatablesButtons = function () {

	var initTable1 = function () {
		var table = $('#table_datos');

		var fixedHeaderOffset = 0;
		if (App.getViewPort().width < App.getResponsiveBreakpoint('md')) {
				if ($('.page-header').hasClass('page-header-fixed-mobile')) {
						fixedHeaderOffset = $('.page-header').outerHeight(true);
				}
		} else if ($('.page-header').hasClass('navbar-fixed-top')) {
				fixedHeaderOffset = $('.page-header').outerHeight(true);
		}

		var oTable = table.dataTable({

			// Internationalisation. For more info refer to http://datatables.net/manual/i18n
			"language": {
				"aria": {
						"sortAscending": ": activate to sort column ascending",
						"sortDescending": ": activate to sort column descending"
				},
				"emptyTable": "No data available in table",
				"info": "Showing _START_ to _END_ of _TOTAL_ entries",
				"infoEmpty": "No entries found",
				"infoFiltered": "(filtered1 from _MAX_ total entries)",
				"lengthMenu": "_MENU_ entries",
				"search": "Search:",
				"zeroRecords": "No matching records found"
			},

			// Or you can use remote translation file
			//"language": {
			//   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
			//},


			buttons: [
				{ extend: 'print', className: 'btn dark btn-outline' },
				{ extend: 'copy', className: 'btn red btn-outline' },
				{ extend: 'pdf', className: 'btn green btn-outline' },
				{ extend: 'excel', className: 'btn yellow btn-outline ' },
				{ extend: 'csv', className: 'btn purple btn-outline ' },
				{ extend: 'colvis', className: 'btn dark btn-outline', text: 'Columns'}
			],

			// setup responsive extension: http://datatables.net/extensions/responsive/
			responsive: true,

			colReorder: {
				reorderCallback: function () {
					console.log( 'callback' );
				}
			},

			fixedHeader: {
				header: true,
				footer: true,
				headerOffset: fixedHeaderOffset
			},

			"order": [
				[0, 'asc']
			],

			"lengthMenu": [
				[5, 10, 15, 20, -1],
				[5, 10, 15, 20, "All"] // change per page values here
			],
			// set the initial value
			"pageLength": 20,

			"dom": "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-striped't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable

			// Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
			// setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
			// So when dropdowns used the scrollable div should be removed.
			//"dom": "<'row' <'col-md-12'T>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
		});
	}

	return {

		//main function to initiate the module
		init: function () {

			if (!jQuery().dataTable) {
					return;
			}

			initTable1();
		}

	};

}();

if (App.isAngularJsApp() === false) {
  jQuery(document).ready(function() {

		toastr.options = {"closeButton": true, "debug": false, "positionClass": "toast-top-center", "timeOut": "3000"};
		<%=strResultado%>

  });
}
</script>
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME LAYOUT SCRIPTS -->
<script src="/fp_mx_nl_linares_lkq_keystone/assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/layouts/layout/scripts/demo.min.js" type="text/javascript"></script>
<script src="/fp_mx_nl_linares_lkq_keystone/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
<!-- END THEME LAYOUT SCRIPTS -->
</body>
</html>
<%
If (Trim(Server.URLEncode(Request.QueryString("Operacion"))) = "correcto") Then
	Response.Write("<script languaje='javascript' type='text/javascript'>")
	Response.Write("jQuery(document).ready(function() {toastr['success']('La operación se llevo a cabo correctamente.', 'Correcto');});")
	Response.Write("</script>")
End If
%>
