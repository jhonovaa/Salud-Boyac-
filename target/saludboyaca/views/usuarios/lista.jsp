<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/templates/header.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4" style="color: var(--texto-titulos);">Gestión de Personal</h2>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Documento</th>
                            <th>Nombres y Apellidos</th>
                            <th>Email</th>
                            <th>Usuario (Login)</th>
                            <th>Rol</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${usuarios}">
                            <tr>
                                <td>${u.documento}</td>
                                <td>${u.nombres} ${u.apellidos}</td>
                                <td>${u.email}</td>
                                <td><strong>${u.username}</strong></td>
                                <td>
                                    <span class="badge bg-secondary">${u.rol}</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>