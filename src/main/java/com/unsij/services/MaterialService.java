package com.unsij.services;

import com.unsij.beans.Material;
import com.unsij.dao.MaterialDAO;
import java.util.List;

public class MaterialService {

    private final MaterialDAO dao = new MaterialDAO();

    public List<Material> obtenerTodosMateriales() {
        return dao.listarTodos();
    }

    public boolean crearMaterial(Material material) {
        return dao.insertar(material);
    }

    public boolean actualizarMaterial(Material material) {
        return dao.actualizar(material);
    }

    public List<String> obtenerLaboratoriosUnicos() {
        return dao.obtenerLaboratoriosUnicos();
    }
}
