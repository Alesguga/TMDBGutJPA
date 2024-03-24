<%-- 
    Document   : home
    Created on : 24-feb-2024, 16:22:16
    Author     : Alejandro
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <title>TMDBGut</title>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous" />
        <link rel="stylesheet" href="css/estilo.css">
    </head>

    <body>
        <div class="container shadow p-0">
            <header>
                <nav class="navbar navbar-expand-sm navbar-light bg-secondary">
                    <div class="container">
                        <img src="img/logotmdb.png" alt="" width="100">
                        <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse"
                                data-bs-target="#collapsibleNavId" aria-controls="collapsibleNavId" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="collapsibleNavId">
                            <ul class="navbar-nav me-auto mt-2 mt-lg-0 ms-5">

                                <li class="nav-item">
                                    <a class="nav-link text-white" href="Controller?op=menu&quieren=person">Person</a>
                                </li>
                                <li class="nav-item ">
                                    <a class="nav-link text-white" href="Controller?op=menu&quieren=movie">Movies</a>
                                </li>
                            </ul>
                            <form class="d-flex my-2 my-lg-0">
                                <c:choose>
                                    <c:when test="${empty usuario}">
                                        <!-- Si el usuario no ha iniciado sesión -->
                                        <!-- Mostrar el formulario de inicio de sesión o registro -->
                                        <form class="d-flex my-2 my-lg-0" action="Controller" method="post">
                                            <input class="form-control me-sm-2" type="text" name="dni" placeholder="dni" required="">
                                            <input class="form-control me-sm-2" type="text" name="nombre" placeholder="nombre" required="">
                                            <input type="hidden" name="op" value="login">
                                            <button class="btn btn-success my-2 my-sm-0" type="submit">Login/Register</button>

                                        </c:when>
                                        <c:otherwise>
                                            <!-- Si el usuario ha iniciado sesión -->
                                            <!-- Mostrar mensaje de bienvenida y botón de cierre de sesión -->
                                            <div class="col-md-4">
                                                <div class="row">
                                                    <div class=" text-end text-success">
                                                        <h5 class="text-white">Welcome ${usuario.nombre}</h5>

                                                    </div>
                                                    <a class="btn btn-danger my-2 my-sm-0 ms-3"  href="Controller?op=logout">
                                                        Logout
                                                    </a>
                                                </div>
                                            </div>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                    </div>
                </nav>

            </header>

            <main>
                <div class="row m-1 pt-1 justify-content-center">
                    <c:forEach items="${persons}" var="person">
                        <div class="col-md-4 d-flex pt-2">
                            <div class="card flex-fill">
                                <c:choose>
                                    <c:when test="${not empty person.foto}">
                                        <!-- Si la foto de la persona está presente, mostrarla -->
                                        <img class="card-img-top img-fluid" src="https://image.tmdb.org/t/p/w500${person.foto}" alt="Title" />
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Si la foto de la persona no está presente, mostrar la imagen predeterminada -->
                                        <img class="card-img-top img-fluid" src="img/noimage.png" alt="No Image" />
                                    </c:otherwise>
                                </c:choose>

                                <div class="card-body text-center">
                                    <h4 class="card-title">${person.nombre}</h4>
                                    <span class="rating">
                                        <a href="Controller?op=rating&rating=1">&#9733;</a>
                                        <a href="Controller?op=rating&rating=2">&#9733;</a>
                                        <a href="Controller?op=rating&rating=3">&#9733;</a>
                                        <a href="Controller?op=rating&rating=4">&#9733;</a>
                                        <a href="Controller?op=rating&rating=5">&#9733;</a>
                                    </span>
                                </div>
                                <div class="card-body text-center bg-secondary-subtle">
                                    <a href="" class="btn btn-success" data-bs-toggle="modal"
                                       data-bs-target="#modalId">Filmografia</a>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </div>
                <div class="row m-1 pt-1 justify-content-center">
                    <c:forEach items="${movies}" var="movie">
                        <div class="col-md-6 pt-2 d-flex">
                            <div class="card flex-fill">
                                <div class="row">
                                    <div class="col-md-6 ">
                                        <c:choose>
                                            <c:when test="${not empty movie.poster}">
                                                <!-- Si la foto de la persona está presente, mostrarla -->
                                                <img class="card-img-top img-fluid rounded" src="https://image.tmdb.org/t/p/w500${movie.poster}" alt="Title" />
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Si la foto de la persona no está presente, mostrar la imagen predeterminada -->
                                                <img class="card-img-top img-fluid" src="img/noimage.png" alt="No Image" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card-body">
                                            <h4 class="card-title">${movie.titulo}</h4>
                                            <h5 class="card-title">${movie.fecha}</h4>
                                                <p class="card-text">${movie.trama}</p>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </c:forEach>
                </div>

            </main>
            <footer class="bg-secondary text-center">
                <h2 class="mt-3 pt-4 text-light">Guti GS2 DAM</h2>
            </footer>
        </div>


        <!-- Modal Body -->
        <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
        <div class="modal fade" id="modalId" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" role="dialog"
             aria-labelledby="modalTitleId" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitleId">
                            ${person.nombre}
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row align-items-center">
                            <div class="col d-flex">
                                <div class="card flex-fill">
                                    <div class="row">
                                        <c:forEach items="${movies}" var="movie">
                                        <div class="col-md-6 ">
                                            <img class="card-img-top img-fluid rounded" src="img/poster.jpg" alt="Title" />
                                        </div>
                                        <div class="col-md-6">
                                            <div class="card-body">
                                                <h5 class="card-title">${movie.titulo}</h4>
                                                    <p class="card-text">${movie.fecha}</p>
                                            </div>
                                        </div>
                                        </c:forEach>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-bs-dismiss="modal">
                            Cerrar
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Optional: Place to the bottom of scripts -->



        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
                integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>
    </body>

</html>
