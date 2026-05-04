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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        /* PALETA OFICIAL SALUDBOYACA */
        :root {
            --color-primario: #1A5276;    
            --color-secundario: #39A900;  
            --acento-celeste: #2E86C1;    
            --fondo-body: #EAF0F7;        
            --texto-titulos: #154360;     
            --texto-normal: #2C3E50;      
            --texto-suave: #7F8C8D;       
            
            --nav-bg: rgba(255, 255, 255, 0.65);
            --card-bg: rgba(255, 255, 255, 0.75);
            --transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }

        body {
            background-color: var(--fondo-body);
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            color: var(--texto-normal);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow-x: hidden;
        }

        /* BURBUJAS DE FONDO ANIMADAS */
        .bg-blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            z-index: -1;
            opacity: 0.3;
            animation: float 15s ease-in-out infinite;
        }
        .blob-1 { top: 10%; left: -5%; width: 400px; height: 400px; background: var(--color-primario); }
        .blob-2 { bottom: -5%; right: -5%; width: 500px; height: 500px; background: var(--color-secundario); animation-delay: -5s; }

        @keyframes float {
            0% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(30px, -50px) scale(1.1); }
            66% { transform: translate(-20px, 20px) scale(0.9); }
            100% { transform: translate(0, 0) scale(1); }
        }

        /* NAVBAR ESTILO APPLE (Glassmorphism) */
        .navbar-apple {
            background: var(--nav-bg) !important;
            backdrop-filter: blur(25px) saturate(200%);
            -webkit-backdrop-filter: blur(25px) saturate(200%);
            border-bottom: 1px solid rgba(255, 255, 255, 0.8);
            padding: 12px 0 !important;
            box-shadow: 0 4px 30px rgba(0,0,0,0.03);
            z-index: 1000;
        }
        .nav-link {
            color: var(--texto-normal) !important;
            font-weight: 500;
            transition: 0.3s;
        }
        .nav-link:hover {
            color: var(--color-primario) !important;
            transform: translateY(-1px);
        }

        /* TARJETA DE CRISTAL (GLASSMORPHISM) */
        .apple-card {
            background: var(--card-bg);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border-radius: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.8);
            box-shadow: 0 20px 40px rgba(26, 82, 118, 0.08);
            transition: var(--transition);
        }

        /* ESTILOS DE INPUTS Y FORMULARIOS */
        .input-group-text {
            background-color: white;
            color: var(--acento-celeste);
            border: 1px solid rgba(0,0,0,0.1);
        }
        .form-control {
            background-color: white;
            border: 1px solid rgba(0,0,0,0.1);
            color: var(--texto-normal);
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(26, 82, 118, 0.15);
            border-color: var(--color-primario);
            background-color: #ffffff;
        }

        /* CONTENEDOR DEL CAPTCHA CORREGIDO */
        .captcha-container {
            background-color: rgba(255, 255, 255, 0.5);
            border: 1px dashed rgba(26, 82, 118, 0.3);
            border-radius: 1.5rem;
            padding: 30px 20px;
            transition: var(--transition);
        }
        .captcha-container:hover {
            background-color: rgba(255, 255, 255, 0.7);
            border-color: var(--acento-celeste);
        }

        /* BOTONES ESTILO APPLE */
        .btn-apple {
            border-radius: 980px;
            padding: 14px 32px;
            font-weight: 600;
            transition: 0.3s;
            letter-spacing: 0.5px;
            border: none;
        }
        .btn-saludboyaca {
            background-color: var(--color-primario);
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            border-radius: 50px; 
            border: none;
            letter-spacing: 0.5px;
        }
        .btn-saludboyaca:hover {
            background-color: #154360;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(26, 82, 118, 0.25);
        }
        .btn-saludboyaca:active, .btn-apple:active {
            transform: scale(0.96);
        }

        /* TABLA DE RESULTADOS */
        .table-wrapper {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 1.5rem;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.03);
            border: 1px solid rgba(0,0,0,0.05);
        }
        .table-custom thead th {
            background-color: rgba(26, 82, 118, 0.05);
            color: var(--texto-titulos);
            border-bottom: 2px solid rgba(26, 82, 118, 0.1);
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        .table-custom tbody tr {
            transition: var(--transition);
        }
        .table-custom tbody tr:hover {
            background-color: rgba(46, 134, 193, 0.05);
            transform: scale(1.01);
        }

        @media (max-width: 991px) {
            .navbar-collapse {
                background: var(--nav-bg);
                backdrop-filter: blur(25px);
                padding: 25px;
                border-radius: 25px;
                margin-top: 15px;
                border: 1px solid rgba(255,255,255,0.8);
            }
        }
    </style>
</head>
<body>

    <!-- BURBUJAS DE CRISTAL -->
    <div class="bg-blob blob-1"></div>
    <div class="bg-blob blob-2"></div>

    <!-- NAVBAR IDENTICA AL INDEX -->
    <nav class="navbar navbar-expand-lg navbar-apple sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/" style="color: var(--color-primario);">
                <i class="bi bi-heart-pulse-fill me-2"></i>SaludBoyaca
            </a>

            <div class="d-flex align-items-center order-lg-last ms-3">
                <a class="btn btn-saludboyaca btn-apple px-4 py-2 d-none d-md-block shadow-sm" style="width: auto;" href="${pageContext.request.contextPath}/login"><fmt:message key='index.nav.intranet'/></a>
                <button class="navbar-toggler ms-2 border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon" style="color: var(--color-primario);"><i class="bi bi-grid-fill fs-3"></i></span>
                </button>
            </div>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-medium align-items-center">
                    <li class="nav-item"><a class="nav-link px-4" href="${pageContext.request.contextPath}/"><fmt:message key='index.nav.inicio'/></a></li>
                    <li class="nav-item d-flex gap-2 px-4 py-2">
                        <a href="?lang=es" class="text-decoration-none fw-bold" style="color: var(--texto-normal);">ES</a>
                        <span style="color: var(--texto-suave);">|</span>
                        <a href="?lang=en" class="text-decoration-none fw-bold" style="color: var(--texto-suave);">EN</a>
                    </li>
                    <li class="nav-item d-md-none mt-3 w-100">
                        <a class="btn btn-saludboyaca btn-apple w-100" href="${pageContext.request.contextPath}/login"><fmt:message key='index.nav.intranet'/></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENEDOR PRINCIPAL -->
    <div class="container py-5 d-flex justify-content-center align-items-center" style="flex: 1; z-index: 1;">
        
        <!-- TARJETA GLASSMORPHISM -->
        <div class="card p-4 p-md-5 apple-card" style="max-width: 650px; width: 100%;">
            
            <div class="text-center mb-5">
                <div class="d-inline-flex align-items-center justify-content-center rounded-4 mb-3 shadow-sm" style="background-color: white; width: 80px; height: 80px;">
                    <i class="fas fa-search-plus fa-2x" style="color: var(--color-primario);"></i>
                </div>
                <h3 class="fw-bold" style="font-size: 2rem; color: var(--texto-titulos);"><fmt:message key='app.institucion'/></h3>
                <p class="text-muted fw-medium"><fmt:message key='consulta.titulo'/></p>
            </div>

            <!-- MANEJO DE ERRORES -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show text-center rounded-4 shadow-sm border-0 mb-4" style="background-color: #FADBD8; color: #922B21;" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i> <strong><fmt:message key='consulta.alerta.ups'/></strong> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- FORMULARIO DE BUSQUEDA -->
            <form action="${pageContext.request.contextPath}/consulta-cita" method="POST">
                
                <!-- Input del Documento (Alineado a la izquierda para mejor lectura) -->
                <div class="mb-4 text-start">
                    <label class="form-label fw-bold" style="color: var(--texto-titulos);"><fmt:message key='consulta.documento'/></label>
                    <div class="input-group input-group-lg shadow-sm rounded-4 overflow-hidden">
                        <span class="input-group-text border-end-0"><i class="fas fa-id-card"></i></span>
                        <input type="text" name="documento" class="form-control border-start-0 py-3" required placeholder="<fmt:message key='consulta.documento.placeholder'/>">
                    </div>
                </div>
                
                <!-- Contenedor del CAPTCHA Corregido -->
                <div class="captcha-container mb-5 text-center">
                    <label class="form-label d-block fw-bold mb-4" style="color: var(--texto-titulos);"><fmt:message key='consulta.captcha'/></label>
                    
                    <div class="mb-4 d-flex justify-content-center">
                        <!-- IMAGEN DEL CAPTCHA (Con mas espacio y resalte) -->
                        <div class="bg-white p-2 border rounded-4 shadow-sm d-inline-block">
                            <img src="${captchaImage}" alt="<fmt:message key='consulta.captcha'/>" style="height: 60px; object-fit: contain;">
                        </div>
                    </div>
                    
                    <!-- Input del CAPTCHA (Ya no esta limitado a 300px, ocupa todo el ancho disponible) -->
                    <div class="input-group input-group-lg shadow-sm rounded-4 overflow-hidden w-100">
                        <span class="input-group-text border-end-0"><i class="fas fa-shield-alt" style="color: var(--color-secundario);"></i></span>
                        <input type="text" name="captcha" class="form-control border-start-0 text-center fw-bold text-uppercase" placeholder="<fmt:message key='consulta.captcha.placeholder'/>" required autocomplete="off" style="letter-spacing: 2px;">
                    </div>
                </div>

                <button type="submit" class="btn btn-saludboyaca w-100 py-3 fs-5">
                    <i class="fas fa-search me-2"></i> <fmt:message key='consulta.buscar'/>
                </button>
            </form>
            
            <%-- RESULTADOS DE LA CONSULTA --%>
            <c:if test="${not empty citasEncontradas}">
                <div class="mt-5 border-top pt-4" style="border-color: rgba(0,0,0,0.1) !important;">
                    <div class="text-center mb-4">
                        <span class="badge rounded-pill px-3 py-2 shadow-sm" style="background-color: #D5F5E3; color: #1E8449; font-size: 0.9rem;">
                            <i class="fas fa-check-circle me-1"></i> <fmt:message key='consulta.resultados.encontrados'/>
                        </span>
                    </div>
                    
                    <div class="table-wrapper">
                        <table class="table table-custom align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="py-3 px-4"><fmt:message key='cita.fecha'/></th>
                                    <th class="py-3"><fmt:message key='cita.especialidad'/></th>
                                    <th class="text-center py-3">PDF</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white">
                                <c:forEach var="c" items="${citasEncontradas}">
                                    <tr>
                                        <td class="px-4 py-3">
                                            <div class="fw-bold" style="color: var(--texto-titulos);">${c.fechaCita}</div>
                                            <div class="text-muted small"><i class="far fa-clock me-1"></i>${c.horaCita}</div>
                                        </td>
                                        <td class="py-3">
                                            <span class="badge rounded-pill px-3 py-2" style="background-color: rgba(46, 134, 193, 0.1); color: var(--acento-celeste); border: 1px solid rgba(46, 134, 193, 0.2);">
                                                ${c.especialidadNombre}
                                            </span>
                                        </td>
                                        <td class="text-center py-3">
                                            <a href="${pageContext.request.contextPath}/pdf?id=${c.id}" class="btn btn-sm btn-outline-danger px-3 rounded-pill fw-bold shadow-sm" title="<fmt:message key='cita.descargar'/>">
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

    <!-- FOOTER CONSISTENTE -->
    <footer class="py-4 text-center mt-auto" style="background: rgba(255, 255, 255, 0.4); backdrop-filter: blur(10px); border-top: 1px solid rgba(255,255,255,0.6); z-index: 1;">
        <div class="container">
            <p class="mb-0 fw-medium small" style="color: var(--texto-suave);">&copy; 2026 - <fmt:message key='app.institucion'/> - ADSO CIMM SENA</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>