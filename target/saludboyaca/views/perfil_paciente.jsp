<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="app.nombre"/> - <fmt:message key="paciente.titulo"/></title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/saludboyaca.css">
    
    <style>
        body { 
            background-color: #EAF0F7; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        }
        .card-header-salud { 
            background-color: #1A5276; 
            color: white; 
            border-radius: 16px 16px 0 0 !important; 
        }
        .data-label { 
            color: #7F8C8D; 
            font-weight: 600; 
            font-size: 0.85rem; 
            text-transform: uppercase; 
            margin-bottom: 2px;
        }
        .data-value { 
            color: #2C3E50; 
            font-size: 1rem; 
            font-weight: 500; 
            border-bottom: 1px solid #dee2e6; 
            padding-bottom: 5px; 
        }
        .icon-accent { 
            color: #2E86C1; 
            margin-right: 8px; 
        }
        .btn-download { 
            background-color: #39A900; 
            color: white; 
            border: none; 
            transition: 0.3s; 
            font-weight: 600;
        }
        .btn-download:hover { 
            background-color: #2d8500; 
            color: white; 
            transform: translateY(-2px); 
            box-shadow: 0 4px 10px rgba(57, 169, 0, 0.2);
        }
    </style>
</head>
<body>

<%@ include file="templates/header.jsp" %>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="card shadow border-0" style="border-radius: 16px;">
                
                <div class="card-header card-header-salud p-3 text-center">
                    <i class="fas fa-user-circle fa-3x mb-2"></i>
                    <h4 class="mb-0 fw-bold"><fmt:message key="paciente.titulo" /></h4>
                    <p class="mb-0 opacity-75 small">${paciente.nombres} ${paciente.apellidos}</p>
                </div>

                <div class="card-body p-4 bg-white">
                    <div class="row g-3">
                        
                        <div class="col-12">
                            <h6 class="text-primary mb-2 border-start border-3 border-primary ps-2">
                                <i class="fas fa-id-card icon-accent"></i><fmt:message key="paciente.identificacion" />
                            </h6>
                        </div>
                        <div class="col-sm-6">
                            <label class="data-label"><fmt:message key="paciente.documento" /></label>
                            <div class="data-value">${paciente.documento}</div>
                        </div>
                        <div class="col-sm-6">
                            <label class="data-label"><fmt:message key="paciente.nombres.completos" /></label>
                            <div class="data-value">${paciente.nombres} ${paciente.apellidos}</div>
                        </div>

                        <div class="col-12 mt-3">
                            <h6 class="text-primary mb-2 border-start border-3 border-primary ps-2">
                                <i class="fas fa-map-marker-alt icon-accent"></i><fmt:message key="paciente.contacto" />
                            </h6>
                        </div>
                        <div class="col-sm-6">
                            <label class="data-label"><fmt:message key="paciente.telefono" /></label>
                            <div class="data-value">${paciente.telefono}</div>
                        </div>
                        <div class="col-sm-6">
                            <label class="data-label"><fmt:message key="paciente.correo" /></label>
                            <div class="data-value">${paciente.email}</div>
                        </div>

                        <div class="col-12 mt-3">
                            <h6 class="text-primary mb-2 border-start border-3 border-primary ps-2">
                                <i class="fas fa-hospital icon-accent"></i><fmt:message key="paciente.datos.medicos" />
                            </h6>
                        </div>
                        <div class="col-sm-6">
                            <label class="data-label"><fmt:message key="paciente.eps" /></label>
                            <div class="data-value">${paciente.eps}</div>
                        </div>
                        <div class="col-sm-6">
                            <label class="data-label"><fmt:message key="paciente.nacimiento" /></label>
                            <div class="data-value">
                                <fmt:formatDate value="${paciente.fechaNacimiento}" pattern="dd/MM/yyyy" />
                            </div>
                        </div>

                    </div>
                </div>

                <div class="card-footer p-3 bg-light d-flex justify-content-between align-items-center" style="border-radius: 0 0 16px 16px;">
                    <a href="${pageContext.request.contextPath}/consulta-cita" class="btn btn-outline-secondary btn-sm px-3">
                        <i class="fas fa-arrow-left me-1"></i><fmt:message key="paciente.cancelar" />
                    </a>
                    
                    <form action="${pageContext.request.contextPath}/generar-pdf" method="get" class="m-0">
                        <input type="hidden" name="documento" value="${paciente.documento}">
                        <button type="submit" class="btn btn-download btn-sm px-3 shadow-sm">
                            <i class="fas fa-file-pdf me-1"></i><fmt:message key="consulta.descargar" />
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>