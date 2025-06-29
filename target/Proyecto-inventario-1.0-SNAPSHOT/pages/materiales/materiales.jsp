<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <title>Materiales - Gestión de Laboratorio de Biología</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>

    <body>
        <jsp:include page="/components/nav.jsp" />
        <div class="container my-4">

            <!-- Cartas principales -->
            <div class="row g-3 mb-4 justify-content-center">
                <div class="col-md-4">
                    <button class="card border-success h-100 shadow-sm w-100 text-decoration-none" id="btnReactivos"
                            style="cursor:pointer;">
                        <div class="card-body text-center">
                            <i class="bi bi-flask text-success display-4 mb-2"></i>
                            <h5 class="card-title text-success">Reactivos</h5>
                            <p class="card-text text-muted">Sustancias químicas utilizadas en experimentos y análisis.
                                Requieren control especial por caducidad y seguridad.</p>
                        </div>
                    </button>
                </div>
                <div class="col-md-4">
                    <button class="card border-primary h-100 shadow-sm w-100 text-decoration-none" id="btnMateriales"
                            style="cursor:pointer;">
                        <div class="card-body text-center">
                            <i class="bi bi-box text-primary display-4 mb-2"></i>
                            <h5 class="card-title text-primary">Materiales</h5>
                            <p class="card-text text-muted">Instrumentos y utensilios reutilizables como vasos, tubos, matraces
                                y otros equipos de laboratorio.</p>
                        </div>
                    </button>
                </div>
                <div class="col-md-4">
                    <button class="card border-warning h-100 shadow-sm w-100 text-decoration-none" id="btnConsumibles"
                            style="cursor:pointer;">
                        <div class="card-body text-center">
                            <i class="bi bi-droplet-half text-warning display-4 mb-2"></i>
                            <h5 class="card-title text-warning">Consumibles</h5>
                            <p class="card-text text-muted">Elementos de un solo uso o fácil reposición, como guantes, placas
                                Petri, papel filtro, etc.</p>
                        </div>
                    </button>
                </div>
            </div>

            <!-- Contenedor dinámico para tablas y botones -->
            <div id="detalleMateriales"></div>
        </div>

        <!-- Modal Registrar Material -->
        <div class="modal fade" id="modalRegistrarMaterial" tabindex="-1" aria-labelledby="modalRegistrarMaterialLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <form class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalRegistrarMaterialLabel">Registrar Nuevo Material</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar">
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="nombreMaterial" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombreMaterial" required>
                        </div>
                        <div class="mb-3">
                            <label for="tipoMaterial" class="form-label">Tipo</label>
                            <select class="form-select" id="tipoMaterial" required>
                                <option value="reactivo">Reactivo</option>
                                <option value="material">Material</option>
                                <option value="consumible">Consumible</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="presentacionMaterial" class="form-label">Presentación</label>
                            <input type="text" class="form-control" id="presentacionMaterial">
                        </div>
                        <div class="mb-3">
                            <label for="unidadMaterial" class="form-label">Unidad</label>
                            <input type="number" class="form-control" id="unidadMaterial" min="1">
                        </div>
                        <div class="mb-3">
                            <label for="claveMaterial" class="form-label">Clave</label>
                            <input type="text" class="form-control" id="claveMaterial">
                        </div>
                        <div class="mb-3">
                            <label for="cantidadMaterial" class="form-label">Cantidad</label>
                            <input type="number" class="form-control" id="cantidadMaterial" min="0" required>
                        </div>
                        <div class="mb-3">
                            <label for="laboratorioMaterial" class="form-label">Laboratorio</label>
                            <select class="form-select" id="laboratorioMaterial" required>
                                <option value="1">Lab 1</option>
                                <option value="2">Lab 2</option>
                                <option value="3">Lab 3</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success">Registrar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal Historial de Movimientos -->
        <div class="modal fade" id="modalHistorial" tabindex="-1" aria-labelledby="modalHistorialLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalHistorialLabel">Historial de Movimientos</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar">
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-striped align-middle">
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>Material</th>
                                    <th>Movimiento</th>
                                    <th>Cantidad</th>
                                    <th>Responsable</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2024-06-10</td>
                                    <td>Vasos de precipitados</td>
                                    <td><span class="badge bg-danger">Salida</span></td>
                                    <td>2</td>
                                    <td>Juan Pérez</td>
                                </tr>
                                <tr>
                                    <td>2024-06-09</td>
                                    <td>Guantes de látex</td>
                                    <td><span class="badge bg-success">Entrada</span></td>
                                    <td>50</td>
                                    <td>María López</td>
                                </tr>
                                <!-- Más movimientos aquí -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            console.log("Script en JSP cargado");
            // Muestra la tabla según el tipo seleccionado
            function mostrarTabla(tipo) {
                console.log("Mostrando tabla para:", tipo);
                // Colores y títulos según tipo
                let color = 'success', titulo = 'Reactivos';
                if (tipo === 'material') {
                    color = 'primary';
                    titulo = 'Materiales';
                }
                if (tipo === 'consumible') {
                    color = 'warning';
                    titulo = 'Consumibles';
                }

                // Ejemplo de tabla (puedes reemplazar por datos dinámicos)
                let tabla = `
        <div class="card border-${color} mb-4 shadow">
            <div class="card-header bg-${color} text-white d-flex justify-content-between align-items-center">
                <span>Inventario de ${titulo}</span>
                <div>
                    <button class="btn btn-light btn-sm me-2" data-bs-toggle="modal" data-bs-target="#modalRegistrarMaterial">
                        <i class="bi bi-plus-circle me-1"></i>Registrar ${titulo.slice(0, -1)}
                    </button>
                    <button class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#modalHistorial">
                        <i class="bi bi-clock-history me-1"></i>Historial de Movimientos
                    </button>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Nombre</th>
                            <th>Presentación</th>
                            <th>Unidad</th>
                            <th>Clave</th>
                            <th>Cantidad</th>
                            <th>Laboratorio</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Ácido clorhídrico</td>
                            <td>Solución 1M</td>
                            <td>500</td>
                            <td>HCL-01</td>
                            <td class="fw-bold text-${color}">10</td>
                            <td>Lab 1</td>
                        </tr>
                        <tr>
                            <td>Guantes de látex</td>
                            <td>Caja 100 pzas</td>
                            <td>100</td>
                            <td>GL-02</td>
                            <td class="fw-bold text-${color}">50</td>
                            <td>Lab 2</td>
                        </tr>
                        <!-- Más materiales aquí -->
                    </tbody>
                </table>
            </div>
        </div>
        `;
                alert(`Tabla generada para ${titulo} con color ${color}`); // ← Debug
                document.getElementById('detalleMateriales').innerHTML = tabla;
                // Scroll suave al detalle
                document.getElementById('detalleMateriales').scrollIntoView({behavior: "smooth"});
            }

            // Eventos para las cartas
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('btnReactivos').onclick = () => mostrarTabla('reactivo');
                document.getElementById('btnMateriales').onclick = () => mostrarTabla('material');
                document.getElementById('btnConsumibles').onclick = () => mostrarTabla('consumible');
            });
        </script>
    </body>
</html>