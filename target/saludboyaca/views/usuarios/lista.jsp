<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.lang == null ? 'es' : sessionScope.lang}" />
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="${sessionScope.lang}">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key='usuarios.titulo'/></title>
    
    <!-- CSS de Bootstrap, DataTables y FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/saludboyaca.css" rel="stylesheet">
    
    <style>
        body { background-color: #EAF0F7; }
    </style>
</head>
<body>

    <!-- Inclusion del Navbar -->
    <%@ include file="templates/header.jsp" %>

    <div class="container" style="margin-top: 100px;">
        <h2 class="mb-4" style="color: var(--texto-titulos);">
            <i class="fas fa-users-cog me-2"></i><fmt:message key='usuarios.titulo'/>
        </h2>

        <div class="card shadow-sm border-0" style="border-radius: 16px;">
            <div class="card-body p-4">
                <div class="table-responsive">
                    <table id="tablaUsuarios" class="table table-hover align-middle w-100">
                        <thead class="table-light">
                            <tr>
                                <th><fmt:message key='usuarios.documento'/></th>
                                <th><fmt:message key='usuarios.nombres'/></th>
                                <th><fmt:message key='usuarios.email'/></th>
                                <th><fmt:message key='usuarios.login'/></th>
                                <th><fmt:message key='usuarios.rol'/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${usuarios}">
                                <tr>
                                    <td><span class="badge bg-light text-dark border px-2 py-1"><i class="fa-regular fa-id-card me-1"></i>${u.documento}</span></td>
                                    <td>${u.nombres} ${u.apellidos}</td>
                                    <td>${u.email}</td>
                                    <td><strong>${u.username}</strong></td>
                                    <td>
                                        <span class="badge bg-secondary">${u.rol}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts de jQuery, Bootstrap y DataTables -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

    <!-- Inicializacion de DataTables con traduccion via JSTL -->
    <script>
        $(document).ready(function() {
            $('#tablaUsuarios').DataTable({
                language: {
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