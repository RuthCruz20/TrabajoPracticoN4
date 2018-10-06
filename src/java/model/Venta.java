package model;
import java.math.BigDecimal;
import java.sql.Date;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
public class Venta {
    private int id;
    private List<Producto>productos = new ArrayList();
    private MedioPago medioPago;
    private Usuario usuario;
    private BigDecimal montoTotal;
    private String fecha;
    private String hora;

    public Venta() {
    }

    public Venta(int id, MedioPago medioPago, Usuario usuario, String fecha, String hora) {
        this.id = id;
        this.medioPago = medioPago;
        this.usuario = usuario;
        this.fecha = fecha;
        this.hora = hora;
    }

    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Producto> getProductos() {
        return productos;
    }

    public void setProductos(List<Producto> productos) {
        this.productos = productos;
    }

    public MedioPago getMedioPago() {
        return medioPago;
    }

    public void setMedioPago(MedioPago medioPago) {
        this.medioPago = medioPago;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public BigDecimal getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(BigDecimal montoTotal) {
        this.montoTotal = montoTotal;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha() { 
        Calendar cal=Calendar.getInstance(); 

        String fecha=cal.get(cal.DATE)+"/"+cal.get(cal.MONTH+1)+"/"+cal.get(cal.YEAR);
         
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora() {
        Calendar cal=Calendar.getInstance();
        String hora = cal.get(cal.HOUR_OF_DAY)+":"+cal.get(cal.MINUTE)+":"+cal.get(cal.SECOND);
        this.hora = hora;
    }



    
    
}
