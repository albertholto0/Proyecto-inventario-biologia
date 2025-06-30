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

@WebServlet("/UsuarioController")
public class UsuarioController extends HttpServlet {
    private final UsuarioService service = new UsuarioService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            service.eliminarUsuario(id);
            response.sendRedirect(request.getContextPath() + "/pages/usuarios.jsp");
            return;
        }
        
        List<Usuario> usuarios = service.obtenerUsuarios();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("/pages/usuarios.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            String nombre = request.getParameter("nombre");
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            
            Usuario nuevoUsuario = new Usuario();
            nuevoUsuario.setNombre(nombre);
            nuevoUsuario.setUsuario(usuario);
            nuevoUsuario.setContrasena(contrasena);
            
            service.agregarUsuario(nuevoUsuario);
        }
        
        response.sendRedirect(request.getContextPath() + "/pages/usuarios.jsp");
    }
}