package com.unsij.dao;

import com.unsij.beans.DetallePrestamoMaterial;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DetallePrestamoMaterialDAO {
    public List<DetallePrestamoMaterial> obtenerPorPrestamo(int idPrestamo) {
        List<DetallePrestamoMaterial> detalles = new ArrayList<>();
        String sql = "SELECT d.*, m.nombre AS nombre_material " +
                     "FROM detalles_prestamos_materiales d " +
                     "JOIN materiales m ON d.id_material = m.id_material " +
                     "WHERE d.id_prestamo = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, idPrestamo);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DetallePrestamoMaterial detalle = new DetallePrestamoMaterial();
                    detalle.setIdDetalle(rs.getInt("id_detalle"));
                    detalle.setIdPrestamo(rs.getInt("id_prestamo"));
                    detalle.setIdMaterial(rs.getInt("id_material"));
                    detalle.setCantidad(rs.getInt("cantidad"));
                    detalle.setNombreMaterial(rs.getString("nombre_material"));
                    detalles.add(detalle);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return detalles;
    }
}