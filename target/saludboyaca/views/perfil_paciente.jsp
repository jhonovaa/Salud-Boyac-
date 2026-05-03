<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="app.nombre"/> - <fmt:message key="paciente.titulo"/></title>
    
    <%-- Bootstrap 5.3.8 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        /* PALETA OFICIAL SALUDBOYACÁ */
        :root {
            --color-primario: #1A5276;    
            --color-secundario: #39A900;  
            --acento-celeste: #2E86C1;    
            --fondo-body: #EAF0F7;        
            --texto-titulos: #154360;     
            --texto-normal: #2C3E50;      
            --texto-suave: #7F8C8D;       
            
            --nav-bg: rgba(255, 255, 255, 0.65);
            --card-bg: rgba(255, 255, 255, 0.85);
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
            border: 1px solid rgba(255, 255, 255, 0.9);
            box-shadow: 0 20px 40px rgba(26, 82, 118, 0.08);
            overflow: hidden; /* Para que el header azul respete los bordes */
            transition: var(--transition);
        }
        .apple-card:hover {
            box-shadow: 0 25px 50px rgba(26, 82, 118, 0.12);
            transform: translateY(-5px);
        }

        /* HEADER AZUL DE LA TARJETA */
        .card-header-blue {
            background-color: var(--color-primario);
            color: white;
            padding: 2.5rem 1rem;
            text-align: center;
            border-bottom: none;
        }

        /* TÍTULOS DE SECCIÓN */
        .section-title {
            color: var(--acento-celeste);
            font-weight: 700;
            font-size: 1.1rem;
            border-left: 4px solid var(--acento-celeste);
            padding-left: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ETIQUETAS Y DATOS */
        .data-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 700;
            color: var(--texto-suave);
            margin-bottom: 0.2rem;
        }
        .data-value {
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--texto-normal);
            border-bottom: 1px solid rgba(0,0,0,0.08);
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
        }

        /* BOTONES ESTILO APPLE */
        .btn-apple {
            border-radius: 50px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            transition: 0.3s;
            letter-spacing: 0.3px;
        }
        .btn-apple:active {
            transform: scale(0.96);
        }
        
        .btn-sena {
            background-color: var(--color-secundario);
            color: white;
            border: none;
        }
        .btn-sena:hover {
            background-color: #2b8000;
            color: white;
            box-shadow: 0 8px 20px rgba(57, 169, 0, 0.25);
        }

        .btn-outline-cancel {
            background-color: transparent;
            color: var(--texto-suave);
            border: 1px solid rgba(0,0,0,0.15);
        }
        .btn-outline-cancel:hover {
            background-color: rgba(0,0,0,0.05);
            color: var(--texto-normal);
        }

        /* Utilidad para botones en la barra de navegación */
        .btn-saludboyaca {
            background-color: var(--color-primario);
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            border-radius: 50px; 
            border: none;
        }
        .btn-saludboyaca:hover {
            background-color: #154360;
            color: white;
            box-shadow: 0 5px 15px rgba(26, 82, 118, 0.2);
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

    <!-- NAVBAR IDENTICA AL INDEX Y CONSULTA -->
    <nav class="navbar navbar-expand-lg navbar-apple sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="${pageContext.request.contextPath}/" style="color: var(--color-primario);">
                <i class="bi bi-heart-pulse-fill me-2"></i><fmt:message key="app.nombre"/>
            </a>

            <div class="d-flex align-items-center order-lg-last ms-3">
                <a class="btn btn-saludboyaca btn-apple px-4 py-2 d-none d-md-block shadow-sm" style="width: auto;" href="${pageContext.request.contextPath}/login">Intranet</a>
                <button class="navbar-toggler ms-2 border-0 shadow-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon" style="color: var(--color-primario);"><i class="bi bi-grid-fill fs-3"></i></span>
                </button>
            </div>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-medium align-items-center">
                    <li class="nav-item"><a class="nav-link px-4" href="${pageContext.request.contextPath}/">Inicio</a></li>
                    <li class="nav-item d-flex gap-2 px-4 py-2">
                        <a href="?lang=es" class="text-decoration-none fw-bold" style="color: var(--texto-normal);">ES</a>
                        <span style="color: var(--texto-suave);">|</span>
                        <a href="?lang=en" class="text-decoration-none fw-bold" style="color: var(--texto-suave);">EN</a>
                    </li>
                    <li class="nav-item d-md-none mt-3 w-100">
                        <a class="btn btn-saludboyaca btn-apple w-100" href="${pageContext.request.contextPath}/login">Intranet</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- CONTENEDOR PRINCIPAL -->
    <div class="container py-5 d-flex justify-content-center align-items-center" style="flex: 1; z-index: 1;">
        
        <div class="apple-card" style="max-width: 750px; width: 100%;">
            
            <!-- ENCABEZADO AZUL -->
            <div class="card-header-blue">
                <i class="fas fa-circle-user fa-4x mb-3 opacity-75"></i>
                <h2 class="fw-bold mb-1"><fmt:message key="paciente.titulo" /></h2>
                <p class="mb-0 fs-5 opacity-75">${not empty paciente ? paciente.nombres : ''} ${not empty paciente ? paciente.apellidos : ''}</p>
            </div>

            <!-- CUERPO DE DATOS -->
            <div class="p-4 p-md-5">
                
                <!-- SECCIÓN 1: Identificación -->
                <div class="mb-4">
                    <h5 class="section-title"><i class="fas fa-id-card"></i> <fmt:message key="paciente.identificacion" /></h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="data-label"><fmt:message key="paciente.documento" /></div>
                            <div class="data-value">${not empty paciente ? paciente.documento : '-'}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="data-label"><fmt:message key="paciente.nombres.completos" /></div>
                            <div class="data-value">${not empty paciente ? paciente.nombres : '-'} ${not empty paciente ? paciente.apellidos : ''}</div>
                        </div>
                    </div>
                </div>

                <!-- SECCIÓN 2: Contacto -->
                <div class="mb-4">
                    <h5 class="section-title"><i class="fas fa-map-marker-alt"></i> <fmt:message key="paciente.contacto" /></h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="data-label"><fmt:message key="paciente.telefono" /></div>
                            <div class="data-value">${not empty paciente ? paciente.telefono : '-'}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="data-label"><fmt:message key="paciente.correo" /></div>
                            <div class="data-value">${not empty paciente.email ? paciente.email : 'No registrado'}</div>
                        </div>
                    </div>
                </div>

                <!-- SECCIÓN 3: Datos Médicos -->
                <div class="mb-4">
                    <h5 class="section-title"><i class="fas fa-hospital-user"></i> <fmt:message key="paciente.datos.medicos" /></h5>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="data-label"><fmt:message key="paciente.eps" /></div>
                            <div class="data-value text-uppercase">${not empty paciente ? paciente.eps : '-'}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="data-label"><fmt:message key="paciente.nacimiento" /></div>
                            <div class="data-value">
                                <c:if test="${not empty paciente.fechaNacimiento}">
                                    <fmt:formatDate value="${paciente.fechaNacimiento}" pattern="dd/MM/yyyy" />
                                </c:if>
                                <c:if test="${empty paciente.fechaNacimiento}">-</c:if>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- BOTONES DE ACCIÓN -->
                <div class="d-flex flex-column flex-sm-row justify-content-between align-items-center mt-5 pt-4 gap-3" style="border-top: 1px solid rgba(0,0,0,0.08);">
                    
                    <!-- Botón Cancelar (Volver) -->
                    <a href="${pageContext.request.contextPath}/consulta-cita" class="btn btn-outline-cancel btn-apple w-100 w-sm-auto text-center">
                        <i class="fas fa-arrow-left me-2"></i> <fmt:message key="paciente.cancelar" />
                    </a>
                    
                    <!-- Botón Generar PDF -->
                    <form action="${pageContext.request.contextPath}/generar-pdf" method="get" class="m-0 w-100 w-sm-auto">
                        <input type="hidden" name="documento" value="${paciente.documento}">
                        <button type="submit" class="btn btn-sena btn-apple shadow-sm w-100">
                            <i class="fas fa-file-pdf me-2"></i> <fmt:message key="consulta.descargar" />
                        </button>
                    </form>
                    
                </div>

            </div>
        </div>
    </div>

    <!-- FOOTER CONSISTENTE -->
    <footer class="py-4 text-center mt-auto" style="background: rgba(255, 255, 255, 0.4); backdrop-filter: blur(10px); border-top: 1px solid rgba(255,255,255,0.6); z-index: 1;">
        <div class="container">
            <p class="mb-0 fw-medium small" style="color: var(--texto-suave);">&copy; 2026 - <fmt:message key="app.nombre"/> - ADSO CIMM SENA</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
