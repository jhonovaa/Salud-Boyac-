<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html>
<head>
    <title><fmt:message key='paciente.nuevo'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/templates/header.jsp" />

    <div class="container mt-4">
        <div class="card shadow border-0">
            <div class="card-body p-4">
                <h3 class="mb-4"><fmt:message key='paciente.nuevo'/></h3>
                <form action="${pageContext.request.contextPath}/pacientes" method="POST">
                    <input type="hidden" name="accion" value="insertar">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label"><fmt:message key='paciente.nombres'/></label>
                            <input type="text" name="nombres" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label"><fmt:message key='paciente.apellidos'/></label>
                            <input type="text" name="apellidos" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label"><fmt:message key='paciente.documento'/></label>
                            <input type="text" name="documento" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label"><fmt:message key='paciente.nacimiento'/></label>
                            <input type="date" name="fechaNacimiento" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label"><fmt:message key='paciente.eps'/></label>
                            <input type="text" name="eps" class="form-control" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label"><fmt:message key='paciente.telefono'/></label>
                            <input type="text" name="telefono" class="form-control">
                        </div>
                    </div>
                    <div class="mt-4 text-end">
                        <a href="lista.jsp" class="btn btn-secondary"><fmt:message key='paciente.cancelar'/></a>
                        <button type="submit" class="btn btn-saludboyaca"><fmt:message key='paciente.guardar'/></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>