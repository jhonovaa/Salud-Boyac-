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
    <title><fmt:message key='cita.nueva'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" rel="stylesheet" />
    
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        /* Ajuste Dinamico para la Sidebar */
        .main-wrapper {
            margin-left: 295px;
            padding: 2rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .top-navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--acento-celeste);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .form-card {
            background: var(--blanco-puro);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border-top: 4px solid var(--color-primario);
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
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <h4 class="fw-bold mb-0" style="color: var(--texto-titulos);">
                <i class="fa-solid fa-calendar-plus me-2"></i><fmt:message key='cita.nueva'/>
            </h4>
            <a href="${pageContext.request.contextPath}/citas" class="btn btn-outline-secondary fw-bold rounded-pill px-4">
                <i class="fa-solid fa-arrow-left me-1"></i> <fmt:message key='cita.volver'/>
            </a>
        </header>

        <div class="container-fluid px-0">
            
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/citas" method="POST" id="formNuevaCita">
                    <input type="hidden" name="accion" value="insertar">
                    
                    <div class="row g-4 mb-4">
                        <div class="col-md-6">
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.paciente'/></label>
                                <select name="idPaciente" id="idPaciente" class="form-select select2-paciente" required>
                                    <option value=""><fmt:message key='cita.buscar.paciente'/></option>
                                    <c:forEach var="p" items="${pacientes}">
                                        <option value="${p.id}">${p.documento} - ${p.nombres} ${p.apellidos}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.especialidad'/></label>
                                <select name="idEspecialidad" id="idEspecialidad" class="form-select" required>
                                    <option value=""><fmt:message key='cita.seleccione.especialidad'/></option>
                                    <c:forEach var="e" items="${especialidades}">
                                        <option value="${e.id}">${e.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.medico'/></label>
                                <select name="idMedico" id="idMedico" class="form-select" required disabled>
                                    <option value=""><fmt:message key='cita.primero.especialidad'/></option>
                                </select>
                            </div>

                        </div>

                        <div class="col-md-6">
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.fecha'/></label>
                                <input type="date" name="fechaCita" id="fechaCita" class="form-control" required>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.hora'/></label>
                                <select name="horaCita" id="horaCita" class="form-select" required disabled>
                                    <option value=""><fmt:message key='cita.seleccione.medico.fecha'/></option>
                                </select>
                            </div>

                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-12">
                            <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='cita.motivo'/></label>
                            <textarea name="motivo" class="form-control" rows="3" placeholder="<fmt:message key='cita.motivo.placeholder'/>" required></textarea>
                        </div>
                    </div>

                    <hr class="mb-4" style="opacity: 0.1;">

                    <div class="text-end">
                        <a href="${pageContext.request.contextPath}/citas" class="btn btn-secondary px-4 py-2 fw-bold" style="border-radius: 12px;">
                            <fmt:message key='cita.cancelar.btn'/>
                        </a>
                        <button type="submit" class="btn btn-saludboyaca ms-2 px-4 py-2 fw-bold" style="border-radius: 12px;">
                            <i class="fa-solid fa-calendar-check me-2"></i><fmt:message key='cita.programar'/>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // 1. Inicializar Select2 para busqueda de Pacientes
            $('.select2-paciente').select2({
                theme: 'bootstrap-5',
                placeholder: '<fmt:message key="cita.js.buscar.paciente"/>',
                width: '100%'
            });

            // 2. Logica AJAX: Especialidad -> Cargar Medicos
            $('#idEspecialidad').change(function() {
                const especialidadId = $(this).val();
                const medicoSelect = $('#idMedico');
                
                // Reiniciar campos dependientes
                medicoSelect.html('<option value=""><fmt:message key="cita.js.cargando.medicos"/></option>').prop('disabled', true);
                $('#horaCita').html('<option value=""><fmt:message key="cita.seleccione.medico.fecha"/></option>').prop('disabled', true);

                if (especialidadId) {
                    fetch('${pageContext.request.contextPath}/citas?accion=cargarMedicos&idEspecialidad=' + especialidadId)
                        .then(response => response.json())
                        .then(data => {
                            medicoSelect.html('<option value=""><fmt:message key="cita.js.seleccione.medico"/></option>');
                            data.forEach(medico => {
                                medicoSelect.append('<option value="' + medico.id + '"><fmt:message key="cita.js.dr"/> ' + medico.nombre + '</option>');
                            });
                            medicoSelect.prop('disabled', false);
                        })
                        .catch(error => {
                            console.error('Error cargando medicos:', error);
                            medicoSelect.html('<option value=""><fmt:message key="cita.js.error.medicos"/></option>');
                        });
                } else {
                    medicoSelect.html('<option value=""><fmt:message key="cita.primero.especialidad"/></option>');
                }
            });

            // 3. Logica AJAX: Medico + Fecha -> Cargar Horas Disponibles
            $('#idMedico, #fechaCita').change(function() {
                const medicoId = $('#idMedico').val();
                const fecha = $('#fechaCita').val();
                const horaSelect = $('#horaCita');

                if (medicoId && fecha) {
                    horaSelect.html('<option value=""><fmt:message key="cita.js.buscando.disponibilidad"/></option>').prop('disabled', true);

                    fetch('${pageContext.request.contextPath}/citas?accion=cargarHorarios&idMedico=' + medicoId + '&fecha=' + fecha)
                        .then(response => response.json())
                        .then(data => {
                            if (data.length > 0) {
                                horaSelect.html('<option value=""><fmt:message key="cita.js.seleccione.hora"/></option>');
                                data.forEach(hora => {
                                    horaSelect.append('<option value="' + hora + '">' + hora + '</option>');
                                });
                                horaSelect.prop('disabled', false);
                            } else {
                                horaSelect.html('<option value=""><fmt:message key="cita.js.sin.horarios"/></option>');
                            }
                        })
                        .catch(error => {
                            console.error('Error cargando horarios:', error);
                            horaSelect.html('<option value=""><fmt:message key="cita.js.error.horas"/></option>');
                        });
                }
            });
        });
    </script>
</body>
</html>