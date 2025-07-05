package com.unsij.dao;

import com.unsij.beans.DetallePrestamoEquipo;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DetallePrestamoEquipoDAO {
    public List<DetallePrestamoEquipo> obtenerPorPrestamo(int idPrestamo) {
        List<DetallePrestamoEquipo> detalles = new ArrayList<>();
        String sql = "SELECT d.*, e.nombre AS nombre_equipo " +
                     "FROM detalles_prestamos_equipos d " +
                     "JOIN equipos e ON d.id_equipo = e.id_equipo " +
                     "WHERE d.id_prestamo = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idPrestamo);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DetallePrestamoEquipo detalle = new DetallePrestamoEquipo();
                    detalle.setIdDetalle(rs.getInt("id_detalle"));
                    detalle.setIdPrestamo(rs.getInt("id_prestamo"));
                    detalle.setIdEquipo(rs.getInt("id_equipo"));
                    detalle.setCantidad(rs.getInt("cantidad"));
                    detalle.setNombreEquipo(rs.getString("nombre_equipo"));
                    detalles.add(detalle);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return detalles;
    }
}