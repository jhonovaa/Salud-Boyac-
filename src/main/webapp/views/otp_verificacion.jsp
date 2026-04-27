<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='otp.titulo'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body class="login-wrapper">
    <div class="container d-flex justify-content-center mt-5">
        <div class="card login-card border-0 shadow-lg" style="max-width: 420px; width: 100%;">
            <div class="card-header text-center py-4" style="background:#6C3483; border-radius:16px 16px 0 0;">
                <i class="fas fa-shield-alt fa-3x text-white mb-2"></i>
                <h4 class="text-white mb-0"><fmt:message key='otp.titulo'/></h4>
            </div>
            <div class="card-body p-4 bg-white">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <p class="text-center text-muted">
                    <fmt:message key='otp.instruccion'>
                        <fmt:param value="${emailMasked}" />
                    </fmt:message>
                </p>
                <form action="${pageContext.request.contextPath}/otp" method="post">
                    <div class="mb-4 text-center">
                        <label class="form-label fw-bold"><fmt:message key='otp.campo'/></label>
                        <input type="text" name="otpCodigo" class="form-control form-control-lg text-center" 
                               maxlength="6" pattern="[0-9]{6}" placeholder="000000" required autofocus 
                               style="letter-spacing:12px; font-size:2rem;">
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-lg text-white" style="background:#6C3483;">
                            <fmt:message key='otp.verificar'/>
                        </button>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary">
                            <fmt:message key='otp.reenviar'/>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>