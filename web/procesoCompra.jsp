<%-- 
    Document   : procesoCompra
    Created on : 01/10/2018, 18:42:38
    Author     : Ruth Cruz
--%>

<%@page import="model.Producto"%>
<%@page import="dao.ProductoVentaDAO"%>
<%@page import="dao.VentaDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="dao.MedioPagoDAO"%>
<%@page import="model.Venta"%>
<%@page import="model.MedioPago"%>
<%@page import="model.Carrito"%>
<%@page import="model.Carrito"%>
<%@page import="model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    Usuario usuario = (Usuario) session.getAttribute("usuario");//obtiene un usr de la sesion(obj implicito, sin instancia) 

    Carrito carrito = null;
    if (session.getAttribute("carrito") == null) {  //si existe un carrito en la sesion, crea un carrito
        carrito = new Carrito();
        session.setAttribute("carrito", carrito);
    } else {
        carrito = (Carrito) session.getAttribute("carrito");
    }
%>

<%
    MedioPago medio = new MedioPago();//EN BASE DEL FORM Y 
    medio.setNumeroTarjeta(Integer.parseInt(request.getParameter("numeroTarjeta")));
    medio.setNombreTitular(request.getParameter("nombreTitular"));
    medio.setMesVenc(request.getParameter("mesVenc"));
    medio.setAnioVenc(request.getParameter("anioVenc"));
    medio.setCodSeguridad(Integer.parseInt(request.getParameter("codSeguridad")));
    MedioPagoDAO medioDAO= new MedioPagoDAO();
    int idMedio = medioDAO.setMedioPagoDAO(medio);
    
    Venta venta = new Venta();//de acuerdo alo anterior
    venta.setMedioPago(medioDAO.getMedioPagoDAO(idMedio));
    venta.setUsuario(usuario);
    venta.setFecha();
    venta.setHora();
    venta.setMontoTotal(carrito.sumarMontoProductos());
    venta.setProductos(carrito.getProductos());
    VentaDAO ventaDAO = new VentaDAO();
    int idVenta= ventaDAO.setVentaDAO(venta);
    
    ProductoVentaDAO productos= new ProductoVentaDAO();
    productos.setProductoVenta(idVenta, carrito.getProductos());
    //convocar metodos insert de clases DAO VENTA Y MEDIO DE PAGO PARA GUARDAR EN LA BD
    //PRIMERO GUARDAMOS DATA DE LA VENTA Y DESPUES GUARDAMOS EN LA TABLA DE PRODUCTO Y VENTA
    
%>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" href="estilos/estilos.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <title>Pagina de Inicio - Carrito de Compras</title>
    </head>
    <body>
        <jsp:include page="encabezado.html" />

        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="#">Logo</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="index.jsp">Productos</a></li>
                        <li><a href="mostrar_carrito.jsp">Carrito</a></li>
                        <li><a href="#">Ofertas</a></li>
                        <li><a href="#">Tiendas</a></li>
                        <li><a href="#">Contacto</a></li>
                    </ul>

                    <%if (usuario == null) {%>
                    <form action="login.jsp" method="post" class="navbar-form navbar-right">
                        <div class="form-group">
                            <input type="text" class="form-control" name="email" placeholder="Email Usuario">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" name="password" placeholder="Contraseña">
                        </div>
                        <button type="submit" name="ingresar" class="btn btn-default">Ingresar</button>
                    </form>

                    <%} else {%>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#"><span class="glyphicon glyphicon-user"></span> <%= usuario.getNombre()%></a></li> <!--lee li del usr-->
                        <li><a href="salir.jsp"><span class="glyphicon glyphicon-log-out"></span> Cerrar Sesión</a></li>
                        <li><a href="mostrar_carrito.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> Carrito</a></li>
                    </ul>
                    <% }%> 
                </div>
            </div>
        </nav>
        <div class="container"> 
        <form>
            <div class="row">
                <div class="col-lg-6" >
                    <h2>Datos Usuario</h2>
                    <ul class="list-group">
                        <li class="list-group-item">Nombre:   <%=usuario.getNombre()%></li>
                        <li class="list-group-item">Usuario:   <%=usuario.getEmail()%></li>
                    </ul>                    
                </div>
                <div class="col-lg-6" >
                    <h2>Medio de pago</h2>
                    <ul class="list-group">
                        <li class="list-group-item">Id Medio Pago:  <%= venta.getMedioPago().getId()%></li>
                        <li class="list-group-item">Nombre del Titular:  <%= venta.getMedioPago().getNombreTitular()%></li>
                        <li class="list-group-item">Numero de tarjeta de credito:  <%= venta.getMedioPago().getMesVenc()%></li>
                        <li class="list-group-item">Mes de vencimiento: <%= venta.getMedioPago().getMesVenc()%></li>
                        <li class="list-group-item">Mes de vencimiento:  <%= venta.getMedioPago().getAnioVenc()%></li>
                        <li class="list-group-item">Codigo de seguridad: <%= venta.getMedioPago().getCodSeguridad() %></li>
                    </ul>
                    
                </div>
            </div>
            
            <h2>Productos a comprar</h2>
            <div class="table-responsive"> 
                <table class="table table-hover table-striped ">
                    <caption>Productos agregados al Carrito</caption>
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Producto</th>
                            <th>Talle</th>
                            <th>Color</th>
                            <th>Precio</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th colspan="6">Total productos del Carrito: <%= carrito.contarProductos()%></th>
                        </tr>
                        <tr>
                            <th colspan="6">Monto Total del Carrito: <%= carrito.sumarMontoProductos()%> </th>
                        </tr>
                    </tfoot>
                    <tbody>

                        <%
                   for (Producto producto : venta.getProductos()) {%>
                        <tr>
                            <td><%= producto.getId()%></td>
                            <td><%= producto.getNombre()%></td>
                            <td><%= producto.getTalle()%></td>
                            <td><%= producto.getColor()%></td>
                            <td><%= producto.getPrecio()%></td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
        </form>
        </div>
        </div>                   
          
        <jsp:include page="footer.html" />
    </body>
</html>



