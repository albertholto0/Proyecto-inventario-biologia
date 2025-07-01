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

    public boolean insertarEquipo(Equipo equipo) {
        String sql = "INSERT INTO equipos (nombre_equipo, id_grupo, id_categoria, id_subcategoria, id_tipo, "
                + "marca, modelo, serie, color, precio, id_estado_fisico, id_laboratorio) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, equipo.getNombreEquipo());
            ps.setInt(2, equipo.getIdGrupo());
            ps.setInt(3, equipo.getIdCategoria());
            ps.setObject(4, equipo.getIdSubcategoria());
            ps.setInt(5, equipo.getIdTipo());
            ps.setString(6, equipo.getMarca());
            ps.setString(7, equipo.getModelo());
            ps.setString(8, equipo.getSerie());
            ps.setString(9, equipo.getColor());
            ps.setObject(10, equipo.getPrecio());
            ps.setInt(11, equipo.getIdEstadoFisico());
            ps.setInt(12, equipo.getIdLaboratorio());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarEquipo(Equipo equipo) {
        String sql = "UPDATE equipos SET nombre_equipo=?, id_grupo=?, id_categoria=?, id_subcategoria=?, id_tipo=?, "
                + "marca=?, modelo=?, serie=?, color=?, precio=?, id_estado_fisico=?, id_laboratorio=? "
                + "WHERE id_equipo=?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, equipo.getNombreEquipo());
            ps.setInt(2, equipo.getIdGrupo());
            ps.setInt(3, equipo.getIdCategoria());
            ps.setObject(4, equipo.getIdSubcategoria());
            ps.setInt(5, equipo.getIdTipo());
            ps.setString(6, equipo.getMarca());
            ps.setString(7, equipo.getModelo());
            ps.setString(8, equipo.getSerie());
            ps.setString(9, equipo.getColor());
            ps.setObject(10, equipo.getPrecio());
            ps.setInt(11, equipo.getIdEstadoFisico());
            ps.setInt(12, equipo.getIdLaboratorio());
            ps.setInt(13, equipo.getIdEquipo());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Equipo obtenerEquipoPorId(int id) {
        String sql = "SELECT * FROM equipos WHERE id_equipo=?";
        Equipo equipo = null;

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    equipo = new Equipo();
                    equipo.setIdEquipo(rs.getInt("id_equipo"));
                    equipo.setNombreEquipo(rs.getString("nombre_equipo"));
                    equipo.setIdGrupo(rs.getInt("id_grupo"));
                    equipo.setIdCategoria(rs.getInt("id_categoria"));
                    equipo.setIdSubcategoria(rs.getObject("id_subcategoria") != null ? rs.getInt("id_subcategoria") : null);
                    equipo.setIdTipo(rs.getInt("id_tipo"));
                    equipo.setMarca(rs.getString("marca"));
                    equipo.setModelo(rs.getString("modelo"));
                    equipo.setSerie(rs.getString("serie"));
                    equipo.setColor(rs.getString("color"));
                    equipo.setPrecio(rs.getObject("precio") != null ? rs.getFloat("precio") : null);
                    equipo.setIdEstadoFisico(rs.getInt("id_estado_fisico"));
                    equipo.setIdLaboratorio(rs.getInt("id_laboratorio"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return equipo;
    }

    public List<Equipo> obtenerCategoriasCompletas() {
        List<Equipo> categorias = new ArrayList<>();
        String sql = "SELECT id_categoria, nombre_categoria FROM categorias ORDER BY nombre_categoria";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdCategoria(rs.getInt("id_categoria"));
                e.setNombreCategoria(rs.getString("nombre_categoria"));
                categorias.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categorias;
    }

    public List<Equipo> obtenerSubcategoriasCompletas() {
        List<Equipo> subcategorias = new ArrayList<>();
        String sql = "SELECT id_subcategoria, nombre_subcategoria FROM subcategorias ORDER BY nombre_subcategoria";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdSubcategoria(rs.getInt("id_subcategoria"));
                e.setNombreSubcategoria(rs.getString("nombre_subcategoria"));
                subcategorias.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return subcategorias;
    }

    public List<Equipo> obtenerTiposCompletos() {
        List<Equipo> tipos = new ArrayList<>();
        String sql = "SELECT id_tipo, nombre_tipo FROM tipos ORDER BY nombre_tipo";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdTipo(rs.getInt("id_tipo"));
                e.setNombreTipo(rs.getString("nombre_tipo"));
                tipos.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tipos;
    }

    public List<Equipo> obtenerEstadosFisicosCompletos() {
        List<Equipo> estados = new ArrayList<>();
        String sql = "SELECT id_estado_fisico, nombre_estado FROM estados_fisicos ORDER BY nombre_estado";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdEstadoFisico(rs.getInt("id_estado_fisico"));
                e.setNombreEstadoFisico(rs.getString("nombre_estado"));
                estados.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return estados;
    }

    public List<Equipo> obtenerLaboratoriosCompletos() {
        List<Equipo> laboratorios = new ArrayList<>();
        String sql = "SELECT id_laboratorio, nombre_laboratorio FROM laboratorios ORDER BY nombre_laboratorio";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Equipo e = new Equipo();
                e.setIdLaboratorio(rs.getInt("id_laboratorio"));
                e.setNombreLaboratorio(rs.getString("nombre_laboratorio"));
                laboratorios.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return laboratorios;
    }
}
