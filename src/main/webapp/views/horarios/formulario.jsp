<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty horario}">Editar Horario</c:when>
            <c:otherwise>Asignar Horario</c:otherwise>
        </c:choose>
    </title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        .main-wrapper {
            margin-left: 295px;
            padding: 2rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .top-navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--acento-celeste);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        .form-card {
            background: var(--blanco-puro);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border-top: 4px solid var(--color-primario);
        }
        @media (max-width: 992px) {
            .main-wrapper {
                margin-left: 0;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    
    <jsp:include page="/views/templates/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <h4 class="fw-bold mb-0" style="color: var(--texto-titulos);">
                <c:choose>
                    <c:when test="${not empty horario}">
                        <i class="fa-solid fa-pen-to-square me-2"></i>Editar Horario Médico
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-calendar-plus me-2"></i>Asignar Nuevo Horario
                    </c:otherwise>
                </c:choose>
            </h4>
            <a href="${pageContext.request.contextPath}/horarios" class="btn btn-outline-secondary fw-bold rounded-pill px-4">
                <i class="fa-solid fa-arrow-left me-1"></i> Volver a la Lista
            </a>
        </header>

        <div class="container-fluid px-0">
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/horarios" method="POST">
                    <input type="hidden" name="accion" value="${not empty horario ? 'actualizar' : 'insertar'}">
                    
                    <c:if test="${not empty horario}">
                        <input type="hidden" name="id" value="${horario.id}">
                    </c:if>
                    
                    <div class="row g-4 mb-4">
                        
                        <!-- Columna Izquierda -->
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);">Médico Asignado</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-user-doctor text-muted"></i></span>
                                    <select name="idMedico" class="form-select border-start-0" required>
                                        <option value="">Seleccione un Médico...</option>
                                        <%-- Este bucle carga solo los usuarios que tengan rol de MEDICO --%>
                                        <c:forEach var="u" items="${usuarios}">
                                            <c:if test="${u.rol == 'MEDICO'}">
                                                <option value="${u.id}" ${not empty horario && horario.idMedico == u.id ? 'selected' : ''}>
                                                    Dr/Dra. ${u.nombres} ${u.apellidos}
                                                </option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);">Día de la Semana</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-regular fa-calendar-days text-muted"></i></span>
                                    <select name="diaSemana" class="form-select border-start-0" required>
                                        <option value="">Seleccione un día...</option>
                                        <option value="1" ${horario.diaSemana == 1 ? 'selected' : ''}>Lunes</option>
                                        <option value="2" ${horario.diaSemana == 2 ? 'selected' : ''}>Martes</option>
                                        <option value="3" ${horario.diaSemana == 3 ? 'selected' : ''}>Miércoles</option>
                                        <option value="4" ${horario.diaSemana == 4 ? 'selected' : ''}>Jueves</option>
                                        <option value="5" ${horario.diaSemana == 5 ? 'selected' : ''}>Viernes</option>
                                        <option value="6" ${horario.diaSemana == 6 ? 'selected' : ''}>Sábado</option>
                                        <option value="7" ${horario.diaSemana == 7 ? 'selected' : ''}>Domingo</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Columna Derecha -->
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-6 mb-4">
                                    <label class="form-label fw-bold" style="color: var(--texto-normal);">Hora Inicio</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="fa-regular fa-clock text-success"></i></span>
                                        <input type="time" name="horaInicio" class="form-control border-start-0" value="${not empty horario ? horario.horaInicio : ''}" required>
                                    </div>
                                </div>
                                <div class="col-6 mb-4">
                                    <label class="form-label fw-bold" style="color: var(--texto-normal);">Hora Fin</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-clock text-danger"></i></span>
                                        <input type="time" name="horaFin" class="form-control border-start-0" value="${not empty horario ? horario.horaFin : ''}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);">Límite Máximo de Citas</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-users text-muted"></i></span>
                                    <input type="number" name="maxCitas" class="form-control border-start-0" min="1" max="50" value="${not empty horario ? horario.maxCitas : '10'}" required>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr class="mb-4" style="opacity: 0.1;">

                    <div class="text-end">
                        <a href="${pageContext.request.contextPath}/horarios" class="btn btn-secondary px-4 py-2 fw-bold" style="border-radius: 12px;">
                            Cancelar
                        </a>
                        <button type="submit" class="btn btn-saludboyaca ms-2 px-4 py-2 fw-bold" style="border-radius: 12px;">
                            <i class="fa-solid fa-save me-2"></i>Guardar Horario
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>