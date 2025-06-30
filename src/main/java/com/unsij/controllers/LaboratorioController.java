package com.unsij.controllers;

import com.unsij.beans.Laboratorio;
import com.unsij.services.LaboratorioService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LaboratorioController extends HttpServlet {
    private final LaboratorioService service = new LaboratorioService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Laboratorio> laboratorios = service.obtenerLaboratorios();
        request.setAttribute("laboratorios", laboratorios);
        request.getRequestDispatcher("/pages/laboratorios.jsp").forward(request, response);
    }
}