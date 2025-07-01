package com.unsij.controllers;

import com.unsij.beans.Prestamo;
import com.unsij.services.PrestamoService;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrestamoController extends HttpServlet {

    private final PrestamoService service = new PrestamoService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String estado = request.getParameter("estado");
        if (estado != null && !estado.isEmpty()) {
            request.setAttribute("prestamos", service.filtrarPrestamosPorEstado(estado));
        } else {
            request.setAttribute("prestamos", service.obtenerPrestamos());
        }
        
        request.getRequestDispatcher("/pages/prestamos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            Prestamo prestamo = new Prestamo();
            String idStr = request.getParameter("idPrestamo");
            if (idStr != null && !idStr.isEmpty()) {
                prestamo.setIdPrestamo(Integer.parseInt(idStr));
            }
            
            prestamo.setIdAlumno(Integer.parseInt(request.getParameter("idAlumno")));
            prestamo.setIdLaboratorio(Integer.parseInt(request.getParameter("idLaboratorio")));
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date fechaPrestamo = sdf.parse(request.getParameter("fechaPrestamo"));
            Date fechaDevolucionPrevista = sdf.parse(request.getParameter("fechaDevolucionPrevista"));
            
            prestamo.setFechaPrestamo(fechaPrestamo);
            prestamo.setFechaDevolucionPrevista(fechaDevolucionPrevista);
            
            String fechaDevolucionRealStr = request.getParameter("fechaDevolucionReal");
            if (fechaDevolucionRealStr != null && !fechaDevolucionRealStr.isEmpty()) {
                Date fechaDevolucionReal = sdf.parse(fechaDevolucionRealStr);
                prestamo.setFechaDevolucionReal(fechaDevolucionReal);
            }
            
            prestamo.setEstado(request.getParameter("estado"));
            
            service.guardarPrestamo(prestamo);
            
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en el formato de fecha");
        }
        
        response.sendRedirect(request.getContextPath() + "/prestamos");
    }
}