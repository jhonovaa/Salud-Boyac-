<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<%-- Guardamos el mensaje conflictivo en una variable para evitar errores de comillas en el JS --%>
<fmt:message key='cita.confirmar.cancelar.medico' var="msgConfirmMedico" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <link href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key='cita.titulo'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
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

        .table-card {
            background: var(--blanco-puro);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border-top: 4px solid var(--color-primario);
        }

        .filter-card {
            background: var(--fondo-body);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(0,0,0,0.05);
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
                <i class="fa-solid fa-calendar-check me-2"></i><fmt:message key='cita.titulo'/>
            </h4>
            <div class="d-flex gap-2">
                <c:if test="${sessionScope.usuario.rol == 'MEDICO' || sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                    <a href="${pageContext.request.contextPath}/citas?accion=exportarPdf" class="btn btn-outline-danger fw-bold rounded-pill px-4">
                        <i class="fa-solid fa-file-pdf me-1"></i> <fmt:message key='cita.descargar'/>
                    </a>
                </c:if>

                <c:if test="${sessionScope.usuario.rol != 'ENFERMERO'}">
                    <a href="${pageContext.request.contextPath}/citas?accion=nuevo" class="btn btn-saludboyaca fw-bold rounded-pill px-4">
                        <i class="fa-solid fa-plus me-1"></i> <fmt:message key='cita.nueva'/>
                    </a>
                </c:if>
            </div>
        </header>

        <div class="container-fluid px-0">

            <c:if test="${param.mensaje == 'ok'}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" style="background-color: var(--alerta-exito); color: var(--color-sena); border-radius: 15px;">
                    <i class="fa-solid fa-check-circle me-2"></i><fmt:message key='alerta.exito'/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${param.mensaje == 'estado_actualizado'}">
                <div class="alert alert-info alert-dismissible fade show border-0 shadow-sm" style="border-radius: 15px;">
                    <i class="fa-solid fa-arrows-rotate me-2"></i><fmt:message key='cita.alerta.actualizado'/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="filter-card">
                <form action="${pageContext.request.contextPath}/citas" method="GET" class="row g-3 align-items-end">
                    <input type="hidden" name="accion" value="listar"> 
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-muted small"><fmt:message key='cita.fecha'/></label>
                        <input type="date" name="fechaFiltro" class="form-control" value="${param.fechaFiltro}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-muted small"><fmt:message key='cita.estado'/></label>
                        <select name="estadoFiltro" class="form-select">
                            <option value=""><fmt:message key='cita.filtro.todos'/></option>
                            <option value="PROGRAMADA" ${param.estadoFiltro == 'PROGRAMADA' ? 'selected' : ''}><fmt:message key='cita.estado.programada'/></option>
                            <option value="CONFIRMADA" ${param.estadoFiltro == 'CONFIRMADA' ? 'selected' : ''}><fmt:message key='cita.estado.confirmada'/></option>
                            <option value="ATENDIDA" ${param.estadoFiltro == 'ATENDIDA' ? 'selected' : ''}><fmt:message key='cita.estado.atendida'/></option>
                            <option value="CANCELADA" ${param.estadoFiltro == 'CANCELADA' ? 'selected' : ''}><fmt:message key='cita.estado.cancelada'/></option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-secondary w-100 fw-bold">
                            <i class="fa-solid fa-filter me-2"></i><fmt:message key='cita.btn.buscar'/>
                        </button>
                    </div>
                </form>
            </div>

            <div class="table-card">
                <div class="table-responsive">
                    <table id="tablaCitas" class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th><fmt:message key='cita.fecha'/></th>
                                <th><fmt:message key='cita.hora'/></th>
                                <th><fmt:message key='cita.paciente'/></th>
                                <th><fmt:message key='cita.medico'/></th>
                                <th><fmt:message key='cita.especialidad'/></th>
                                <th class="text-center"><fmt:message key='cita.estado'/></th>
                                <th class="text-center"><fmt:message key='cita.acciones'/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${citas}">
                                <tr>
                                    <td class="fw-bold">${c.fechaCita}</td>
                                    <td>${c.horaCita}</td>
                                    <td>
                                        <strong>${c.pacienteNombre}</strong><br>
                                        <small class="text-muted"><fmt:message key='cita.cc'/>: ${c.pacienteDocumento}</small>
                                    </td>
                                    <td>${c.medicoNombre}</td>
                                    <td><span class="badge bg-light text-dark border">${c.especialidadNombre}</span></td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${c.estado == 'PROGRAMADA'}">
                                                <span class="badge badge-estado-programada" style="background-color: var(--estado-programada);"><fmt:message key='cita.estado.programada'/></span>
                                            </c:when>
                                            <c:when test="${c.estado == 'CONFIRMADA'}">
                                                <span class="badge badge-estado-confirmada" style="background-color: var(--estado-confirmada);"><fmt:message key='cita.estado.confirmada'/></span>
                                            </c:when>
                                            <c:when test="${c.estado == 'ATENDIDA'}">
                                                <span class="badge badge-estado-atendida" style="background-color: var(--estado-atendida);"><fmt:message key='cita.estado.atendida'/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-estado-cancelada" style="background-color: var(--estado-cancelada);"><fmt:message key='cita.estado.cancelada'/></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm shadow-sm">
                                            
                                            <!-- Boton de detalle Modal -->
                                            <button type="button" class="btn btn-outline-info" title="<fmt:message key='cita.ver.detalle'/>" data-bs-toggle="modal" data-bs-target="#modalDetalle${c.id}" style="border-radius: 4px 0 0 4px;">
                                                <i class="fa-solid fa-eye"></i>
                                            </button>

                                            <!-- Acciones restringidas (Excluye al enfermero) -->
                                            <c:if test="${sessionScope.usuario.rol != 'ENFERMERO'}">
                                                
                                                <!-- Exportar PDF individual -->
                                                <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA' || sessionScope.usuario.rol == 'MEDICO'}">
                                                   <a href="${pageContext.request.contextPath}/pdf?id=${c.id}" class="btn btn-outline-primary" target="_blank" title="<fmt:message key='cita.descargar'/>" style="border-radius: 0;">
                                                        <i class="fa-solid fa-file-pdf"></i>
                                                    </a>
                                                </c:if>

                                                <!-- Boton de Reprogramar (SOLO para Recepcionista) -->
                                                <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                                                    <a href="${pageContext.request.contextPath}/citas?accion=editar&id=${c.id}" class="btn btn-outline-warning" title="<fmt:message key='cita.reprogramar'/>" style="border-radius: 0;">
                                                        <i class="fa-solid fa-calendar-day"></i>
                                                    </a>
                                                </c:if>
                                                
                                                <!-- BOTON ACTIVAR CITA (SOLO RECEPCIONISTA cuando esta PROGRAMADA) -->
                                                <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA' && c.estado == 'PROGRAMADA'}">
                                                    <form action="${pageContext.request.contextPath}/citas" method="POST" class="d-inline m-0 p-0">
                                                        <input type="hidden" name="accion" value="cambiarEstado">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <input type="hidden" name="estado" value="CONFIRMADA">
                                                        <button type="submit" class="btn btn-outline-success" title="<fmt:message key='cita.activar'/>" style="border-radius: 0;">
                                                            <i class="fa-solid fa-volume-high"></i>
                                                        </button>
                                                    </form>
                                                </c:if>

                                                <!-- BOTON ATENDER CITA (SOLO MEDICO cuando ya fue activada/CONFIRMADA) -->
                                                <c:if test="${sessionScope.usuario.rol == 'MEDICO' && c.estado == 'CONFIRMADA'}">
                                                    <form action="${pageContext.request.contextPath}/citas" method="POST" class="d-inline m-0 p-0">
                                                        <input type="hidden" name="accion" value="cambiarEstado">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <input type="hidden" name="estado" value="ATENDIDA">
                                                        <button type="submit" class="btn btn-outline-primary" title="<fmt:message key='cita.marcar.atendida'/>" style="border-radius: 0; border-color: var(--acento-celeste); color: var(--acento-celeste);">
                                                            <i class="fa-solid fa-stethoscope"></i>
                                                        </button>
                                                    </form>
                                                </c:if>

                                                <!-- BOTON CANCELAR (Logica mixta) -->
                                                <c:if test="${c.estado != 'CANCELADA' && c.estado != 'ATENDIDA'}">
                                                    <form action="${pageContext.request.contextPath}/citas" method="POST" class="d-inline m-0 p-0">
                                                        <input type="hidden" name="accion" value="cambiarEstado">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <input type="hidden" name="estado" value="CANCELADA">
                                                        
                                                        <c:choose>
                                                            <c:when test="${sessionScope.usuario.rol == 'MEDICO'}">
                                                                <!-- Usamos la variable msgConfirmMedico definida al inicio del archivo -->
                                                                <button type="submit" class="btn btn-outline-danger" title="<fmt:message key='cita.cancelar'/>" style="border-radius: 0 4px 4px 0;" onclick="return confirm('${msgConfirmMedico}');">
                                                                    <i class="fa-solid fa-ban"></i>
                                                                </button>
                                                            </c:when>
                                                            <c:when test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                                                                <button type="button" class="btn btn-outline-danger btn-cancelar-recepcionista" title="<fmt:message key='cita.cancelar.inasistencia'/>" data-fecha="${c.fechaCita}" data-hora="${c.horaCita}" style="border-radius: 0 4px 4px 0;">
                                                                    <i class="fa-solid fa-user-xmark"></i>
                                                                </button>
                                                            </c:when>
                                                        </c:choose>
                                                    </form>
                                                </c:if>

                                            </c:if>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Ventana Flotante (Modal) de Detalle - ESTILO APPLE/iOS -->
                                <div class="modal fade" id="modalDetalle${c.id}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content border-0" style="border-radius: 24px; box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);">
                                            
                                            <div class="modal-header border-0 pb-0 pt-4 px-4 position-relative justify-content-center">
                                                <h5 class="modal-title fw-bold" style="color: var(--texto-titulos);"><fmt:message key='cita.detalle.titulo'/></h5>
                                                <button type="button" class="btn-close position-absolute end-0 me-4 bg-light rounded-circle p-2 shadow-sm" data-bs-dismiss="modal" aria-label="<fmt:message key='cita.btn.cerrar'/>" style="font-size: 0.7rem;"></button>
                                            </div>

                                            <div class="modal-body p-4">
                                                <!-- Fecha y Hora -->
                                                <div class="d-flex justify-content-between align-items-center mb-3 p-3 shadow-sm" style="background-color: #f5f5f7; border-radius: 16px;">
                                                    <div class="d-flex align-items-center">
                                                        <div class="bg-white rounded-circle d-flex align-items-center justify-content-center shadow-sm me-3" style="width: 48px; height: 48px; color: var(--acento-celeste);">
                                                            <i class="fa-regular fa-calendar-days fs-5"></i>
                                                        </div>
                                                        <div>
                                                            <small class="text-muted fw-bold text-uppercase d-block" style="font-size: 0.7rem;"><fmt:message key='cita.fecha'/></small>
                                                            <span class="fs-5 fw-bold text-dark">${c.fechaCita}</span>
                                                        </div>
                                                    </div>
                                                    <div class="text-end border-start ps-3 border-secondary border-opacity-10">
                                                        <small class="text-muted fw-bold text-uppercase d-block" style="font-size: 0.7rem;"><fmt:message key='cita.hora'/></small>
                                                        <span class="fs-5 fw-bold text-dark">${c.horaCita}</span>
                                                    </div>
                                                </div>

                                                <!-- Participantes -->
                                                <div class="mb-3 p-3 shadow-sm" style="background-color: #f5f5f7; border-radius: 16px;">
                                                    <div class="d-flex align-items-center mb-3 pb-3 border-bottom border-secondary border-opacity-10">
                                                        <div class="bg-white rounded-circle d-flex align-items-center justify-content-center shadow-sm me-3" style="width: 40px; height: 40px; color: var(--texto-titulos);">
                                                            <i class="fa-solid fa-user"></i>
                                                        </div>
                                                        <div>
                                                            <small class="text-muted fw-bold text-uppercase d-block" style="font-size: 0.7rem;"><fmt:message key='cita.paciente'/></small>
                                                            <div class="fw-bold text-dark fs-6">${c.pacienteNombre}</div>
                                                            <div class="text-muted small" style="font-size: 0.8rem;"><fmt:message key='cita.cc'/>: ${c.pacienteDocumento}</div>
                                                        </div>
                                                    </div>
                                                    <div class="d-flex align-items-center">
                                                        <div class="bg-white rounded-circle d-flex align-items-center justify-content-center shadow-sm me-3" style="width: 40px; height: 40px; color: var(--acento-celeste);">
                                                            <i class="fa-solid fa-user-doctor"></i>
                                                        </div>
                                                        <div>
                                                            <small class="text-muted fw-bold text-uppercase d-block" style="font-size: 0.7rem;"><fmt:message key='cita.medico.tratante'/></small>
                                                            <div class="fw-bold text-dark fs-6">${c.medicoNombre}</div>
                                                            <div class="badge bg-white text-dark border mt-1 fw-medium">${c.especialidadNombre}</div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Motivo -->
                                                <div class="mb-4 p-3 shadow-sm" style="background-color: #f5f5f7; border-radius: 16px;">
                                                    <small class="text-muted fw-bold text-uppercase d-block mb-2" style="font-size: 0.7rem;"><i class="fa-solid fa-comment-medical me-1"></i> <fmt:message key='cita.motivo'/></small>
                                                    <p class="mb-0 text-dark" style="font-size: 0.95rem; line-height: 1.5;">
                                                        <c:choose>
                                                            <c:when test="${empty c.motivo}"><fmt:message key='cita.sin.motivo'/></c:when>
                                                            <c:otherwise>${c.motivo}</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>

                                                <!-- Estado -->
                                                <div class="text-center p-3 shadow-sm" style="background-color: #f5f5f7; border-radius: 16px;">
                                                    <small class="text-muted fw-bold text-uppercase d-block mb-2" style="font-size: 0.7rem;"><fmt:message key='cita.estado.actual'/></small>
                                                    <c:choose>
                                                        <c:when test="${c.estado == 'PROGRAMADA'}">
                                                            <span class="badge fs-6 px-4 py-2 rounded-pill shadow-sm" style="background-color: var(--estado-programada); color: white;"><fmt:message key='cita.estado.programada'/></span>
                                                        </c:when>
                                                        <c:when test="${c.estado == 'CONFIRMADA'}">
                                                            <span class="badge fs-6 px-4 py-2 rounded-pill shadow-sm" style="background-color: var(--estado-confirmada); color: white;"><fmt:message key='cita.estado.confirmada'/></span>
                                                        </c:when>
                                                        <c:when test="${c.estado == 'ATENDIDA'}">
                                                            <span class="badge fs-6 px-4 py-2 rounded-pill shadow-sm" style="background-color: var(--estado-atendida); color: white;"><fmt:message key='cita.estado.atendida'/></span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge fs-6 px-4 py-2 rounded-pill shadow-sm" style="background-color: var(--estado-cancelada); color: white;"><fmt:message key='cita.estado.cancelada'/></span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="modal-footer border-0 pt-0 pb-4 px-4 justify-content-center">
                                                <button type="button" class="btn btn-secondary fw-bold rounded-pill w-100 py-2 shadow-sm" data-bs-dismiss="modal" style="background-color: #e5e5ea; color: #1c1c1e; border: none; font-size: 1.05rem;"><fmt:message key='cita.btn.cerrar'/></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Fin de la ventana flotante -->

                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#tablaCitas').DataTable({
                "pageLength": 10,
                "ordering": true,
                "responsive": true,
                "language": {
                    "sEmptyTable":     "<fmt:message key='dt.vacio'/>",
                    "sInfo":           "<fmt:message key='dt.info'/>",
                    "sInfoEmpty":      "<fmt:message key='dt.info.vacio'/>",
                    "sInfoFiltered":   "<fmt:message key='dt.info.filtro'/>",
                    "sLengthMenu":     "<fmt:message key='dt.menu'/>",
                    "sLoadingRecords": "<fmt:message key='dt.cargando'/>",
                    "sProcessing":     "<fmt:message key='dt.procesando'/>",
                    "sSearch":         "<fmt:message key='dt.buscar'/>",
                    "sZeroRecords":    "<fmt:message key='dt.cero'/>",
                    "oPaginate": {
                        "sFirst":    "<fmt:message key='dt.pag.primero'/>",
                        "sLast":     "<fmt:message key='dt.pag.ultimo'/>",
                        "sNext":     "<fmt:message key='dt.pag.siguiente'/>",
                        "sPrevious": "<fmt:message key='dt.pag.anterior'/>"
                    }
                }
            });

            // LOGICA DE LOS 10 MINUTOS DE GRACIA PARA LA RECEPCIONISTA
            // Inyectamos las traducciones en variables JS
            const msgGraciaAlto = "<fmt:message key='cita.js.gracia.alto'/>";
            const msgGraciaConfirmar = "<fmt:message key='cita.js.gracia.confirmar'/>";

            $(document).on('click', '.btn-cancelar-recepcionista', function(e) {
                e.preventDefault(); 
                
                let fechaStr = $(this).data('fecha'); 
                let horaStr = $(this).data('hora');   
                
                let citaDate = new Date(fechaStr + 'T' + horaStr);
                let ahora = new Date();
                
                let diffMs = ahora - citaDate;
                let diffMins = Math.floor(diffMs / 60000);
                
                if (diffMins < 10) {
                    alert(msgGraciaAlto);
                } else {
                    if(confirm(msgGraciaConfirmar)) {
                        $(this).closest('form').submit();
                    }
                }
            });
        });
    </script>
</body>
</html>