package com.unsij.services;

import com.unsij.beans.Equipo;
import com.unsij.dao.EquipoDAO;
import java.util.List;

public class EquipoService {

    private final EquipoDAO dao = new EquipoDAO();

    public List<Equipo> obtenerEquipos() {
        return dao.listar();
    }

    public List<String> obtenerOpcionesGrupos() {
        return dao.obtenerNombresGrupos();
    }

    public List<String> obtenerOpcionesCategorias() {
        return dao.obtenerNombresCategorias();
    }

    public List<String> obtenerOpcionesLaboratorios() {
        return dao.obtenerNombresLaboratorios();
    }

    public List<String> obtenerOpcionesEstadosFisicos() {
        return dao.obtenerNombresEstadosFisicos();
    }

    public boolean guardarEquipo(Equipo equipo) {
        if (equipo.getIdEquipo() == 0) {
            return dao.insertarEquipo(equipo);
        } else {
            return dao.actualizarEquipo(equipo);
        }
    }

    public Equipo obtenerEquipoPorId(int id) {
        return dao.obtenerEquipoPorId(id);
    }

    public List<Equipo> obtenerGruposCompletos() {
        return dao.obtenerGruposCompletos();
    }

    public List<Equipo> obtenerCategoriasCompletas() {
        return dao.obtenerCategoriasCompletas();
    }

    public List<Equipo> obtenerSubcategoriasCompletas() {
        return dao.obtenerSubcategoriasCompletas();
    }

    public List<Equipo> obtenerTiposCompletos() {
        return dao.obtenerTiposCompletos();
    }

    public List<Equipo> obtenerEstadosFisicosCompletos() {
        return dao.obtenerEstadosFisicosCompletos();
    }

    public List<Equipo> obtenerLaboratoriosCompletos() {
        return dao.obtenerLaboratoriosCompletos();
    }
}
