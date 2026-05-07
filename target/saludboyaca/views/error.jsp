<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key='error.titulo'/> - <fmt:message key='app.nombre'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body class="login-wrapper d-flex align-items-center justify-content-center" style="background-color: #EAF0F7; min-height: 100vh;">
    <div class="card p-5 text-center shadow border-0" style="max-width: 500px; border-radius: 20px;">
        <h1 class="display-1 text-danger mb-3">⚠️</h1>
        <h2 style="color: var(--texto-titulos, #154360); font-weight: 700;"><fmt:message key='error.servidor'/></h2>
        
        <p class="text-muted mt-3 fs-5">
            <fmt:message key='error.descripcion'/>
        </p>
        
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-saludboyaca mt-4 py-2 px-4 rounded-pill fw-bold" style="background-color: #1A5276; color: white;">
            <i class="fas fa-home me-2"></i><fmt:message key='error.btn.inicio'/>
        </a>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>