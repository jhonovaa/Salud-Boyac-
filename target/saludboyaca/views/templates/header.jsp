<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-saludboyaca shadow-sm py-3">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/dashboard">
            🏥 <fmt:message key='app.nombre'/>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><fmt:message key='nav.dashboard'/></a>
                </li>
                
                <%-- Módulos para MÉDICO y RECEPCIONISTA --%>
                <c:if test="${sessionScope.usuario.rol == 'MEDICO' || sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/pacientes"><fmt:message key='nav.pacientes'/></a>
                    </li>
                </c:if>
                
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/citas"><fmt:message key='nav.citas'/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/horarios"><fmt:message key='nav.horarios'/></a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <%-- Selector de Idioma en el Nav --%>
                <div class="me-4">
                    <a href="?lang=es" class="text-decoration-none fs-5">🇨🇴</a>
                    <a href="?lang=en" class="text-decoration-none fs-5 mx-1">🇺🇸</a>
                    <a href="?lang=it" class="text-decoration-none fs-5">🇮🇹</a>
                </div>
                
                <span class="text-white me-3 fw-semibold">
                    <i class="fas fa-user-circle me-1"></i> ${sessionScope.usuario.nombres}
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-danger px-3">
                    <fmt:message key='nav.salir'/>
                </a>
            </div>
        </div>
    </div>
</nav>