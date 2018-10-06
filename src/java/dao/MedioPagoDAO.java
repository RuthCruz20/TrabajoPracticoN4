//hace la consulta a la BD
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.MedioPago;

public class MedioPagoDAO extends ConexionDAO {
  
public int setMedioPagoDAO(MedioPago medio) throws Exception{
        int lasId=0;
        Connection conn = null;
        ResultSet rs=null;
        PreparedStatement ps=null;
        
        try {
            conn = this.getDs().getConnection();
            String vsql="INSERT INTO medio_pago(numero_tarjeta,nombre_titular,mes_venc,anio_venc,cod_seguridad) VALUES(?,?,?,?,?)";
            ps = conn.prepareStatement(vsql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, medio.getNumeroTarjeta());
            ps.setString(2, medio.getNombreTitular());
            ps.setString(3, medio.getMesVenc());
            ps.setString(4, medio.getAnioVenc());
            ps.setInt(5, medio.getCodSeguridad());
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
  public MedioPago getMedioPagoDAO(int idMedioPago) throws Exception{
        Connection conn = null;
        ResultSet rs=null;
        PreparedStatement ps=null;
        MedioPago p = null;
        
        try {
            conn = this.getDs().getConnection();
            String vsql="SELECT * FROM medio_pago where id=? ";
            ps = conn.prepareStatement(vsql);
            ps.setInt(1, idMedioPago);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                p = new MedioPago();
                p.setId(rs.getInt("id"));
                p.setNumeroTarjeta(rs.getInt("numero_tarjeta"));
                p.setNombreTitular(rs.getString("nombre_titular"));
                p.setMesVenc(rs.getString("mes_venc"));
                p.setAnioVenc(rs.getString("anio_venc"));
                p.setCodSeguridad(rs.getInt("cod_seguridad"));
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
        return p;
     }
}
