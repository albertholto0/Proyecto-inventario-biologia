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

        String action = request.getParameter("action");
        if ("obtener".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Alumno alumno = service.obtenerAlumnoPorId(id);
            request.setAttribute("alumno", alumno);
            request.getRequestDispatcher("/pages/alumnos.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("/pages/alumnos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        Alumno alumno = new Alumno();
        String idStr = request.getParameter("idAlumno");
        if (idStr != null && !idStr.isEmpty()) {
            alumno.setIdAlumno(Integer.parseInt(idStr));
        }
        alumno.setNombreCompleto(request.getParameter("nombreCompleto"));
        alumno.setCorreo(request.getParameter("correo"));
        alumno.setMatricula(Integer.parseInt(request.getParameter("matricula")));
        alumno.setGrupo(Integer.parseInt(request.getParameter("grupo")));
        alumno.setCarrera(request.getParameter("carrera"));

        service.guardarAlumno(alumno);
        response.sendRedirect(request.getContextPath() + "/alumnos");
    }
}
