package com.unsij.services;

import com.unsij.beans.Responsable;
import com.unsij.dao.ResponsableDAO;
import java.util.List;

public class ResponsableService {
    private final ResponsableDAO dao = new ResponsableDAO();
    
    public List<Responsable> obtenerResponsables() {
        return dao.obtenerTodos();
    }
    
    public boolean guardarResponsable(Responsable responsable) {
        return dao.guardar(responsable);
    }
}