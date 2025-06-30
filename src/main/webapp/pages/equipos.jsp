<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="equipoService" class="com.unsij.services.EquipoService" scope="page"/>

<html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Módulo de Equipos</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>

    <body>
        <jsp:include page="/components/nav.jsp" />

        <div class="container my-4">
            <div class="mb-4">
                <h2 class="fw-bold mb-3">
                    <i class="bi bi-pc-display-horizontal text-success me-2"></i>Gestión de Equipos
                </h2>
                <p class="text-muted">
                    Consulta, registra y administra los equipos disponibles en los laboratorios. Filtra por grupo, categoría, laboratorio o estado físico para encontrar rápidamente el equipo que necesitas.
                </p>
            </div>

            <!-- Filtros -->
            <form class="row g-3 mb-4" id="filtrosForm">
                <div class="col-md-2">
                    <label for="grupo" class="form-label">Grupo</label>
                    <select id="grupo" class="form-select">
                        <option value="">Todos</option>
                        <option value="1">Grupo 1</option>
                        <option value="2">Grupo 2</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="categoria" class="form-label">Categoría</label>
                    <select id="categoria" class="form-select">
                        <option value="">Todas</option>
                        <option value="1">Categoría 1</option>
                        <option value="2">Categoría 2</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="subcategoria" class="form-label">Subcategoría</label>
                    <select id="subcategoria" class="form-select">
                        <option value="">Todas</option>
                        <option value="1">Subcat 1</option>
                        <option value="2">Subcat 2</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="laboratorio" class="form-label">Laboratorio</label>
                    <select id="laboratorio" class="form-select">
                        <option value="">Todos</option>
                        <option value="1">Lab 1</option>
                        <option value="2">Lab 2</option>
                        <option value="3">Lab 3</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="estadoFisico" class="form-label">Estado Físico</label>
                    <select id="estadoFisico" class="form-select">
                        <option value="">Todos</option>
                        <option value="1">Bueno</option>
                        <option value="2">Regular</option>
                        <option value="3">Malo</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Filtrar</button>
                </div>
            </form>

            <!-- Botones de acción -->
            <div class="mb-3 d-flex justify-content-between">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#equipoModal">Registrar Equipo</button>
                <div>
                    <button class="btn btn-outline-secondary me-2">Exportar PDF</button>
                    <button class="btn btn-outline-secondary">Exportar Excel</button>
                </div>
            </div>

            <!-- Listado de equipos -->
            <table class="table table-bordered table-hover" id="tablaEquipos">
                <thead class="table-light">
                    <tr>
                        <th>Nombre</th>
                        <th>Grupo</th>
                        <th>Categoría</th>
                        <th>Tipo</th>
                        <th>Marca</th>
                        <th>Modelo</th>
                        <th>Serie</th>
                        <th>Laboratorio</th>
                        <th>Estado Físico</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="equipos" value="${equipoService.obtenerEquipos()}"/>
                    <c:choose>
                        <c:when test="${empty equipos}">
                            <tr>
                                <td colspan="10" class="text-center">No se encontraron equipos</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${equipos}" var="equipo">
                                <tr>
                                    <td>${equipo.nombreEquipo}</td>
                                    <td>${equipo.nombreGrupo}</td> 
                                    <td>${equipo.nombreCategoria}</td>
                                    <td>${equipo.nombreTipo}</td> 
                                    <td>${equipo.marca}</td>
                                    <td>${equipo.modelo}</td>
                                    <td>${equipo.serie}</td>
                                    <td>${equipo.nombreLaboratorio}</td> 
                                    <td>${equipo.nombreEstadoFisico}</td> 
                                    <td>
                                        <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#detalleModal">Detalle</button>
                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#equipoModal">Editar</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
                <tbody>
                    <c:forEach items="${equipos}" var="equipo">

                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Modal Registro/Edición de Equipo -->
        <div class="modal fade" id="equipoModal" tabindex="-1" aria-labelledby="equipoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <form class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="equipoModalLabel">Registrar/Editar Equipo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body row g-3">
                        <div class="col-md-6">
                            <label for="nombreEquipo" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombreEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="grupoEquipo" class="form-label">Grupo</label>
                            <select id="grupoEquipo" class="form-select">
                                <option value="1">Grupo 1</option>
                                <option value="2">Grupo 2</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="categoriaEquipo" class="form-label">Categoría</label>
                            <select id="categoriaEquipo" class="form-select">
                                <option value="1">Categoría 1</option>
                                <option value="2">Categoría 2</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="subcategoriaEquipo" class="form-label">Subcategoría</label>
                            <input type="text" class="form-control" id="subcategoriaEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="tipoEquipo" class="form-label">Tipo</label>
                            <select id="tipoEquipo" class="form-select">
                                <option value="1">Tipo 1</option>
                                <option value="2">Tipo 2</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="marcaEquipo" class="form-label">Marca</label>
                            <input type="text" class="form-control" id="marcaEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="modeloEquipo" class="form-label">Modelo</label>
                            <input type="text" class="form-control" id="modeloEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="serieEquipo" class="form-label">Serie</label>
                            <input type="text" class="form-control" id="serieEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="colorEquipo" class="form-label">Color</label>
                            <input type="text" class="form-control" id="colorEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="precioEquipo" class="form-label">Precio</label>
                            <input type="number" step="0.01" class="form-control" id="precioEquipo">
                        </div>
                        <div class="col-md-6">
                            <label for="estadoFisicoEquipo" class="form-label">Estado Físico</label>
                            <select id="estadoFisicoEquipo" class="form-select">
                                <option value="1">Bueno</option>
                                <option value="2">Regular</option>
                                <option value="3">Malo</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="laboratorioEquipo" class="form-label">Laboratorio</label>
                            <select id="laboratorioEquipo" class="form-select">
                                <option value="1">Lab 1</option>
                                <option value="2">Lab 2</option>
                                <option value="3">Lab 3</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal Detalle de Equipo -->
        <div class="modal fade" id="detalleModal" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detalleModalLabel">Detalle del Equipo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <h6>Información General</h6>
                        <ul>
                            
                        </ul>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>