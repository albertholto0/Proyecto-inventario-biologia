package com.unsij.dao;

import com.unsij.beans.Alumno;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlumnoDAO {
    public List<Alumno> listar() {
        List<Alumno> lista = new ArrayList<>();
        String sql = "SELECT * FROM alumnos";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    // Puedes agregar más métodos según necesites (insertar, actualizar, eliminar)
}