<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key='index.titulo_pestana'/></title>

    <%-- Bootstrap 5.3.8 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
        crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">

    <style>
        /* PALETA OFICIAL SALUDBOYACA */
        :root {
            --color-primario: #1A5276;
            /* Azul salud */
            --color-secundario: #39A900;
            /* Verde SENA */
            --acento-celeste: #2E86C1;
            /* Celeste suave */
            --fondo-body: #EAF0F7;
            /* Gris hielo */
            --blanco-puro: #FFFFFF;
            /* Blanco puro */
            --texto-titulos: #154360;
            /* Azul oscuro */
            --texto-normal: #2C3E50;
            /* Gris oscuro */
            --texto-suave: #7F8C8D;
            /* Gris medio */

            --nav-bg: rgba(255, 255, 255, 0.65);
            --card-bg: rgba(255, 255, 255, 0.70);
            --transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            scroll-behavior: smooth;
            color: var(--texto-normal);
            background-color: var(--fondo-body);
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Circulos de fondo para el efecto de cristal (CON COLORES INSTITUCIONALES) */
        .bg-blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(100px);
            z-index: -1;
            opacity: 0.3;
            animation: float 15s ease-in-out infinite;
        }

        .blob-1 {
            top: -5%;
            left: -5%;
            width: 450px;
            height: 450px;
            background: var(--color-primario);
        }

        .blob-2 {
            bottom: 10%;
            right: -10%;
            width: 550px;
            height: 550px;
            background: var(--color-secundario);
            animation-delay: -5s;
        }

        .blob-3 {
            top: 40%;
            left: 30%;
            width: 350px;
            height: 350px;
            background: var(--acento-celeste);
            opacity: 0.2;
            animation-delay: -10s;
        }

        @keyframes float {
            0% {
                transform: translate(0, 0) scale(1);
            }

            33% {
                transform: translate(30px, -50px) scale(1.1);
            }

            66% {
                transform: translate(-20px, 20px) scale(0.9);
            }

            100% {
                transform: translate(0, 0) scale(1);
            }
        }

        /* Glassmorphism Navigation */
        .navbar-apple {
            background: var(--nav-bg) !important;
            backdrop-filter: blur(25px) saturate(200%);
            -webkit-backdrop-filter: blur(25px) saturate(200%);
            border-bottom: 1px solid rgba(255, 255, 255, 0.8);
            padding: 12px 0 !important;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.03);
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

        /* Scroll Reveal Animaciones */
        .reveal {
            opacity: 0;
            transform: translateY(40px);
            transition: var(--transition);
        }

        .reveal.active {
            opacity: 1;
            transform: translateY(0);
        }

        .delay-1 {
            transition-delay: 0.2s;
        }

        /* Hero Section */
        .hero {
            flex: 1;
            display: flex;
            align-items: center;
            padding: 80px 0;
            position: relative;
            z-index: 1;
        }

        .hero h1 {
            font-size: clamp(3rem, 10vw, 4.5rem);
            font-weight: 800;
            letter-spacing: -2px;
            line-height: 1.1;
            margin-bottom: 25px;
            color: var(--texto-titulos);
        }

        /* Pildoras informativas flotantes (Glass) */
        .info-pill {
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.8);
            border-radius: 50px;
            padding: 0.6rem 1.2rem;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--texto-titulos);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(26, 82, 118, 0.05);
            transition: transform 0.3s ease;
        }

        .info-pill:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(26, 82, 118, 0.1);
        }

        /* Glassmorphism Cards (Tarjetas Principales) */
        .apple-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 2.5rem;
            padding: 3.5rem;
            border: 1px solid rgba(255, 255, 255, 0.9);
            height: 100%;
            transition: var(--transition);
            box-shadow: 0 15px 35px rgba(26, 82, 118, 0.05);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .apple-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(26, 82, 118, 0.12);
            background: rgba(255, 255, 255, 0.85);
        }

        .icon-box {
            font-size: 3rem;
            width: 90px;
            height: 90px;
            border-radius: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 10px 25px rgba(26, 82, 118, 0.08);
        }

        .icon-box-small {
            font-size: 1.5rem;
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 5px 15px rgba(26, 82, 118, 0.08);
        }

        /* Botones estilo iOS con colores oficiales */
        .btn-apple {
            border-radius: 980px;
            padding: 14px 32px;
            font-weight: 600;
            transition: 0.3s;
            letter-spacing: 0.5px;
            border: none;
            width: 100%;
            margin-top: auto;
        }

        .btn-apple:active {
            transform: scale(0.96);
        }

        .btn-salud {
            background-color: var(--color-primario);
            color: white;
        }

        .btn-salud:hover {
            background-color: #154360;
            color: white;
            box-shadow: 0 10px 20px rgba(26, 82, 118, 0.3);
        }

        .btn-sena {
            background-color: var(--color-secundario);
            color: white;
        }

        .btn-sena:hover {
            background-color: #2b8000;
            color: white;
            box-shadow: 0 10px 20px rgba(57, 169, 0, 0.3);
        }

        footer {
            background: rgba(255, 255, 255, 0.4);
            backdrop-filter: blur(10px);
            padding: 40px 0;
            border-top: 1px solid rgba(255, 255, 255, 0.6);
            z-index: 1;
        }

        @media (max-width: 991px) {
            .navbar-collapse {
                background: var(--nav-bg);
                backdrop-filter: blur(25px);
                padding: 25px;
                border-radius: 25px;
                margin-top: 15px;
                border: 1px solid rgba(255, 255, 255, 0.8);
            }

            .hero {
                text-align: center;
                padding: 40px 0;
            }
        }
    </style>
</head>

<body>

    <!-- Burbujas de Cristal Institucionales -->
    <div class="bg-blob blob-1"></div>
    <div class="bg-blob blob-2"></div>
    <div class="bg-blob blob-3"></div>

    <!-- Navbar Glassmorphism -->
    <nav class="navbar navbar-expand-lg navbar-apple sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="#inicio" style="color: var(--color-primario);">
                <i class="bi bi-heart-pulse-fill me-2"></i>SaludBoyaca
            </a>

            <div class="d-flex align-items-center order-lg-last ms-3">
                <!-- Boton Intranet en la Navbar -->
                <a class="btn btn-salud btn-apple px-4 py-2 d-none d-md-block shadow-sm"
                    style="width: auto;" href="${pageContext.request.contextPath}/login"><fmt:message key='index.nav.intranet'/></a>
                <button class="navbar-toggler ms-2 border-0 shadow-none" type="button"
                    data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="custom-toggler-icon" style="color: var(--color-primario);"><i
                            class="bi bi-grid-fill fs-3"></i></span>
                </button>
            </div>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto fw-medium align-items-center">
                    <li class="nav-item"><a class="nav-link px-4" href="#inicio"><fmt:message key='index.nav.inicio'/></a></li>
                    <li class="nav-item"><a class="nav-link px-4" href="#servicios"><fmt:message key='index.nav.servicios'/></a></li>
                    <li class="nav-item d-flex gap-2 px-4 py-2">
                        <a href="?lang=es" class="text-decoration-none fw-bold"
                            style="color: var(--texto-normal);">ES</a>
                        <span style="color: var(--texto-suave);">|</span>
                        <a href="?lang=en" class="text-decoration-none fw-bold"
                            style="color: var(--texto-suave);">EN</a>
                        <span style="color: var(--texto-suave);">|</span>
                        <a href="?lang=it" class="text-decoration-none fw-bold"
                            style="color: var(--texto-suave);">IT</a>
                    </li>
                    <li class="nav-item d-md-none mt-3 w-100">
                        <!-- Boton Intranet para Moviles -->
                        <a class="btn btn-salud btn-apple w-100"
                            href="${pageContext.request.contextPath}/login"><fmt:message key='index.nav.intranet'/></a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section con Tarjetas de Accion -->
    <section id="inicio" class="hero d-flex flex-column justify-content-center">
        <div class="container">

            <!-- Encabezado Central -->
            <div class="row justify-content-center text-center mb-5 reveal active">
                <div class="col-lg-10">
                    <div class="d-flex flex-wrap justify-content-center gap-3 mb-4">
                        <div class="info-pill">
                            <span style="color: var(--color-secundario);"><i
                                    class="bi bi-calendar-check-fill"></i></span> <fmt:message key='index.pill.agendamiento'/>
                        </div>
                        <div class="info-pill">
                            <span style="color: var(--color-primario);"><i
                                    class="bi bi-person-heart"></i></span> <fmt:message key='index.pill.profesionales'/>
                        </div>
                        <div class="info-pill">
                            <span style="color: var(--acento-celeste);"><i
                                    class="bi bi-shield-lock-fill"></i></span> <fmt:message key='index.pill.seguro'/>
                        </div>
                    </div>

                    <h1 class="apple-title mb-3">
                        <fmt:message key='app.institucion' />
                    </h1>
                    <p class="lead fw-medium mx-auto"
                        style="color: var(--texto-suave); max-width: 650px; font-size: 1.25rem;">
                        <fmt:message key='index.subtitulo' />
                    </p>
                </div>
            </div>

            <!-- Tarjetas Glassmorphism de Accion -->
            <div class="row g-4 justify-content-center px-lg-4">

                <%-- UNICA OPCION: Consulta Publica (Pacientes) --%>
                    <div class="col-md-8 col-lg-6 reveal active delay-1">
                        <div class="apple-card">
                            <div class="icon-box" style="color: var(--color-secundario);">
                                <i class="bi bi-search-heart"></i>
                            </div>

                            <h2 class="fw-bold mb-3" style="color: var(--texto-titulos);">
                                <fmt:message key='nav.consulta' />
                            </h2>
                            <p class="mb-4"
                                style="color: var(--texto-normal); line-height: 1.6; font-size: 1.1rem;">
                                <fmt:message key='index.consulta.desc' />
                            </p>

                            <a href="${pageContext.request.contextPath}/consulta-cita"
                                class="btn btn-apple btn-sena mt-4 btn-lg" style="max-width: 300px;">
                                <fmt:message key='consulta.buscar' />
                            </a>
                        </div>
                    </div>

            </div>
        </div>
    </section>

    <!-- Servicios Adicionales Simplificados (Para mantener diseno) -->
    <section id="servicios" class="py-5 mt-3 reveal"
        style="border-top: 1px solid rgba(255,255,255,0.6); z-index: 1;">
        <div class="container">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 ps-lg-5">
                    <h2 class="display-6 fw-bold mb-4" style="color: var(--texto-titulos);"><fmt:message key='index.servicios.titulo'/></h2>

                    <div class="d-flex mb-4 align-items-center">
                        <div class="icon-box-small me-4" style="color: var(--acento-celeste);"><i
                                class="bi bi-phone"></i></div>
                        <div>
                            <h5 class="fw-bold mb-1" style="color: var(--texto-titulos);"><fmt:message key='index.servicios.digital.titulo'/>
                            </h5>
                            <p class="mb-0 small" style="color: var(--texto-normal);"><fmt:message key='index.servicios.digital.desc'/></p>
                        </div>
                    </div>

                    <div class="d-flex align-items-center">
                        <div class="icon-box-small me-4" style="color: var(--acento-celeste);"><i
                                class="bi bi-folder-check"></i></div>
                        <div>
                            <h5 class="fw-bold mb-1" style="color: var(--texto-titulos);"><fmt:message key='index.servicios.historial.titulo'/>
                            </h5>
                            <p class="mb-0 small" style="color: var(--texto-normal);"><fmt:message key='index.servicios.historial.desc'/></p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="https://img.freepik.com/foto-gratis/medicos-tableta_1098-18151.jpg"
                        class="img-fluid rounded-5 shadow-lg"
                        style="max-height: 380px; object-fit: cover; border: 5px solid rgba(255,255,255,0.7);"
                        alt="Tecnologia Medica">
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <div class="mb-3 reveal">
                <span class="fw-bold fs-4" style="color: var(--texto-titulos);"><i
                        class="bi bi-heart-pulse-fill me-2"
                        style="color: var(--color-primario);"></i>SaludBoyaca</span>
            </div>
            <div class="d-flex justify-content-center gap-4 fs-5 mb-4 reveal delay-1">
                <a href="#" class="nav-link" style="color: var(--color-primario) !important;"><i
                        class="bi bi-facebook"></i></a>
                <a href="#" class="nav-link" style="color: var(--color-primario) !important;"><i
                        class="bi bi-twitter-x"></i></a>
                <a href="#" class="nav-link" style="color: var(--color-primario) !important;"><i
                        class="bi bi-instagram"></i></a>
            </div>
            <p class="mb-0 fw-medium small" style="color: var(--texto-suave);">&copy; 2026 -
                <fmt:message key='app.institucion' /> - ADSO CIMM SENA
            </p>
        </div>
    </footer>

    <!-- JS Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
        crossorigin="anonymous"></script>

    <!-- Animaciones Scroll Reveal -->
    <script>
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting)
                    entry.target.classList.add('active');
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.reveal').forEach((el) => observer.observe(el));
    </script>
</body>

</html>