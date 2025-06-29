<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Reportes | Inventario</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <jsp:include page="/components/nav.jsp" />

    <div class="container my-4">
        <h2 class="fw-bold mb-3 d-flex align-items-center">
            <i class="bi bi-bar-chart-fill text-danger me-2" style="font-size: 2.2em;"></i>
            Módulo de Reportes
        </h2>
        <p class="text-muted">
            Visualiza estadísticas de uso y el historial de préstamos de equipos y materiales del laboratorio. Genera reportes personalizados y exporta la información en diferentes formatos para un mejor control y análisis.
        </p>
        <div class="row g-4">
            <!-- Reporte Personalizado -->
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <i class="bi bi-funnel"></i> Generación de reportes personalizados
                    </div>
                    <div class="card-body">
                        <form id="customReportForm" class="row g-3 align-items-end">
                            <div class="col-md-4">
                                <label for="reportType" class="form-label">Tipo de reporte</label>
                                <select id="reportType" class="form-select" required>
                                    <option value="uso">Estadísticas de uso</option>
                                    <option value="historico">Histórico de préstamos</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="dateFrom" class="form-label">Desde</label>
                                <input type="date" id="dateFrom" class="form-control" required>
                            </div>
                            <div class="col-md-3">
                                <label for="dateTo" class="form-label">Hasta</label>
                                <input type="date" id="dateTo" class="form-control" required>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="bi bi-search"></i> Generar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Estadísticas de uso -->
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-info text-white">
                        <i class="bi bi-pie-chart"></i> Estadísticas de uso de equipos/materiales
                    </div>
                    <div class="card-body">
                        <canvas id="usageStatsChart" height="200"></canvas>
                    </div>
                </div>
            </div>

            <!-- Históricos de préstamos -->
            <div class="col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-header bg-warning text-dark">
                        <i class="bi bi-clock-history"></i> Históricos de préstamos
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped align-middle" id="loanHistoryTable">
                                <thead>
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Equipo/Material</th>
                                        <th>Usuario</th>
                                        <th>Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Datos dinámicos -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Exportación -->
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-secondary text-white">
                        <i class="bi bi-download"></i> Exportación de reportes
                    </div>
                    <div class="card-body">
                        <button class="btn btn-outline-primary me-2" id="exportExcel">
                            <i class="bi bi-file-earmark-excel"></i> Exportar a Excel
                        </button>
                        <button class="btn btn-outline-danger me-2" id="exportPDF">
                            <i class="bi bi-file-earmark-pdf"></i> Exportar a PDF
                        </button>
                        <button class="btn btn-outline-dark" id="exportCSV">
                            <i class="bi bi-file-earmark-text"></i> Exportar a CSV
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JS de Bootstrap y lógica de reportes -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Ejemplo de datos para la gráfica de uso
        const usageStatsData = {
            labels: ['Laptop', 'Proyector', 'Microscopio', 'Multímetro'],
            datasets: [{
                label: 'Usos',
                data: [12, 19, 7, 5],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(255, 206, 86, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(255, 99, 132, 0.7)'
                ],
                borderWidth: 1
            }]
        };
        const usageStatsChart = new Chart(document.getElementById('usageStatsChart'), {
            type: 'doughnut',
            data: usageStatsData,
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // Ejemplo de datos para la tabla de históricos
        const loanHistory = [
            { fecha: '2024-06-01', equipo: 'Laptop', usuario: 'Juan Pérez', estado: 'Devuelto' },
            { fecha: '2024-06-03', equipo: 'Proyector', usuario: 'Ana Gómez', estado: 'Prestado' },
            { fecha: '2024-06-05', equipo: 'Microscopio', usuario: 'Luis Torres', estado: 'Devuelto' }
        ];
        const tbody = document.querySelector('#loanHistoryTable tbody');
        loanHistory.forEach(item => {
            const tr = document.createElement('tr');
            tr.innerHTML = `<td>${item.fecha}</td><td>${item.equipo}</td><td>${item.usuario}</td><td>${item.estado}</td>`;
            tbody.appendChild(tr);
        });

        // Exportación (solo ejemplo, requiere implementación real)
        document.getElementById('exportExcel').onclick = () => alert('Funcionalidad de exportar a Excel no implementada.');
        document.getElementById('exportPDF').onclick = () => alert('Funcionalidad de exportar a PDF no implementada.');
        document.getElementById('exportCSV').onclick = () => alert('Funcionalidad de exportar a CSV no implementada.');

        // Generación de reportes personalizados (solo ejemplo)
        document.getElementById('customReportForm').onsubmit = function (e) {
            e.preventDefault();
            alert('Generación de reporte personalizada no implementada.');
        };
    </script>
    <script src="/components/nav.js"></script>
</body>

</html>