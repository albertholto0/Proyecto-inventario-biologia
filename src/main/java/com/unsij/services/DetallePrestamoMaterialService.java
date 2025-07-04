package com.unsij.services;

import com.unsij.beans.DetallePrestamoMaterial;
import com.unsij.dao.DetallePrestamoMaterialDAO;
import java.util.List;

public class DetallePrestamoMaterialService {
    private final DetallePrestamoMaterialDAO dao = new DetallePrestamoMaterialDAO();
    
    public List<DetallePrestamoMaterial> obtenerPorPrestamo(int idPrestamo) {
        return dao.obtenerPorPrestamo(idPrestamo);
    }
}