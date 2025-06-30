package com.unsij.services;

import com.unsij.beans.Laboratorio;
import com.unsij.dao.LaboratorioDAO;
import java.util.List;

public class LaboratorioService {
    private final LaboratorioDAO dao = new LaboratorioDAO();
    
    public List<Laboratorio> obtenerLaboratorios() {
        return dao.listar();
    }
    
    public boolean cambiarResponsable(int idLaboratorio, int idResponsable) {
        return dao.actualizarResponsable(idLaboratorio, idResponsable);
    }
}