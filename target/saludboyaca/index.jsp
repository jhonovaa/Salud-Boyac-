<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Configuracion de Idioma --%>
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
<body style="background-color: #EAF0F7;"> <%-- Fondo Gris hielo --%>

    <%-- Se incluye el header desde la raiz apuntando a la carpeta views --%>
    <%@ include file="views/templates/header.jsp" %>

    <main class="container my-5">
        <div class="row justify-content-center text-center mb-5">
            <div class="col-md-8">
                <h2 class="display-5 fw-bold" style="color: var(--texto-titulos);">
                    <fmt:message key='app.institucion'/>
                </h2>
                <p class="lead text-muted">Gestion integral de servicios de salud para Paipa, Boyaca.</p>
            </div>
        </div>

        <div class="row g-4 justify-content-center">
            <%-- Opcion 1: Consulta Publica (Pacientes) --%>
            <div class="col-md-5">
                <div class="card h-100 shadow border-0 card-stat" style="border-left: 5px solid var(--color-sena); border-radius: 16px;">
                    <div class="card-body p-5 text-center">
                        <i class="fas fa-calendar-check fa-4x mb-4" style="color: var(--color-sena);"></i>
                        <h3 class="fw-bold"><fmt:message key='nav.consulta'/></h3>
                        <p class="text-muted">Consulte y descargue su comprobante de cita medica sin necesidad de cuenta.</p>
                        <a href="${pageContext.request.contextPath}/consulta-cita" class="btn btn-lg w-100 mt-3 text-white" style="background-color: var(--color-sena); border:none; border-radius: 12px; font-weight: 600;">
                            <fmt:message key='consulta.buscar'/>
                        </a>
                    </div>
                </div>
            </div>

            <%-- Opcion 2: Acceso Personal (Login) --%>
            <div class="col-md-5">
                <div class="card h-100 shadow border-0 card-stat" style="border-left: 5px solid var(--color-primario); border-radius: 16px;">
                    <div class="card-body p-5 text-center">
                        <i class="fas fa-user-md fa-4x mb-4" style="color: var(--color-primario);"></i>
                        <h3 class="fw-bold"><fmt:message key='login.titulo'/></h3>
                        <p class="text-muted">Acceso exclusivo para Medicos, Enfermeros y Personal Administrativo.</p>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-lg w-100 mt-3 btn-saludboyaca text-white" style="background-color: var(--color-primario); border-radius: 12px; font-weight: 600;">
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