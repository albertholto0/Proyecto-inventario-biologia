package com.unsij.dao;

import com.unsij.beans.Usuario;
import com.unsij.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    public Usuario validarUsuario(String usuario, String contrasena) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        Usuario user = null;

        try {
            connection = DBConnection.getConnection();
            String sql = "SELECT id_usuario, nombre, usuario, password_usuario FROM usuarios WHERE usuario = ? AND password_usuario = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, usuario);
            preparedStatement.setString(2, contrasena);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new Usuario();
                user.setId(resultSet.getInt("id_usuario"));
                user.setNombre(resultSet.getString("nombre"));
                user.setUsuario(resultSet.getString("usuario"));
                user.setContrasena(resultSet.getString("password_usuario"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(resultSet, preparedStatement, connection);
        }
        return user;
    }

    public List<Usuario> obtenerTodosUsuarios() {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        List<Usuario> usuarios = new ArrayList<>();

        try {
            connection = DBConnection.getConnection();
            String sql = "SELECT id_usuario, nombre, usuario, password_usuario FROM usuarios";
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(resultSet.getInt("id_usuario"));
                usuario.setNombre(resultSet.getString("nombre"));
                usuario.setUsuario(resultSet.getString("usuario"));
                usuario.setContrasena(resultSet.getString("password_usuario"));
                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(resultSet, preparedStatement, connection);
        }
        return usuarios;
    }

    public boolean agregarUsuario(Usuario usuario) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean success = false;

        try {
            connection = DBConnection.getConnection();
            String sql = "INSERT INTO usuarios (nombre, usuario, password_usuario) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, usuario.getNombre());
            preparedStatement.setString(2, usuario.getUsuario());
            preparedStatement.setString(3, usuario.getContrasena());
            int rowsAffected = preparedStatement.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(null, preparedStatement, connection);
        }
        return success;
    }

    public boolean eliminarUsuario(int id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean success = false;

        try {
            connection = DBConnection.getConnection();
            String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            int rowsAffected = preparedStatement.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(null, preparedStatement, connection);
        }
        return success;
    }
}