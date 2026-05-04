<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <link href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key='horario.titulo'/></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">

    <style>
        .main-wrapper {
            margin-left: 295px;
            padding: 2rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

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
            background: var(--blanco-puro);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            border-top: 4px solid var(--color-primario);
        }

        @media (max-width: 992px) {
            .main-wrapper {
                margin-left: 0;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="/views/templates/sidebar.jsp" />

    <div class="main-wrapper">
        
        <header class="top-navbar d-flex justify-content-between align-items-center">
            <h4 class="fw-bold mb-0" style="color: var(--texto-titulos);">
                <i class="fa-regular fa-clock me-2"></i><fmt:message key='horario.titulo'/>
            </h4>
            
            <%-- FILTRO: Solo Recepcionista puede crear horarios --%>
            <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                <a href="${pageContext.request.contextPath}/horarios?accion=nuevo" class="btn btn-saludboyaca fw-bold rounded-pill px-4">
                    <i class="fa-solid fa-plus me-1"></i> <fmt:message key='horario.asignar'/>
                </a>
            </c:if>
        </header>

        <div class="container-fluid px-0">

            <c:if test="${param.mensaje == 'ok'}">
                <div class="alert alert-success alert-dismissible fade show border-0 shadow-sm" style="background-color: var(--alerta-exito); color: var(--color-sena); border-radius: 15px;">
                    <i class="fa-solid fa-check-circle me-2"></i><fmt:message key='alerta.exito'/>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="table-card">
                <div class="table-responsive">
                    <table id="tablaHorarios" class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <%-- FILTRO: Ocultar columna de Medico si el que loguea es un Medico --%>
                                <c:if test="${sessionScope.usuario.rol != 'MEDICO'}">
                                    <th><fmt:message key='horario.medico'/></th>
                                </c:if>
                                
                                <th><fmt:message key='horario.dia'/></th>
                                <th><fmt:message key='horario.hora.inicio'/></th>
                                <th><fmt:message key='horario.hora.fin'/></th>
                                <th class="text-center"><fmt:message key='horario.max.citas'/></th>
                                
                                <%-- FILTRO: Columna de acciones solo para Recepcionista --%>
                                <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                                    <th class="text-center"><fmt:message key='horario.acciones'/></th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${horarios}">
                                <tr>
                                    <%-- FILTRO: Ocultar celda de Medico si el que loguea es un Medico --%>
                                    <c:if test="${sessionScope.usuario.rol != 'MEDICO'}">
                                        <td class="fw-bold">
                                            <i class="fa-solid fa-user-doctor text-muted me-2"></i>${h.medicoNombre}
                                        </td>
                                    </c:if>
                                    
                                    <td class="fw-bold" style="color: var(--texto-normal);">
                                        <c:choose>
                                            <c:when test="${h.diaSemana == 1}"><fmt:message key='dia.lunes'/></c:when>
                                            <c:when test="${h.diaSemana == 2}"><fmt:message key='dia.martes'/></c:when>
                                            <c:when test="${h.diaSemana == 3}"><fmt:message key='dia.miercoles'/></c:when>
                                            <c:when test="${h.diaSemana == 4}"><fmt:message key='dia.jueves'/></c:when>
                                            <c:when test="${h.diaSemana == 5}"><fmt:message key='dia.viernes'/></c:when>
                                            <c:when test="${h.diaSemana == 6}"><fmt:message key='dia.sabado'/></c:when>
                                            <c:when test="${h.diaSemana == 7}"><fmt:message key='dia.domingo'/></c:when>
                                            <c:otherwise><fmt:message key='dia.nodefinido'/></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><i class="fa-regular fa-hourglass-half text-success me-1"></i> ${h.horaInicio}</td>
                                    <td><i class="fa-solid fa-flag-checkered text-danger me-1"></i> ${h.horaFin}</td>
                                    <td class="text-center">
                                        <span class="badge rounded-pill bg-secondary">${h.maxCitas}</span>
                                    </td>
                                    
                                    <%-- FILTRO: Botones de editar y borrar solo para Recepcionista --%>
                                    <c:if test="${sessionScope.usuario.rol == 'RECEPCIONISTA'}">
                                        <td class="text-center">
                                            <div class="btn-group btn-group-sm shadow-sm">
                                                <a href="${pageContext.request.contextPath}/horarios?accion=editar&id=${h.id}" class="btn btn-outline-warning" style="border-radius: 4px 0 0 4px;">
                                                    <i class="fa-solid fa-pen"></i>
                                                </a>
                                                <form action="${pageContext.request.contextPath}/horarios" method="POST" class="d-inline m-0 p-0">
                                                    <input type="hidden" name="accion" value="eliminar">
                                                    <input type="hidden" name="id" value="${h.id}">
                                                    <button type="submit" class="btn btn-outline-danger" style="border-radius: 0 4px 4px 0;" onclick="return confirm('<fmt:message key='horario.confirmar.eliminar'/>');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </c:if>
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
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#tablaHorarios').DataTable({
                "pageLength": 10,
                "ordering": true,
                "responsive": true,
                "language": {
                    "sEmptyTable":     "<fmt:message key='dt.vacio'/>",
                    "sInfo":           "<fmt:message key='dt.info'/>",
                    "sInfoEmpty":      "<fmt:message key='dt.info.vacio'/>",
                    "sInfoFiltered":   "<fmt:message key='dt.info.filtro'/>",
                    "sLengthMenu":     "<fmt:message key='dt.menu'/>",
                    "sLoadingRecords": "<fmt:message key='dt.cargando'/>",
                    "sProcessing":     "<fmt:message key='dt.procesando'/>",
                    "sSearch":         "<fmt:message key='dt.buscar'/>",
                    "sZeroRecords":    "<fmt:message key='dt.cero'/>",
                    "oPaginate": {
                        "sFirst":    "<fmt:message key='dt.pag.primero'/>",
                        "sLast":     "<fmt:message key='dt.pag.ultimo'/>",
                        "sNext":     "<fmt:message key='dt.pag.siguiente'/>",
                        "sPrevious": "<fmt:message key='dt.pag.anterior'/>"
                    }
                }
            });
        });
    </script>
</body>
</html>