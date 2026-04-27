<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='cita.titulo'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/templates/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: var(--texto-titulos);"><fmt:message key='cita.titulo'/></h2>
            <a href="${pageContext.request.contextPath}/citas?accion=nuevo" class="btn btn-saludboyaca">
                + <fmt:message key='cita.nueva'/>
            </a>
        </div>

        <c:if test="${param.mensaje == 'ok'}">
            <div class="alert alert-success"><fmt:message key='alerta.exito'/></div>
        </c:if>

        <div class="card shadow-sm border-0">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th><fmt:message key='cita.fecha'/></th>
                            <th><fmt:message key='cita.hora'/></th>
                            <th><fmt:message key='cita.paciente'/></th>
                            <th><fmt:message key='cita.medico'/></th>
                            <th><fmt:message key='cita.especialidad'/></th>
                            <th><fmt:message key='cita.estado'/></th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${citas}">
                            <tr>
                                <td>${c.fechaCita}</td>
                                <td>${c.horaCita}</td>
                                <td>
                                    <strong>${c.pacienteNombre}</strong><br>
                                    <small class="text-muted">CC: ${c.pacienteDocumento}</small>
                                </td>
                                <td>${c.medicoNombre}</td>
                                <td>${c.especialidadNombre}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.estado == 'PROGRAMADA'}">
                                            <span class="badge bg-warning text-dark"><fmt:message key='cita.estado.programada'/></span>
                                        </c:when>
                                        <c:when test="${c.estado == 'CONFIRMADA'}">
                                            <span class="badge" style="background-color: var(--color-sena);"><fmt:message key='cita.estado.confirmada'/></span>
                                        </c:when>
                                        <c:when test="${c.estado == 'ATENDIDA'}">
                                            <span class="badge bg-info text-dark"><fmt:message key='cita.estado.atendida'/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger"><fmt:message key='cita.estado.cancelada'/></span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/citas" method="POST" class="d-inline">
                                        <input type="hidden" name="accion" value="cambiarEstado">
                                        <input type="hidden" name="id" value="${c.id}">
                                        <input type="hidden" name="estado" value="CONFIRMADA">
                                        <button type="submit" class="btn btn-sm btn-outline-success" title="Confirmar">✓</button>
                                    </form>
                                    <a href="${pageContext.request.contextPath}/pdf?id=${c.id}" class="btn btn-sm btn-outline-primary" target="_blank" title="<fmt:message key='cita.descargar'/>">
                                        📄
                                    </a>
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