<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='consulta.titulo'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body class="login-wrapper">
    <div class="container d-flex justify-content-center">
        <div class="card login-card p-4">
            
            <div class="text-end mb-3">
                <a href="?lang=es" class="text-decoration-none fs-4">🇨🇴</a>
                <a href="?lang=en" class="text-decoration-none fs-4 ms-2">🇺🇸</a>
                <a href="?lang=it" class="text-decoration-none fs-4 ms-2">🇮🇹</a>
            </div>

            <div class="text-center mb-4">
                <h2 style="color: var(--color-primario);">🏥 <fmt:message key='app.institucion'/></h2>
                <h4 style="color: var(--texto-titulos);"><fmt:message key='consulta.titulo'/></h4>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty mensajeExito}">
                <div class="alert alert-success">${mensajeExito}</div>
            </c:if>

            <p class="text-muted text-center"><fmt:message key='consulta.instruccion'/></p>

            <form action="${pageContext.request.contextPath}/consulta-cita" method="POST">
                <div class="mb-3">
                    <label class="form-label fw-bold"><fmt:message key='consulta.documento'/></label>
                    <input type="text" name="documento" class="form-control form-control-lg" required placeholder="Ej: 1052345678">
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold"><fmt:message key='consulta.captcha'/></label>
                    <div class="text-center mb-2">
                        <img src="${captchaImage}" alt="CAPTCHA" class="img-fluid border rounded shadow-sm">
                    </div>
                    <input type="text" name="captcha" class="form-control text-center text-uppercase" required autocomplete="off" placeholder="Ingrese el código superior">
                </div>

                <button type="submit" class="btn btn-saludboyaca w-100 py-2 fs-5">
                    🔍 <fmt:message key='consulta.buscar'/>
                </button>
                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Soy personal médico</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>