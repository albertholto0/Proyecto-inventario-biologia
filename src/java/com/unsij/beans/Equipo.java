package com.unsij.beans;

import java.io.Serializable;

public class Equipo implements Serializable {
    private int idEquipo;
    private String nombreEquipo;
    private int idGrupo;
    private String nombreGrupo; 
    private int idCategoria;
    private String nombreCategoria; 
    private Integer idSubcategoria;
    private String nombreSubcategoria; 
    private int idTipo;
    private String nombreTipo;
    private String marca;
    private String modelo;
    private String serie;
    private String color;
    private Float precio;
    private int idEstadoFisico;
    private String nombreEstadoFisico; 
    private int idLaboratorio;
    private String nombreLaboratorio;
    
    public int getIdEquipo() {
        return idEquipo;
    }

    public void setIdEquipo(int idEquipo) {
        this.idEquipo = idEquipo;
    }

    public String getNombreEquipo() {
        return nombreEquipo;
    }

    public void setNombreEquipo(String nombreEquipo) {
        this.nombreEquipo = nombreEquipo;
    }

    public int getIdGrupo() {
        return idGrupo;
    }

    public void setIdGrupo(int idGrupo) {
        this.idGrupo = idGrupo;
    }

    public String getNombreGrupo() {
        return nombreGrupo;
    }

    public void setNombreGrupo(String nombreGrupo) {
        this.nombreGrupo = nombreGrupo;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    public Integer getIdSubcategoria() {
        return idSubcategoria;
    }

    public void setIdSubcategoria(Integer idSubcategoria) {
        this.idSubcategoria = idSubcategoria;
    }

    public String getNombreSubcategoria() {
        return nombreSubcategoria;
    }

    public void setNombreSubcategoria(String nombreSubcategoria) {
        this.nombreSubcategoria = nombreSubcategoria;
    }

    public int getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(int idTipo) {
        this.idTipo = idTipo;
    }

    public String getNombreTipo() {
        return nombreTipo;
    }

    public void setNombreTipo(String nombreTipo) {
        this.nombreTipo = nombreTipo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Float getPrecio() {
        return precio;
    }

    public void setPrecio(Float precio) {
        this.precio = precio;
    }

    public int getIdEstadoFisico() {
        return idEstadoFisico;
    }

    public void setIdEstadoFisico(int idEstadoFisico) {
        this.idEstadoFisico = idEstadoFisico;
    }

    public String getNombreEstadoFisico() {
        return nombreEstadoFisico;
    }

    public void setNombreEstadoFisico(String nombreEstadoFisico) {
        this.nombreEstadoFisico = nombreEstadoFisico;
    }

    public int getIdLaboratorio() {
        return idLaboratorio;
    }

    public void setIdLaboratorio(int idLaboratorio) {
        this.idLaboratorio = idLaboratorio;
    }

    public String getNombreLaboratorio() {
        return nombreLaboratorio;
    }

    public void setNombreLaboratorio(String nombreLaboratorio) {
        this.nombreLaboratorio = nombreLaboratorio;
    }
    
    @Override
    public String toString() {
        return "Equipo{" + "idEquipo=" + idEquipo + ", nombreEquipo=" + nombreEquipo + '}';
    }
}