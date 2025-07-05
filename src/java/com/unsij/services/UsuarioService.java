package com.unsij.services;

import com.unsij.beans.Usuario;
import com.unsij.dao.UsuarioDAO;
import java.util.List;

public class UsuarioService {
    private final UsuarioDAO dao = new UsuarioDAO();
    
    public List<Usuario> obtenerUsuarios() {
        return dao.obtenerTodosUsuarios();
    }
    
    public boolean agregarUsuario(Usuario usuario) {
        return dao.agregarUsuario(usuario);
    }
    
    public boolean eliminarUsuario(int id) {
        return dao.eliminarUsuario(id);
    }
}