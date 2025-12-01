<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Menú Lateral</title>

<style>
body {
    margin: 0;
    font-family: "Open Sans", sans-serif;
    display: flex;
}
nav {
    width: 240px;
    background-color: #003366;
    color: white;
    height: 100vh;
    overflow-y: auto;
}
ul.menu {
    list-style: none;
    padding: 0;
    margin: 0;
}
.menu > li {
    position: relative;
}
.menu-link {
    display: block;
    padding: 12px 20px;
    color: white;
    font-weight: bold;
    text-decoration: none;
    background-color: #003366;
    transition: background-color 0.3s;
}
.menu-link:hover,
.menu > li.active > .menu-link {
    background-color: #005599;
}
.submenu {
    display: none;
    list-style: none;
    margin: 0;
    padding: 0;
    background-color: #004080;
}
.menu > li:hover .submenu,
.menu > li.active .submenu {
    display: block;
}
.submenu-link {
    display: block;
    padding: 10px 30px;
    color: white;
    text-decoration: none;
    background-color: #004080;
    transition: background-color 0.3s;
}
.submenu-link:hover,
.submenu li.active .submenu-link {
    background-color: #0074c1;
}
main {
    flex: 1;
    padding: 2em;
    background: #f5f5f5;
}
</style>


<style>
.menu-link.active,
.submenu-link.active {
    background-color: #0074c1;
    color: #fff;
}
</style>


<script>
document.addEventListener("DOMContentLoaded", function () {
    const currentUrl = window.location.href;
    const links = document.querySelectorAll("nav a");

    links.forEach(link => {
        if (currentUrl === link.href) {
            link.classList.add("active");

            const parentLi = link.closest("li");
            if (parentLi) parentLi.classList.add("active");

            const parentMenuLi = link.closest("ul.submenu");
            if (parentMenuLi) {
                const topLi = parentMenuLi.closest("li");
                if (topLi) topLi.classList.add("active");
            }
        }
    });
});
</script>

</head>

<ul class="menu">
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/index_busqueda.jsp" class="menu-link">Buscar</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/index_busqueda.jsp" class="submenu-link">Busqueda</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Datos/index.jsp" class="menu-link">Funcionario</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Datos/index.jsp" class="submenu-link">Datos personales</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Permisos/index.jsp" class="submenu-link">Permisos</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Ausencias/index.jsp" class="submenu-link">Ausencias</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Finger/index_new4.jsp" class="submenu-link">Fichajes</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Firmas/index.jsp" class="submenu-link">Firmas</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Horas/index.jsp" class="submenu-link">Horas extras</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bolsa/index.jsp" class="submenu-link">Bolsa</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bolsa_concilia/index.jsp" class="submenu-link">Bolsa Conciliacion</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Incidencias_finger/index.jsp" class="submenu-link">Incidencias de fichaje</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Permisos_vo_rrhh/index.jsp" class="menu-link">Autorizar</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Permisos_vo_rrhh/index.jsp" class="submenu-link">Permisos</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Ausencias_vo_rrhh/index.jsp" class="submenu-link">Ausencias</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Fichajes_vo_rrhh/index.jsp" class="submenu-link">Fichajes</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bolsa_proceso/index.jsp" class="menu-link">Proceso mensual Saldos</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bolsa_proceso/index.jsp" class="submenu-link">SNP</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bolsa_proceso/index_policias.jsp" class="submenu-link">POLICIAS</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bolsa_proceso/index_bomberos.jsp" class="submenu-link">BOMBEROS</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Gestion/index.jsp" class="menu-link">Horas sindicales</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Gestion/index.jsp" class="submenu-link">Horas</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Permisos_vo_rrhh/index.jsp" class="menu-link">Aplicación Finger</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Permisos_vo_rrhh/index.jsp" class="submenu-link">Incidencias diarias</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Ausencias_vo_rrhh/index.jsp" class="submenu-link">Fichajes on line</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Fichajes_vo_rrhh/index.jsp" class="submenu-link">Chequeo de relojes</a></li>
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Fichajes_vo_rrhh/index.jsp" class="submenu-link">Calendarios</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bajas/index.jsp" class="menu-link">Bajas</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Bajas/index.jsp" class="submenu-link">Bajas</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Informes/index_informes.jsp" class="menu-link">Informes</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Informes/index_informes.jsp" class="submenu-link">Informes</a></li>
    </ul>
  </li>
  <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Formacion/index_formacion.jsp" class="menu-link">Formacion</a>
    <ul class="submenu">
      <li><a href="http://barcelo.aytosa.inet/permisos/jsp/gestion/Formacion/index_formacion.jsp" class="submenu-link">Formacion</a></li>
    </ul>
  </li>
</ul>

