<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<nav class="navbar navbar-expand-lg navbar-dark navbar-saludboyaca mb-4 shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/dashboard">
            🏥 <fmt:message key='app.nombre'/>
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><fmt:message key='nav.dashboard'/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/pacientes"><fmt:message key='nav.pacientes'/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/citas"><fmt:message key='nav.citas'/></a>
                </li>
            </ul>
            
            <div class="d-flex align-items-center">
                <div class="me-4">
                    <a href="?lang=es" class="text-decoration-none fs-5" title="<fmt:message key='app.lang.es'/>">🇨🇴</a>
                    <a href="?lang=en" class="text-decoration-none fs-5 ms-1" title="<fmt:message key='app.lang.en'/>">🇺🇸</a>
                    <a href="?lang=it" class="text-decoration-none fs-5 ms-1" title="<fmt:message key='app.lang.it'/>">🇮🇹</a>
                </div>
                
                <span class="text-white me-3 fw-semibold">
                    👤 ${sessionScope.usuario.nombres} (${sessionScope.usuario.rol})
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-danger">
                    <fmt:message key='nav.salir'/>
                </a>
            </div>
        </div>
    </div>
</nav>