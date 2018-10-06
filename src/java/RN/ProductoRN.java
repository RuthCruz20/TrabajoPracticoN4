package RN;

import dao.ProductoDAO;
import java.util.List;
import model.Producto;

public class ProductoRN {
    public static List<Producto> listarProductos() throws Exception {
        ProductoDAO prodDao = new ProductoDAO();
        return prodDao.getProductos();
    }
    public static Producto obtenerProductoById(int idProducto) throws Exception {
        ProductoDAO prodDao = new ProductoDAO();
        return prodDao.getProductoById(idProducto);
    }
}
