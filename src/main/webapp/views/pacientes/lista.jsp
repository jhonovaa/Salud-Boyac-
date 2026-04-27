<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='paciente.titulo'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/templates/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: var(--texto-titulos);"><fmt:message key='paciente.titulo'/></h2>
            <a href="${pageContext.request.contextPath}/pacientes?accion=nuevo" class="btn btn-saludboyaca">
                + <fmt:message key='paciente.nuevo'/>
            </a>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th><fmt:message key='paciente.documento'/></th>
                            <th><fmt:message key='paciente.nombres'/></th>
                            <th><fmt:message key='paciente.apellidos'/></th>
                            <th><fmt:message key='paciente.eps'/></th>
                            <th><fmt:message key='paciente.telefono'/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${pacientes}">
                            <tr>
                                <td><strong>${p.documento}</strong></td>
                                <td>${p.nombres}</td>
                                <td>${p.apellidos}</td>
                                <td>${p.eps}</td>
                                <td>${p.telefono}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>