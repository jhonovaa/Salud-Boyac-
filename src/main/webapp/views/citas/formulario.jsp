<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty cita}"><fmt:message key='cita.form.editar.titulo'/></c:when>
            <c:otherwise><fmt:message key='cita.form.programar.titulo'/></c:otherwise>
        </c:choose>
    </title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        .main-wrapper {
            margin-left: 295px;
            padding: 2rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .form-card {
            background: var(--blanco-puro);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border-top: 4px solid var(--color-primario);
        }
        .form-select, .form-control {
            border-radius: 8px;
            padding: 0.6rem 1rem;
        }
        @media (max-width: 992px) {
            .main-wrapper {
                margin-left: 0;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    
    <jsp:include page="/views/templates/sidebar.jsp" />

    <div class="main-wrapper">
        <div class="form-card">
            <form action="${pageContext.request.contextPath}/citas" method="POST">
                <input type="hidden" name="accion" value="${not empty cita ? 'actualizar' : 'insertar'}">
                
                <c:if test="${not empty cita}">
                    <input type="hidden" name="id" value="${cita.id}">
                </c:if>

                <div class="row g-4 mb-4">
                    <!-- Columna Izquierda -->
                    <div class="col-md-6">
                        <div class="mb-4">
                            <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.paciente'/></label>
                            <select name="idPaciente" id="idPaciente" class="form-select border-secondary border-opacity-25" required>
                                <option value=""><fmt:message key='cita.form.seleccione.paciente'/></option>
                                <c:forEach var="p" items="${pacientes}">
                                    <option value="${p.id}" ${not empty cita && cita.idPaciente == p.id ? 'selected' : ''}>
                                        ${p.documento} - ${p.nombres} ${p.apellidos}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.especialidad'/></label>
                            <select name="idEspecialidad" id="idEspecialidad" class="form-select border-secondary border-opacity-25" required>
                                <option value=""><fmt:message key='cita.seleccione.especialidad'/></option>
                                <c:forEach var="e" items="${especialidades}">
                                    <option value="${e.id}" ${not empty cita && cita.idEspecialidad == e.id ? 'selected' : ''}>
                                        ${e.nombre}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.medico'/></label>
                            <select name="idMedico" id="idMedico" class="form-select border-secondary border-opacity-25 bg-light" required disabled>
                                <option value=""><fmt:message key='cita.primero.especialidad'/></option>
                            </select>
                            <!-- Input oculto para preseleccionar medico en modo Edicion -->
                            <input type="hidden" id="medicoActual" value="${not empty cita ? cita.idMedico : ''}">
                        </div>
                    </div>

                    <!-- Columna Derecha -->
                    <div class="col-md-6">
                        <div class="mb-4">
                            <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.fecha'/></label>
                            <input type="date" name="fechaCita" id="fechaCita" class="form-control border-secondary border-opacity-25" value="${not empty cita ? cita.fechaCita : ''}" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.hora'/></label>
                            <select name="horaCita" id="horaCita" class="form-select border-secondary border-opacity-25 bg-light" required disabled>
                                <option value=""><fmt:message key='cita.seleccione.medico.fecha'/></option>
                            </select>
                            <!-- Input oculto para preseleccionar hora en modo Edicion -->
                            <input type="hidden" id="horaActual" value="${not empty cita ? cita.horaCita : ''}">
                        </div>
                    </div>
                </div>

                <!-- Fila Completa -->
                <div class="row mb-4">
                    <div class="col-12">
                        <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.motivo'/></label>
                        <textarea name="motivo" class="form-control border-secondary border-opacity-25" rows="4" placeholder="<fmt:message key='cita.motivo.placeholder'/>">${not empty cita ? cita.motivo : ''}</textarea>
                    </div>
                </div>

                <hr class="mb-4" style="opacity: 0.1;">

                <div class="text-end">
                    <a href="${pageContext.request.contextPath}/citas" class="btn btn-secondary px-4 py-2 fw-bold" style="border-radius: 8px;">
                        <fmt:message key='cita.cancelar.btn'/>
                    </a>
                    <button type="submit" class="btn btn-saludboyaca ms-2 px-4 py-2 fw-bold" style="border-radius: 8px;">
                        <i class="fa-solid fa-calendar-check me-2"></i><fmt:message key='cita.programar'/>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function() {
            const ctx = '${pageContext.request.contextPath}';
            const espSelect = $('#idEspecialidad');
            const medSelect = $('#idMedico');
            const fecInput = $('#fechaCita');
            const horSelect = $('#horaCita');
            
            const medicoActual = $('#medicoActual').val();
            const horaActual = $('#horaActual').val();

            // Variables de internacionalizacion
            const msgCargandoMedicos = "<fmt:message key='cita.js.cargando.medicos'/>";
            const msgEsperandoMedico = "<fmt:message key='cita.js.esperando.medico'/>";
            const msgPrimeroEspecialidad = "<fmt:message key='cita.primero.especialidad'/>";
            const msgSeleccioneMedico = "<fmt:message key='cita.js.seleccione.medico'/>";
            const msgSinMedicos = "<fmt:message key='cita.js.sin.medicos'/>";
            const msgErrorMedicos = "<fmt:message key='cita.js.error.medicos.servidor'/>";
            const msgEsperandoFechaMedico = "<fmt:message key='cita.seleccione.medico.fecha'/>";
            const msgBuscandoDisponibilidad = "<fmt:message key='cita.js.buscando.disponibilidad'/>";
            const msgSinHorarios = "<fmt:message key='cita.js.sin.horarios'/>";
            const msgSeleccioneHora = "<fmt:message key='cita.js.seleccione.hora'/>";
            const msgErrorConexion = "<fmt:message key='cita.js.error.conexion'/>";
            const msgDr = "<fmt:message key='cita.js.dr'/>";

            // 1. CARGAR MEDICOS
            function cargarMedicos(idEspecialidad, cb) {
                medSelect.html('<option value="">' + msgCargandoMedicos + '</option>').prop('disabled', true).addClass('bg-light');
                horSelect.html('<option value="">' + msgEsperandoMedico + '</option>').prop('disabled', true).addClass('bg-light');

                if (!idEspecialidad) {
                    medSelect.html('<option value="">' + msgPrimeroEspecialidad + '</option>');
                    return;
                }

                $.ajax({
                    url: ctx + '/citas?accion=cargarMedicos',
                    type: 'GET',
                    data: { idEspecialidad: idEspecialidad },
                    dataType: 'json',
                    success: function(data) {
                        medSelect.empty().append('<option value="">' + msgSeleccioneMedico + '</option>');
                        if(data.length === 0) {
                            medSelect.append('<option value="" disabled>' + msgSinMedicos + '</option>');
                        } else {
                            $.each(data, function(i, m) {
                                let sel = (medicoActual == m.id) ? 'selected' : '';
                                medSelect.append('<option value="'+m.id+'" '+sel+'>' + msgDr + ' '+m.nombre+'</option>');
                            });
                            medSelect.prop('disabled', false).removeClass('bg-light');
                            if(cb) cb(); 
                        }
                    },
                    error: function() {
                        alert(msgErrorMedicos);
                    }
                });
            }

            // 2. CARGAR HORARIOS
            function cargarHorarios() {
                let idMed = medSelect.val();
                let fecCita = fecInput.val();

                if (!idMed || !fecCita) {
                    horSelect.html('<option value="">' + msgEsperandoFechaMedico + '</option>').prop('disabled', true).addClass('bg-light');
                    return;
                }

                horSelect.html('<option value="">' + msgBuscandoDisponibilidad + '</option>').prop('disabled', true).addClass('bg-light');

                $.ajax({
                    url: ctx + '/citas?accion=cargarHorarios',
                    type: 'GET',
                    data: { idMedico: idMed, fechaCita: fecCita },
                    dataType: 'json',
                    success: function(data) {
                        horSelect.empty();
                        if(data.length === 0) {
                            horSelect.append('<option value="" disabled selected>' + msgSinHorarios + '</option>');
                            horSelect.prop('disabled', true).addClass('bg-light');
                        } else {
                            horSelect.append('<option value="">' + msgSeleccioneHora + '</option>');
                            $.each(data, function(i, h) {
                                let horaLimpia = h.substring(0, 5); 
                                let currentLimpia = horaActual ? horaActual.substring(0, 5) : '';
                                let sel = (currentLimpia === horaLimpia) ? 'selected' : '';
                                horSelect.append('<option value="'+horaLimpia+'" '+sel+'>'+horaLimpia+'</option>');
                            });
                            horSelect.prop('disabled', false).removeClass('bg-light');
                        }
                    },
                    error: function() {
                        horSelect.html('<option value="" disabled>' + msgErrorConexion + '</option>');
                    }
                });
            }

            // EVENTOS (Aqui estaba la magia faltante)
            espSelect.change(function() {
                cargarMedicos($(this).val());
            });

            fecInput.change(cargarHorarios);
            medSelect.change(cargarHorarios);

            // AUTO-CARGA AL ABRIR EL FORMULARIO (Util para modo Edicion)
            if (espSelect.val() !== '') {
                cargarMedicos(espSelect.val(), function() {
                    if (fecInput.val() !== '') {
                        cargarHorarios();
                    }
                });
            }
        });
    </script>
</body>
</html>