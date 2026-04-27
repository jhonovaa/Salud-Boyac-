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
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card p-4 shadow border-0" style="max-width: 500px; width: 100%;">
            <div class="text-center mb-4">
                <h3 style="color: var(--color-primario);"><fmt:message key='app.institucion'/></h3>
                <h5 class="text-muted"><fmt:message key='consulta.titulo'/></h5>
            </div>

            <form action="${pageContext.request.contextPath}/consulta-cita" method="POST">
                <div class="mb-3">
                    <label class="form-label fw-bold"><fmt:message key='consulta.documento'/></label>
                    <input type="text" name="documento" class="form-control" required>
                </div>
                
                <div class="mb-4 text-center">
                    <label class="form-label d-block fw-bold"><fmt:message key='consulta.captcha'/></label>
                    <img src="${captchaImage}" class="mb-2 border rounded shadow-sm">
                    <input type="text" name="captcha" class="form-control text-center text-uppercase" placeholder="Escriba el código de la imagen" required>
                </div>

                <button type="submit" class="btn btn-saludboyaca w-100 py-2 fs-5">
                    <fmt:message key='consulta.buscar'/>
                </button>
            </form>
            
            <%-- Resultados de la consulta --%>
            <c:if test="${not empty citasEncontradas}">
                <div class="mt-4 table-responsive">
                    <table class="table table-sm small">
                        <thead>
                            <tr>
                                <th><fmt:message key='cita.fecha'/></th>
                                <th><fmt:message key='cita.especialidad'/></th>
                                <th>PDF</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${citasEncontradas}">
                                <tr>
                                    <td>${c.fechaCita} ${c.horaCita}</td>
                                    <td>${c.especialidadNombre}</td>
                                    <td>
                                        <a href="pdf?id=${c.id}" class="btn btn-sm btn-danger"><i class="fas fa-file-pdf"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>