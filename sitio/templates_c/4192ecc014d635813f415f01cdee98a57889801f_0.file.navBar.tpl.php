<?php
/* Smarty version 3.1.33, created on 2019-06-03 01:42:44
  from 'C:\xampp\htdocs\sitio\templates\navBar.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.33',
  'unifunc' => 'content_5cf45ef407ec29_29337919',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4192ecc014d635813f415f01cdee98a57889801f' => 
    array (
      0 => 'C:\\xampp\\htdocs\\sitio\\templates\\navBar.tpl',
      1 => 1559518956,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5cf45ef407ec29_29337919 (Smarty_Internal_Template $_smarty_tpl) {
?>

<div class="contenedor_Navbar barra">

    <nav class="navbar navbar-expand-xl navbar-dark bg-primary  ">


      <!-- Dentro de este div se crea una lista donde se encuentra cada boton de la navbar del lado izquierdo-->
      <div class="collapse navbar-collapse" id="navbarsExample06">
        <ul class="navbar-nav mr-auto">
          <!-- Dentro de cada "li" se crea un boton de la barra de navegacion -->
          <li class="nav-item active logonav">
          </li>
          <li class="nav-item active">
            <a class="nav-link btn btn-primary" href="home">Inicio <span class="sr-only">(current)</span></a>
        </ul>

        <div class=" nav-item active  bd-navbar-nav ">
            <a class=" nav-link btn btn-primary"  style="color: white;" href="#">Cerrar Sesión</a>
        </div>
        </div>
          </nav>
  </div>
<?php }
}
