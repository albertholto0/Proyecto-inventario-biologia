<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Módulo de Préstamos - Gestión de Laboratorio de Biología</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <jsp:include page="/components/nav.jsp" />

    <div class="container mb-5">
        <div class="mb-4">
            <h2 class="fw-bold mb-3 d-flex align-items-center">
                <i class="bi bi-arrow-left-right text-success me-2" style="font-size: 2.2em;"></i>
                Módulo de Préstamos
            </h2>
            <p class="text-muted">
                Gestiona y registra los préstamos de equipos y materiales del laboratorio de manera eficiente. Consulta el historial, controla las fechas de devolución y mantén un seguimiento claro de los préstamos activos y devueltos.
            </p>
        </div>

        <!-- Registro de nuevos préstamos -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white">
                Registro de Nuevo Préstamo
            </div>
            <div class="card-body">
                <form id="form-prestamo">
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label for="alumno" class="form-label">Alumno</label>
                            <select class="form-select" id="alumno" required>
                                <option value="">Seleccione un alumno</option>
                                <!-- Opciones dinámicas -->
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="laboratorio" class="form-label">Laboratorio</label>
                            <select class="form-select" id="laboratorio" required>
                                <option value="">Seleccione laboratorio</option>
                                <!-- Opciones dinámicas -->
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="fecha_prestamo" class="form-label">Fecha de Préstamo</label>
                            <input type="datetime-local" class="form-control" id="fecha_prestamo" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="fecha_devolucion_prevista" class="form-label">Fecha de Devolución Prevista</label>
                            <input type="datetime-local" class="form-control" id="fecha_devolucion_prevista" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Equipos</label>
                            <div class="d-flex">
                                <button type="button" class="btn btn-outline-success me-2" data-bs-toggle="modal" data-bs-target="#modalEquipos">
                                    <i class="bi bi-plus-circle"></i> Agregar Equipos
                                </button>
                                <div id="equipos-seleccionados" class="d-flex flex-wrap gap-2">
                                    <!-- Aquí aparecerán los equipos seleccionados -->
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Materiales</label>
                            <div class="d-flex">
                                <button type="button" class="btn btn-outline-success me-2" data-bs-toggle="modal" data-bs-target="#modalMateriales">
                                    <i class="bi bi-plus-circle"></i> Agregar Materiales
                                </button>
                                <div id="materiales-seleccionados" class="d-flex flex-wrap gap-2">
                                    <!-- Aquí aparecerán los materiales seleccionados -->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-success">Registrar Préstamo</button>
                </form>
            </div>
        </div>

        <!-- Modal para selección de equipos -->
        <div class="modal fade" id="modalEquipos" tabindex="-1" aria-labelledby="modalEquiposLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalEquiposLabel">Seleccionar Equipos</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Seleccionar</th>
                                        <th>Equipo</th>
                                        <th>Disponibles</th>
                                        <th>Cantidad</th>
                                    </tr>
                                </thead>
                                <tbody id="lista-equipos">
                                    <!-- Filas dinámicas de equipos -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-success" id="guardar-equipos">Guardar Selección</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para selección de materiales -->
        <div class="modal fade" id="modalMateriales" tabindex="-1" aria-labelledby="modalMaterialesLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalMaterialesLabel">Seleccionar Materiales</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Seleccionar</th>
                                        <th>Material</th>
                                        <th>Disponibles</th>
                                        <th>Cantidad</th>
                                    </tr>
                                </thead>
                                <tbody id="lista-materiales">
                                    <!-- Filas dinámicas de materiales -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-success" id="guardar-materiales">Guardar Selección</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Listado de préstamos con filtros por estado -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                <span>Listado de Préstamos</span>
                <form class="row g-2">
                    <div class="col-auto">
                        <select class="form-select form-select-sm" id="filtro_estado">
                            <option value="">Todos</option>
                            <option value="activo">Activo</option>
                            <option value="completado">Completado</option>
                            <option value="atrasado">Atrasado</option>
                            <option value="cancelado">Cancelado</option>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-sm btn-outline-light">Filtrar</button>
                    </div>
                </form>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped align-middle" id="tabla-prestamos">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Alumno</th>
                                <th>Laboratorio</th>
                                <th>Fecha Préstamo</th>
                                <th>Devolución Prevista</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Ejemplo de fila -->
                            <tr>
                                <td>1</td>
                                <td>Juan Pérez</td>
                                <td>Lab 1</td>
                                <td>01/06/2024 09:00</td>
                                <td>05/06/2024 18:00</td>
                                <td><span class="badge bg-success">Completado</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalDetallesPrestamo" data-id="1">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalDevolucion" data-id="1">
                                        <i class="bi bi-arrow-return-left"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>María López</td>
                                <td>Lab 2</td>
                                <td>10/06/2024 10:00</td>
                                <td>12/06/2024 18:00</td>
                                <td><span class="badge bg-warning text-dark">Activo</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalDetallesPrestamo" data-id="2">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#modalDevolucion" data-id="2">
                                        <i class="bi bi-arrow-return-left"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal para detalles del préstamo -->
        <div class="modal fade" id="modalDetallesPrestamo" tabindex="-1" aria-labelledby="modalDetallesPrestamoLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalDetallesPrestamoLabel">Detalles del Préstamo</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="detalles-prestamo">
                        <!-- Contenido dinámico -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal para registrar devolución -->
        <div class="modal fade" id="modalDevolucion" tabindex="-1" aria-labelledby="modalDevolucionLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title" id="modalDevolucionLabel">Registrar Devolución</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="form-devolucion">
                            <input type="hidden" id="prestamo_id">
                            <div class="mb-3">
                                <label for="fecha_devolucion_real" class="form-label">Fecha y Hora de Devolución</label>
                                <input type="datetime-local" class="form-control" id="fecha_devolucion_real" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="devolucion_completa">
                                <label class="form-check-label" for="devolucion_completa">Todos los items fueron devueltos</label>
                            </div>
                            <div class="mb-3" id="items-faltantes-container" style="display: none;">
                                <label class="form-label">Items faltantes o dañados</label>
                                <div id="items-faltantes">
                                    <!-- Lista dinámica de items -->
                                </div>
                            </div>
                            <button type="submit" class="btn btn-success">Registrar Devolución</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (CDN) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/components/nav.js"></script>
    
    <script>
        // Aquí iría el JavaScript para manejar la interacción con los modales
        // y el envío de los formularios
    </script>
</body>

</html>