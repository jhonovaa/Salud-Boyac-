<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<div class="mobile-overlay" id="mobileOverlay" onclick="toggleMenu()"></div>

<div class="mobile-menu-btn d-lg-none" onclick="toggleMenu()" 
     style="position: fixed; bottom: 25px; left: 50%; transform: translateX(-50%); z-index: 1050; background: white; padding: 12px 25px; border-radius: 30px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); cursor: pointer; font-weight: bold;">
    <i class="fa-solid fa-bars" id="menuIcon"></i> <fmt:message key='nav.menu'/>
</div>

<aside class="sidebar" id="mainSidebar">
    <div class="brand-section">
        <i class="fa-solid fa-house-medical"></i>
        <div class="fw-bold" style="color: var(--color-primario); font-size: 0.9rem; letter-spacing: 0.5px;">SALUD BOYACA</div>
    </div>

    <div class="nav-label"><fmt:message key='nav.servicios'/></div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link ${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
                <i class="fa-solid fa-chart-pie"></i> <fmt:message key='nav.dashboard'/>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/pacientes" class="nav-link ${pageContext.request.requestURI.contains('pacientes') ? 'active' : ''}">
                <i class="fa-solid fa-user-injured"></i> <fmt:message key='nav.pacientes'/>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/citas" class="nav-link ${pageContext.request.requestURI.contains('citas') ? 'active' : ''}">
                <i class="fa-solid fa-calendar-check"></i> <fmt:message key='nav.citas'/>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/horarios" class="nav-link ${pageContext.request.requestURI.contains('horarios') ? 'active' : ''}">
                <i class="fa-solid fa-clock"></i> <fmt:message key='nav.horarios'/>
            </a>
        </li>
    </ul>

    <div class="nav-label"><fmt:message key='app.lang.seleccionar'/></div>
    <div class="d-flex gap-2 px-3 mb-4">
        <a href="?lang=es" class="btn-lang ${sessionScope.lang == 'es' || sessionScope.lang == null ? 'active' : ''}" title="<fmt:message key='app.lang.es'/>">
            ES
        </a>
        <a href="?lang=en" class="btn-lang ${sessionScope.lang == 'en' ? 'active' : ''}" title="<fmt:message key='app.lang.en'/>">
            EN
        </a>
        <a href="?lang=it" class="btn-lang ${sessionScope.lang == 'it' ? 'active' : ''}" title="<fmt:message key='app.lang.it'/>">
            IT
        </a>
    </div>

    <div class="user-profile-mini">
        <div class="avatar-circle">
            ${sessionScope.usuario.nombres.substring(0,1)}
        </div>
        <div class="overflow-hidden">
            <div class="fw-bold text-dark text-truncate" style="font-size: 0.85rem; max-width: 140px;">
                ${sessionScope.usuario.nombreCompleto}
            </div>
            <a href="${pageContext.request.contextPath}/login?action=logout" class="logout-btn" style="color: #E74C3C; text-decoration: none; font-size: 0.75rem; font-weight: bold; display: flex; align-items: center; gap: 5px;">
                <i class="fa-solid fa-power-off"></i> <fmt:message key='nav.salir'/>
            </a>
        </div>
    </div>
</aside>

<style>
    /* Estilos para los botones de idioma */
    .btn-lang {
        width: 35px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        font-size: 0.7rem;
        font-weight: 800;
        text-decoration: none;
        color: var(--texto-suave);
        background: rgba(0,0,0,0.04);
        transition: all 0.3s ease;
        border: 1px solid rgba(0,0,0,0.05);
    }

    .btn-lang:hover {
        background: rgba(57, 169, 0, 0.1);
        color: var(--color-sena);
    }

    .btn-lang.active {
        background: var(--color-sena);
        color: white;
        border-color: var(--color-sena);
        box-shadow: 0 4px 10px rgba(57, 169, 0, 0.2);
    }
</style>

<script>
    function toggleMenu() {
        const sidebar = document.getElementById('mainSidebar');
        const overlay = document.getElementById('mobileOverlay');
        const icon = document.getElementById('menuIcon');

        sidebar.classList.toggle('show');
        
        if (sidebar.classList.contains('show')) {
            overlay.style.display = 'block';
            setTimeout(() => overlay.style.opacity = '1', 10);
            icon.classList.replace('fa-bars', 'fa-xmark');
        } else {
            overlay.style.opacity = '0';
            setTimeout(() => overlay.style.display = 'none', 300);
            icon.classList.replace('fa-xmark', 'fa-bars');
        }
    }
</script>