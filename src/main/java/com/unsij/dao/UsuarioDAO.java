package com.unsij.dao;

import com.unsij.beans.Usuario;
import com.unsij.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
}