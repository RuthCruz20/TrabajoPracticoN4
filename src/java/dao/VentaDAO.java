/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Venta;



/**
 *
 * @author Ruth Cruz
 */
public class VentaDAO extends ConexionDAO{
    public int setVentaDAO(Venta venta) throws Exception{
        int lasId=0;
        Connection conn = null;
        ResultSet rs=null;
        PreparedStatement ps=null;
        
        try {
            conn = this.getDs().getConnection();
            String vsql="INSERT INTO venta(id_medio_pago,monto_total,id_usuario,fecha,hora) VALUES(?,?,?,?,?)";
            ps = conn.prepareStatement(vsql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, venta.getMedioPago().getId());
            ps.setBigDecimal(2, venta.getMontoTotal());
            ps.setString(3, venta.getUsuario().getEmail());
            ps.setString(4, venta.getFecha());
            ps.setString(5, venta.getHora());
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if(rs.next()){
                lasId = rs.getInt(1);
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
        return lasId;
    }
    
}
