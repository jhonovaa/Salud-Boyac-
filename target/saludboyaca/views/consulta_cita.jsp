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
    <title><fmt:message key='consulta.titulo'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #EAF0F7; /* Gris hielo del manual de diseno */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .consulta-card {
            border-radius: 16px;
            border-top: 6px solid #1A5276; /* Acento Azul Salud */
        }
        .btn-saludboyaca {
            background-color: #1A5276;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            border-radius: 10px;
        }
        .btn-saludboyaca:hover {
            background-color: #154360;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(26, 82, 118, 0.2);
        }
        .captcha-container {
            background-color: #f8f9fa;
            border: 1px dashed #ced4da;
            border-radius: 12px;
            padding: 20px;
        }
        .input-group-text {
            background-color: transparent;
            color: #1A5276;
        }
        .table-custom thead th {
            background-color: #1A5276;
            color: white;
            border-bottom: none;
        }
        .table-custom tbody tr:hover {
            background-color: rgba(46, 134, 193, 0.05);
        }
    </style>
</head>
<body>

    <%@ include file="templates/header.jsp" %>

    <div class="container py-5 d-flex justify-content-center align-items-center" style="min-height: calc(100vh - 70px);">
        <div class="card p-4 p-md-5 shadow-lg border-0 consulta-card" style="max-width: 600px; width: 100%;">
            
            <div class="text-center mb-4">
                <div class="d-inline-block p-3 rounded-circle mb-3" style="background-color: rgba(26, 82, 118, 0.1);">
                    <i class="fas fa-search-plus fa-3x" style="color: #1A5276;"></i>
                </div>
                <h3 class="fw-bold" style="color: #1A5276;"><fmt:message key='app.institucion'/></h3>
                <h5 class="text-muted"><fmt:message key='consulta.titulo'/></h5>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show text-center rounded-3" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/consulta-cita" method="POST">
                
                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary"><fmt:message key='consulta.documento'/></label>
                    <div class="input-group input-group-lg shadow-sm rounded-3">
                        <span class="input-group-text border-end-0"><i class="fas fa-id-card"></i></span>
                        <input type="text" name="documento" class="form-control border-start-0" required placeholder="<fmt:message key='consulta.documento.placeholder'/>">
                    </div>
                </div>
                
                <div class="captcha-container mb-4 text-center shadow-sm">
                    <label class="form-label d-block fw-bold text-secondary mb-3"><fmt:message key='consulta.captcha'/></label>
                    
                    <div class="mb-3">
                        <img src="${captchaImage}" class="border rounded-3 shadow-sm bg-white" alt="<fmt:message key='consulta.captcha'/>" style="max-width: 100%; height: auto;">
                    </div>
                    
                    <div class="input-group input-group-lg">
                        <span class="input-group-text bg-white border-end-0"><i class="fas fa-shield-alt text-success"></i></span>
                        <input type="text" name="captcha" class="form-control border-start-0 text-center text-uppercase fw-bold" placeholder="<fmt:message key='consulta.captcha.placeholder'/>" required autocomplete="off" style="letter-spacing: 2px;">
                    </div>
                </div>

                <button type="submit" class="btn btn-saludboyaca w-100 py-3 fs-5 shadow-sm">
                    <i class="fas fa-search me-2"></i> <fmt:message key='consulta.buscar'/>
                </button>
            </form>
            
            <%-- Resultados de la consulta --%>
            <c:if test="${not empty citasEncontradas}">
                <div class="mt-5 border-top pt-4">
                    <h5 class="text-center fw-bold mb-4" style="color: #39A900;">
                        <i class="fas fa-check-circle me-2"></i> <fmt:message key='consulta.resultados.encontrados'/>
                    </h5>
                    
                    <div class="table-responsive rounded-3 shadow-sm border">
                        <table class="table table-custom table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="py-3 px-3"><fmt:message key='cita.fecha'/></th>
                                    <th class="py-3"><fmt:message key='cita.especialidad'/></th>
                                    <th class="text-center py-3">PDF</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white">
                                <c:forEach var="c" items="${citasEncontradas}">
                                    <tr>
                                        <td class="px-3">
                                            <div class="fw-bold text-dark">${c.fechaCita}</div>
                                            <div class="text-muted small"><i class="far fa-clock me-1"></i>${c.horaCita}</div>
                                        </td>
                                        <td>
                                            <span class="badge" style="background-color: rgba(46, 134, 193, 0.1); color: #2E86C1; border: 1px solid #2E86C1;">
                                                ${c.especialidadNombre}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/pdf?id=${c.id}" class="btn btn-sm btn-outline-danger px-3 rounded-pill" title="<fmt:message key='cita.descargar'/>">
                                                <i class="fas fa-file-pdf me-1"></i> PDF
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>