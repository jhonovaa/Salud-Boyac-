<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='cita.nueva'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="/views/templates/header.jsp" />

    <div class="container mt-4">
        <h2 class="mb-4" style="color: var(--texto-titulos);"><fmt:message key='cita.nueva'/></h2>
        
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/citas" method="POST">
                    <input type="hidden" name="accion" value="insertar">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold"><fmt:message key='cita.paciente'/></label>
                            <input type="number" name="idPaciente" class="form-control" placeholder="ID del paciente (Temporal)" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold"><fmt:message key='cita.especialidad'/></label>
                            <select name="idEspecialidad" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <c:forEach var="e" items="${especialidades}">
                                    <option value="${e.id}">${e.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4">
                            <label class="form-label fw-bold"><fmt:message key='cita.medico'/></label>
                            <input type="number" name="idMedico" class="form-control" placeholder="ID del Médico" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold"><fmt:message key='cita.fecha'/></label>
                            <input type="date" name="fechaCita" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold"><fmt:message key='cita.hora'/></label>
                            <input type="time" name="horaCita" class="form-control" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold"><fmt:message key='cita.motivo'/></label>
                        <textarea name="motivo" class="form-control" rows="3" required></textarea>
                    </div>

                    <div class="text-end">
                        <a href="${pageContext.request.contextPath}/citas" class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-saludboyaca ms-2">Programar Cita</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>