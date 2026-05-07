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
        <title><fmt:message key='login.titulo'/> - <fmt:message key='app.nombre'/></title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

        <style>
            :root {
                /* Colores Institucionales SaludBoyaca */
                --color-primario: #1A5276;
                --color-sena: #39A900;
                --acento-celeste: #2E86C1;
                --fondo-body: #EAF0F7;
                --blanco-puro: #FFFFFF;
                --texto-titulos: #154360;
                --texto-normal: #2C3E50;
                --texto-suave: #7F8C8D;
                --alerta-error: #FADBD8;
                --texto-error: #E74C3C;
                --login-card: #D6EAF8;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: var(--fondo-body);
                color: var(--texto-normal);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                margin: 0;
                overflow: hidden;
            }

            @keyframes fadeInUp {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            @keyframes cardScale {
                from { transform: scale(0.95); opacity: 0; }
                to { transform: scale(1); opacity: 1; }
            }

            .login-card {
                display: flex;
                width: 100%;
                max-width: 1000px;
                height: 650px;
                background: var(--login-card); 
                border: 1px solid rgba(255, 255, 255, 0.5);
                border-radius: 40px;
                overflow: hidden;
                box-shadow: 0 20px 60px rgba(26, 82, 118, 0.15);
                animation: cardScale 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
            }

            .left-panel {
                flex: 1.3;
                position: relative;
                background: url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') center/cover no-repeat;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .left-panel::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(26, 82, 118, 0.9) 0%, rgba(46, 134, 193, 0.8) 100%);
                z-index: 1;
            }

            .left-content {
                position: relative;
                z-index: 2;
                color: var(--blanco-puro);
                text-align: center;
                padding: 40px;
            }
            .left-content h2 {
                font-size: 42px;
                font-weight: 800;
                letter-spacing: -0.04em;
                animation: fadeInUp 1s ease 0.2s forwards;
                opacity: 0;
                color: var(--blanco-puro) !important;
            }
            .left-content p {
                font-size: 18px;
                animation: fadeInUp 1s ease 0.4s forwards;
                opacity: 0;
                color: var(--fondo-body) !important;
            }

            .right-panel {
                flex: 1;
                padding: 60px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                position: relative;
            }

            .top-actions {
                position: absolute;
                top: 30px;
                right: 30px;
                display: flex;
                align-items: center;
            }

            .lang-flags a {
                text-decoration: none;
                font-size: 1.4rem;
                opacity: 0.6;
                transition: 0.3s;
                margin-left: 10px;
            }
            .lang-flags a:hover { 
                opacity: 1; 
                transform: scale(1.1); 
            }

            .login-box {
                width: 100%;
                max-width: 340px;
                margin: 0 auto;
            }
            .login-box h3 {
                font-size: 34px;
                font-weight: 700;
                margin-bottom: 5px;
                color: var(--texto-titulos);
            }
            .login-box p.subtitle {
                color: var(--texto-normal);
                margin-bottom: 30px;
            }

            .form-group-apple {
                position: relative;
                margin-bottom: 20px;
            }

            .form-group-apple input {
                width: 100%;
                padding: 16px 50px;
                border-radius: 18px;
                border: 1px solid rgba(26, 82, 118, 0.1);
                background: var(--blanco-puro);
                color: var(--texto-normal) !important;
                font-size: 16px;
                transition: all 0.3s;
            }
            
            .form-group-apple input::placeholder {
                color: var(--texto-suave);
            }

            .form-group-apple input:focus {
                border-color: var(--color-primario);
                box-shadow: 0 0 0 4px rgba(46, 134, 193, 0.2);
                outline: none;
            }

            .form-group-apple i.fa-main {
                position: absolute;
                left: 20px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--color-primario);
                font-size: 18px;
            }

            .toggle-password {
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                background: transparent;
                border: none;
                color: var(--texto-suave);
                cursor: pointer;
                transition: 0.3s;
            }
            .toggle-password:hover {
                color: var(--color-primario);
            }

            .btn-custom {
                background: var(--color-primario);
                color: var(--blanco-puro);
                border-radius: 18px;
                padding: 16px;
                font-weight: 700;
                border: none;
                width: 100%;
                margin-top: 10px;
                transition: 0.3s;
                box-shadow: 0 10px 20px rgba(26, 82, 118, 0.2);
            }
            .btn-custom:hover {
                background: var(--texto-titulos);
                transform: translateY(-2px);
                box-shadow: 0 15px 25px rgba(26, 82, 118, 0.3);
                color: var(--blanco-puro);
            }

            .alert-custom {
                background-color: var(--alerta-error);
                color: var(--texto-error);
                border-radius: 15px;
                border: none;
                font-weight: 500;
            }

            .animate-item {
                opacity: 0;
                animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
            }
            .delay-1 { animation-delay: 0.3s; }
            .delay-2 { animation-delay: 0.4s; }
            .delay-3 { animation-delay: 0.5s; }

            @media (max-width: 850px) {
                .login-card {
                    flex-direction: column;
                    height: auto;
                    max-width: 450px;
                    margin: 20px;
                }
                .left-panel { padding: 60px 20px; }
                .right-panel { padding: 40px 30px; }
                body { overflow: auto; }
            }
        </style>
    </head>
    <body>

        <div class="login-card">
            <div class="left-panel">
                <div class="left-content">
                    <i class="fas fa-hospital-user mb-3" style="font-size: 65px; color: var(--color-sena);"></i>
                    <h2><fmt:message key='app.nombre'/></h2>
                    <p><fmt:message key='app.institucion'/></p>
                </div>
            </div>

            <div class="right-panel">
                
                <div class="top-actions">
                    <div class="lang-flags">
                        <a href="?lang=es" title="<fmt:message key='app.lang.es'/>">🇨🇴</a>
                        <a href="?lang=en" title="<fmt:message key='app.lang.en'/>">🇺🇸</a>
                        <a href="?lang=it" title="<fmt:message key='app.lang.it'/>">🇮🇹</a>
                    </div>
                </div>

                <div class="login-box">
                    <h3 class="animate-item"><fmt:message key='login.titulo'/></h3>
                    <p class="small subtitle animate-item delay-1"><fmt:message key='login.subtitulo'/></p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-custom py-2 small animate-item text-center">
                            <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="POST" class="needs-validation" novalidate>

                        <div class="form-group-apple animate-item delay-2">
                            <input type="text" name="username" placeholder="<fmt:message key='login.usuario'/>" required>
                            <i class="fas fa-user fa-main"></i>
                        </div>

                        <div class="form-group-apple animate-item delay-3">
                            <input type="password" name="password" id="passwordField" placeholder="<fmt:message key='login.contrasena'/>" required>
                            <i class="fas fa-lock fa-main"></i>
                            <button type="button" class="toggle-password" onclick="togglePassword()" title="<fmt:message key='login.mostrar.ocultar'/>">
                                <i class="fas fa-eye" id="eyeIcon"></i>
                            </button>
                        </div>

                        <button type="submit" class="btn-custom animate-item delay-3">
                            <fmt:message key='login.ingresar'/>
                        </button>
                    </form>

                    <div class="text-center mt-4 pt-4 border-top animate-item delay-3" style="border-color: rgba(26, 82, 118, 0.1) !important;">
                        <a href="${pageContext.request.contextPath}/consulta-cita" class="small text-decoration-none fw-bold" style="color: var(--color-primario);">
                            <i class="fas fa-calendar-check me-1"></i> <fmt:message key='nav.consulta'/>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Logica para Mostrar/Ocultar Contrasena
            function togglePassword() {
                const field = document.getElementById('passwordField');
                const icon = document.getElementById('eyeIcon');
                
                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.replace('fa-eye', 'fa-eye-slash');
                } else {
                    field.type = 'password';
                    icon.classList.replace('fa-eye-slash', 'fa-eye');
                }
            }
        </script>
    </body>
</html>