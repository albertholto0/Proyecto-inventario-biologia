package com.unsij.dao;

import com.unsij.beans.Alumno;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlumnoDAO {
    public List<Alumno> listar() {
        return listarFiltrado(null, null);
    }
    
    public List<Alumno> listarFiltrado(Integer grupo, String carrera) {
        List<Alumno> lista = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM alumnos WHERE 1=1");
        
        if (grupo != null) {
            sql.append(" AND grupo = ?");
        }
        if (carrera != null && !carrera.isEmpty()) {
            sql.append(" AND carrera = ?");
        }
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (grupo != null) {
                ps.setInt(paramIndex++, grupo);
            }
            if (carrera != null && !carrera.isEmpty()) {
                ps.setString(paramIndex, carrera);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Alumno a = new Alumno();
                    a.setIdAlumno(rs.getInt("id_alumno"));
                    a.setNombreCompleto(rs.getString("nombre_completo"));
                    a.setCorreo(rs.getString("correo"));
                    a.setMatricula(rs.getInt("matricula"));
                    a.setGrupo(rs.getInt("grupo"));
                    a.setCarrera(rs.getString("carrera"));
                    lista.add(a);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    public boolean insertar(Alumno alumno) {
        String sql = "INSERT INTO alumnos (nombre_completo, correo, matricula, grupo, carrera) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, alumno.getNombreCompleto());
            ps.setString(2, alumno.getCorreo());
            ps.setInt(3, alumno.getMatricula());
            ps.setInt(4, alumno.getGrupo());
            ps.setString(5, alumno.getCarrera());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        alumno.setIdAlumno(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean actualizar(Alumno alumno) {
        String sql = "UPDATE alumnos SET nombre_completo=?, correo=?, matricula=?, grupo=?, carrera=? WHERE id_alumno=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, alumno.getNombreCompleto());
            ps.setString(2, alumno.getCorreo());
            ps.setInt(3, alumno.getMatricula());
            ps.setInt(4, alumno.getGrupo());
            ps.setString(5, alumno.getCarrera());
            ps.setInt(6, alumno.getIdAlumno());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Alumno obtenerPorId(int id) {
        String sql = "SELECT * FROM alumnos WHERE id_alumno=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Alumno a = new Alumno();
                    a.setIdAlumno(rs.getInt("id_alumno"));
                    a.setNombreCompleto(rs.getString("nombre_completo"));
                    a.setCorreo(rs.getString("correo"));
                    a.setMatricula(rs.getInt("matricula"));
                    a.setGrupo(rs.getInt("grupo"));
                    a.setCarrera(rs.getString("carrera"));
                    return a;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}