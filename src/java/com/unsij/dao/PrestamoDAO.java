package com.unsij.dao;

import com.unsij.beans.Prestamo;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrestamoDAO {
    public List<Prestamo> listar() {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM prestamos";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Prestamo p = new Prestamo();
                p.setIdPrestamo(rs.getInt("id_prestamo"));
                p.setIdAlumno(rs.getInt("id_alumno"));
                p.setFechaPrestamo(rs.getTimestamp("fecha_prestamo"));
                p.setFechaDevolucionPrevista(rs.getTimestamp("fecha_devolucion_prevista"));
                p.setFechaDevolucionReal(rs.getTimestamp("fecha_devolucion_real"));
                p.setIdLaboratorio(rs.getInt("id_laboratorio"));
                p.setEstado(rs.getString("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    public boolean insertar(Prestamo prestamo) {
        String sql = "INSERT INTO prestamos (id_alumno, fecha_prestamo, fecha_devolucion_prevista, id_laboratorio, estado) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, prestamo.getIdAlumno());
            ps.setTimestamp(2, new java.sql.Timestamp(prestamo.getFechaPrestamo().getTime()));
            ps.setTimestamp(3, new java.sql.Timestamp(prestamo.getFechaDevolucionPrevista().getTime()));
            ps.setInt(4, prestamo.getIdLaboratorio());
            ps.setString(5, prestamo.getEstado());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        prestamo.setIdPrestamo(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean actualizar(Prestamo prestamo) {
        String sql = "UPDATE prestamos SET id_alumno=?, fecha_prestamo=?, fecha_devolucion_prevista=?, fecha_devolucion_real=?, id_laboratorio=?, estado=? WHERE id_prestamo=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, prestamo.getIdAlumno());
            ps.setTimestamp(2, new java.sql.Timestamp(prestamo.getFechaPrestamo().getTime()));
            ps.setTimestamp(3, new java.sql.Timestamp(prestamo.getFechaDevolucionPrevista().getTime()));
            ps.setTimestamp(4, prestamo.getFechaDevolucionReal() != null ? 
                new java.sql.Timestamp(prestamo.getFechaDevolucionReal().getTime()) : null);
            ps.setInt(5, prestamo.getIdLaboratorio());
            ps.setString(6, prestamo.getEstado());
            ps.setInt(7, prestamo.getIdPrestamo());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Prestamo obtenerPorId(int id) {
        String sql = "SELECT * FROM prestamos WHERE id_prestamo=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Prestamo p = new Prestamo();
                    p.setIdPrestamo(rs.getInt("id_prestamo"));
                    p.setIdAlumno(rs.getInt("id_alumno"));
                    p.setFechaPrestamo(rs.getTimestamp("fecha_prestamo"));
                    p.setFechaDevolucionPrevista(rs.getTimestamp("fecha_devolucion_prevista"));
                    p.setFechaDevolucionReal(rs.getTimestamp("fecha_devolucion_real"));
                    p.setIdLaboratorio(rs.getInt("id_laboratorio"));
                    p.setEstado(rs.getString("estado"));
                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Prestamo> filtrarPorEstado(String estado) {
        List<Prestamo> lista = new ArrayList<>();
        String sql = "SELECT * FROM prestamos WHERE estado=?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, estado);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prestamo p = new Prestamo();
                    p.setIdPrestamo(rs.getInt("id_prestamo"));
                    p.setIdAlumno(rs.getInt("id_alumno"));
                    p.setFechaPrestamo(rs.getTimestamp("fecha_prestamo"));
                    p.setFechaDevolucionPrevista(rs.getTimestamp("fecha_devolucion_prevista"));
                    p.setFechaDevolucionReal(rs.getTimestamp("fecha_devolucion_real"));
                    p.setIdLaboratorio(rs.getInt("id_laboratorio"));
                    p.setEstado(rs.getString("estado"));
                    lista.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}