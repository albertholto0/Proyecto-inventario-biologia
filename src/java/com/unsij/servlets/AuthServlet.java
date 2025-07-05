package com.unsij.servlets;

import com.unsij.beans.Usuario;
import com.unsij.dao.UsuarioDAO;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario user = usuarioDAO.validarUsuario(usuario, contrasena);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("authenticated", true);
            session.setAttribute("username", user.getUsuario()); 
            
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp?error=1");
        }
    }
}