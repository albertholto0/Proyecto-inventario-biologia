<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="bg-success text-white py-2 shadow-sm mb-4">
    <div class="container d-flex flex-column flex-lg-row align-items-center justify-content-between">
        <div class="d-flex align-items-center mb-2 mb-lg-0">
            <img src="${pageContext.request.contextPath}/assets/logo_unsij.png" alt="Logo UNSiJ">
            <span class="h4 mb-0 fw-semibold ms-3">Gestión de Laboratorio de Biología</span>
        </div>
        <nav class="navbar navbar-expand-lg navbar-success p-0">
            <button class="navbar-toggler ms-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse ms-lg-3" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link text-white fw-semibold"
                            href="${pageContext.request.contextPath}/pages/equipos.jsp">Equipos</a></li>
                    <li class="nav-item"><a class="nav-link text-white fw-semibold"
                            href="${pageContext.request.contextPath}/pages/materiales.jsp">Materiales</a></li>
                    <li class="nav-item"><a class="nav-link text-white fw-semibold"
                            href="${pageContext.request.contextPath}/pages/prestamos.jsp">Préstamos</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link text-white fw-semibold dropdown-toggle" href="#" id="otrosDropdown"
                            role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Otros
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="otrosDropdown">
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/pages/alumnos.jsp">
                                    <i class="bi bi-people-fill text-primary me-2"></i> Alumnos
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/pages/alertas/alertas.jsp">
                                    <i class="bi bi-exclamation-triangle-fill text-danger me-2"></i> Alertas
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/pages/laboratorios.jsp">
                                    <i class="bi bi-building-gear text-primary me-2"></i> Laboratorios
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/pages/usuarios.jsp">
                                    <i class="bi bi-people-fill text-secondary me-2"></i> Usuarios
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center text-danger" href="${pageContext.request.contextPath}/pages/login.jsp">
                                    <i class="bi bi-box-arrow-right me-2"></i> Cerrar sesión
                                </a>
                            </li>
                            <li>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</header>