<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<nav class="navbar-saludboyaca fixed-top">
    <div class="container d-flex justify-content-between align-items-center">
        
        <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand text-decoration-none d-flex align-items-center gap-2">
            <i class="fa-solid fa-house-medical text-white"></i>
            <span class="fw-bold text-white">SALUD BOYACA</span>
        </a>

        <div class="d-flex align-items-center gap-3">
            <span class="d-none d-md-inline text-white opacity-75" style="font-weight: 600; font-size: 0.85rem;">
                <fmt:message key='app.lang.seleccionar'/>:
            </span>
            <div class="d-flex gap-2">
                <a href="?lang=es" class="btn-lang ${sessionScope.lang == 'es' || sessionScope.lang == null ? 'active' : ''}" title="<fmt:message key='app.lang.es'/>">ES</a>
                <a href="?lang=en" class="btn-lang ${sessionScope.lang == 'en' ? 'active' : ''}" title="<fmt:message key='app.lang.en'/>">EN</a>
                <a href="?lang=it" class="btn-lang ${sessionScope.lang == 'it' ? 'active' : ''}" title="<fmt:message key='app.lang.it'/>">IT</a>
            </div>
        </div>

    </div>
</nav>

<div style="height: 70px;"></div>

<style>
    .navbar-saludboyaca {
        background-color: var(--color-primario, #1A5276);
        border-bottom: 1px solid rgba(0,0,0,0.1);
        padding: 15px 0;
        z-index: 1030;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }

    .btn-lang {
        width: 35px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        font-size: 0.75rem;
        font-weight: 700;
        text-decoration: none;
        color: rgba(255, 255, 255, 0.8);
        background: rgba(255, 255, 255, 0.1);
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .btn-lang:hover {
        background: rgba(255, 255, 255, 0.25);
        color: #ffffff;
    }

    .btn-lang.active {
        background: var(--color-sena, #39A900);
        color: #ffffff;
        border-color: var(--color-sena, #39A900);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    } 
</style>