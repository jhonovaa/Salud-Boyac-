<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html>
<head>
    <title>Error - SaludBoyacá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body class="login-wrapper d-flex align-items-center justify-content-center">
    <div class="card p-5 text-center shadow" style="max-width: 500px;">
        <h1 class="display-1 text-danger">⚠️</h1>
        <h2><fmt:message key='error.servidor'/></h2>
        <p class="text-muted mt-3">Lo sentimos, algo salió mal. Por favor intenta volver al inicio.</p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-saludboyaca mt-3">Ir al inicio</a>
    </div>
</body>
</html>