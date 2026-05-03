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
            <c:when test="${not empty paciente}">
                <fmt:message key='paciente.editar'/>
            </c:when>
            <c:otherwise>
                <fmt:message key='paciente.nuevo'/>
            </c:otherwise>
        </c:choose>
    </title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        /* Ajuste Dinamico para la Sidebar */
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
                    <c:when test="${not empty paciente}">
                        <i class="fa-solid fa-user-pen me-2"></i><fmt:message key='paciente.editar'/>
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-user-plus me-2"></i><fmt:message key='paciente.nuevo'/>
                    </c:otherwise>
                </c:choose>
            </h4>
            <a href="${pageContext.request.contextPath}/pacientes" class="btn btn-outline-secondary fw-bold rounded-pill px-4">
                <i class="fa-solid fa-arrow-left me-1"></i> <fmt:message key='paciente.volver'/>
            </a>
        </header>

        <div class="container-fluid px-0">
            
            <div class="form-card">
                <form action="${pageContext.request.contextPath}/pacientes" method="POST">
                    <%-- Acción dinámica: actualizar o insertar --%>
                    <input type="hidden" name="accion" value="${not empty paciente ? 'actualizar' : 'insertar'}">
                    
                    <%-- Enviamos el ID oculto solo si estamos editando --%>
                    <c:if test="${not empty paciente}">
                        <input type="hidden" name="id" value="${paciente.id}">
                    </c:if>
                    
                    <div class="row g-4 mb-4">
                        
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='paciente.nombres'/></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-user text-muted"></i></span>
                                    <input type="text" name="nombres" class="form-control border-start-0" value="${paciente.nombres}" required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='paciente.documento'/></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-id-card text-muted"></i></span>
                                    <input type="text" name="documento" class="form-control border-start-0" value="${paciente.documento}" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='paciente.eps'/></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-notes-medical text-muted"></i></span>
                                    <input type="text" name="eps" class="form-control border-start-0" value="${paciente.eps}" required>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='paciente.apellidos'/></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-regular fa-user text-muted"></i></span>
                                    <input type="text" name="apellidos" class="form-control border-start-0" value="${paciente.apellidos}" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='paciente.nacimiento'/></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-calendar-days text-muted"></i></span>
                                    <input type="date" name="fechaNacimiento" class="form-control border-start-0" value="${paciente.fechaNacimiento}" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold" style="color: var(--texto-normal);"><fmt:message key='paciente.telefono'/></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-phone text-muted"></i></span>
                                    <input type="text" name="telefono" class="form-control border-start-0" value="${paciente.telefono}">
                                </div>
                            </div>
                        </div>

                    </div>

                    <hr class="mb-4" style="opacity: 0.1;">

                    <div class="text-end">
                        <a href="${pageContext.request.contextPath}/pacientes" class="btn btn-secondary px-4 py-2 fw-bold" style="border-radius: 12px;">
                            <fmt:message key='paciente.cancelar'/>
                        </a>
                        <button type="submit" class="btn btn-saludboyaca ms-2 px-4 py-2 fw-bold" style="border-radius: 12px;">
                            <i class="fa-solid fa-save me-2"></i><fmt:message key='paciente.guardar'/>
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