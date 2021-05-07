<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>

    <jsp:include page="../header.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css" />

    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css" />
    <style>
        .ui-autocomplete-loading {
            background: white url("../assets/img/jqueryUI/anim_16x16.gif") right center no-repeat;
        }
        .error_field {
            color: red;
        }
    </style>

    <meta charset="ISO-8859-1">
    <title>Elimina Film</title>

</head>

<body>

    <jsp:include page="../navbar.jsp" />

    <main role="main" class="container">

        <div class='card'>
            <div class='card-header'>
                Visualizza dettaglio
            </div>

            <div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
                ${errorMessage}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class='card-body'>
                <dl class="row">
                    <dt class="col-sm-3 text-right">Id:</dt>
                    <dd class="col-sm-9">${delete_regista_attribute.id}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Nome:</dt>
                    <dd class="col-sm-9">${delete_regista_attribute.nome}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Cognome:</dt>
                    <dd class="col-sm-9">${delete_regista_attribute.cognome}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">NickName:</dt>
                    <dd class="col-sm-9">${delete_regista_attribute.nickName}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Sesso:</dt>
                    <dd class="col-sm-9">${delete_regista_attribute.sesso.abbreviazione}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Data di Nascita:</dt>
                    <dd class="col-sm-9"><fmt:formatDate type = "date" value = "${delete_regista_attribute.dataDiNascita}" /></dd>
                </dl>

            </div>

            <div class='card-footer'>
                <%--@elvariable id="regista_delete_attribute" type="Regista"--%>
                <form:form modelAttribute="delete_regista_attribute" method="post" action="deleteRegista" novalidate="novalidate">
                    <spring:bind path="id">
                        <input type="hidden" name="id" id="id" class="form-control ${status.error ? 'is-invalid' : ''}" value="${delete_regista_attribute.id }" required>
                    </spring:bind>
                    <a href="${pageContext.request.contextPath }/regista/" class='btn btn-outline-secondary' style='width:7em;'>
                        <i class='fa fa-chevron-left'></i> Indietro
                    </a>
                    <button type="submit" name="submit" value="submit" id="submit" class="btn btn-danger" style='width:7em;'>Elimina</button>
                </form:form>
            </div>

        </div>

    </main>

    <jsp:include page="../footer.jsp" />

    </body>

</html>