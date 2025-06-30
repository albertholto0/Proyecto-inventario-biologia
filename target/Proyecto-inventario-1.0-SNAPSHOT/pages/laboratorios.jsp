<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="laboratorioService" class="com.unsij.services.LaboratorioService" scope="page"/>

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
            <p class="text-muted">Consulta la información de cada laboratorio, su inventario y responsables asignados.</p>
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
                                    
                                    <h6 class="fw-semibold mb-2">Responsable</h6>
                                    <ul class="list-unstyled mb-3">
                                        <li><i class="bi bi-person-fill text-primary me-2"></i> ${laboratorio.nombreResponsable}</li>
                                    </ul>
                                    
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/components/nav.js"></script>
</body>
</html>