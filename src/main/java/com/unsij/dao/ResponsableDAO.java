package com.unsij.dao;

import com.unsij.beans.Responsable;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResponsableDAO {
    public List<Responsable> obtenerTodos() {
        List<Responsable> responsables = new ArrayList<>();
        String sql = "SELECT * FROM responsables";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Responsable responsable = new Responsable();
                responsable.setIdResponsable(rs.getInt("id_responsable"));
                responsable.setNombreCompleto(rs.getString("nombre_completo"));
                responsable.setCorreo(rs.getString("correo"));
                responsable.setNumeroTelefonico(rs.getString("numero_telefonico"));
                
                responsables.add(responsable);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return responsables;
    }
    
    public boolean guardar(Responsable responsable) {
        String sql = "INSERT INTO responsables (nombre_completo, correo, numero_telefonico) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, responsable.getNombreCompleto());
            ps.setString(2, responsable.getCorreo());
            ps.setString(3, responsable.getNumeroTelefonico());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}