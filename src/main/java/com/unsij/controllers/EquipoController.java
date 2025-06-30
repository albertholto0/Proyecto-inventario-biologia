package com.unsij.controllers;

import com.unsij.beans.Equipo;
import com.unsij.services.EquipoService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EquipoController extends HttpServlet {
    private final EquipoService service = new EquipoService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("EquipoController - doGet ejecutándose");
        
        try {
            List<Equipo> equipos = service.obtenerEquipos();
            System.out.println("Equipos obtenidos: " + equipos.size());
            
            request.setAttribute("equipos", equipos);
            request.getRequestDispatcher("/pages/equipos.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error en EquipoController:");
            e.printStackTrace();
            throw new ServletException("Error al obtener equipos", e);
        }
    }
    
    
}