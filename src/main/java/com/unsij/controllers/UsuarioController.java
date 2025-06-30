package com.unsij.controllers;

import com.unsij.beans.Usuario;
import com.unsij.services.UsuarioService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UsuarioController extends HttpServlet {
    private final UsuarioService service = new UsuarioService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Usuario> usuarios = service.obtenerUsuarios();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("/pages/usuarios.jsp").forward(request, response);
    }
}