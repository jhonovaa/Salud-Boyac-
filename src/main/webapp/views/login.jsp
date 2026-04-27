<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='login.titulo'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body class="login-wrapper"> <%-- Aplica el gradiente diagonal definido en CSS --%>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card login-card shadow-lg p-4" style="max-width: 420px; width: 100%; border-radius: 16px;">
            <div class="text-center mb-4">
                <h2 style="color: var(--color-primario);">🏥 <fmt:message key='app.nombre'/></h2>
                <p class="text-muted"><fmt:message key='app.institucion'/></p>
            </div>

            <%-- Selector de 3 idiomas con banderas --%>
            <div class="text-end mb-3">
                <a href="?lang=es" title="Español" class="text-decoration-none fs-4">🇨🇴</a>
                <a href="?lang=en" title="English" class="text-decoration-none fs-4 ms-2">🇺🇸</a>
                <a href="?lang=it" title="Italiano" class="text-decoration-none fs-4 ms-2">🇮🇹</a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2 small">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="mb-3">
                    <label class="form-label fw-bold"><i class="fas fa-user me-2"></i><fmt:message key='login.usuario'/></label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold"><i class="fas fa-lock me-2"></i><fmt:message key='login.contrasena'/></label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-saludboyaca w-100 py-2 fs-5">
                    <fmt:message key='login.ingresar'/>
                </button>
            </form>
            
            <div class="text-center mt-4 pt-3 border-top">
                <a href="${pageContext.request.contextPath}/consulta-cita" class="text-decoration-none small">
                    <fmt:message key='nav.consulta'/>
                </a>
            </div>
        </div>
    </div>
</body>
</html>