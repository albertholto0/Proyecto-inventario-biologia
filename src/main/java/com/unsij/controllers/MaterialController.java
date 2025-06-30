package com.unsij.controllers;

import com.unsij.beans.Material;
import com.unsij.services.MaterialService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MaterialController extends HttpServlet {
    private final MaterialService service = new MaterialService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Material> materiales = service.obtenerTodosMateriales();
        request.setAttribute("materiales", materiales);
        request.getRequestDispatcher("/pages/materiales.jsp").forward(request, response);
    }
}