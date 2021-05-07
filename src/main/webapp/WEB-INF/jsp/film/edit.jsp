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
    <title>Insert title here</title>

</head>

<body>

<jsp:include page="../navbar.jsp" />

<main role="main" class="container">

    <spring:hasBindErrors  name="film_regista_attr">
        <%-- alert errori --%>
        <div class="alert alert-danger " role="alert">
            Attenzione!! Sono presenti errori di validazione
        </div>
    </spring:hasBindErrors>

    <div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
        ${errorMessage}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class='card'>
        <div class='card-header'>
            <h5>Inserisci elemento da modificare</h5>
        </div>
        <div class='card-body'>

            <form:form method="post" modelAttribute="edit_film_attribute" action="saveEdit" novalidate="novalidate" >

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="titolo">Titolo</label>
                        <spring:bind path="titolo">
                            <input type="text" name="titolo" id="titolo" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il titolo" value="${edit_film_attribute.titolo }">

                        </spring:bind>
                        <form:errors  path="titolo" cssClass="error_field" />
                    </div>

                    <div class="form-group col-md-6">
                        <label for="genere">Genere</label>
                        <spring:bind path="genere">
                            <input type="text" name="genere" id="genere" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il genere" value="${edit_film_attribute.genere }">
                        </spring:bind>
                        <form:errors  path="genere" cssClass="error_field" />
                    </div>
                </div>

                <div class="form-row">
                    <fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date' value='${edit_film_attribute.dataPubblicazione}' />
                    <div class="form-group col-md-6">
                        <label for="dataPubblicazione">Data di Pubblicazione</label>
                        <spring:bind path="dataPubblicazione">
                            <input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataPubblicazione" type="date" placeholder="dd/MM/yy"
                                   title="formato : gg/mm/aaaa"  name="dataPubblicazione" value="${parsedDate}" >
                        </spring:bind>
                        <form:errors  path="dataPubblicazione" cssClass="error_field" />
                    </div>

                    <div class="form-group col-md-6">
                        <label for="minutiDurata">Durata (minuti)</label>
                        <spring:bind path="minutiDurata">
                            <input type="number" class="form-control ${status.error ? 'is-invalid' : ''}" name="minutiDurata" id="minutiDurata" placeholder="Inserire la durata" value="${edit_film_attribute.minutiDurata }">
                        </spring:bind>
                        <form:errors  path="minutiDurata" cssClass="error_field" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="registaSearchInput">Regista:</label>
                        <spring:bind path="regista.id">
                            <input class="form-control ${status.error ? 'is-invalid' : ''}" type="text" id="registaSearchInput"
                                   name="registaInput" value="${edit_film_attribute.regista.nome}${empty edit_film_attribute.regista.nome?'':' '}${edit_film_attribute.regista.cognome}">
                        </spring:bind>
                        <input type="hidden" name="regista.id" id="registaId" value="${edit_film_attribute.regista.id }">
                        <form:errors  path="regista.id" cssClass="error_field" />
                    </div>
                </div>

                <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary" style='width:7em;'>Modifica</button>
                <a href="${pageContext.request.contextPath }/film/" class='btn btn-outline-secondary' style='width:7em;'>
                    <i class='fa fa-chevron-left'></i> Indietro
                </a>

                <spring:bind path="id">
                    <input type="hidden" name="id" id="id" class="form-control ${status.error ? 'is-invalid' : ''}" value="${edit_film_attribute.id }" required>
                </spring:bind>

            </form:form>

            <!-- end card-body -->
        </div>
    </div>

        <script>
            $("#registaSearchInput").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: "../edit/searchRegistiAjax",
                        datatype: "json",
                        data: {
                            term: request.term,
                        },
                        success: function(data) {
                            response($.map(data, function(item) {
                                return {
                                    label: item.label,
                                    value: item.value
                                }
                            }))
                        }
                    })
                },
                //quando seleziono la voce nel campo deve valorizzarsi la descrizione
                focus: function(event, ui) {
                    $("#registaSearchInput").val(ui.item.label);
                    return false;
                },
                minLength: 2,
                //quando seleziono la voce nel campo hidden deve valorizzarsi l'id
                select: function( event, ui ) {
                    $('#registaId').val(ui.item.value);
                    //console.log($('#registaId').val())
                    return false;
                }
            });
        </script>

    <!-- end container -->
    </div>
</main>

<jsp:include page="../footer.jsp" />

</body>

</html>