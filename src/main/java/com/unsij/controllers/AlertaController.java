package com.unsij.controllers;

import com.unsij.beans.Alerta;
import com.unsij.services.AlertaService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AlertaController extends HttpServlet {
    private final AlertaService service = new AlertaService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Alerta> alertas = service.obtenerTodasAlertas();
        request.setAttribute("alertas", alertas);
        request.getRequestDispatcher("/pages/alertas.jsp").forward(request, response);
    }
}