<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

            <fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
            <fmt:setBundle basename="messages" />

            <!DOCTYPE html>
            <html lang="${sessionScope.lang}">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>
                    <fmt:message key="app.nombre" /> -
                    <fmt:message key="perfil.titulo.pestana" />
                </title>

                <%-- Bootstrap 5.3.3 --%>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                        rel="stylesheet">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <style>
                        :root {
                            --color-primario: #1A5276;
                            --color-secundario: #39A900;
                            --acento-celeste: #2E86C1;
                            --fondo-body: #EAF0F7;
                            --texto-titulos: #154360;
                            --texto-normal: #2C3E50;
                            --texto-suave: #7F8C8D;
                            --card-bg: rgba(255, 255, 255, 0.9);
                            --transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
                        }

                        body {
                            background-color: var(--fondo-body);
                            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                            color: var(--texto-normal);
                            min-height: 100vh;
                            display: flex;
                            flex-direction: column;
                            position: relative;
                            overflow-x: hidden;
                        }

                        /* BURBUJAS DE FONDO ANIMADAS */
                        .bg-blob {
                            position: absolute;
                            border-radius: 50%;
                            filter: blur(100px);
                            z-index: -1;
                            opacity: 0.3;
                            animation: float 15s ease-in-out infinite;
                        }

                        .blob-1 {
                            top: 10%;
                            left: -5%;
                            width: 400px;
                            height: 400px;
                            background: var(--color-primario);
                        }

                        .blob-2 {
                            bottom: -5%;
                            right: -5%;
                            width: 500px;
                            height: 500px;
                            background: var(--color-secundario);
                            animation-delay: -5s;
                        }

                        @keyframes float {
                            0% {
                                transform: translate(0, 0) scale(1);
                            }

                            33% {
                                transform: translate(30px, -50px) scale(1.1);
                            }

                            66% {
                                transform: translate(-20px, 20px) scale(0.9);
                            }

                            100% {
                                transform: translate(0, 0) scale(1);
                            }
                        }

                        /* NAVBAR ESTILO APPLE */
                        .navbar-apple {
                            background: rgba(255, 255, 255, 0.65) !important;
                            backdrop-filter: blur(25px) saturate(200%);
                            -webkit-backdrop-filter: blur(25px) saturate(200%);
                            border-bottom: 1px solid rgba(255, 255, 255, 0.8);
                            padding: 12px 0 !important;
                            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.03);
                            z-index: 1000;
                        }

                        .apple-card {
                            background: var(--card-bg);
                            backdrop-filter: blur(20px);
                            -webkit-backdrop-filter: blur(20px);
                            border-radius: 1.5rem;
                            border: 1px solid rgba(255, 255, 255, 0.8);
                            box-shadow: 0 10px 30px rgba(26, 82, 118, 0.08);
                            overflow: hidden;
                            margin-bottom: 2rem;
                            transition: var(--transition);
                        }

                        .apple-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 15px 35px rgba(26, 82, 118, 0.12);
                        }

                        .card-header-blue {
                            background-color: var(--color-primario);
                            color: white;
                            padding: 1.5rem;
                            border-bottom: 4px solid var(--color-secundario);
                        }

                        .section-title {
                            color: var(--acento-celeste);
                            font-weight: 700;
                            font-size: 1.2rem;
                            border-left: 4px solid var(--acento-celeste);
                            padding-left: 12px;
                            margin-bottom: 1.5rem;
                            display: flex;
                            align-items: center;
                            gap: 10px;
                        }

                        .data-label {
                            font-size: 0.75rem;
                            text-transform: uppercase;
                            font-weight: 700;
                            color: var(--texto-suave);
                            margin-bottom: 0.3rem;
                            letter-spacing: 0.5px;
                        }

                        .data-value {
                            font-size: 1.1rem;
                            font-weight: 500;
                            margin-bottom: 1.2rem;
                            border-bottom: 1px solid rgba(0, 0, 0, 0.06);
                            padding-bottom: 0.6rem;
                            color: var(--texto-normal);
                        }

                        .db-table {
                            border-radius: 1rem;
                            overflow: hidden;
                            font-size: 0.95rem;
                            background: white;
                        }

                        .db-table thead th {
                            background-color: var(--color-primario);
                            color: white;
                            font-weight: 600;
                            text-transform: uppercase;
                            font-size: 0.8rem;
                            letter-spacing: 0.5px;
                            padding: 1rem;
                            border: none;
                        }

                        .db-table tbody td {
                            padding: 1rem;
                            vertical-align: middle;
                            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        }

                        .status-badge {
                            padding: 0.5rem 1rem;
                            border-radius: 50px;
                            font-weight: 700;
                            font-size: 0.75rem;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            display: inline-block;
                        }

                        .bg-atendida {
                            background-color: #d1e7dd;
                            color: #0f5132;
                        }

                        .bg-cancelada {
                            background-color: #f8d7da;
                            color: #842029;
                        }

                        .bg-confirmada {
                            background-color: #cfe2ff;
                            color: #084298;
                        }

                        .bg-programada {
                            background-color: #fff3cd;
                            color: #664d03;
                        }

                        .btn-apple {
                            border-radius: 50px;
                            padding: 0.6rem 1.5rem;
                            font-weight: 600;
                            transition: 0.3s;
                        }

                        .btn-sena {
                            background-color: var(--color-secundario);
                            color: white;
                            border: none;
                        }

                        .btn-sena:hover {
                            background-color: #2b8000;
                            color: white;
                            box-shadow: 0 8px 20px rgba(57, 169, 0, 0.25);
                            transform: translateY(-2px);
                        }

                        .btn-saludboyaca {
                            background-color: var(--color-primario);
                            color: white;
                            border: none;
                            border-radius: 50px;
                            font-weight: 600;
                        }

                        .btn-saludboyaca:hover {
                            background-color: #123a54;
                            color: white;
                            box-shadow: 0 8px 20px rgba(26, 82, 118, 0.25);
                        }
                    </style>
            </head>

            <body>

                <div class="bg-blob blob-1"></div>
                <div class="bg-blob blob-2"></div>

                <nav class="navbar navbar-expand-lg navbar-apple sticky-top">
                    <div class="container">
                        <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/"
                            style="color: var(--color-primario);">
                            <i class="bi bi-heart-pulse-fill me-2"></i>
                            <fmt:message key="app.nombre" />
                        </a>
                        <div class="d-flex align-items-center ms-auto">
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav ms-auto fw-medium align-items-center">
                                    <li class="nav-item d-flex gap-2 px-4 py-2">
                                        <%-- Definimos la variable de idioma actual, por defecto 'es' --%>
                                            <c:set var="currentLang"
                                                value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />

                                            <%-- Idioma ES --%>
                                                <a href="?lang=es" class="text-decoration-none fw-bold"
                                                    style="color: ${currentLang == 'es' ? 'var(--texto-normal)' : 'var(--texto-suave)'};">
                                                    ES
                                                </a>

                                                <span style="color: var(--texto-suave);">|</span>

                                                <%-- Idioma EN --%>
                                                    <a href="?lang=en" class="text-decoration-none fw-bold"
                                                        style="color: ${currentLang == 'en' ? 'var(--texto-normal)' : 'var(--texto-suave)'};">
                                                        EN
                                                    </a>

                                                    <span style="color: var(--texto-suave);">|</span>

                                                    <%-- Idioma IT --%>
                                                        <a href="?lang=it" class="text-decoration-none fw-bold"
                                                            style="color: ${currentLang == 'it' ? 'var(--texto-normal)' : 'var(--texto-suave)'};">
                                                            IT
                                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <a class="btn btn-saludboyaca px-4 py-2 shadow-sm d-none d-md-block ms-3"
                                href="${pageContext.request.contextPath}/login">
                                <fmt:message key="index.nav.intranet" />
                            </a>
                        </div>
                    </div>
                </nav>

                <div class="container py-5" style="flex: 1; z-index: 1;">

                    <%-- EXTRAEMOS LA CITA MAS RECIENTE DEL HISTORIAL DE FORMA AUTOMATICA --%>
                        <c:set var="citaActual" value="${not empty historial ? historial[0] : null}" />

                        <div class="row g-4 mb-4">
                            <%-- Tarjeta 1: Informacion del Paciente --%>
                                <div class="col-lg-4">
                                    <div class="apple-card h-100">
                                        <div class="card-header-blue text-center py-4">
                                            <div class="bg-white rounded-circle d-inline-flex align-items-center justify-content-center mb-3 shadow"
                                                style="width: 90px; height: 90px;">
                                                <i class="bi bi-person-fill fs-1"
                                                    style="color: var(--color-primario);"></i>
                                            </div>
                                            <h4 class="mb-1 fw-bold">
                                                <c:choose>
                                                    <c:when test="${not empty paciente.nombres}">
                                                        ${paciente.nombres} ${paciente.apellidos}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:message key="perfil.nombre.nodisponible" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </h4>
                                            <span
                                                class="badge bg-light text-dark px-3 py-2 rounded-pill shadow-sm mt-2 fw-bold">
                                                <i class="bi bi-upc-scan me-1"></i>
                                                <fmt:message key="cita.cc" />: ${not empty paciente.documento ?
                                                paciente.documento : 'N/A'}
                                            </span>
                                        </div>
                                        <div class="p-4">
                                            <div class="data-label mt-2">
                                                <fmt:message key="perfil.estado" />
                                            </div>
                                            <div class="data-value border-0">
                                                <span class="badge bg-success rounded-pill px-3"><i
                                                        class="bi bi-check-circle me-1"></i>
                                                    <fmt:message key="perfil.activo" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <%-- Tarjeta 2: Datos de la Cita Actual --%>
                                    <div class="col-lg-8">
                                        <div class="apple-card h-100">
                                            <div class="p-4 p-md-5">
                                                <h5 class="section-title"><i class="bi bi-calendar2-check-fill"></i>
                                                    <fmt:message key="perfil.cita.reciente" />
                                                </h5>

                                                <div class="row mt-4">
                                                    <div class="col-md-6">
                                                        <div class="data-label">
                                                            <fmt:message key="perfil.fecha.programada" />
                                                        </div>
                                                        <div class="data-value text-primary fw-bold fs-5">
                                                            <c:choose>
                                                                <c:when test="${not empty citaActual.fechaCita}">
                                                                    <i class="bi bi-calendar3 me-2"></i>
                                                                    <fmt:formatDate value="${citaActual.fechaCita}"
                                                                        pattern="dd/MM/yyyy" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:message key="perfil.pendiente.asignacion" />
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="data-label">
                                                            <fmt:message key="perfil.hora.atencion" />
                                                        </div>
                                                        <div class="data-value fw-bold fs-5">
                                                            <i class="bi bi-clock me-2 text-muted"></i>
                                                            ${not empty citaActual.horaCita ? citaActual.horaCita :
                                                            '--:--'}
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="data-label">
                                                            <fmt:message key="cita.estado.actual" />
                                                        </div>
                                                        <div class="data-value border-0">
                                                            <c:choose>
                                                                <c:when test="${not empty citaActual.estado}">
                                                                    <c:set var="estadoActual"
                                                                        value="${citaActual.estado}" />
                                                                    <span
                                                                        class="status-badge bg-${estadoActual.toLowerCase()} shadow-sm">${estadoActual}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge bg-programada shadow-sm">
                                                                        <fmt:message key="perfil.sin.cita" />
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="data-label">
                                                            <fmt:message key="perfil.medico.asignado" />
                                                        </div>
                                                        <div class="data-value border-0">
                                                            <i class="bi bi-file-medical-fill me-2 text-primary"></i>
                                                            <span class="fw-bold">
                                                                <fmt:message key="horario.dr" /> ${not empty
                                                                citaActual.medicoNombre ? citaActual.medicoNombre : ''}
                                                            </span>
                                                            <c:if test="${empty citaActual.medicoNombre}">
                                                                <fmt:message key="perfil.por.asignar" />
                                                            </c:if>
                                                            <div class="small text-muted mt-1 fw-normal"
                                                                style="font-size: 0.85rem; padding-left: 28px;">
                                                                ${not empty citaActual.especialidadNombre ?
                                                                citaActual.especialidadNombre : ''}
                                                                <c:if test="${empty citaActual.especialidadNombre}">
                                                                    <fmt:message key="perfil.medicina.general" />
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-12 mt-2">
                                                        <div class="data-label">
                                                            <fmt:message key="cita.motivo" />
                                                        </div>
                                                        <div
                                                            class="data-value border-0 bg-light p-3 rounded-4 mt-2 shadow-sm border">
                                                            <c:choose>
                                                                <c:when test="${not empty citaActual.motivo}">
                                                                    <i
                                                                        class="bi bi-chat-square-quote text-muted me-2"></i>
                                                                    ${citaActual.motivo}
                                                                </c:when>
                                                                <c:otherwise><span class="text-muted fst-italic">
                                                                        <fmt:message key="cita.sin.motivo" />
                                                                    </span></c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                        </div>

                        <%-- Seccion 3: Historial --%>
                            <div class="apple-card">
                                <div class="p-4 p-md-5">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h5 class="section-title mb-0"><i class="bi bi-clipboard2-data-fill"></i>
                                            <fmt:message key="perfil.historial.completo" />
                                        </h5>
                                        <span class="badge bg-primary rounded-pill px-3 py-2 shadow-sm">${not empty
                                            historial ? historial.size() : 0}
                                            <fmt:message key="perfil.registros" />
                                        </span>
                                    </div>

                                    <div class="table-responsive db-table shadow-sm border border-light">
                                        <table class="table table-hover mb-0 align-middle">
                                            <thead>
                                                <tr>
                                                    <th class="ps-4">
                                                        <fmt:message key="cita.fecha" />
                                                    </th>
                                                    <th>
                                                        <fmt:message key="cita.hora" />
                                                    </th>
                                                    <th>
                                                        <fmt:message key="cita.motivo" />
                                                    </th>
                                                    <th>
                                                        <fmt:message key="cita.estado" />
                                                    </th>
                                                    <th>
                                                        <fmt:message key="perfil.observaciones" />
                                                    </th>
                                                    <th>
                                                        <fmt:message key="perfil.registrado.el" />
                                                    </th>
                                                    <th class="pe-4 text-center">PDF</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="h" items="${historial}">
                                                    <tr>
                                                        <td class="ps-4 fw-bold text-primary">
                                                            <i
                                                                class="bi bi-calendar2-event text-muted me-1 d-none d-sm-inline"></i>
                                                            <fmt:formatDate value="${h.fechaCita}"
                                                                pattern="dd/MM/yyyy" />
                                                        </td>
                                                        <td class="fw-medium">${h.horaCita}</td>
                                                        <td>${h.motivo}</td>
                                                        <td>
                                                            <c:set var="st" value="${h.estado.toLowerCase()}" />
                                                            <span class="status-badge bg-${st}">${h.estado}</span>
                                                        </td>
                                                        <td class="text-muted small">
                                                            <c:choose>
                                                                <c:when test="${not empty h.observaciones}">
                                                                    ${h.observaciones}</c:when>
                                                                <c:otherwise><span class="fst-italic opacity-50">
                                                                        <fmt:message key="perfil.sin.observaciones" />
                                                                    </span></c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-muted" style="font-size: 0.8rem;">
                                                            <fmt:formatDate value="${h.fechaRegistro}"
                                                                pattern="dd/MM/yyyy HH:mm" />
                                                        </td>
                                                        <td class="pe-4 text-center">
                                                            <a href="${pageContext.request.contextPath}/pdf?id=${h.id}"
                                                                target="_blank"
                                                                class="btn btn-sm btn-outline-danger rounded-pill shadow-sm"
                                                                title="<fmt:message key='cita.descargar'/>">
                                                                <i class="bi bi-file-earmark-pdf-fill"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty historial}">
                                                    <tr>
                                                        <td colspan="7" class="text-center py-5 text-muted">
                                                            <div class="p-4">
                                                                <i class="bi bi-inbox-fill fs-1 d-block mb-3 opacity-25"
                                                                    style="color: var(--color-primario);"></i>
                                                                <h6 class="fw-bold">
                                                                    <fmt:message key="perfil.sin.registros" />
                                                                </h6>
                                                                <p class="mb-0 small">
                                                                    <fmt:message key="perfil.sin.historial.desc" />
                                                                </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>

                                    <%-- Botones de Accion Inferiores --%>
                                        <div
                                            class="d-flex flex-column flex-sm-row justify-content-center align-items-center mt-5 pt-4 border-top">
                                            <a href="${pageContext.request.contextPath}/consulta-cita"
                                                class="btn btn-outline-secondary btn-apple">
                                                <i class="bi bi-arrow-left me-2"></i>
                                                <fmt:message key="perfil.volver.buscar" />
                                            </a>
                                        </div>
                                </div>
                            </div>

                </div>

                <footer class="py-4 text-center mt-auto"
                    style="background: rgba(255, 255, 255, 0.4); backdrop-filter: blur(10px); border-top: 1px solid rgba(255,255,255,0.6); z-index: 1;">
                    <div class="container">
                        <p class="mb-0 fw-bold small" style="color: var(--texto-suave);">&copy; 2026 -
                            <fmt:message key="perfil.footer" />
                        </p>
                    </div>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>