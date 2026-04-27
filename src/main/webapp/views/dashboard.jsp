<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key='nav.dashboard'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/templates/header.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4" style="color: var(--texto-titulos);">
            <fmt:message key='dashboard.bienvenida'><fmt:param value='${sessionScope.usuario.nombres}'/></fmt:message>
        </h2>

        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="card card-stat p-3 shadow-sm" style="border-left: 4px solid #2980B9;">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-calendar-day fa-2x text-primary me-3"></i>
                        <div>
                            <h5 class="mb-0">12</h5>
                            <small class="text-muted"><fmt:message key='dashboard.citas.hoy'/></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat p-3 shadow-sm" style="border-left: 4px solid #F39C12;">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-clock fa-2x text-warning me-3"></i>
                        <div>
                            <h5 class="mb-0">5</h5>
                            <small class="text-muted"><fmt:message key='dashboard.citas.pendientes'/></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat p-3 shadow-sm" style="border-left: 4px solid #39A900;">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-calendar-alt fa-2x text-success me-3"></i>
                        <div>
                            <h5 class="mb-0">84</h5>
                            <small class="text-muted"><fmt:message key='dashboard.citas.mes'/></small>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card card-stat p-3 shadow-sm" style="border-left: 4px solid #2E86C1;">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-users fa-2x text-info me-3"></i>
                        <div>
                            <h5 class="mb-0">450</h5>
                            <small class="text-muted"><fmt:message key='dashboard.pacientes.total'/></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>