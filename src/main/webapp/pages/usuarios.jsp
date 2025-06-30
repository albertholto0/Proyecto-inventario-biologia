<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="usuarioService" class="com.unsij.services.UsuarioService" scope="page"/>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Usuarios - Laboratorio de Biología</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>
    <body>
        <jsp:include page="/components/nav.jsp" />

        <div class="container my-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-0 d-flex align-items-center">
                        <i class="bi bi-people-fill text-secondary me-2" style="font-size: 2.2em;"></i>
                        Gestión de Usuarios
                    </h2>
                    <p class="text-muted mb-0">Administra los usuarios encargados de los laboratorios</p>
                </div>
                <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">
                    <i class="bi bi-plus-circle me-1"></i> Nuevo Usuario
                </button>
            </div>

            <!-- Tabla de usuarios -->
            <div class="card shadow-sm">
                <div class="card-header bg-secondary text-white d-flex justify-content-between align-items-center">
                    <span>Listado de Usuarios</span>
                    <div class="input-group" style="width: 300px;">
                        <input type="text" class="form-control" placeholder="Buscar usuario..." id="buscarUsuario">
                        <button class="btn btn-light" type="button">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Usuario</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="usuarios" value="${usuarioService.obtenerUsuarios()}"/>
                                <c:forEach items="${usuarios}" var="usuario">
                                    <tr>
                                        <td>${usuario.id}</td>
                                        <td>${usuario.usuario}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-secondary me-1" data-bs-toggle="modal" 
                                                    data-bs-target="#modalVerUsuario" data-id="${usuario.id}">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" 
                                                    data-bs-target="#modalEliminarUsuario" data-id="${usuario.id}">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modales (mantener igual) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>