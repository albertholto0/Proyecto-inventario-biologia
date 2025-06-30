<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios - Laboratorio de Biología</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <jsp:include page="/components/nav.jsp" />
    
    <div class="container my-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-0 d-flex align-items-center">
                    <i class="bi bi-people-fill text-primary me-2" style="font-size: 2.2em;"></i>
                    Gestión de Usuarios
                </h2>
                <p class="text-muted mb-0">Administra los usuarios encargados de los laboratorios</p>
            </div>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">
                <i class="bi bi-plus-circle me-1"></i> Nuevo Usuario
            </button>
        </div>

        <!-- Tabla de usuarios -->
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                <span>Listado de Usuarios</span>
                <div class="input-group" style="width: 300px;">
                    <input type="text" class="form-control" placeholder="Buscar usuario..." id="buscarUsuario">
                    <button class="btn btn-light" type="button">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Usuario</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Ejemplo de datos estáticos - Reemplazar con datos dinámicos -->
                            <tr>
                                <td>1</td>
                                <td>Juan Pérez</td>
                                <td>jperez</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#modalVerUsuario" data-id="1">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarUsuario" data-id="1">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>María López</td>
                                <td>mlopez</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary me-1" data-bs-toggle="modal" data-bs-target="#modalVerUsuario" data-id="2">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarUsuario" data-id="2">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <!-- Paginación -->
                <nav class="mt-3">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Anterior</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Siguiente</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Modal Agregar Usuario -->
    <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" aria-labelledby="modalAgregarUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalAgregarUsuarioLabel">Agregar Nuevo Usuario</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <form id="formAgregarUsuario">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="nombreUsuario" class="form-label">Nombre Completo</label>
                            <input type="text" class="form-control" id="nombreUsuario" name="nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="usuario" class="form-label">Nombre de Usuario</label>
                            <input type="text" class="form-control" id="usuario" name="usuario" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password_usuario" required>
                        </div>
                        <!-- Espacio para campos adicionales -->
                        <div id="camposAdicionales"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-primary">Guardar Usuario</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Ver Usuario -->
    <div class="modal fade" id="modalVerUsuario" tabindex="-1" aria-labelledby="modalVerUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalVerUsuarioLabel">Detalles del Usuario</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body" id="detallesUsuario">
                    <!-- Contenido dinámico -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Eliminar Usuario -->
    <div class="modal fade" id="modalEliminarUsuario" tabindex="-1" aria-labelledby="modalEliminarUsuarioLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="modalEliminarUsuarioLabel">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p>¿Estás seguro que deseas eliminar este usuario? Esta acción no se puede deshacer.</p>
                    <input type="hidden" id="usuarioAEliminar">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" id="confirmarEliminar">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Ejemplo de cómo añadir campos adicionales
        function agregarCampoAdicional() {
            const camposAdicionales = document.getElementById('camposAdicionales');
            camposAdicionales.innerHTML += `
                <div class="mb-3">
                    <label for="nuevoCampo" class="form-label">Nuevo Campo</label>
                    <input type="text" class="form-control" id="nuevoCampo" name="nuevo_campo">
                </div>
            `;
        }

        // Eventos para los modales
        document.addEventListener('DOMContentLoaded', function() {
            // Modal Ver Usuario
            const modalVerUsuario = document.getElementById('modalVerUsuario');
            modalVerUsuario.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const userId = button.getAttribute('data-id');
                
                // Aquí iría una llamada AJAX para obtener los datos del usuario
                document.getElementById('detallesUsuario').innerHTML = `
                    <p><strong>ID:</strong> ${userId}</p>
                    <p><strong>Nombre:</strong> Nombre del usuario ${userId}</p>
                    <p><strong>Usuario:</strong> usuario${userId}</p>
                    <p><strong>Contraseña:</strong> ********</p>
                `;
            });

            // Modal Eliminar Usuario
            const modalEliminarUsuario = document.getElementById('modalEliminarUsuario');
            modalEliminarUsuario.addEventListener('show.bs.modal', function(event) {
                const button = event.relatedTarget;
                const userId = button.getAttribute('data-id');
                document.getElementById('usuarioAEliminar').value = userId;
            });

            // Confirmar eliminación
            document.getElementById('confirmarEliminar').addEventListener('click', function() {
                const userId = document.getElementById('usuarioAEliminar').value;
                alert(`Usuario ${userId} eliminado (implementar lógica real)`);
                $('#modalEliminarUsuario').modal('hide');
                // Aquí iría una llamada AJAX para eliminar el usuario
            });

            // Formulario Agregar Usuario
            document.getElementById('formAgregarUsuario').addEventListener('submit', function(e) {
                e.preventDefault();
                alert('Usuario agregado (implementar lógica real)');
                $('#modalAgregarUsuario').modal('hide');
                // Aquí iría una llamada AJAX para agregar el usuario
            });
        });
    </script>
    <script src="/components/nav.js"></script>
</body>
</html>