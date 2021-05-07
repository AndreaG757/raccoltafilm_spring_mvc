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
                    <dd class="col-sm-9">${film_delete_attribute.id}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Titolo:</dt>
                    <dd class="col-sm-9">${film_delete_attribute.titolo}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Genere:</dt>
                    <dd class="col-sm-9">${film_delete_attribute.genere}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Durata Minuti:</dt>
                    <dd class="col-sm-9">${film_delete_attribute.minutiDurata}</dd>
                </dl>

                <dl class="row">
                    <dt class="col-sm-3 text-right">Data di Pubblicazione:</dt>
                    <dd class="col-sm-9"><fmt:formatDate type = "date" value = "${film_delete_attribute.dataPubblicazione}" /></dd>
                </dl>

            </div>

            <div class='card-footer'>
                <%--@elvariable id="film_delete_attribute" type="Film"--%>
                <form:form modelAttribute="film_delete_attribute" method="post" action="deleteFilm" novalidate="novalidate">
                    <spring:bind path="id">
                        <input type="hidden" name="id" id="id" class="form-control ${status.error ? 'is-invalid' : ''}" value="${film_delete_attribute.id }" required>
                    </spring:bind>
                    <a href="${pageContext.request.contextPath }/film/" class='btn btn-outline-secondary' style='width:7em;'>
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