<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="laboratorioService" class="com.unsij.services.LaboratorioService" scope="page"/>
<jsp:useBean id="responsableService" class="com.unsij.services.ResponsableService" scope="page"/>

<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Módulo de Laboratorios</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <!-- SweetAlert2 CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    </head>

    <body class="bg-light">
        <jsp:include page="/components/nav.jsp" />

        <main class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-3"><i class="bi bi-building-gear text-success me-2"></i>Módulo de Laboratorios</h2>
                    <p class="text-muted">Consulta la información de cada laboratorio, su inventario y responsables asignados.</p>
                </div>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevoResponsable">
                    <i class="bi bi-person-plus me-1"></i> Registrar Nuevo Responsable
                </button>
            </div>

            <div class="row g-4">
                <c:set var="laboratorios" value="${laboratorioService.obtenerLaboratorios()}"/>
                <c:choose>
                    <c:when test="${empty laboratorios}">
                        <div class="col-12">
                            <div class="alert alert-info">No hay laboratorios registrados</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${laboratorios}" var="laboratorio">
                            <div class="col-md-6">
                                <div class="card shadow-sm h-100">
                                    <div class="card-header bg-success text-white d-flex align-items-center">
                                        <i class="bi bi-flask2-fill me-2"></i>
                                        <span>${laboratorio.nombreLaboratorio}</span>
                                    </div>
                                    <div class="card-body">
                                        <c:if test="${not empty laboratorio.descripcion}">
                                            <p class="mb-3">${laboratorio.descripcion}</p>
                                        </c:if>

                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div>
                                                <h6 class="fw-semibold mb-2">Responsable</h6>
                                                <ul class="list-unstyled mb-0">
                                                    <li><i class="bi bi-person-fill text-primary me-2"></i> 
                                                        ${not empty laboratorio.nombreResponsable ? laboratorio.nombreResponsable : 'Sin responsable asignado'}
                                                    </li>
                                                </ul>
                                            </div>
                                            <button class="btn btn-sm btn-outline-primary" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#modalCambiarResponsable"
                                                    data-id-laboratorio="${laboratorio.idLaboratorio}">
                                                <i class="bi bi-arrow-repeat me-1"></i> Cambiar
                                            </button>
                                        </div>

                                        <!--Informacion del inventario. Por el momento no esta implementado-->
                                        <h6 class="fw-semibold mb-2">Inventario Asociado</h6>
                                        <div class="alert alert-secondary mb-0">
                                            <i class="bi bi-info-circle me-2"></i>
                                            La información de inventario se mostrará aquí cuando esté implementada.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>

        <!-- Modal para cambiar responsable -->
        <div class="modal fade" id="modalCambiarResponsable" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/LaboratorioController" method="POST">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title">Cambiar Responsable</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="idLaboratorio" id="idLaboratorioModal">
                            <div class="mb-3">
                                <label for="nuevoResponsable" class="form-label">Seleccionar Responsable</label>
                                <select class="form-select" id="nuevoResponsable" name="idResponsable" required>
                                    <option value="">-- Seleccione un responsable --</option>
                                    <c:set var="responsables" value="${responsableService.obtenerResponsables()}"/>
                                    <c:forEach items="${responsables}" var="responsable">
                                        <option value="${responsable.idResponsable}">${responsable.nombreCompleto}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary" name="action" value="cambiarResponsable">Guardar Cambios</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Modal para nuevo responsable -->
        <div class="modal fade" id="modalNuevoResponsable" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/ResponsableController" method="POST">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title">Registrar Nuevo Responsable</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="nombreCompleto" class="form-label">Nombre Completo</label>
                                <input type="text" class="form-control" id="nombreCompleto" name="nombreCompleto" required>
                            </div>
                            <div class="mb-3">
                                <label for="correo" class="form-label">Correo Electrónico</label>
                                <input type="email" class="form-control" id="correo" name="correo" required>
                            </div>
                            <div class="mb-3">
                                <label for="numeroTelefonico" class="form-label">Número Telefónico</label>
                                <input type="tel" class="form-control" id="numeroTelefonico" name="numeroTelefonico" 
                                       maxlength="10" pattern="[0-9]{10}" 
                                       title="Debe contener exactamente 10 dígitos numéricos" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-success" name="action" value="guardar">Guardar Responsable</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            // Script para pasar el id del laboratorio al modal
            document.getElementById('modalCambiarResponsable').addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var idLaboratorio = button.getAttribute('data-id-laboratorio');
                document.getElementById('idLaboratorioModal').value = idLaboratorio;
            });

            <c:if test="${not empty sessionScope.alertMessage}">
            Swal.fire({
                icon: '${sessionScope.alertType}',
                title: '${sessionScope.alertMessage}',
                showConfirmButton: false,
                timer: 2500,
                timerProgressBar: true,
                background: '#fff',
                backdrop: `
                rgba(0,0,0,0.4)
                url("${pageContext.request.contextPath}/images/confetti.gif")
                center top
                no-repeat
            `
            });

                <c:remove var="alertMessage" scope="session"/>
                <c:remove var="alertType" scope="session"/>
            </c:if>
        </script>
    </body>
</html>