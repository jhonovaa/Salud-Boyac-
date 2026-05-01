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
    <title><fmt:message key='otp.titulo'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

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
            /* Color especifico de OTP/Seguridad */
            --otp-morado: #6C3483;
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
            box-shadow: 0 20px 60px rgba(108, 52, 131, 0.15); /* Sombra ligeramente morada */
            animation: cardScale 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
        }

        .left-panel {
            flex: 1.3;
            position: relative;
            background: url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            inset: 0;
            /* Gradiente mezclando el Azul Primario con el Morado OTP */
            background: linear-gradient(135deg, rgba(26, 82, 118, 0.9) 0%, rgba(108, 52, 131, 0.85) 100%);
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

        .login-box {
            width: 100%;
            max-width: 360px;
            margin: 0 auto;
            text-align: center;
        }
        
        .shield-icon {
            color: var(--otp-morado);
            font-size: 3.5rem;
            margin-bottom: 20px;
        }

        .login-box h3 {
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--texto-titulos);
        }
        .login-box p.subtitle {
            color: var(--texto-normal);
            margin-bottom: 30px;
            font-size: 0.95rem;
            line-height: 1.5;
        }

        .form-group-apple {
            position: relative;
            margin-bottom: 25px;
        }

        /* Estilo especifico para el input OTP */
        .otp-input-custom {
            width: 100%;
            padding: 20px;
            border-radius: 20px;
            border: 2px solid rgba(108, 52, 131, 0.15);
            background: var(--blanco-puro);
            color: var(--otp-morado) !important;
            font-size: 2rem !important;
            letter-spacing: 12px !important;
            text-align: center;
            font-weight: 700;
            transition: all 0.3s;
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.02);
        }
        
        .otp-input-custom::placeholder {
            color: var(--texto-suave);
            opacity: 0.5;
        }

        .otp-input-custom:focus {
            border-color: var(--otp-morado);
            box-shadow: 0 0 0 5px rgba(108, 52, 131, 0.2);
            outline: none;
        }

        .btn-custom {
            background: var(--otp-morado);
            color: var(--blanco-puro);
            border-radius: 18px;
            padding: 16px;
            font-weight: 700;
            border: none;
            width: 100%;
            margin-bottom: 15px;
            transition: 0.3s;
            box-shadow: 0 10px 20px rgba(108, 52, 131, 0.25);
        }
        .btn-custom:hover {
            background: #512E5F; /* Un morado mas oscuro para el hover */
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(108, 52, 131, 0.35);
            color: var(--blanco-puro);
        }

        .btn-outline-custom {
            background: transparent;
            color: var(--texto-normal);
            border: 2px solid rgba(44, 62, 80, 0.1);
            border-radius: 18px;
            padding: 14px;
            font-weight: 600;
            width: 100%;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-outline-custom:hover {
            background: rgba(44, 62, 80, 0.05);
            color: var(--texto-titulos);
        }

        .alert-custom {
            background-color: var(--alerta-error);
            color: var(--texto-error);
            border-radius: 15px;
            border: none;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .animate-item {
            opacity: 0;
            animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
        }
        .delay-1 { animation-delay: 0.3s; }
        .delay-2 { animation-delay: 0.4s; }
        .delay-3 { animation-delay: 0.5s; }

        /* NUEVO: Clases para deshabilitar el enlace de reenviar */
        .disabled-link {
            pointer-events: none;
            opacity: 0.6;
        }

        @media (max-width: 850px) {
            .login-card {
                flex-direction: column;
                height: auto;
                max-width: 450px;
                margin: 20px;
            }
            .left-panel { padding: 50px 20px; }
            .right-panel { padding: 40px 20px; }
            body { overflow: auto; }
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="left-panel">
            <div class="left-content">
                <i class="fas fa-user-shield mb-3" style="font-size: 65px; color: var(--blanco-puro);"></i>
                <h2><fmt:message key='otp.proteccion.titulo'/></h2>
                <p><fmt:message key='otp.proteccion.desc'/></p>
            </div>
        </div>

        <div class="right-panel">
            
            <div class="login-box">
                <i class="fas fa-shield-alt shield-icon animate-item"></i>
                
                <h3 class="animate-item delay-1"><fmt:message key='otp.titulo'/></h3>
                
                <p class="subtitle animate-item delay-1">
                    <fmt:message key='otp.instruccion'>
                        <fmt:param value="<strong>${emailMasked}</strong>" />
                    </fmt:message>
                </p>

                <c:if test="${not empty error}">
                    <div class="alert alert-custom py-2 small animate-item delay-2">
                        <i class="fas fa-exclamation-circle me-2"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/otp" method="post" class="needs-validation" novalidate>
                    
                    <label class="form-label fw-bold text-start w-100 animate-item delay-2" style="color: var(--texto-normal); padding-left: 10px;">
                        <fmt:message key='otp.campo'/>
                    </label>
                    
                    <div class="form-group-apple animate-item delay-2">
                        <input type="text" name="otpCodigo" class="otp-input-custom" 
                               maxlength="6" pattern="[0-9]{6}" placeholder="000000" required autofocus>
                        
                        <div class="text-center mt-2">
                            <span class="small" style="color: var(--texto-suave);"><fmt:message key='otp.expira'/> </span>
                            <span id="mainTimer" style="font-weight: bold; color: var(--texto-normal); transition: color 0.3s;">05:00</span>
                        </div>
                    </div>

                    <button type="submit" class="btn-custom animate-item delay-3">
                        <fmt:message key='otp.verificar'/>
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/login" id="resendBtn" class="btn-outline-custom animate-item delay-3 disabled-link">
                        <fmt:message key='otp.reenviar'/> <span id="resendTimerText">(<fmt:message key='otp.espera'/> 60s)</span>
                    </a>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Variable inyectada desde JSTL para la traduccion en JS
            const textEspera = "<fmt:message key='otp.espera'/>";

            // --- 1. Logica del Contador Principal (5 Minutos) ---
            let totalTime = 300; // 5 minutos en segundos
            const timerDisplay = document.getElementById("mainTimer");

            const mainInterval = setInterval(() => {
                totalTime--;
                let minutes = Math.floor(totalTime / 60);
                let seconds = totalTime % 60;
                
                // Formatear segundos a dos digitos
                if (seconds < 10) seconds = "0" + seconds;
                
                timerDisplay.textContent = minutes + ":" + seconds;

                // Cambiar a ROJO cuando quede menos de 60 segundos
                if (totalTime < 60) {
                    timerDisplay.style.color = "var(--texto-error)";
                }

                if (totalTime <= 0) {
                    clearInterval(mainInterval);
                    timerDisplay.textContent = "0:00";
                }
            }, 1000);

            // --- 2. Logica del Boton Reenviar (Espera de 60 Segundos) ---
            let resendTime = 60; 
            const resendBtn = document.getElementById("resendBtn");
            const resendText = document.getElementById("resendTimerText");

            const resendInterval = setInterval(() => {
                resendTime--;
                if (resendTime > 0) {
                    resendText.textContent = "(" + textEspera + " " + resendTime + "s)";
                } else {
                    clearInterval(resendInterval);
                    resendText.textContent = "";
                    // Habilitar el enlace para que el usuario pueda hacer clic
                    resendBtn.classList.remove("disabled-link");
                }
            }, 1000);
            
            // Forzar que el input solo acepte numeros y limitar la longitud
            const otpInput = document.querySelector('.otp-input-custom');
            otpInput.addEventListener('input', function (e) {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });
    </script>
</body>
</html>