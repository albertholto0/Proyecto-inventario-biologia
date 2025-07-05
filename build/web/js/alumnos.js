
document.getElementById('grupoFiltro').addEventListener('change', function () {
    const grupo = this.value;
    const carreraField = document.getElementById('carreraFiltro');

    switch (grupo) {
        case '1':
            carreraField.value = 'Biología';
            break;
        case '2':
            carreraField.value = 'Biología Marina';
            break;
        case '3':
            carreraField.value = 'Bioquímica';
            break;
        case '4':
            carreraField.value = 'Biotecnología';
            break;
        default:
            carreraField.value = '';
    }
});

document.getElementById('modalGrupo').addEventListener('change', function () {
    const grupo = this.value;
    const modalCarreraField = document.getElementById('modalCarrera');

    switch (grupo) {
        case '1':
            modalCarreraField.value = 'Biología';
            break;
        case '2':
            modalCarreraField.value = 'Biología Marina';
            break;
        case '3':
            modalCarreraField.value = 'Bioquímica';
            break;
        case '4':
            modalCarreraField.value = 'Biotecnología';
            break;
        default:
            modalCarreraField.value = '';
    }
});

function limpiarFormulario() {
    document.getElementById('idAlumno').value = '';
    document.getElementById('nombreCompleto').value = '';
    document.getElementById('correo').value = '';
    document.getElementById('matricula').value = '';
    document.getElementById('modalGrupo').value = '1';
    document.getElementById('modalCarrera').value = 'Biología';
}

function mostrarDetalle(nombre, correo, matricula, grupo, carrera) {
    document.getElementById('detalleNombre').textContent = nombre;
    document.getElementById('detalleCorreo').textContent = correo;
    document.getElementById('detalleMatricula').textContent = matricula;
    document.getElementById('detalleGrupo').textContent = grupo;
    document.getElementById('detalleCarrera').textContent = carrera;
}

function cargarDatosAlumno(id, nombre, correo, matricula, grupo, carrera) {
    document.getElementById('idAlumno').value = id;
    document.getElementById('nombreCompleto').value = nombre;
    document.getElementById('correo').value = correo;
    document.getElementById('matricula').value = matricula;
    const modalGrupoSelect = document.getElementById('modalGrupo');
    modalGrupoSelect.value = grupo;
    modalGrupoSelect.dispatchEvent(new Event('change'));
    document.getElementById('modalCarrera').value = carrera;
}