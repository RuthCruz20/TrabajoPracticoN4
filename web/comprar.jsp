<%@page import="dao.MedioPagoDAO"%>
<%@page contentType="text/html" language="java" pageEncoding="UTF-8"%>  

<%@page import="java.util.List"%>
<%@page import="model.Producto"%>
<%@page import="RN.ProductoRN"%>
<%@page contentType="text/html" language="java"%>  
<%@page import="model.Usuario" session="true"%>
<%@page import="model.Carrito"%>
<%@page import="model.MedioPago"%>

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
        <h1>DATOS USUARIO</h1>
        <form>
            <label>Nombre</label>
            <%=usuario.getNombre()%>
            <br><br>
            <label>DNI</label>
            <%=usuario.getEmail()%>
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
                            <th colspan="6" name="montoTotal">Monto Total del Carrito: <%= carrito.sumarMontoProductos()%> </th>
                        </tr>
                    </tfoot>
                    <tbody>

                        <%
                            for (Producto producto : carrito.getProductos()) {%>
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
        <form name="f1" action="procesoCompra.jsp" >
            <h1>Medio de pago</h1>
            <label>Numero de tarjeta de credito </label>
            <input type="number" name="numeroTarjeta"><br>
            <label>mes de vencimiento </label>
            <input type="text" name="mesVenc"><br>
            <label>anio de vencimiento </label>
            <input type="text" name="anioVenc"><br>
            <label>Codigo de seguridad </label>
            <input type="number" name="codSeguridad"><br>
            <label>Titular </label>
            <input type="text" name="nombreTitular"><br>
            <input type="submit" value="Comprar" name="b1" class="btn btn-success" />
        </form> 
        </div>
        </div>
    <jsp:include page="footer.html" />
</body>
</html>