package com.unsij.services;

import com.unsij.beans.Prestamo;
import com.unsij.dao.PrestamoDAO;
import java.util.List;

public class PrestamoService {
    private final PrestamoDAO dao = new PrestamoDAO();
    
    public List<Prestamo> obtenerPrestamos() {
        return dao.listar();
    }
    
    public List<Prestamo> filtrarPrestamosPorEstado(String estado) {
        return dao.filtrarPorEstado(estado);
    }
    
    public boolean guardarPrestamo(Prestamo prestamo) {
        if (prestamo.getIdPrestamo() == 0) {
            return dao.insertar(prestamo);
        } else {
            return dao.actualizar(prestamo);
        }
    }
    
    public Prestamo obtenerPrestamoPorId(int id) {
        return dao.obtenerPorId(id);
    }
}