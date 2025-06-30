package com.unsij.dao;

import com.unsij.beans.Equipo;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EquipoDAO {
    public List<Equipo> listar() {
        List<Equipo> lista = new ArrayList<>();
        String sql = "SELECT e.*, "
                + "g.nombre_grupo, "
                + "cat.nombre_categoria, "
                + "sc.nombre_subcategoria, "
                + "t.nombre_tipo, "
                + "ef.nombre_estado, "
                + "l.nombre_laboratorio "
                + "FROM equipos e "
                + "LEFT JOIN grupos g ON e.id_grupo = g.id_grupo "
                + "LEFT JOIN categorias cat ON e.id_categoria = cat.id_categoria "
                + "LEFT JOIN subcategorias sc ON e.id_subcategoria = sc.id_subcategoria "
                + "LEFT JOIN tipos t ON e.id_tipo = t.id_tipo "
                + "LEFT JOIN estados_fisicos ef ON e.id_estado_fisico = ef.id_estado_fisico "
                + "LEFT JOIN laboratorios l ON e.id_laboratorio = l.id_laboratorio";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdEquipo(rs.getInt("id_equipo"));
                e.setNombreEquipo(rs.getString("nombre_equipo"));
                e.setIdGrupo(rs.getInt("id_grupo"));
                e.setNombreGrupo(rs.getString("nombre_grupo")); 
                e.setIdCategoria(rs.getInt("id_categoria"));
                e.setNombreCategoria(rs.getString("nombre_categoria")); 
                e.setIdSubcategoria(rs.getObject("id_subcategoria") != null ? rs.getInt("id_subcategoria") : null);
                e.setNombreSubcategoria(rs.getString("nombre_subcategoria")); 
                e.setIdTipo(rs.getInt("id_tipo"));
                e.setNombreTipo(rs.getString("nombre_tipo"));
                e.setMarca(rs.getString("marca"));
                e.setModelo(rs.getString("modelo"));
                e.setSerie(rs.getString("serie"));
                e.setColor(rs.getString("color"));
                e.setPrecio(rs.getObject("precio") != null ? rs.getFloat("precio") : null);
                e.setIdEstadoFisico(rs.getInt("id_estado_fisico"));
                e.setNombreEstadoFisico(rs.getString("nombre_estado")); 
                e.setIdLaboratorio(rs.getInt("id_laboratorio"));
                e.setNombreLaboratorio(rs.getString("nombre_laboratorio")); 
                
                lista.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<String> obtenerNombresGrupos() {
        List<String> grupos = new ArrayList<>();
        String sql = "SELECT nombre_grupo FROM grupos ORDER BY nombre_grupo";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                grupos.add(rs.getString("nombre_grupo"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return grupos;
    }

    public List<String> obtenerNombresCategorias() {
        List<String> categorias = new ArrayList<>();
        String sql = "SELECT nombre_categoria FROM categorias ORDER BY nombre_categoria";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                categorias.add(rs.getString("nombre_categoria"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categorias;
    }

    public List<String> obtenerNombresLaboratorios() {
        List<String> laboratorios = new ArrayList<>();
        String sql = "SELECT nombre_laboratorio FROM laboratorios ORDER BY nombre_laboratorio";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                laboratorios.add(rs.getString("nombre_laboratorio"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return laboratorios;
    }

    public List<String> obtenerNombresEstadosFisicos() {
        List<String> estados = new ArrayList<>();
        String sql = "SELECT nombre_estado FROM estados_fisicos ORDER BY nombre_estado";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                estados.add(rs.getString("nombre_estado"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return estados;
    }
    
    public List<Equipo> obtenerGruposCompletos() {
        List<Equipo> grupos = new ArrayList<>();
        String sql = "SELECT id_grupo, nombre_grupo FROM grupos ORDER BY nombre_grupo";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdGrupo(rs.getInt("id_grupo"));
                e.setNombreGrupo(rs.getString("nombre_grupo"));
                grupos.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return grupos;
    }
}