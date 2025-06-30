package com.unsij.services;

import com.unsij.beans.Alerta;
import com.unsij.dao.AlertaDAO;
import java.util.List;

public class AlertaService {
    private final AlertaDAO dao = new AlertaDAO();
    
    public List<Alerta> obtenerTodasAlertas() {
        return dao.listarTodas();
    }
}