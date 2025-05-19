const materiales = [
    { id: 1, nombre: "Tubos Eppendorf 1.5 ml", tipo: "consumible", presentacion: "Caja", unidad: 100, clave: "TUBEPP15", cantidad: 30, idLaboratorio: 1 },
    { id: 2, nombre: "Puntas para pipeta 200 µl", tipo: "consumible", presentacion: "Caja", unidad: 1000, clave: "PIP200", cantidad: 25, idLaboratorio: 1 },
    { id: 3, nombre: "Guantes de látex", tipo: "consumible", presentacion: "Par", unidad: 100, clave: "GUANTLAT", cantidad: 40, idLaboratorio: 2 },
    { id: 4, nombre: "Batas desechables", tipo: "consumible", presentacion: "Unidad", unidad: 1, clave: "BATADES", cantidad: 50, idLaboratorio: 2 },
    { id: 5, nombre: "Gradillas para tubos", tipo: "material", presentacion: "Unidad", unidad: 1, clave: "GRADILLA", cantidad: 15, idLaboratorio: 3 },
    { id: 6, nombre: "Portaobjetos", tipo: "material", presentacion: "Caja", unidad: 50, clave: "PORTOBJ", cantidad: 20, idLaboratorio: 1 },
    { id: 7, nombre: "Cubreobjetos", tipo: "material", presentacion: "Caja", unidad: 100, clave: "CUBROBJ", cantidad: 18, idLaboratorio: 1 },
    { id: 8, nombre: "Tubos Falcon 15 ml", tipo: "consumible", presentacion: "Caja", unidad: 50, clave: "TUBFAL15", cantidad: 22, idLaboratorio: 2 },
    { id: 9, nombre: "Tubos Falcon 50 ml", tipo: "consumible", presentacion: "Caja", unidad: 25, clave: "TUBFAL50", cantidad: 18, idLaboratorio: 2 },
    { id: 10, nombre: "Placas de Petri", tipo: "consumible", presentacion: "Caja", unidad: 20, clave: "PLAPETRI", cantidad: 35, idLaboratorio: 3 },
    { id: 11, nombre: "Agar sangre", tipo: "reactivo", presentacion: "Placa", unidad: 10, clave: "AGARSANG", cantidad: 12, idLaboratorio: 2 }
];

const equipos = [
    { id: 1, nombre: "Microscopio estereoscópico", idGrupo: 1, idCategoria: 1, idSubcategoria: 1, idTipo: 3, marca: "Nikon", modelo: "SMZ745", serie: "NIK23456", color: "Blanco", precio: 18000.00, idEstadoFisico: 2, idLaboratorio: 1 },
    { id: 2, nombre: "Termociclador", idGrupo: 2, idCategoria: 2, idSubcategoria: null, idTipo: 1, marca: "Bio-Rad", modelo: "T100", serie: "BIO34567", color: "Blanco", precio: 65000.00, idEstadoFisico: 1, idLaboratorio: 1 },
    { id: 3, nombre: "Agitador magnético", idGrupo: 3, idCategoria: 3, idSubcategoria: null, idTipo: 2, marca: "IKA", modelo: "RH basic 2", serie: "IKA45678", color: "Blanco", precio: 5000.00, idEstadoFisico: 3, idLaboratorio: 2 },
    { id: 4, nombre: "pHmetro", idGrupo: 4, idCategoria: 1, idSubcategoria: null, idTipo: 4, marca: "Hanna Instruments", modelo: "HI2210", serie: "HAN56789", color: "Blanco", precio: 8000.00, idEstadoFisico: 2, idLaboratorio: 3 },
    { id: 5, nombre: "Autoclave", idGrupo: 1, idCategoria: 3, idSubcategoria: null, idTipo: 2, marca: "Tuttnauer", modelo: "2540E", serie: "TUT67890", color: "Acero", precio: 42000.00, idEstadoFisico: 1, idLaboratorio: 2 },
    { id: 6, nombre: "Campana de flujo laminar", idGrupo: 2, idCategoria: 3, idSubcategoria: null, idTipo: 2, marca: "ESCO", modelo: "LA2-4A1", serie: "ESC78901", color: "Acero", precio: 38000.00, idEstadoFisico: 2, idLaboratorio: 1 },
    { id: 7, nombre: "Baño María", idGrupo: 3, idCategoria: 3, idSubcategoria: null, idTipo: 2, marca: "Memmert", modelo: "WNE14", serie: "MEM89012", color: "Acero", precio: 12000.00, idEstadoFisico: 3, idLaboratorio: 2 },
    { id: 8, nombre: "Vortex", idGrupo: 4, idCategoria: 3, idSubcategoria: null, idTipo: 2, marca: "Scientific Industries", modelo: "G-560", serie: "SCI90123", color: "Blanco", precio: 3000.00, idEstadoFisico: 2, idLaboratorio: 3 },
    { id: 9, nombre: "Horno de secado", idGrupo: 1, idCategoria: 3, idSubcategoria: null, idTipo: 2, marca: "Binder", modelo: "ED23", serie: "BIN01234", color: "Acero", precio: 25000.00, idEstadoFisico: 1, idLaboratorio: 1 },
    { id: 10, nombre: "Microcentrífuga", idGrupo: 2, idCategoria: 3, idSubcategoria: 3, idTipo: 2, marca: "Eppendorf", modelo: "5425", serie: "EPP12345", color: "Blanco", precio: 32000.00, idEstadoFisico: 2, idLaboratorio: 1 },
    { id: 11, nombre: "Espectrofotómetro IR", idGrupo: 3, idCategoria: 2, idSubcategoria: 2, idTipo: 1, marca: "PerkinElmer", modelo: "Spectrum Two", serie: "PER23456", color: "Negro", precio: 75000.00, idEstadoFisico: 1, idLaboratorio: 2 }
];

function generarTablaMateriales() {
    const tbody = document.querySelector("#tabla-materiales tbody");
    tbody.innerHTML = "";

    materiales.forEach(material => {
        const row = document.createElement("tr");
        row.innerHTML = `
            <td>${material.id}</td>
            <td>${material.nombre}</td>
            <td>${material.tipo}</td>
            <td>${material.presentacion}</td>
            <td>${material.unidad}</td>
            <td>${material.clave}</td>
            <td>${material.cantidad}</td>
            <td>${material.idLaboratorio}</td>
        `;
        tbody.appendChild(row);
    });
}

// Función para generar las filas de la tabla de Equipos
function generarTablaEquipos() {
    const tbody = document.querySelector("#tabla-equipos tbody");
    tbody.innerHTML = "";

    equipos.forEach(equipo => {
        const row = document.createElement("tr");
        row.innerHTML = `
            <td>${equipo.id}</td>
            <td>${equipo.nombre}</td>
            <td>${equipo.idGrupo}</td>
            <td>${equipo.idCategoria}</td>
            <td>${equipo.idSubcategoria !== null ? equipo.idSubcategoria : "NULL"}</td>
            <td>${equipo.idTipo}</td>
            <td>${equipo.marca}</td>
            <td>${equipo.modelo}</td>
            <td>${equipo.serie}</td>
            <td>${equipo.color}</td>
            <td>${equipo.precio.toFixed(2)}</td>
            <td>${equipo.idEstadoFisico}</td>
            <td>${equipo.idLaboratorio}</td>
        `;
        tbody.appendChild(row);
    });
}

// Ejecutar las funciones cuando el DOM esté cargado
document.addEventListener("DOMContentLoaded", () => {
    generarTablaMateriales();
    generarTablaEquipos();
});