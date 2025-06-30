<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="materialService" class="com.unsij.services.MaterialService" scope="page"/>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Materiales - Gestión de Laboratorio de Biología</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>

    <body>
        <jsp:include page="/components/nav.jsp" />
        <div class="container my-4">

            <c:if test="${not empty sessionScope.mensaje}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="mensaje" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${sessionScope.error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="mb-4">
                <h2 class="fw-bold mb-3">
                    <i class="bi bi-box-seam text-primary me-2"></i>Gestión de Materiales
                </h2>
                <p class="text-muted">
                    Administra los diferentes tipos de materiales del laboratorio: reactivos, materiales y consumibles.
                </p>
            </div>

            <div class="d-flex justify-content-between mb-3">
                <div class="w-50">
                    <div class="input-group mb-2">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" id="searchInput" class="form-control" placeholder="Buscar por nombre o clave..." aria-label="Buscar">
                    </div>
                    <div class="row g-2">
                        <div class="col-md-6">
                            <select id="filterType" class="form-select">
                                <option value="">Todos los tipos</option>
                                <option value="reactivo">Reactivo</option>
                                <option value="material">Material</option>
                                <option value="consumible">Consumible</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <select id="filterLab" class="form-select">
                                <option value="">Todos los laboratorios</option>
                                <c:forEach items="${materialService.obtenerLaboratoriosUnicos()}" var="lab">
                                    <option value="${lab}">${lab}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalRegistrarMaterial">
                    <i class="bi bi-plus-circle me-1"></i>Agregar Material
                </button>
            </div>

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
                    <tbody id="materialTableBody">
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
                                        <td class="tipo">
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
                                        <td class="nombre">${material.nombre}</td>
                                        <td>${material.presentacion}</td>
                                        <td>${material.unidad}</td>
                                        <td class="clave">${material.clave}</td>
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
                                        <td class="laboratorio">${material.nombreLaboratorio}</td>
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
            // Función para cargar datos en el modal de edición
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

            // Función para filtrar la tabla
            function filtrarTabla() {
                const searchText = document.getElementById('searchInput').value.toLowerCase();
                const filterType = document.getElementById('filterType').value;
                const filterLab = document.getElementById('filterLab').value;
                const rows = document.querySelectorAll('#materialTableBody tr');
                
                let resultsFound = false; // Variable para rastrear si se encontraron resultados

                rows.forEach(row => {
                    // Ignoramos la fila de "No hay materiales registrados" si existe.
                    // Si el contenido de la primera celda es "No hay materiales registrados", ocultarla.
                    if (row.firstElementChild && row.firstElementChild.textContent.trim() === 'No hay materiales registrados') {
                        row.style.display = 'none';
                        return; // Salir de esta iteración y pasar a la siguiente fila
                    }

                    const nombre = row.querySelector('.nombre').textContent.toLowerCase();
                    const clave = row.querySelector('.clave').textContent.toLowerCase();
                    const tipoElement = row.querySelector('.tipo');
                    const tipo = tipoElement ? tipoElement.textContent.toLowerCase() : '';
                    const laboratorioElement = row.querySelector('.laboratorio');
                    const laboratorio = laboratorioElement ? laboratorioElement.textContent : '';
                    
                    const matchesSearch = searchText === '' || 
                                          nombre.includes(searchText) || 
                                          clave.includes(searchText);
                    
                    const matchesType = filterType === '' || 
                                        (filterType === 'reactivo' && tipo.includes('reactivo')) ||
                                        (filterType === 'material' && tipo.includes('material')) ||
                                        (filterType === 'consumible' && tipo.includes('consumible'));
                    
                    const matchesLab = filterLab === '' || 
                                       laboratorio === filterLab;
                    
                    if (matchesSearch && matchesType && matchesLab) {
                        row.style.display = '';
                        resultsFound = true;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                // Manejar el mensaje de "No se encontraron resultados"
                const tbody = document.getElementById('materialTableBody');
                let noResultsRow = tbody.querySelector('tr.no-results-row');

                if (!resultsFound) {
                    if (!noResultsRow) {
                        // Si no hay resultados y la fila no existe, crearla
                        noResultsRow = document.createElement('tr');
                        noResultsRow.classList.add('no-results-row');
                        noResultsRow.innerHTML = '<td colspan="8" class="text-center">No se encontraron resultados</td>';
                        tbody.appendChild(noResultsRow);
                    } else {
                        // Si no hay resultados y la fila ya existe, asegurarse de que esté visible
                        noResultsRow.style.display = '';
                    }
                } else {
                    // Si hay resultados y la fila de "no resultados" existe, ocultarla o removerla
                    if (noResultsRow) {
                        noResultsRow.style.display = 'none';
                    }
                }
            }

            // Event listeners para los filtros
            document.getElementById('searchInput').addEventListener('input', filtrarTabla);
            document.getElementById('filterType').addEventListener('change', filtrarTabla);
            document.getElementById('filterLab').addEventListener('change', filtrarTabla);

            // Ejecutar el filtro al cargar la página para aplicar cualquier filtro inicial o mostrar el mensaje "No hay materiales registrados"
            document.addEventListener('DOMContentLoaded', filtrarTabla);
        </script>
    </body>
</html>