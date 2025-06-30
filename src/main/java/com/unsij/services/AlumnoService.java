package com.unsij.services;

import com.unsij.beans.Alumno;
import com.unsij.dao.AlumnoDAO;
import java.util.List;

public class AlumnoService {
    private final AlumnoDAO dao = new AlumnoDAO();
    
    public List<Alumno> obtenerAlumnos() {
        return dao.listar();
    }
    
    // Puedes agregar más métodos según necesites
}