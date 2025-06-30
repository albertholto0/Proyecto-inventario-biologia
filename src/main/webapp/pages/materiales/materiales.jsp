<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="materialService" class="com.unsij.services.MaterialService" scope="page"/>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Materiales - Gestión de Laboratorio de Biología</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>

    <body>
        <jsp:include page="/components/nav.jsp" />
        <div class="container my-4">

            <!-- Encabezado con descripción -->
            <div class="mb-4">
                <h2 class="fw-bold mb-3">
                    <i class="bi bi-box-seam text-primary me-2"></i>Gestión de Materiales
                </h2>
                <p class="text-muted">
                    Administra los diferentes tipos de materiales del laboratorio: reactivos, materiales y consumibles.
                </p>
            </div>

            <!-- Pestañas -->
            <ul class="nav nav-tabs mb-4" id="materialTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="reactivos-tab" data-bs-toggle="tab" data-bs-target="#reactivos" type="button" role="tab">
                        <i class="bi bi-flask text-success me-1"></i>Reactivos
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="materiales-tab" data-bs-toggle="tab" data-bs-target="#materiales" type="button" role="tab">
                        <i class="bi bi-box text-primary me-1"></i>Materiales
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="consumibles-tab" data-bs-toggle="tab" data-bs-target="#consumibles" type="button" role="tab">
                        <i class="bi bi-droplet-half text-warning me-1"></i>Consumibles
                    </button>
                </li>
            </ul>

            <!-- Contenido de las pestañas -->
            <div class="tab-content" id="materialTabsContent">
                <!-- Pestaña Reactivos -->
                <div class="tab-pane fade show active" id="reactivos" role="tabpanel" aria-labelledby="reactivos-tab">
                    <div class="mb-3">
                        <p class="text-muted">
                            <i class="bi bi-info-circle-fill text-success me-1"></i>
                            Sustancias químicas utilizadas en experimentos y análisis. Requieren control especial por caducidad y seguridad.
                        </p>
                    </div>
                    
                    <c:set var="reactivos" value="${materialService.obtenerMaterialesPorTipo('reactivo')}"/>
                    <c:choose>
                        <c:when test="${empty reactivos}">
                            <div class="alert alert-info">No hay reactivos registrados</div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-success">
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Presentación</th>
                                            <th>Unidad</th>
                                            <th>Clave</th>
                                            <th>Cantidad</th>
                                            <th>Laboratorio</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${reactivos}" var="material">
                                            <tr>
                                                <td>${material.nombre}</td>
                                                <td>${material.presentacion}</td>
                                                <td>${material.unidad}</td>
                                                <td>${material.clave}</td>
                                                <td class="fw-bold text-success">${material.cantidad}</td>
                                                <td>${material.nombreLaboratorio}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-success">Editar</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pestaña Materiales -->
                <div class="tab-pane fade" id="materiales" role="tabpanel" aria-labelledby="materiales-tab">
                    <div class="mb-3">
                        <p class="text-muted">
                            <i class="bi bi-info-circle-fill text-primary me-1"></i>
                            Instrumentos y utensilios reutilizables como vasos, tubos, matraces y otros equipos de laboratorio.
                        </p>
                    </div>
                    
                    <c:set var="materiales" value="${materialService.obtenerMaterialesPorTipo('material')}"/>
                    <c:choose>
                        <c:when test="${empty materiales}">
                            <div class="alert alert-info">No hay materiales registrados</div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Presentación</th>
                                            <th>Unidad</th>
                                            <th>Clave</th>
                                            <th>Cantidad</th>
                                            <th>Laboratorio</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${materiales}" var="material">
                                            <tr>
                                                <td>${material.nombre}</td>
                                                <td>${material.presentacion}</td>
                                                <td>${material.unidad}</td>
                                                <td>${material.clave}</td>
                                                <td class="fw-bold text-primary">${material.cantidad}</td>
                                                <td>${material.nombreLaboratorio}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary">Editar</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pestaña Consumibles -->
                <div class="tab-pane fade" id="consumibles" role="tabpanel" aria-labelledby="consumibles-tab">
                    <div class="mb-3">
                        <p class="text-muted">
                            <i class="bi bi-info-circle-fill text-warning me-1"></i>
                            Elementos de un solo uso o fácil reposición, como guantes, placas Petri, papel filtro, etc.
                        </p>
                    </div>
                    
                    <c:set var="consumibles" value="${materialService.obtenerMaterialesPorTipo('consumible')}"/>
                    <c:choose>
                        <c:when test="${empty consumibles}">
                            <div class="alert alert-info">No hay consumibles registrados</div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover align-middle">
                                    <thead class="table-warning">
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Presentación</th>
                                            <th>Unidad</th>
                                            <th>Clave</th>
                                            <th>Cantidad</th>
                                            <th>Laboratorio</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${consumibles}" var="material">
                                            <tr>
                                                <td>${material.nombre}</td>
                                                <td>${material.presentacion}</td>
                                                <td>${material.unidad}</td>
                                                <td>${material.clave}</td>
                                                <td class="fw-bold text-warning">${material.cantidad}</td>
                                                <td>${material.nombreLaboratorio}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-warning">Editar</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Botón para agregar nuevo material -->
            <div class="d-flex justify-content-end mt-3">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalRegistrarMaterial">
                    <i class="bi bi-plus-circle me-1"></i>Agregar Material
                </button>
            </div>

            <!-- Modal Registrar Material (mantener igual) -->
            <!-- Modal Historial (mantener igual) -->

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>