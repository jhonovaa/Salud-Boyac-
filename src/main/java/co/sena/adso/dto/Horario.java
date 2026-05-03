package co.sena.adso.dto;

import java.sql.Time;

public class Horario {
    
    private int id;
    private int idMedico;
    
    // NUEVO CAMPO: Agregado para que el DAO pueda guardar el nombre del doctor
    private String medicoNombre; 
    
    private int diaSemana;
    private Time horaInicio;
    private Time horaFin;
    private int maxCitas;

    // Constructor vacío por defecto
    public Horario() {
    }

    // Getters y Setters originales intactos
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idMedico) {
        this.idMedico = idMedico;
    }

    // NUEVOS GETTERS Y SETTERS para el nombre del médico
    public String getMedicoNombre() {
        return medicoNombre;
    }

    public void setMedicoNombre(String medicoNombre) {
        this.medicoNombre = medicoNombre;
    }

    // El resto de Getters y Setters intactos
    public int getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(int diaSemana) {
        this.diaSemana = diaSemana;
    }

    public Time getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Time horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Time getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(Time horaFin) {
        this.horaFin = horaFin;
    }

    public int getMaxCitas() {
        return maxCitas;
    }

    public void setMaxCitas(int maxCitas) {
        this.maxCitas = maxCitas;
    }
}