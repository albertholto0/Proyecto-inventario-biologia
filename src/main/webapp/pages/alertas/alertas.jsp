<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="alertaService" class="com.unsij.services.AlertaService" scope="page"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Alertas - Inventario</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>

<body>
    <jsp:include page="/components/nav.jsp" />

    <div class="container my-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2>
                <i class="bi bi-bell-fill"></i> Alertas
                <span id="alert-badge" class="badge rounded-pill bg-danger ms-2">
                    <c:out value="${alertaService.obtenerTodasAlertas().size()}"/> pendientes
                </span>
            </h2>
            <button id="btn-generar-alertas" class="btn btn-outline-primary">
                <i class="bi bi-lightning-charge"></i> Generar alertas pendientes
            </button>
        </div>

        <!-- Lista de alertas -->
        <div class="table-responsive">
            <table class="table align-middle" id="tabla-alertas">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tipo</th>
                        <th>Préstamo</th>
                        <th>Mensaje</th>
                        <th>Fecha de envío</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${alertaService.obtenerTodasAlertas()}" var="alerta">
                        <tr>
                            <td>${alerta.idAlerta}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${alerta.tipo == 'recordatorio prestamo'}">
                                        <span class="badge bg-info">Recordatorio</span>
                                    </c:when>
                                    <c:when test="${alerta.tipo == 'material atrasado'}">
                                        <span class="badge bg-danger">Atrasado</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Otro</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${alerta.idPrestamo}</td>
                            <td>
                                <c:if test="${not empty alerta.mensaje}">
                                    <c:choose>
                                        <c:when test="${fn:length(alerta.mensaje) > 50}">
                                            ${fn:substring(alerta.mensaje, 0, 50)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${alerta.mensaje}
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </td>
                            <td>${alerta.fechaEnvio}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${alerta.estado == 'pendiente'}">
                                        <span class="badge bg-warning">Pendiente</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">Enviada</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" 
                                    data-bs-target="#modalDetalleAlerta" data-id="${alerta.idAlerta}">
                                    <i class="bi bi-eye"></i> Ver
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Detalle de Alerta -->
    <div class="modal fade" id="modalDetalleAlerta" tabindex="-1" aria-labelledby="modalDetalleAlertaLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalDetalleAlertaLabel">Detalle de Alerta</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div id="detalle-alerta-contenido">
                        <!-- Se llena dinámicamente -->
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
        document.addEventListener('DOMContentLoaded', function() {
            const modalDetalle = document.getElementById('modalDetalleAlerta');
            if (modalDetalle) {
                modalDetalle.addEventListener('show.bs.modal', function(event) {
                    const button = event.relatedTarget;
                    const idAlerta = button.getAttribute('data-id');
                    
                    document.getElementById('detalle-alerta-contenido').innerHTML = `
                        <h6>Detalles completos de la alerta #${idAlerta}</h6>
                        <p>Información detallada de la alerta aparecerá aquí.</p>
                    `;
                });
            }
        });
    </script>
</body>
</html>