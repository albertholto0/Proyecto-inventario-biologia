package com.unsij.dao;

import com.unsij.beans.Material;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO {
    public List<Material> listarTodos() {
        List<Material> lista = new ArrayList<>();
        String sql = "SELECT m.*, l.nombre_laboratorio " +
                     "FROM materiales m " +
                     "LEFT JOIN laboratorios l ON m.id_laboratorio = l.id_laboratorio";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Material mat = new Material();
                mat.setIdMaterial(rs.getInt("id_material"));
                mat.setNombre(rs.getString("nombre"));
                mat.setTipo(rs.getString("tipo"));
                mat.setPresentacion(rs.getString("presentacion"));
                mat.setUnidad(rs.getInt("unidad"));
                mat.setClave(rs.getString("clave"));
                mat.setCantidad(rs.getInt("cantidad"));
                mat.setIdLaboratorio(rs.getInt("id_laboratorio"));
                mat.setNombreLaboratorio(rs.getString("nombre_laboratorio"));
                
                lista.add(mat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}