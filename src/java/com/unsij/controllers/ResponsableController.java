package com.unsij.controllers;

import com.unsij.beans.Responsable;
import com.unsij.services.ResponsableService;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ResponsableController")
public class ResponsableController extends HttpServlet {
    private final ResponsableService service = new ResponsableService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        if ("guardar".equals(action)) {
            Responsable responsable = new Responsable();
            responsable.setNombreCompleto(request.getParameter("nombreCompleto"));
            responsable.setCorreo(request.getParameter("correo"));
            responsable.setNumeroTelefonico(request.getParameter("numeroTelefonico"));
            
            boolean guardado = service.guardarResponsable(responsable);
            
            if (guardado) {
                session.setAttribute("alertType", "success");
                session.setAttribute("alertMessage", "Responsable registrado exitosamente");
            } else {
                session.setAttribute("alertType", "error");
                session.setAttribute("alertMessage", "Error al registrar responsable");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/pages/laboratorios.jsp");
    }
}