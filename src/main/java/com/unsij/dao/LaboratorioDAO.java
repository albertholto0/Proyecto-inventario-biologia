package com.unsij.dao;

import com.unsij.beans.Laboratorio;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LaboratorioDAO {
    public List<Laboratorio> listar() {
        List<Laboratorio> lista = new ArrayList<>();
        String sql = "SELECT l.*, r.nombre_completo AS nombre_responsable " +
                     "FROM laboratorios l " +
                     "LEFT JOIN responsables r ON l.id_responsable = r.id_responsable";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Laboratorio lab = new Laboratorio();
                lab.setIdLaboratorio(rs.getInt("id_laboratorio"));
                lab.setNombreLaboratorio(rs.getString("nombre_laboratorio"));
                lab.setDescripcion(rs.getString("descripcion"));
                lab.setIdResponsable(rs.getInt("id_responsable"));
                lab.setNombreResponsable(rs.getString("nombre_responsable"));
                
                lista.add(lab);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}