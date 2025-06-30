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
    
    public boolean insertar(Material material) {
        String sql = "INSERT INTO materiales (nombre, tipo, presentacion, unidad, clave, cantidad, id_laboratorio) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, material.getNombre());
            ps.setString(2, material.getTipo());
            ps.setString(3, material.getPresentacion());
            ps.setInt(4, material.getUnidad());
            ps.setString(5, material.getClave());
            ps.setInt(6, material.getCantidad());
            
            if (material.getIdLaboratorio() > 0) {
                ps.setInt(7, material.getIdLaboratorio());
            } else {
                ps.setNull(7, Types.INTEGER);
            }
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        material.setIdMaterial(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean actualizar(Material material) {
        String sql = "UPDATE materiales SET nombre = ?, tipo = ?, presentacion = ?, unidad = ?, " +
                     "clave = ?, cantidad = ?, id_laboratorio = ? WHERE id_material = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, material.getNombre());
            ps.setString(2, material.getTipo());
            ps.setString(3, material.getPresentacion());
            ps.setInt(4, material.getUnidad());
            ps.setString(5, material.getClave());
            ps.setInt(6, material.getCantidad());
            
            if (material.getIdLaboratorio() > 0) {
                ps.setInt(7, material.getIdLaboratorio());
            } else {
                ps.setNull(7, Types.INTEGER);
            }
            
            ps.setInt(8, material.getIdMaterial());
            
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}