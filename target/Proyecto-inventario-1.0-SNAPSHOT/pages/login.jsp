<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Inventario</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    </head>
    <style>
        body {
            background-image: url('../assets/inicio_sesion_fondo.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
    <body>
        <div class="container login-container d-flex align-items-center justify-content-center">
            <div class="row w-100 justify-content-center align-items-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-10 col-md-6 col-lg-5">
                    <div class="p-5 login-card shadow-lg">
                        <div class="text-center mb-3">
                            <i class="bi bi-box-seam text-primary" style="font-size: 4rem;"></i>
                        </div>
                        <h2 class="mb-4 text-center">Iniciar sesión</h2>
                        <%-- Mostrar alerta de error si existe --%>
                        <% if (request.getParameter("error") != null) { %>
                        <div class="alert alert-danger mb-4">
                            Usuario o contraseña incorrectos
                        </div>
                        <% }%>
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="usuario" class="form-label">Usuario</label>
                                <input type="text" class="form-control" id="usuario" name="usuario" required>
                            </div>
                            <div class="mb-3">
                                <label for="contrasena" class="form-label">Contraseña</label>
                                <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Entrar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>