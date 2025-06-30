package com.unsij.services;

import com.unsij.beans.Alumno;
import com.unsij.dao.AlumnoDAO;
import java.util.List;

public class AlumnoService {
    private final AlumnoDAO dao = new AlumnoDAO();
    
    public List<Alumno> obtenerAlumnos() {
        return dao.listar();
    }
    
    public List<Alumno> filtrarAlumnos(Integer grupo, String carrera) {
        return dao.listarFiltrado(grupo, carrera);
    }
    
    public boolean guardarAlumno(Alumno alumno) {
        if (alumno.getIdAlumno() == 0) {
            return dao.insertar(alumno);
        } else {
            return dao.actualizar(alumno);
        }
    }
    
    public Alumno obtenerAlumnoPorId(int id) {
        return dao.obtenerPorId(id);
    }
}