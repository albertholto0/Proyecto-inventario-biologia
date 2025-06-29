<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verificación simple de autenticación (puedes mejorarla)
    if (session.getAttribute("authenticated") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Laboratorio de Biología</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-light">

    <!-- Header dinámico -->
    <jsp:include page="/components/nav.jsp" />

    <!-- Dashboard Summary -->
    <div class="container mb-4">
        <div class="row g-3">
            <div class="col-md-3">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <i class="bi bi-hdd-network-fill display-5 text-success mb-2"></i>
                        <h5 class="card-title">Equipos Totales</h5>
                        <p class="display-6" id="equiposTotales">120</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <i class="bi bi-box-seam-fill display-5 text-primary mb-2"></i>
                        <h5 class="card-title">Materiales</h5>
                        <p class="display-6" id="materialesTotales">350</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <i class="bi bi-arrow-repeat display-5 text-warning mb-2"></i>
                        <h5 class="card-title">Préstamos Activos</h5>
                        <p class="display-6" id="prestamosActivos">15</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center shadow-sm">
                    <div class="card-body">
                        <i class="bi bi-exclamation-triangle-fill display-5 text-danger mb-2"></i>
                        <h5 class="card-title">Alertas Pendientes</h5>
                        <p class="display-6" id="alertasPendientes">3</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content: Chart and Lists -->
    <div class="container mb-4">
        <div class="row g-4">
            <div class="col-lg-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        Préstamos por Estado
                    </div>
                    <div class="card-body">
                        <canvas id="prestamosChart" height="180"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-warning text-dark">
                        Préstamos Próximos a Vencer
                    </div>
                    <ul class="list-group list-group-flush" id="proximosVencer">
                        <li class="list-group-item">Microscopio #12 - 10/06/2024</li>
                        <li class="list-group-item">Centrífuga #5 - 12/06/2024</li>
                        <li class="list-group-item">Pipetas #8 - 13/06/2024</li>
                    </ul>
                </div>
                <div class="card shadow-sm">
                    <div class="card-header bg-danger text-white">
                        Últimas Alertas Generadas
                    </div>
                    <ul class="list-group list-group-flush" id="ultimasAlertas">
                        <li class="list-group-item">Mantenimiento pendiente: Microscopio #7</li>
                        <li class="list-group-item">Material agotado: Placas Petri</li>
                        <li class="list-group-item">Préstamo atrasado: Balanza #2</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer dinámico -->
    <jsp:include page="/components/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const ctx = document.getElementById('prestamosChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Activos', 'Completados', 'Atrasados'],
                datasets: [{
                    data: [15, 40, 2],
                    backgroundColor: ['#198754', '#0dcaf0', '#dc3545'],
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    </script>
</body>
</html>