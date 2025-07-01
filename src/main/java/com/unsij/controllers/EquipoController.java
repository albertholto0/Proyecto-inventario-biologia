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

    // En EquipoController.java agregar este método:
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Equipo equipo = new Equipo();

            // Si es una edición, establecer el ID
            String idStr = request.getParameter("idEquipo");
            if (idStr != null && !idStr.isEmpty()) {
                equipo.setIdEquipo(Integer.parseInt(idStr));
            }

            // Establecer los demás campos
            equipo.setNombreEquipo(request.getParameter("nombreEquipo"));
            equipo.setIdGrupo(Integer.parseInt(request.getParameter("idGrupo")));
            equipo.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));

            String idSubcategoria = request.getParameter("idSubcategoria");
            equipo.setIdSubcategoria(idSubcategoria != null && !idSubcategoria.isEmpty() ? Integer.parseInt(idSubcategoria) : null);

            equipo.setIdTipo(Integer.parseInt(request.getParameter("idTipo")));
            equipo.setMarca(request.getParameter("marca"));
            equipo.setModelo(request.getParameter("modelo"));
            equipo.setSerie(request.getParameter("serie"));
            equipo.setColor(request.getParameter("color"));

            String precio = request.getParameter("precio");
            equipo.setPrecio(precio != null && !precio.isEmpty() ? Float.parseFloat(precio) : null);

            equipo.setIdEstadoFisico(Integer.parseInt(request.getParameter("idEstadoFisico")));
            equipo.setIdLaboratorio(Integer.parseInt(request.getParameter("idLaboratorio")));

            boolean success = service.guardarEquipo(equipo);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/equipos");
            } else {
                throw new ServletException("Error al guardar el equipo");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error al procesar la solicitud", e);
        }
    }

}
