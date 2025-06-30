package com.unsij.services;

import com.unsij.beans.Equipo;
import com.unsij.dao.EquipoDAO;
import java.util.List;

public class EquipoService {
    private final EquipoDAO dao = new EquipoDAO();
    
    public List<Equipo> obtenerEquipos() {
        return dao.listar();
    }
    
    public List<String> obtenerOpcionesGrupos() {
        return dao.obtenerNombresGrupos();
    }
    
    public List<String> obtenerOpcionesCategorias() {
        return dao.obtenerNombresCategorias();
    }
    
    public List<String> obtenerOpcionesLaboratorios() {
        return dao.obtenerNombresLaboratorios();
    }
    
    public List<String> obtenerOpcionesEstadosFisicos() {
        return dao.obtenerNombresEstadosFisicos();
    }
    
}