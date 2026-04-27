<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Configuración de Idioma --%>
<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key='app.nombre'/> - <fmt:message key='app.institucion'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>

    <header class="navbar-saludboyaca py-3 shadow-sm">
        <div class="container d-flex justify-content-between align-items-center">
            <h1 class="h4 text-white mb-0">🏥 <fmt:message key='app.nombre'/></h1>
            
            <%-- Selector de Idiomas --%>
            <div class="bg-white px-3 py-1 rounded-pill shadow-sm">
                <a href="?lang=es" class="text-decoration-none me-2" title="Español">🇨🇴</a>
                <a href="?lang=en" class="text-decoration-none me-2" title="English">🇺🇸</a>
                <a href="?lang=it" class="text-decoration-none" title="Italiano">🇮🇹</a>
            </div>
        </div>
    </header>

    <main class="container my-5">
        <div class="row justify-content-center text-center mb-5">
            <div class="col-md-8">
                <h2 class="display-5 fw-bold" style="color: var(--texto-titulos);">
                    <fmt:message key='app.institucion'/>
                </h2>
                <p class="lead text-muted">Gestión integral de servicios de salud para Paipa, Boyacá.</p>
            </div>
        </div>

        <div class="row g-4 justify-content-center">
            <%-- Opción 1: Consulta Pública (Pacientes) --%>
            <div class="col-md-5">
                <div class="card h-100 shadow border-0 card-stat" style="border-left: 5px solid var(--color-sena);">
                    <div class="card-body p-5 text-center">
                        <i class="fas fa-calendar-check fa-4x mb-4" style="color: var(--color-sena);"></i>
                        <h3 class="fw-bold"><fmt:message key='nav.consulta'/></h3>
                        <p class="text-muted">Consulte y descargue su comprobante de cita médica sin necesidad de cuenta.</p>
                        <a href="${pageContext.request.contextPath}/consulta-cita" class="btn btn-lg btn-success w-100 mt-3" style="background-color: var(--color-sena); border:none;">
                            <fmt:message key='consulta.buscar'/>
                        </a>
                    </div>
                </div>
            </div>

            <%-- Opción 2: Acceso Personal (Login) --%>
            <div class="col-md-5">
                <div class="card h-100 shadow border-0 card-stat" style="border-left: 5px solid var(--color-primario);">
                    <div class="card-body p-5 text-center">
                        <i class="fas fa-user-md fa-4x mb-4" style="color: var(--color-primario);"></i>
                        <h3 class="fw-bold"><fmt:message key='login.titulo'/></h3>
                        <p class="text-muted">Acceso exclusivo para Médicos, Enfermeros y Personal Administrativo.</p>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-lg btn-primary w-100 mt-3 btn-saludboyaca">
                            <fmt:message key='login.ingresar'/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="py-4 mt-5 border-top bg-white">
        <div class="container text-center text-muted">
            <p class="mb-0">&copy; 2026 - <fmt:message key='app.institucion'/> - ADSO CIMM SENA</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>