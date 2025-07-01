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
        <style>
            .btn-add-equipo {
                padding: 0.5rem 1.5rem;
                font-weight: 500;
            }
            #tablaEquipos th {
                white-space: nowrap;
            }
            .btn-action {
                margin-right: 5px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/components/nav.jsp" />

        <div class="container my-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-0">
                        <i class="bi bi-pc-display-horizontal text-success me-2"></i>Gestión de Equipos
                    </h2>
                    <p class="text-muted mb-0">
                        Consulta y administra los equipos disponibles en los laboratorios.
                    </p>
                </div>
                <button class="btn btn-success btn-add-equipo" data-bs-toggle="modal" data-bs-target="#equipoModal">
                    <i class="bi bi-plus-lg me-1"></i> Nuevo Equipo
                </button>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <form class="row g-3" id="filtrosForm">
                        <div class="col-md-2">
                            <label for="grupo" class="form-label">Grupo</label>
                            <select id="grupo" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${equipoService.obtenerOpcionesGrupos()}" var="grupo">
                                    <option value="${grupo}">${grupo}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label for="categoria" class="form-label">Categoría</label>
                            <select id="categoria" class="form-select">
                                <option value="">Todas</option>
                                <c:forEach items="${equipoService.obtenerOpcionesCategorias()}" var="categoria">
                                    <option value="${categoria}">${categoria}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label for="laboratorio" class="form-label">Laboratorio</label>
                            <select id="laboratorio" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${equipoService.obtenerOpcionesLaboratorios()}" var="laboratorio">
                                    <option value="${laboratorio}">${laboratorio}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label for="estadoFisico" class="form-label">Estado Físico</label>
                            <select id="estadoFisico" class="form-select">
                                <option value="">Todos</option>
                                <c:forEach items="${equipoService.obtenerOpcionesEstadosFisicos()}" var="estado">
                                    <option value="${estado}">${estado}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100 me-2">Filtrar</button>
                            <button type="button" class="btn btn-outline-secondary w-100" onclick="limpiarFiltros()">Limpiar</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover" id="tablaEquipos">
                            <thead class="table-light">
                                <tr>
                                    <th>Nombre</th>
                                    <th>Grupo</th>
                                    <th>Categoría</th>
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
                                            <td colspan="6" class="text-center">No se encontraron equipos</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${equipos}" var="equipo" varStatus="loop">
                                            <tr>
                                                <td>${equipo.nombreEquipo}</td>
                                                <td>${equipo.nombreGrupo}</td>
                                                <td>${equipo.nombreCategoria}</td>
                                                <td>${equipo.nombreLaboratorio}</td>
                                                <td>${equipo.nombreEstadoFisico}</td>
                                                <td>
                                                    <button class="btn btn-info btn-sm btn-action" 
                                                            onclick="mostrarDetalleEquipo(${equipo.idEquipo})">
                                                        <i class="bi bi-eye"></i> Detalle
                                                    </button>
                                                    <button class="btn btn-warning btn-sm btn-action" onclick="prepararEdicionEquipo(${equipo.idEquipo})">
                                                        <i class="bi bi-pencil"></i> Editar
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="detalleModal" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="detalleModalLabel">Detalle del Equipo</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="fw-bold">Información Básica</h6>
                                <ul class="list-unstyled">
                                    <li><strong>Nombre:</strong> <span id="detalleNombre"></span></li>
                                    <li><strong>Grupo:</strong> <span id="detalleGrupo"></span></li>
                                    <li><strong>Categoría:</strong> <span id="detalleCategoria"></span></li>
                                    <li><strong>Subcategoría:</strong> <span id="detalleSubcategoria"></span></li>
                                    <li><strong>Tipo:</strong> <span id="detalleTipo"></span></li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <h6 class="fw-bold">Especificaciones</h6>
                                <ul class="list-unstyled">
                                    <li><strong>Marca:</strong> <span id="detalleMarca"></span></li>
                                    <li><strong>Modelo:</strong> <span id="detalleModelo"></span></li>
                                    <li><strong>Serie:</strong> <span id="detalleSerie"></span></li>
                                    <li><strong>Color:</strong> <span id="detalleColor"></span></li>
                                    <li><strong>Precio:</strong> <span id="detallePrecio"></span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <h6 class="fw-bold">Ubicación y Estado</h6>
                                <ul class="list-unstyled">
                                    <li><strong>Laboratorio:</strong> <span id="detalleLaboratorio"></span></li>
                                    <li><strong>Estado Físico:</strong> <span id="detalleEstadoFisico"></span></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="equipoModal" tabindex="-1" aria-labelledby="equipoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <form class="modal-content" action="${pageContext.request.contextPath}/equipos" method="POST">
                    <input type="hidden" id="idEquipo" name="idEquipo" value="">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="equipoModalLabel">Registrar Nuevo Equipo</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body row g-3">
                        <div class="col-md-6">
                            <label for="nombreEquipo" class="form-label">Nombre del Equipo</label>
                            <input type="text" class="form-control" id="nombreEquipo" name="nombreEquipo" required>
                        </div>
                        <div class="col-md-6">
                            <label for="marca" class="form-label">Marca</label>
                            <input type="text" class="form-control" id="marca" name="marca">
                        </div>
                        <div class="col-md-6">
                            <label for="modelo" class="form-label">Modelo</label>
                            <input type="text" class="form-control" id="modelo" name="modelo">
                        </div>
                        <div class="col-md-6">
                            <label for="serie" class="form-label">Número de Serie</label>
                            <input type="text" class="form-control" id="serie" name="serie">
                        </div>
                        <div class="col-md-6">
                            <label for="color" class="form-label">Color</label>
                            <input type="text" class="form-control" id="color" name="color">
                        </div>
                        <div class="col-md-6">
                            <label for="precio" class="form-label">Precio</label>
                            <input type="number" step="0.01" class="form-control" id="precio" name="precio">
                        </div>
                        <div class="col-md-6">
                            <label for="idGrupo" class="form-label">Grupo</label>
                            <select class="form-select" id="idGrupo" name="idGrupo" required>
                                <option value="">Seleccione un grupo</option>
                                <c:forEach items="${equipoService.obtenerGruposCompletos()}" var="grupo">
                                    <option value="${grupo.idGrupo}">${grupo.nombreGrupo}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idCategoria" class="form-label">Categoría</label>
                            <select class="form-select" id="idCategoria" name="idCategoria" required>
                                <option value="">Seleccione una categoría</option>
                                <c:forEach items="${equipoService.obtenerCategoriasCompletas()}" var="categoria">
                                    <option value="${categoria.idCategoria}">${categoria.nombreCategoria}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idSubcategoria" class="form-label">Subcategoría</label>
                            <select class="form-select" id="idSubcategoria" name="idSubcategoria">
                                <option value="">Seleccione una subcategoría</option>
                                <c:forEach items="${equipoService.obtenerSubcategoriasCompletas()}" var="subcategoria">
                                    <option value="${subcategoria.idSubcategoria}">${subcategoria.nombreSubcategoria}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idTipo" class="form-label">Tipo</label>
                            <select class="form-select" id="idTipo" name="idTipo" required>
                                <option value="">Seleccione un tipo</option>
                                <c:forEach items="${equipoService.obtenerTiposCompletos()}" var="tipo">
                                    <option value="${tipo.idTipo}">${tipo.nombreTipo}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idEstadoFisico" class="form-label">Estado Físico</label>
                            <select class="form-select" id="idEstadoFisico" name="idEstadoFisico" required>
                                <option value="">Seleccione un estado</option>
                                <c:forEach items="${equipoService.obtenerEstadosFisicosCompletos()}" var="estado">
                                    <option value="${estado.idEstadoFisico}">${estado.nombreEstadoFisico}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="idLaboratorio" class="form-label">Laboratorio</label>
                            <select class="form-select" id="idLaboratorio" name="idLaboratorio" required>
                                <option value="">Seleccione un laboratorio</option>
                                <c:forEach items="${equipoService.obtenerLaboratoriosCompletos()}" var="laboratorio">
                                    <option value="${laboratorio.idLaboratorio}">${laboratorio.nombreLaboratorio}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Guardar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>

                                                        function mostrarDetalleEquipo(idEquipo) {

                                                        const equipos = [
            <c:forEach items="${equipos}" var="equipo" varStatus="loop">
                                                        {
                                                        idEquipo: ${equipo.idEquipo},
                                                                nombreEquipo: "${equipo.nombreEquipo}",
                                                                nombreGrupo: "${equipo.nombreGrupo}",
                                                                nombreCategoria: "${equipo.nombreCategoria}",
                                                                nombreSubcategoria: "${equipo.nombreSubcategoria}",
                                                                nombreTipo: "${equipo.nombreTipo}",
                                                                marca: "${equipo.marca}",
                                                                modelo: "${equipo.modelo}",
                                                                serie: "${equipo.serie}",
                                                                color: "${equipo.color}",
                                                                precio: "${equipo.precio}",
                                                                nombreLaboratorio: "${equipo.nombreLaboratorio}",
                                                                nombreEstadoFisico: "${equipo.nombreEstadoFisico}"
                                                        }${!loop.last ? ',' : ''}
            </c:forEach>
                                                        ];
                                                        const equipo = equipos.find(e => e.idEquipo === idEquipo);
                                                        if (equipo) {
                                                        document.getElementById('detalleNombre').textContent = equipo.nombreEquipo;
                                                        document.getElementById('detalleGrupo').textContent = equipo.nombreGrupo;
                                                        document.getElementById('detalleCategoria').textContent = equipo.nombreCategoria;
                                                        document.getElementById('detalleSubcategoria').textContent = equipo.nombreSubcategoria;
                                                        document.getElementById('detalleTipo').textContent = equipo.nombreTipo;
                                                        document.getElementById('detalleMarca').textContent = equipo.marca;
                                                        document.getElementById('detalleModelo').textContent = equipo.modelo;
                                                        document.getElementById('detalleSerie').textContent = equipo.serie;
                                                        document.getElementById('detalleColor').textContent = equipo.color;
                                                        document.getElementById('detallePrecio').textContent = equipo.precio ? '$' + equipo.precio : 'No especificado';
                                                        document.getElementById('detalleLaboratorio').textContent = equipo.nombreLaboratorio;
                                                        document.getElementById('detalleEstadoFisico').textContent = equipo.nombreEstadoFisico;
                                                        const modal = new bootstrap.Modal(document.getElementById('detalleModal'));
                                                        modal.show();
                                                        }
                                                        }

                                                        document.getElementById('filtrosForm').addEventListener('submit', function (e) {
                                                        e.preventDefault();
                                                        filtrarEquipos();
                                                        });
                                                        function filtrarEquipos() {
                                                        const grupo = document.getElementById('grupo').value.toLowerCase();
                                                        const categoria = document.getElementById('categoria').value.toLowerCase();
                                                        const laboratorio = document.getElementById('laboratorio').value.toLowerCase();
                                                        const estadoFisico = document.getElementById('estadoFisico').value.toLowerCase();
                                                        const filas = document.querySelectorAll('#tablaEquipos tbody tr');
                                                        let resultadosEncontrados = false;
                                                        filas.forEach(fila => {
                                                        if (fila.cells.length === 1)
                                                                return;
                                                        const grupoFila = fila.cells[1].textContent.toLowerCase();
                                                        const categoriaFila = fila.cells[2].textContent.toLowerCase();
                                                        const laboratorioFila = fila.cells[3].textContent.toLowerCase();
                                                        const estadoFisicoFila = fila.cells[4].textContent.toLowerCase();
                                                        const coincideGrupo = !grupo || grupoFila.includes(grupo);
                                                        const coincideCategoria = !categoria || categoriaFila.includes(categoria);
                                                        const coincideLaboratorio = !laboratorio || laboratorioFila.includes(laboratorio);
                                                        const coincideEstadoFisico = !estadoFisico || estadoFisicoFila.includes(estadoFisico);
                                                        if (coincideGrupo && coincideCategoria && coincideLaboratorio && coincideEstadoFisico) {
                                                        fila.style.display = '';
                                                        resultadosEncontrados = true;
                                                        } else {
                                                        fila.style.display = 'none';
                                                        }
                                                        });
                                                        const mensajeNoResultados = document.querySelector('#tablaEquipos tbody tr td[colspan="6"]');
                                                        if (mensajeNoResultados) {
                                                        mensajeNoResultados.parentElement.style.display = resultadosEncontrados ? 'none' : '';
                                                        } else if (!resultadosEncontrados && filas.length > 0) {
                                                        const tbody = document.querySelector('#tablaEquipos tbody');
                                                        const noResultsRow = document.createElement('tr');
                                                        noResultsRow.innerHTML = '<td colspan="6" class="text-center">No se encontraron equipos</td>';
                                                        tbody.appendChild(noResultsRow);
                                                        } else if (resultadosEncontrados && filas.length > 0 && filas[filas.length - 1].cells.length === 1) {
                                                        const tbody = document.querySelector('#tablaEquipos tbody');
                                                        tbody.removeChild(filas[filas.length - 1]);
                                                        }
                                                        }

                                                        function limpiarFiltros() {
                                                        document.getElementById('grupo').value = '';
                                                        document.getElementById('categoria').value = '';
                                                        document.getElementById('laboratorio').value = '';
                                                        document.getElementById('estadoFisico').value = '';
                                                        filtrarEquipos();
                                                        }

                                                        function prepararEdicionEquipo(idEquipo) {
                                                        const equipos = [
            <c:forEach items="${equipos}" var="equipo" varStatus="loop">
                                                        {
                                                        idEquipo: ${equipo.idEquipo},
                                                                nombreEquipo: "${equipo.nombreEquipo}",
                                                                idGrupo: ${equipo.idGrupo},
                                                                nombreGrupo: "${equipo.nombreGrupo}",
                                                                idCategoria: ${equipo.idCategoria},
                                                                nombreCategoria: "${equipo.nombreCategoria}",
                                                                idSubcategoria: ${equipo.idSubcategoria != null ? equipo.idSubcategoria : 'null'},
                                                                nombreSubcategoria: "${equipo.nombreSubcategoria}",
                                                                idTipo: ${equipo.idTipo},
                                                                nombreTipo: "${equipo.nombreTipo}",
                                                                marca: "${equipo.marca}",
                                                                modelo: "${equipo.modelo}",
                                                                serie: "${equipo.serie}",
                                                                color: "${equipo.color}",
                                                                precio: ${equipo.precio != null ? equipo.precio : 'null'},
                                                                idEstadoFisico: ${equipo.idEstadoFisico},
                                                                nombreEstadoFisico: "${equipo.nombreEstadoFisico}",
                                                                idLaboratorio: ${equipo.idLaboratorio},
                                                                nombreLaboratorio: "${equipo.nombreLaboratorio}"
                                                        }${!loop.last ? ',' : ''}
            </c:forEach>
                                                        ];
                                                        const equipo = equipos.find(e => e.idEquipo === idEquipo);
                                                        if (equipo) {
                                                        document.getElementById('equipoModalLabel').textContent = 'Editar Equipo';
                                                        document.getElementById('idEquipo').value = equipo.idEquipo;
                                                        document.getElementById('nombreEquipo').value = equipo.nombreEquipo;
                                                        document.getElementById('marca').value = equipo.marca;
                                                        document.getElementById('modelo').value = equipo.modelo;
                                                        document.getElementById('serie').value = equipo.serie;
                                                        document.getElementById('color').value = equipo.color;
                                                        document.getElementById('precio').value = equipo.precio !== null ? equipo.precio : '';
                                                        document.getElementById('idGrupo').value = equipo.idGrupo;
                                                        document.getElementById('idCategoria').value = equipo.idCategoria;
                                                        if (equipo.idSubcategoria !== null) {
                                                        document.getElementById('idSubcategoria').value = equipo.idSubcategoria;
                                                        }
                                                        document.getElementById('idTipo').value = equipo.idTipo;
                                                        document.getElementById('idEstadoFisico').value = equipo.idEstadoFisico;
                                                        document.getElementById('idLaboratorio').value = equipo.idLaboratorio;
                                                        const modal = new bootstrap.Modal(document.getElementById('equipoModal'));
                                                        modal.show();
                                                        }
                                                        }

                                                        document.getElementById('equipoModal').addEventListener('hidden.bs.modal', function () {
                                                        document.getElementById('equipoModalLabel').textContent = 'Registrar Nuevo Equipo';
                                                        document.getElementById('idEquipo').value = '';
                                                        this.querySelector('form').reset();
                                                        });




        </script>
    </body>
</html>