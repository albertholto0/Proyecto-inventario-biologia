package com.unsij.dao;

import com.unsij.beans.Laboratorio;
import com.unsij.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LaboratorioDAO {

    public List<Laboratorio> listar() {
        List<Laboratorio> lista = new ArrayList<>();
        String sql = "SELECT l.*, r.nombre_completo AS nombre_responsable "
                + "FROM laboratorios l "
                + "LEFT JOIN responsables r ON l.id_responsable = r.id_responsable";

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

    public boolean actualizarResponsable(int idLaboratorio, int idResponsable) {
        String sql = "UPDATE laboratorios SET id_responsable = ? WHERE id_laboratorio = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idResponsable);
            ps.setInt(2, idLaboratorio);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Laboratorio obtenerPorId(int id) {
        String sql = "SELECT l.*, r.nombre_completo AS nombre_responsable "
                + "FROM laboratorios l "
                + "LEFT JOIN responsables r ON l.id_responsable = r.id_responsable "
                + "WHERE l.id_laboratorio = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Laboratorio lab = new Laboratorio();
                    lab.setIdLaboratorio(rs.getInt("id_laboratorio"));
                    lab.setNombreLaboratorio(rs.getString("nombre_laboratorio"));
                    lab.setDescripcion(rs.getString("descripcion"));
                    lab.setIdResponsable(rs.getInt("id_responsable"));
                    lab.setNombreResponsable(rs.getString("nombre_responsable"));
                    return lab;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
