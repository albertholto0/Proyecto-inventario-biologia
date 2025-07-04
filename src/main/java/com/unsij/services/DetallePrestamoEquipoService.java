package com.unsij.services;

import com.unsij.beans.DetallePrestamoEquipo;
import com.unsij.dao.DetallePrestamoEquipoDAO;
import java.util.List;

public class DetallePrestamoEquipoService {
    private final DetallePrestamoEquipoDAO dao = new DetallePrestamoEquipoDAO();
    
    public List<DetallePrestamoEquipo> obtenerPorPrestamo(int idPrestamo) {
        return dao.obtenerPorPrestamo(idPrestamo);
    }
}