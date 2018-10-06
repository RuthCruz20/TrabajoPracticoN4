package model;

public class MedioPago {
    private int id;
    private int numeroTarjeta;
    private String nombreTitular;
    private String mesVenc;
    private String anioVenc;
    private int codSeguridad;
    
    public MedioPago(){
        
    }
    public MedioPago(int numeroTarjeta, String nombreTitular, String mesVenc,String anioVenc, int codSeguridad) {
        
        this.numeroTarjeta = numeroTarjeta;
        this.nombreTitular = nombreTitular;
        this.mesVenc=mesVenc;
        this.anioVenc=anioVenc;
        this.codSeguridad = codSeguridad;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumeroTarjeta() {
        return numeroTarjeta;
    }

    public void setNumeroTarjeta(int numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }

    public String getNombreTitular() {
        return nombreTitular;
    }

    public void setNombreTitular(String nombreTitular) {
        this.nombreTitular = nombreTitular;
    }

    public String getMesVenc() {
        return mesVenc;
    }

    public void setMesVenc(String mesVenc) {
        this.mesVenc = mesVenc;
    }

    public String getAnioVenc() {
        return anioVenc;
    }

    public void setAnioVenc(String anioVenc) {
        this.anioVenc = anioVenc;
    }

    public int getCodSeguridad() {
        return codSeguridad;
    }

    public void setCodSeguridad(int codSeguridad) {
        this.codSeguridad = codSeguridad;
    }


    
    
    
}
