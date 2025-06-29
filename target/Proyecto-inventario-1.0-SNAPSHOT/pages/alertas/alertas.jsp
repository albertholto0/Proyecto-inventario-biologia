<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                    <span id="alert-badge" class="badge rounded-pill bg-danger ms-2" style="display:none;">
                        <span id="alert-count">0</span> pendientes
                    </span>
                </h2>
                <button id="btn-generar-alertas" class="btn btn-outline-primary">
                    <i class="bi bi-lightning-charge"></i> Generar alertas pendientes
                </button>
            </div>

            <!-- Filtros rápidos -->
            <form id="filtros-alertas" class="row g-2 mb-4">
                <div class="col-md-3">
                    <select class="form-select" id="filtro-tipo">
                        <option value="">Tipo (todos)</option>
                        <option value="recordatorio">Recordatorio préstamo</option>
                        <option value="atrasado">Material atrasado</option>
                        <option value="otro">Otro asunto</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="filtro-estado">
                        <option value="">Estado (todos)</option>
                        <option value="pendiente">Pendiente</option>
                        <option value="enviada">Enviada</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <input type="date" class="form-control" id="filtro-fecha" placeholder="Fecha de envío">
                </div>
                <div class="col-md-3">
                    <button type="button" class="btn btn-secondary w-100" id="btn-limpiar-filtros">
                        Limpiar filtros
                    </button>
                </div>
            </form>

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

        <!-- Toast de alertas urgentes -->
        <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1100">
            <div id="toast-alerta-urgente" class="toast align-items-center text-bg-danger border-0" role="alert"
                aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        Tienes alertas urgentes de préstamos atrasados.
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                        aria-label="Cerrar"></button>
                </div>
            </div>
        </div>

        <!-- Modal para enviar correo -->
        <div class="modal fade" id="modalEnviarCorreo" tabindex="-1" aria-labelledby="modalEnviarCorreoLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content" id="form-enviar-correo">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalEnviarCorreoLabel">Enviar correo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-2">
                            <label for="correo-destino" class="form-label">Para</label>
                            <input type="email" class="form-control" id="correo-destino" required>
                        </div>
                        <div class="mb-2">
                            <label for="asunto-correo" class="form-label">Asunto</label>
                            <input type="text" class="form-control" id="asunto-correo" required>
                        </div>
                        <div class="mb-2">
                            <label for="mensaje-correo" class="form-label">Mensaje</label>
                            <textarea class="form-control" id="mensaje-correo" rows="5" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Enviar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/components/nav.js"></script>
    </body>

    </html>