package com.unsij.controllers;

import com.unsij.beans.Alumno;
import com.unsij.services.AlumnoService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AlumnoController extends HttpServlet {
    private final AlumnoService service = new AlumnoService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Alumno> alumnos = service.obtenerAlumnos();
        request.setAttribute("alumnos", alumnos);
        request.getRequestDispatcher("/pages/alumnos.jsp").forward(request, response);
    }
    
    // Puedes implementar doPost para manejar formularios
}