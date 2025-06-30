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

            <!-- Botón para agregar nuevo material -->
            <div class="d-flex justify-content-end mb-3">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalRegistrarMaterial">
                    <i class="bi bi-plus-circle me-1"></i>Agregar Material
                </button>
            </div>

            <!-- Tabla única para todos los materiales -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Tipo</th>
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
                        <c:set var="materiales" value="${materialService.obtenerTodosMateriales()}"/>
                        <c:choose>
                            <c:when test="${empty materiales}">
                                <tr>
                                    <td colspan="8" class="text-center">No hay materiales registrados</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${materiales}" var="material">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${material.tipo == 'reactivo'}">
                                                    <span class="badge bg-success">
                                                        <i class="bi bi-flask me-1"></i>Reactivo
                                                    </span>
                                                </c:when>
                                                <c:when test="${material.tipo == 'material'}">
                                                    <span class="badge bg-primary">
                                                        <i class="bi bi-box me-1"></i>Material
                                                    </span>
                                                </c:when>
                                                <c:when test="${material.tipo == 'consumible'}">
                                                    <span class="badge bg-warning text-dark">
                                                        <i class="bi bi-droplet-half me-1"></i>Consumible
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    ${material.tipo}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${material.nombre}</td>
                                        <td>${material.presentacion}</td>
                                        <td>${material.unidad}</td>
                                        <td>${material.clave}</td>
                                        <td class="fw-bold">
                                            <c:choose>
                                                <c:when test="${material.tipo == 'reactivo'}">
                                                    <span class="text-success">${material.cantidad}</span>
                                                </c:when>
                                                <c:when test="${material.tipo == 'material'}">
                                                    <span class="text-primary">${material.cantidad}</span>
                                                </c:when>
                                                <c:when test="${material.tipo == 'consumible'}">
                                                    <span class="text-warning">${material.cantidad}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    ${material.cantidad}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${material.nombreLaboratorio}</td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-secondary" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#modalEditarMaterial"
                                                    onclick="cargarDatosEdicion(${material.idMaterial}, '${material.nombre}', '${material.tipo}', '${material.presentacion}', ${material.unidad}, '${material.clave}', ${material.cantidad}, ${material.idLaboratorio})">
                                                Editar
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Modal Registrar Material -->
            <div class="modal fade" id="modalRegistrarMaterial" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Registrar Nuevo Material</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/MaterialController" method="POST">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="crear">
                                <div class="mb-3">
                                    <label class="form-label">Tipo de Material</label>
                                    <select class="form-select" name="tipo" required>
                                        <option value="" selected disabled>Seleccione un tipo</option>
                                        <option value="reactivo">Reactivo</option>
                                        <option value="material">Material</option>
                                        <option value="consumible">Consumible</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Nombre</label>
                                    <input type="text" class="form-control" name="nombre" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Presentación</label>
                                    <input type="text" class="form-control" name="presentacion" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Unidad</label>
                                    <input type="number" class="form-control" name="unidad" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Clave</label>
                                    <input type="text" class="form-control" name="clave" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Cantidad</label>
                                    <input type="number" class="form-control" name="cantidad" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">ID Laboratorio</label>
                                    <input type="number" class="form-control" name="idLaboratorio">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal Editar Material -->
            <div class="modal fade" id="modalEditarMaterial" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Editar Material</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/MaterialController" method="POST">
                            <div class="modal-body">
                                <input type="hidden" name="action" value="actualizar">
                                <input type="hidden" id="editIdMaterial" name="idMaterial">
                                <div class="mb-3">
                                    <label class="form-label">Tipo de Material</label>
                                    <select class="form-select" id="editTipo" name="tipo" required>
                                        <option value="reactivo">Reactivo</option>
                                        <option value="material">Material</option>
                                        <option value="consumible">Consumible</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Nombre</label>
                                    <input type="text" class="form-control" id="editNombre" name="nombre" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Presentación</label>
                                    <input type="text" class="form-control" id="editPresentacion" name="presentacion" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Unidad</label>
                                    <input type="number" class="form-control" id="editUnidad" name="unidad" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Clave</label>
                                    <input type="text" class="form-control" id="editClave" name="clave" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Cantidad</label>
                                    <input type="number" class="form-control" id="editCantidad" name="cantidad" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">ID Laboratorio</label>
                                    <input type="number" class="form-control" id="editIdLaboratorio" name="idLaboratorio">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function cargarDatosEdicion(idMaterial, nombre, tipo, presentacion, unidad, clave, cantidad, idLaboratorio) {
                document.getElementById('editIdMaterial').value = idMaterial;
                document.getElementById('editNombre').value = nombre;
                document.getElementById('editTipo').value = tipo;
                document.getElementById('editPresentacion').value = presentacion;
                document.getElementById('editUnidad').value = unidad;
                document.getElementById('editClave').value = clave;
                document.getElementById('editCantidad').value = cantidad;
                document.getElementById('editIdLaboratorio').value = idLaboratorio;
            }
        </script>
    </body>
</html>