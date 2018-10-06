/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import model.Producto;

/**
 *
 * @author Ruth Cruz
 */
public class ProductoVentaDAO extends ConexionDAO{
    public void setProductoVenta(int idVenta,List<Producto> productos) throws Exception{
        
        Connection conn = null;
        ResultSet rs=null;
        PreparedStatement ps=null;
        
        try {
            conn = this.getDs().getConnection();
            
            for (Producto producto : productos) {
            String vsql="INSERT INTO producto_venta(id_producto,id_venta) VALUES(?,?)";
            ps = conn.prepareStatement(vsql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, producto.getId());
            ps.setInt(2, idVenta);
            ps.executeUpdate();
            }
            
            
            rs = ps.getGeneratedKeys();
            if(rs.next()){
                int lasId = rs.getInt(1);
            }
            
            rs.close();
            rs=null;
            ps.close();
            ps=null;
            conn.close();
            conn=null;

        } catch (Exception e) {
            throw e;
        } finally {
            cierra_todo(rs, conn, ps);
        }
     }
    
}
