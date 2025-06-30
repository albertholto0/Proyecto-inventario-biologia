<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="alumnoService" class="com.unsij.services.AlumnoService" scope="page"/>

<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Módulo de Alumnos</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>

    <body>
        <jsp:include page="/components/nav.jsp" />

        <div class="container my-4">
            <div class="mb-4">
                <h2 class="fw-bold mb-3">
                    <i class="bi bi-people-fill text-primary me-2"></i>Gestión de Alumnos
                </h2>
                <p class="text-muted">
                    Consulta, registra y administra los alumnos que tienen acceso a los laboratorios.
                </p>
            </div>

            <!-- Filtros (opcional) -->
            <form class="row g-3 mb-4" id="filtrosForm">
                <div class="col-md-3">
                    <label for="grupo" class="form-label">Grupo</label>
                    <select id="grupo" class="form-select">
                        <option value="">Todos</option>
                        <option value="1">Grupo 1</option>
                        <option value="2">Grupo 2</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="carrera" class="form-label">Carrera</label>
                    <select id="carrera" class="form-select">
                        <option value="">Todas</option>
                        <option value="Biología">Biología</option>
                        <option value="Química">Química</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Filtrar</button>
                </div>
            </form>

            <!-- Botones de acción -->
            <div class="mb-3 d-flex justify-content-between">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#alumnoModal">Registrar Alumno</button>
                <div>
                    <button class="btn btn-outline-secondary me-2">Exportar PDF</button>
                    <button class="btn btn-outline-secondary">Exportar Excel</button>
                </div>
            </div>

            <!-- Listado de alumnos -->
            <table class="table table-bordered table-hover" id="tablaAlumnos">
                <thead class="table-light">
                    <tr>
                        <th>Matrícula</th>
                        <th>Nombre Completo</th>
                        <th>Correo</th>
                        <th>Grupo</th>
                        <th>Carrera</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="alumnos" value="${alumnoService.obtenerAlumnos()}"/>
                    <c:choose>
                        <c:when test="${empty alumnos}">
                            <tr>
                                <td colspan="6" class="text-center">No se encontraron alumnos</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${alumnos}" var="alumno">
                                <tr>
                                    <td>${alumno.matricula}</td>
                                    <td>${alumno.nombreCompleto}</td>
                                    <td>${alumno.correo}</td>
                                    <td>${alumno.grupo}</td>
                                    <td>${alumno.carrera}</td>
                                    <td>
                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">Detalle</button>
                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#alumnoModal">Editar</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Modal Registro/Edición de Alumno -->
        <div class="modal fade" id="alumnoModal" tabindex="-1" aria-labelledby="alumnoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="alumnoModalLabel">Registrar/Editar Alumno</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body row g-3">
                        <div class="col-md-12">
                            <label for="nombreCompleto" class="form-label">Nombre Completo</label>
                            <input type="text" class="form-control" id="nombreCompleto" required>
                        </div>
                        <div class="col-md-6">
                            <label for="correo" class="form-label">Correo</label>
                            <input type="email" class="form-control" id="correo">
                        </div>
                        <div class="col-md-6">
                            <label for="matricula" class="form-label">Matrícula</label>
                            <input type="number" class="form-control" id="matricula">
                        </div>
                        <div class="col-md-6">
                            <label for="grupo" class="form-label">Grupo</label>
                            <input type="number" class="form-control" id="grupo" required>
                        </div>
                        <div class="col-md-6">
                            <label for="carrera" class="form-label">Carrera</label>
                            <input type="text" class="form-control" id="carrera" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>