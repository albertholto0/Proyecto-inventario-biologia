package com.unsij.dao;

import com.unsij.beans.Alerta;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlertaDAO {
    public List<Alerta> listarTodas() {
        List<Alerta> lista = new ArrayList<>();
        String sql = "SELECT * FROM alertas ORDER BY fecha_envio DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Alerta alerta = new Alerta();
                alerta.setIdAlerta(rs.getInt("id_alerta"));
                alerta.setTipo(rs.getString("tipo"));
                alerta.setIdPrestamo(rs.getInt("id_prestamo"));
                alerta.setMensaje(rs.getString("mensaje"));
                alerta.setFechaEnvio(rs.getTimestamp("fecha_envio"));
                alerta.setEstado(rs.getString("estado"));
                
                lista.add(alerta);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}