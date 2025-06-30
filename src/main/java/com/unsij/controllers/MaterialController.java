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

@WebServlet("/MaterialController")
public class MaterialController extends HttpServlet {

    private final MaterialService service = new MaterialService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<Material> materiales = service.obtenerTodosMateriales();
        request.setAttribute("materiales", materiales);
        request.getRequestDispatcher("/pages/materiales.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");

        if ("crear".equals(action)) {
            crearMaterial(request, response);
        } else if ("actualizar".equals(action)) {
            actualizarMaterial(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/MaterialController");
        }
    }

    private void crearMaterial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Material material = new Material();
        material.setNombre(request.getParameter("nombre"));
        material.setTipo(request.getParameter("tipo"));
        material.setPresentacion(request.getParameter("presentacion"));
        material.setUnidad(Integer.parseInt(request.getParameter("unidad")));
        material.setClave(request.getParameter("clave"));
        material.setCantidad(Integer.parseInt(request.getParameter("cantidad")));

        String idLab = request.getParameter("idLaboratorio");
        if (idLab != null && !idLab.isEmpty()) {
            material.setIdLaboratorio(Integer.parseInt(idLab));
        }

        boolean success = service.crearMaterial(material);

        if (success) {
            request.getSession().setAttribute("mensaje", "Material creado exitosamente");
        } else {
            request.getSession().setAttribute("error", "Error al crear el material");
        }

        response.sendRedirect(request.getContextPath() + "/MaterialController");
    }

    private void actualizarMaterial(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Material material = new Material();
        material.setIdMaterial(Integer.parseInt(request.getParameter("idMaterial")));
        material.setNombre(request.getParameter("nombre"));
        material.setTipo(request.getParameter("tipo"));
        material.setPresentacion(request.getParameter("presentacion"));
        material.setUnidad(Integer.parseInt(request.getParameter("unidad")));
        material.setClave(request.getParameter("clave"));
        material.setCantidad(Integer.parseInt(request.getParameter("cantidad")));

        String idLab = request.getParameter("idLaboratorio");
        if (idLab != null && !idLab.isEmpty()) {
            material.setIdLaboratorio(Integer.parseInt(idLab));
        }

        boolean success = service.actualizarMaterial(material);

        if (success) {
            request.getSession().setAttribute("mensaje", "Material actualizado exitosamente");
        } else {
            request.getSession().setAttribute("error", "Error al actualizar el material");
        }

        response.sendRedirect(request.getContextPath() + "/MaterialController");
    }
}
