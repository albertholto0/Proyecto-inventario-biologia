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

            <form class="row g-3 mb-4" id="filtrosForm" method="GET">
                <div class="col-md-3">
                    <label for="grupoFiltro" class="form-label">Grupo</label>
                    <select id="grupoFiltro" name="grupo" class="form-select">
                        <option value="">Todos</option>
                        <option value="1" ${param.grupo == '1' ? 'selected' : ''}>Grupo 1</option>
                        <option value="2" ${param.grupo == '2' ? 'selected' : ''}>Grupo 2</option>
                        <option value="3" ${param.grupo == '3' ? 'selected' : ''}>Grupo 3</option>
                        <option value="4" ${param.grupo == '4' ? 'selected' : ''}>Grupo 4</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="carreraFiltro" class="form-label">Carrera</label>
                    <select id="carreraFiltro" name="carrera" class="form-select">
                        <option value="">Todas</option>
                        <option value="Biología" ${param.carrera == 'Biología' ? 'selected' : ''}>Biología</option>
                        <option value="Biología Marina" ${param.carrera == 'Biología Marina' ? 'selected' : ''}>Biología Marina</option>
                        <option value="Bioquímica" ${param.carrera == 'Bioquímica' ? 'selected' : ''}>Bioquímica</option>
                        <option value="Biotecnología" ${param.carrera == 'Biotecnología' ? 'selected' : ''}>Biotecnología</option>
                    </select>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Filtrar</button>
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <a href="${pageContext.request.contextPath}/alumnos" class="btn btn-outline-secondary w-100">Limpiar</a>
                </div>
            </form>

            <div class="mb-3 d-flex justify-content-between">
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#alumnoModal" onclick="limpiarFormulario()">Registrar Alumno</button>
            </div>

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
                    <c:set var="grupoFiltro" value="${param.grupo}"/>
                    <c:set var="carreraFiltro" value="${param.carrera}"/>
                    <c:set var="alumnos" value="${alumnoService.filtrarAlumnos(grupoFiltro != null && !grupoFiltro.isEmpty() ? Integer.parseInt(grupoFiltro) : null, carreraFiltro != null && !carreraFiltro.isEmpty() ? carreraFiltro : null)}"/>

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
                                        <button class="btn btn-info btn-sm" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#detalleModal"
                                                onclick="mostrarDetalle('${alumno.nombreCompleto}', '${alumno.correo}', ${alumno.matricula}, ${alumno.grupo}, '${alumno.carrera}')">
                                            Detalle
                                        </button>
                                        <button class="btn btn-warning btn-sm" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#alumnoModal"
                                                onclick="cargarDatosAlumno(${alumno.idAlumno}, '${alumno.nombreCompleto}', '${alumno.correo}', ${alumno.matricula}, ${alumno.grupo}, '${alumno.carrera}')">
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

        <div class="modal fade" id="alumnoModal" tabindex="-1" aria-labelledby="alumnoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content" action="${pageContext.request.contextPath}/alumnos" method="POST">
                    <div class="modal-header">
                        <h5 class="modal-title" id="alumnoModalLabel">Registrar/Editar Alumno</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body row g-3">
                        <input type="hidden" id="idAlumno" name="idAlumno">
                        <div class="col-md-12">
                            <label for="nombreCompleto" class="form-label">Nombre Completo</label>
                            <input type="text" class="form-control" id="nombreCompleto" name="nombreCompleto" required>
                        </div>
                        <div class="col-md-6">
                            <label for="correo" class="form-label">Correo</label>
                            <input type="email" class="form-control" id="correo" name="correo">
                        </div>
                        <div class="col-md-6">
                            <label for="matricula" class="form-label">Matrícula</label>
                            <input type="number" class="form-control" id="matricula" name="matricula" required>
                        </div>
                        <div class="col-md-6">
                            <label for="modalGrupo" class="form-label">Grupo</label>
                            <select class="form-control" id="modalGrupo" name="grupo" required>
                                <option value="1">Grupo 1</option>
                                <option value="2">Grupo 2</option>
                                <option value="3">Grupo 3</option>
                                <option value="4">Grupo 4</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="modalCarrera" class="form-label">Carrera</label>
                            <input type="text" class="form-control" id="modalCarrera" name="carrera" required readonly style="background-color: #e9ecef; cursor: not-allowed;">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="modal fade" id="detalleModal" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="detalleModalLabel">Detalle del Alumno</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nombre Completo:</label>
                            <p id="detalleNombre"></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Correo:</label>
                            <p id="detalleCorreo"></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Matrícula:</label>
                            <p id="detalleMatricula"></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Grupo:</label>
                            <p id="detalleGrupo"></p>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Carrera:</label>
                            <p id="detalleCarrera"></p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById('grupoFiltro').addEventListener('change', function () {
                const grupo = this.value;
                const carreraField = document.getElementById('carreraFiltro');

                switch (grupo) {
                    case '1':
                        carreraField.value = 'Biología';
                        break;
                    case '2':
                        carreraField.value = 'Biología Marina';
                        break;
                    case '3':
                        carreraField.value = 'Bioquímica';
                        break;
                    case '4':
                        carreraField.value = 'Biotecnología';
                        break;
                    default:
                        carreraField.value = '';
                }
            });

            // Lógica para autocompletar la carrera en el modal
            document.getElementById('modalGrupo').addEventListener('change', function () {
                const grupo = this.value;
                const modalCarreraField = document.getElementById('modalCarrera');

                switch (grupo) {
                    case '1':
                        modalCarreraField.value = 'Biología';
                        break;
                    case '2':
                        modalCarreraField.value = 'Biología Marina';
                        break;
                    case '3':
                        modalCarreraField.value = 'Bioquímica';
                        break;
                    case '4':
                        modalCarreraField.value = 'Biotecnología';
                        break;
                    default:
                        modalCarreraField.value = '';
                }
            });

            function limpiarFormulario() {
                document.getElementById('idAlumno').value = '';
                document.getElementById('nombreCompleto').value = '';
                document.getElementById('correo').value = '';
                document.getElementById('matricula').value = '';
                document.getElementById('modalGrupo').value = '1';
                document.getElementById('modalCarrera').value = 'Biología';
            }

            function mostrarDetalle(nombre, correo, matricula, grupo, carrera) {
                document.getElementById('detalleNombre').textContent = nombre;
                document.getElementById('detalleCorreo').textContent = correo;
                document.getElementById('detalleMatricula').textContent = matricula;
                document.getElementById('detalleGrupo').textContent = grupo;
                document.getElementById('detalleCarrera').textContent = carrera;
            }

            function cargarDatosAlumno(id, nombre, correo, matricula, grupo, carrera) {
                document.getElementById('idAlumno').value = id;
                document.getElementById('nombreCompleto').value = nombre;
                document.getElementById('correo').value = correo;
                document.getElementById('matricula').value = matricula;
                const modalGrupoSelect = document.getElementById('modalGrupo');
                modalGrupoSelect.value = grupo;
                modalGrupoSelect.dispatchEvent(new Event('change'));
                document.getElementById('modalCarrera').value = carrera;
            }
        </script>
    </body>
</html>