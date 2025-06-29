<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Módulo de Laboratorios</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="bg-light">
    <jsp:include page="/components/nav.jsp" />


    <main class="container">
        <div class="mb-4">
            <h2 class="fw-bold mb-3"><i class="bi bi-building-gear text-success me-2"></i>Módulo de Laboratorios</h2>
            <p class="text-muted">Consulta la información de cada laboratorio, su inventario y responsables asignados.
            </p>
        </div>

        <div class="row g-4">
            <!-- Laboratorio 1 -->
            <div class="col-md-6">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-success text-white d-flex align-items-center">
                        <i class="bi bi-flask2-fill me-2"></i>
                        <span>Laboratorio de Biología Molecular</span>
                    </div>
                    <div class="card-body">
                        <h6 class="fw-semibold mb-2">Inventario Asociado</h6>
                        <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item">Microscopios ópticos (5)</li>
                            <li class="list-group-item">Centrífuga (2)</li>
                            <li class="list-group-item">Pipetas automáticas (10)</li>
                        </ul>
                        <h6 class="fw-semibold mb-2">Responsables Asignados</h6>
                        <ul class="list-unstyled mb-0">
                            <li><i class="bi bi-person-fill text-primary me-2"></i> Dra. Ana López</li>
                            <li><i class="bi bi-person-fill text-primary me-2"></i> Mtro. Carlos Pérez</li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- Laboratorio 2 -->
            <div class="col-md-6">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-success text-white d-flex align-items-center">
                        <i class="bi bi-flask2 me-2"></i>
                        <span>Laboratorio de Microbiología</span>
                    </div>
                    <div class="card-body">
                        <h6 class="fw-semibold mb-2">Inventario Asociado</h6>
                        <ul class="list-group list-group-flush mb-3">
                            <li class="list-group-item">Estufas de cultivo (3)</li>
                            <li class="list-group-item">Placas de Petri (100)</li>
                            <li class="list-group-item">Autoclave (1)</li>
                        </ul>
                        <h6 class="fw-semibold mb-2">Responsables Asignados</h6>
                        <ul class="list-unstyled mb-0">
                            <li><i class="bi bi-person-fill text-primary me-2"></i> Dr. Luis Ramírez</li>
                            <li><i class="bi bi-person-fill text-primary me-2"></i> Lic. Sofía Méndez</li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- Puedes agregar más laboratorios aquí siguiendo la misma estructura -->
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
    </script>
    <script src="/components/nav.js"></script>
</body>

</html>