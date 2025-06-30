package com.unsij.services;

import com.unsij.beans.Usuario;
import com.unsij.dao.UsuarioDAO;
import java.util.ArrayList;
import java.util.List;

public class UsuarioService {
    private final UsuarioDAO dao = new UsuarioDAO();
    
    public List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        
        usuarios.add(new Usuario(1, "admin", "password123"));
        usuarios.add(new Usuario(2, "usuario1", "clave456"));
        
        return usuarios;
    }
}