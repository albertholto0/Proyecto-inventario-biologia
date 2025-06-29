<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Módulo de Alumnos</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <jsp:include page="/components/nav.jsp" />

    <div class="container my-4">
        <h1 class="mb-4"><i class="bi bi-people"></i> Módulo de Alumnos</h1>
        <div class="row">
            <!-- Directorio de alumnos -->
            <div class="col-lg-7 mb-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-list-ul"></i> Directorio de Alumnos</span>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#alumnoModal">
                            <i class="bi bi-plus-circle"></i> Nuevo Alumno
                        </button>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover" id="tablaAlumnos">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Matrícula</th>
                                    <th>Correo</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Filas de alumnos dinámicas -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Historial y Reporte -->
            <div class="col-lg-5">
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="bi bi-clock-history"></i> Historial de Préstamos
                    </div>
                    <div class="card-body" id="historialPrestamos">
                        <p class="text-muted">Selecciona un alumno para ver su historial.</p>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header">
                        <i class="bi bi-bar-chart"></i> Reporte de Actividades
                    </div>
                    <div class="card-body">
                        <canvas id="reporteActividades" height="180"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Registro/Edición Alumno -->
    <div class="modal fade" id="alumnoModal" tabindex="-1" aria-labelledby="alumnoModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form class="modal-content" id="formAlumno">
                <div class="modal-header">
                    <h5 class="modal-title" id="alumnoModalLabel">Registrar Alumno</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="alumnoId">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre completo</label>
                        <input type="text" class="form-control" id="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="matricula" class="form-label">Matrícula</label>
                        <input type="text" class="form-control" id="matricula" required>
                    </div>
                    <div class="mb-3">
                        <label for="correo" class="form-label">Correo electrónico</label>
                        <input type="email" class="form-control" id="correo" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Cargar el encabezado de navegación
        document.addEventListener("DOMContentLoaded", function () {
            fetch('/components/nav.html')
                .then(response => response.text())
                .then(data => {
                    document.getElementById('main-header').innerHTML = data;
                });
        });

        // Datos simulados de alumnos y préstamos
        let alumnos = [
            { id: 1, nombre: "Ana López", matricula: "A001", correo: "ana@correo.com" },
            { id: 2, nombre: "Luis Pérez", matricula: "A002", correo: "luis@correo.com" }
        ];
        let prestamos = {
            1: [
                { fecha: "2024-06-01", item: "Libro: Matemáticas" },
                { fecha: "2024-06-10", item: "Laptop HP" }
            ],
            2: [
                { fecha: "2024-06-05", item: "Libro: Física" }
            ]
        };

        // Renderizar tabla de alumnos
        function renderAlumnos() {
            const tbody = document.querySelector("#tablaAlumnos tbody");
            tbody.innerHTML = "";
            alumnos.forEach(alumno => {
                const tr = document.createElement("tr");
                tr.innerHTML = `
                    <td>${alumno.nombre}</td>
                    <td>${alumno.matricula}</td>
                    <td>${alumno.correo}</td>
                    <td>
                        <button class="btn btn-sm btn-info me-1" onclick="editarAlumno(${alumno.id})"><i class="bi bi-pencil"></i></button>
                        <button class="btn btn-sm btn-danger" onclick="eliminarAlumno(${alumno.id})"><i class="bi bi-trash"></i></button>
                        <button class="btn btn-sm btn-secondary" onclick="verHistorial(${alumno.id})"><i class="bi bi-clock-history"></i></button>
                    </td>
                `;
                tbody.appendChild(tr);
            });
        }

        // Modal: Registrar o editar alumno
        document.getElementById("formAlumno").addEventListener("submit", function(e) {
            e.preventDefault();
            const id = document.getElementById("alumnoId").value;
            const nombre = document.getElementById("nombre").value;
            const matricula = document.getElementById("matricula").value;
            const correo = document.getElementById("correo").value;
            if (id) {
                // Editar
                const idx = alumnos.findIndex(a => a.id == id);
                if (idx > -1) {
                    alumnos[idx] = { id: Number(id), nombre, matricula, correo };
                }
            } else {
                // Nuevo
                const nuevoId = alumnos.length ? Math.max(...alumnos.map(a => a.id)) + 1 : 1;
                alumnos.push({ id: nuevoId, nombre, matricula, correo });
            }
            renderAlumnos();
            bootstrap.Modal.getInstance(document.getElementById('alumnoModal')).hide();
            this.reset();
            document.getElementById("alumnoId").value = "";
        });

        // Editar alumno
        window.editarAlumno = function(id) {
            const alumno = alumnos.find(a => a.id === id);
            if (alumno) {
                document.getElementById("alumnoId").value = alumno.id;
                document.getElementById("nombre").value = alumno.nombre;
                document.getElementById("matricula").value = alumno.matricula;
                document.getElementById("correo").value = alumno.correo;
                document.getElementById("alumnoModalLabel").textContent = "Editar Alumno";
                new bootstrap.Modal(document.getElementById('alumnoModal')).show();
            }
        };

        // Eliminar alumno
        window.eliminarAlumno = function(id) {
            if (confirm("¿Seguro que deseas eliminar este alumno?")) {
                alumnos = alumnos.filter(a => a.id !== id);
                renderAlumnos();
                document.getElementById("historialPrestamos").innerHTML = '<p class="text-muted">Selecciona un alumno para ver su historial.</p>';
            }
        };

        // Ver historial de préstamos
        window.verHistorial = function(id) {
            const alumno = alumnos.find(a => a.id === id);
            const historial = prestamos[id] || [];
            let html = `<h6>${alumno.nombre} (${alumno.matricula})</h6>`;
            if (historial.length) {
                html += '<ul class="list-group">';
                historial.forEach(p => {
                    html += `<li class="list-group-item">${p.fecha} - ${p.item}</li>`;
                });
                html += '</ul>';
            } else {
                html += '<p class="text-muted">Sin préstamos registrados.</p>';
            }
            document.getElementById("historialPrestamos").innerHTML = html;
        };

        // Reset modal al abrir para nuevo registro
        document.getElementById('alumnoModal').addEventListener('show.bs.modal', function (event) {
            if (!event.relatedTarget || event.relatedTarget.innerText.includes('Nuevo')) {
                document.getElementById("formAlumno").reset();
                document.getElementById("alumnoId").value = "";
                document.getElementById("alumnoModalLabel").textContent = "Registrar Alumno";
            }
        });

        // Reporte de actividades con Chart.js
        function renderReporte() {
            const ctx = document.getElementById('reporteActividades').getContext('2d');
            const data = {
                labels: alumnos.map(a => a.nombre),
                datasets: [{
                    label: 'Préstamos',
                    data: alumnos.map(a => (prestamos[a.id] || []).length),
                    backgroundColor: 'rgba(54, 162, 235, 0.5)'
                }]
            };
            new Chart(ctx, {
                type: 'bar',
                data: data,
                options: {
                    responsive: true,
                    plugins: { legend: { display: false } }
                }
            });
        }

        // Inicializar
        renderAlumnos();
        renderReporte();
    </script>
</body>
</html>