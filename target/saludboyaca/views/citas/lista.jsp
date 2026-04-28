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
    <title><fmt:message key='cita.titulo'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        /* Ajuste Dinámico para la Sidebar */
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
                        <i class="fa-solid fa-file-pdf me-1"></i> Exportar PDF
                    </a>
                </c:if>

                <a href="${pageContext.request.contextPath}/citas?accion=nuevo" class="btn btn-saludboyaca fw-bold rounded-pill px-4">
                    <i class="fa-solid fa-plus me-1"></i> <fmt:message key='cita.nueva'/>
                </a>
            </div>
        </header>

        <div class="container-fluid px-0">

            <c:if test="${param.mensaje == 'ok'}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" style="background-color: var(--alerta-exito); color: var(--color-sena); border-radius: 15px;">
                    <i class="fa-solid fa-check-circle me-2"></i><fmt:message key='alerta.exito'/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="filter-card">
                <form action="${pageContext.request.contextPath}/citas" method="GET" class="row g-3 align-items-end">
                    <input type="hidden" name="accion" value="listar"> 
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-muted small">Filtrar por Fecha</label>
                        <input type="date" name="fechaFiltro" class="form-control" value="${param.fechaFiltro}">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-bold text-muted small">Estado de Cita</label>
                        <select name="estadoFiltro" class="form-select">
                            <option value="">Todos los estados...</option>
                            <option value="PROGRAMADA" ${param.estadoFiltro == 'PROGRAMADA' ? 'selected' : ''}>Programada</option>
                            <option value="CONFIRMADA" ${param.estadoFiltro == 'CONFIRMADA' ? 'selected' : ''}>Confirmada</option>
                            <option value="ATENDIDA" ${param.estadoFiltro == 'ATENDIDA' ? 'selected' : ''}>Atendida</option>
                            <option value="CANCELADA" ${param.estadoFiltro == 'CANCELADA' ? 'selected' : ''}>Cancelada</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-secondary w-100 fw-bold">
                            <i class="fa-solid fa-filter me-2"></i>Aplicar Filtros
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
                                <th class="text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${citas}">
                                <tr>
                                    <td class="fw-bold">${c.fechaCita}</td>
                                    <td>${c.horaCita}</td>
                                    <td>
                                        <strong>${c.pacienteNombre}</strong><br>
                                        <small class="text-muted">CC: ${c.pacienteDocumento}</small>
                                    </td>
                                    <td>${c.medicoNombre}</td>
                                    <td><span class="badge bg-light text-dark border">${c.especialidadNombre}</span></td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${c.estado == 'PROGRAMADA'}">
                                                <span class="badge badge-estado-programada"><fmt:message key='cita.estado.programada'/></span>
                                            </c:when>
                                            <c:when test="${c.estado == 'CONFIRMADA'}">
                                                <span class="badge badge-estado-confirmada"><fmt:message key='cita.estado.confirmada'/></span>
                                            </c:when>
                                            <c:when test="${c.estado == 'ATENDIDA'}">
                                                <span class="badge badge-estado-atendida"><fmt:message key='cita.estado.atendida'/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-estado-cancelada"><fmt:message key='cita.estado.cancelada'/></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm shadow-sm">
                                            
                                            <a href="${pageContext.request.contextPath}/pdf?id=${c.id}" class="btn btn-outline-primary" target="_blank" title="<fmt:message key='cita.descargar'/>">
                                                <i class="fa-solid fa-file-pdf"></i>
                                            </a>

                                            <a href="${pageContext.request.contextPath}/citas?accion=editar&id=${c.id}" class="btn btn-outline-warning" title="Reprogramar Cita" style="border-radius: 0;">
                                                <i class="fa-solid fa-calendar-day"></i>
                                            </a>
                                            
                                            <form action="${pageContext.request.contextPath}/citas" method="POST" class="d-inline m-0 p-0">
                                                <input type="hidden" name="accion" value="cambiarEstado">
                                                <input type="hidden" name="id" value="${c.id}">
                                                <input type="hidden" name="estado" value="CONFIRMADA">
                                                <button type="submit" class="btn btn-outline-success" title="Confirmar Cita" style="border-radius: 0;">
                                                    <i class="fa-solid fa-check"></i>
                                                </button>
                                            </form>

                                            <form action="${pageContext.request.contextPath}/citas" method="POST" class="d-inline m-0 p-0">
                                                <input type="hidden" name="accion" value="cambiarEstado">
                                                <input type="hidden" name="id" value="${c.id}">
                                                <input type="hidden" name="estado" value="CANCELADA">
                                                <button type="submit" class="btn btn-outline-danger" title="Cancelar Cita" style="border-radius: 0 4px 4px 0;" onclick="return confirm('¿Está seguro de cancelar esta cita?');">
                                                    <i class="fa-solid fa-ban"></i>
                                                </button>
                                            </form>

                                        </div>
                                    </td>
                                </tr>
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
    
    <script>
        $(document).ready(function() {
            $('#tablaCitas').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                },
                "pageLength": 10,
                "ordering": true,
                "responsive": true
            });
        });
    </script>
</body>
</html>