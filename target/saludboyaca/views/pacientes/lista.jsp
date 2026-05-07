<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Configuracion de Localizacion dinamica --%>
<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<%-- Mensaje de confirmacion para JS --%>
<fmt:message key="paciente.confirmar" var="msgConfirmar" />

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key='paciente.titulo'/></title>
    
    <%-- Bootstrap 5.3.0 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- FontAwesome 6.4.0 --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <%-- DataTables CSS --%>
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <%-- CSS Personalizado --%>
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        .main-wrapper { margin-left: 295px; padding: 2rem; transition: all 0.4s; }
        .top-navbar {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--acento-celeste);
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        .table-card {
            background: #fff;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border-top: 4px solid var(--color-primario);
        }
        
        @media (max-width: 992px) { .main-wrapper { margin-left: 0; padding: 1.5rem; } }
    </style>
</head>
<body>

    <jsp:include page="/views/templates/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <h4 class="fw-bold mb-0" style="color: var(--texto-titulos);">
                <i class="fa-solid fa-users me-2"></i><fmt:message key='paciente.titulo'/>
            </h4>
            
            <div class="d-flex gap-2">

                <%-- FILTRO DE SEGURIDAD: Solo RECEPCIONISTA --%>
                <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                    <a href="${pageContext.request.contextPath}/pacientes?accion=nuevo" class="btn btn-saludboyaca fw-bold rounded-pill px-4">
                        <i class="fa-solid fa-user-plus me-1"></i> <fmt:message key='paciente.nuevo'/>
                    </a>
                </c:if>
            </div>
        </header>

        <div class="container-fluid px-0">

            <c:if test="${param.mensaje == 'ok'}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm mb-4" style="border-radius: 15px;">
                    <i class="fa-solid fa-check-circle me-2"></i><fmt:message key='alerta.exito'/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="table-card">
                <div class="table-responsive">
                    <table id="tablaPacientes" class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th><fmt:message key='paciente.documento'/></th>
                                <th><fmt:message key='paciente.nombres'/></th>
                                <th><fmt:message key='paciente.apellidos'/></th>
                                <th><fmt:message key='paciente.eps'/></th>
                                <th><fmt:message key='paciente.email'/></th>
                                <th><fmt:message key='paciente.veredaBarrio'/></th>
                                <th><fmt:message key='paciente.telefono'/></th>
                                <th class="text-center"><fmt:message key='paciente.acciones'/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${pacientes}">
                                <tr>
                                    <td><span class="badge bg-light text-dark border px-2 py-1">${p.documento}</span></td>
                                    <td class="fw-bold text-dark">${p.nombres}</td>
                                    <td>${p.apellidos}</td>
                                    <td>${p.eps}</td>
                                    <td>${not empty p.email ? p.email : 'N/A'}</td>
                                    <td>${not empty p.veredaBarrio ? p.veredaBarrio : 'N/A'}</td>
                                    <td>${p.telefono}</td>
                                    <td class="text-center">
                                        <div class="btn-group btn-group-sm">
                                            <%-- Boton Ver Perfil --%>


                                            <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                                                <a href="${pageContext.request.contextPath}/pacientes?accion=editar&id=${p.id}" class="btn btn-outline-warning">
                                                    <i class="fa-solid fa-pen"></i>
                                                </a>
                                                <form action="${pageContext.request.contextPath}/pacientes" method="POST" class="d-inline">
                                                    <input type="hidden" name="accion" value="eliminar">
                                                    <input type="hidden" name="id" value="${p.id}">
                                                    <button type="submit" class="btn btn-outline-danger" onclick="return confirm('${msgConfirmar}');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#tablaPacientes').DataTable({
                "pageLength": 10,
                "ordering": true,
                "responsive": true,
                "language": {
                    "sSearch": "<fmt:message key='dt.buscar'/>",
                    "sEmptyTable": "<fmt:message key='dt.vacio'/>",
                    "sInfo": "<fmt:message key='dt.info'/>",
                    "sLengthMenu": "<fmt:message key='dt.menu'/>",
                    "oPaginate": {
                        "sFirst": "<fmt:message key='dt.pag.primero'/>",
                        "sLast": "<fmt:message key='dt.pag.ultimo'/>",
                        "sNext": "<fmt:message key='dt.pag.siguiente'/>",
                        "sPrevious": "<fmt:message key='dt.pag.anterior'/>"
                    }
                }
            });
        });
    </script>
</body>
</html>