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
    <title><fmt:message key='nav.dashboard'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/saludboyaca.css">
    
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
            padding: 0.8rem 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--acento-celeste);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .welcome-box {
            background: var(--color-primario);
            color: white;
            border-radius: 20px;
            padding: 3.5rem;
            box-shadow: 0 15px 30px rgba(26, 82, 118, 0.2);
            position: relative;
            overflow: hidden;
        }

        .welcome-box-medico {
            background: var(--acento-celeste);
            color: white;
            border-radius: 20px;
            padding: 3.5rem;
            box-shadow: 0 15px 30px rgba(26, 82, 118, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .welcome-box-enfermero {
            background: var(--color-sena);
            color: white;
            border-radius: 20px;
            padding: 3.5rem;
            box-shadow: 0 15px 30px rgba(57, 169, 0, 0.2);
            position: relative;
            overflow: hidden;
        }

        .welcome-box h1, .welcome-box-medico h1, .welcome-box-enfermero h1 {
            color: white;
            font-weight: 700;
            font-size: 2.8rem;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1.5rem;
        }

        .table-card {
            background: var(--blanco-puro);
            border-radius: 20px;
            padding: 2.5rem;
            margin-top: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
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
            <h5 class="fw-bold mb-0 titulo-modulo"><fmt:message key='dashboard.resumen'/></h5>
            <div class="d-flex align-items-center">
                <div class="text-end me-3 d-none d-md-block">
                    <p class="mb-0 fw-bold small">${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}</p>
                    <span class="text-muted small fw-medium" style="font-size: 0.7rem; text-transform: uppercase;">
                        ${sessionScope.usuario.rol}
                    </span>
                </div>
                <div class="bg-white rounded-circle shadow-sm d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border: 1px solid var(--acento-celeste);">
                    <c:choose>
                        <c:when test="${sessionScope.usuario.rol == 'MEDICO'}">
                            <i class="fa-solid fa-user-doctor" style="color: var(--color-sena);"></i>
                        </c:when>
                        <c:when test="${sessionScope.usuario.rol == 'ENFERMERO'}">
                            <i class="fa-solid fa-user-nurse" style="color: var(--color-sena);"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fa-solid fa-user-gear" style="color: var(--color-sena);"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </header>

        <div class="container-fluid px-0">
            
            <c:choose>
                <%-- ======================================================= --%>
                <%-- VISTA ESPECIFICA PARA EL MEDICO                         --%>
                <%-- ======================================================= --%>
                <c:when test="${sessionScope.usuario.rol == 'MEDICO'}">
                    
                    <div class="welcome-box-medico mb-5">
                        <div class="row align-items-center">
                            <div class="col-md-9">
                                <span class="badge bg-white bg-opacity-25 text-white mb-3 px-3 py-2 rounded-pill fw-bold"><fmt:message key='dashboard.medico.badge'/></span>
                                <h1><fmt:message key='dashboard.medico.bienvenida'><fmt:param value="${sessionScope.usuario.nombres}"/></fmt:message></h1>
                                <p class="lead opacity-75 mb-0"><fmt:message key='dashboard.medico.desc'/></p>
                            </div>
                            <div class="col-md-3 text-end d-none d-md-block">
                                <i class="fa-solid fa-user-doctor fa-6x opacity-25"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-5">
                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--acento-celeste);">
                                <div>
                                    <div class="stat-icon" style="background: #eef2ff; color: var(--acento-celeste);">
                                        <i class="fa-solid fa-stethoscope"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.medico.citas.hoy'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty totalCitasHoy ? totalCitasHoy : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.medico.citas.hoy.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/citas" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.medico.btn.agenda'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--estado-programada);">
                                <div>
                                    <div class="stat-icon" style="background: #fffbeb; color: var(--estado-programada);">
                                        <i class="fa-solid fa-clock"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.medico.pendientes'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty citasPendientes ? citasPendientes : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.medico.pendientes.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/citas" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.medico.btn.atender'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--color-sena);">
                                <div>
                                    <div class="stat-icon" style="background: #f0fdf4; color: var(--color-sena);">
                                        <i class="fa-solid fa-calendar-check"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.medico.horario'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);"><i class="fa-regular fa-clock"></i></div>
                                    <p class="text-muted small"><fmt:message key='dashboard.medico.horario.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/horarios" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.medico.btn.turnos'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--estado-atendida);">
                                <div>
                                    <div class="stat-icon" style="background: #e0f2fe; color: var(--estado-atendida);">
                                        <i class="fa-solid fa-users-medical"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.medico.pacientes'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty totalPacientes ? totalPacientes : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.medico.pacientes.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/pacientes" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.medico.btn.pacientes'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:when>

                <%-- ======================================================= --%>
                <%-- VISTA ESENCIAL PARA EL ENFERMERO                        --%>
                <%-- ======================================================= --%>
                <c:when test="${sessionScope.usuario.rol == 'ENFERMERO'}">
                    
                    <div class="welcome-box-enfermero mb-5">
                        <div class="row align-items-center">
                            <div class="col-md-9">
                                <span class="badge bg-white bg-opacity-25 text-white mb-3 px-3 py-2 rounded-pill fw-bold"><fmt:message key='dashboard.enfermero.badge'/></span>
                                <h1><fmt:message key='dashboard.enfermero.bienvenida'><fmt:param value="${sessionScope.usuario.nombres}"/></fmt:message></h1>
                                <p class="lead opacity-75 mb-0"><fmt:message key='dashboard.enfermero.desc'/></p>
                            </div>
                            <div class="col-md-3 text-end d-none d-md-block">
                                <i class="fa-solid fa-user-nurse fa-6x opacity-25"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-5 justify-content-center">
                        <div class="col-12 col-md-6">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--acento-celeste);">
                                <div>
                                    <div class="stat-icon" style="background: #eef2ff; color: var(--acento-celeste);">
                                        <i class="fa-solid fa-calendar-day"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.enfermero.citas'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty totalCitasHoy ? totalCitasHoy : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.enfermero.citas.desc'/></p>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--color-sena);">
                                <div>
                                    <div class="stat-icon" style="background: #f0fdf4; color: var(--color-sena);">
                                        <i class="fa-solid fa-users-medical"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.enfermero.directorio'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty totalPacientes ? totalPacientes : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.enfermero.directorio.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/pacientes" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.enfermero.btn.directorio'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                </c:when>

                <%-- ======================================================= --%>
                <%-- VISTA GENERAL PARA RECEPCIONISTA                        --%>
                <%-- ======================================================= --%>
                <c:otherwise>
                    
                    <div class="welcome-box mb-5">
                        <div class="row align-items-center">
                            <div class="col-md-9">
                                <span class="badge bg-white bg-opacity-25 text-white mb-3 px-3 py-2 rounded-pill fw-bold"><fmt:message key='dashboard.sistema'/></span>
                                <h1><fmt:message key='dashboard.bienvenida'><fmt:param value='${sessionScope.usuario.nombres}'/></fmt:message></h1>
                                <p class="lead opacity-75 mb-0"><fmt:message key='dashboard.panel'/></p>
                            </div>
                            <div class="col-md-3 text-end d-none d-md-block">
                                <i class="fa-solid fa-heart-pulse fa-6x opacity-25"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row g-4 mb-5">
                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--acento-celeste);">
                                <div>
                                    <div class="stat-icon" style="background: #eef2ff; color: var(--acento-celeste);">
                                        <i class="fa-solid fa-calendar-day"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.citas.hoy'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty totalCitasHoy ? totalCitasHoy : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.citas.hoy.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/citas" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.btn.agenda'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--estado-programada);">
                                <div>
                                    <div class="stat-icon" style="background: #fffbeb; color: var(--estado-programada);">
                                        <i class="fa-solid fa-clock"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.citas.pendientes'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty citasPendientes ? citasPendientes : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.citas.pendientes.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/citas" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.btn.atender'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--color-sena);">
                                <div>
                                    <div class="stat-icon" style="background: #f0fdf4; color: var(--color-sena);">
                                        <i class="fa-solid fa-calendar-check"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.citas.mes'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty citasMes ? citasMes : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.citas.mes.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/citas" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.btn.historial'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-xl-3">
                            <div class="card-stat p-4 h-100 d-flex flex-column justify-content-between" style="border-left-color: var(--estado-atendida);">
                                <div>
                                    <div class="stat-icon" style="background: #e0f2fe; color: var(--estado-atendida);">
                                        <i class="fa-solid fa-users-medical"></i>
                                    </div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1"><fmt:message key='dashboard.pacientes.total'/></p>
                                    <div class="h2 fw-bold mb-0" style="color: var(--color-primario);">${not empty totalPacientes ? totalPacientes : '0'}</div>
                                    <p class="text-muted small"><fmt:message key='dashboard.pacientes.total.desc'/></p>
                                </div>
                                <a href="${pageContext.request.contextPath}/pacientes" class="btn btn-saludboyaca w-100 mt-4 rounded-3">
                                    <fmt:message key='dashboard.btn.directorio'/> <i class="fa-solid fa-chevron-right ms-2 small"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                </c:otherwise>
            </c:choose>

            <%-- ======================================================= --%>
            <%-- LA TABLA DE ACTIVIDAD SE MUESTRA PARA TODOS ABAJO       --%>
            <%-- ======================================================= --%>
            <div class="table-card mb-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="fw-bold mb-0 titulo-modulo">
                        <i class="fa-solid fa-clock-rotate-left me-2 text-muted"></i><fmt:message key='dashboard.actividad'/>
                    </h5>
                    <a href="${pageContext.request.contextPath}/citas" class="btn btn-sm btn-light border rounded-pill px-3 fw-bold text-muted text-decoration-none"><fmt:message key='dashboard.btn.vertodo'/></a>
                </div>
                
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th><fmt:message key='dashboard.tabla.operacion'/></th>
                                <th><fmt:message key='dashboard.tabla.fecha'/></th>
                                <th><fmt:message key='dashboard.tabla.responsable'/></th>
                                <th class="text-center"><fmt:message key='dashboard.tabla.estado'/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty ultimasCitas}">
                                    <c:forEach var="cita" items="${ultimasCitas}">
                                        <tr>
                                            <td class="fw-bold" style="color: var(--texto-normal);">
                                                <fmt:message key='dashboard.tabla.movimiento'/> ${cita.pacienteNombre}
                                            </td>
                                            <td class="text-muted">${cita.fechaCita} <fmt:message key='dashboard.tabla.alas'/> ${cita.horaCita}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-light rounded-circle p-2 me-2">
                                                        <i class="fa-solid fa-user-doctor text-secondary small"></i>
                                                    </div>
                                                    <span class="fw-bold small text-muted"><fmt:message key='dashboard.tabla.dr'/> ${cita.medicoNombre}</span>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${cita.estado == 'PROGRAMADA'}">
                                                        <span class="badge" style="background-color: var(--estado-programada);"><fmt:message key='cita.estado.programada'/></span>
                                                    </c:when>
                                                    <c:when test="${cita.estado == 'CONFIRMADA'}">
                                                        <span class="badge" style="background-color: var(--estado-confirmada);"><fmt:message key='cita.estado.confirmada'/></span>
                                                    </c:when>
                                                    <c:when test="${cita.estado == 'ATENDIDA'}">
                                                        <span class="badge" style="background-color: var(--estado-atendida);"><fmt:message key='cita.estado.atendida'/></span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge" style="background-color: var(--estado-cancelada);"><fmt:message key='cita.estado.cancelada'/></span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted"><fmt:message key='dashboard.tabla.vacia'/></td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>