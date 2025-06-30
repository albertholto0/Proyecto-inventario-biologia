package com.unsij.services;

import com.unsij.beans.Equipo;
import com.unsij.dao.EquipoDAO;
import java.util.List;

public class EquipoService {
    private final EquipoDAO dao = new EquipoDAO();
    
    public List<Equipo> obtenerEquipos() {
        return dao.listar();
    }
    
    // Puedes agregar más métodos según necesites
}