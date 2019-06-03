<?php
/* Smarty version 3.1.33, created on 2019-06-03 01:04:39
  from 'C:\xampp\htdocs\sitio\templates\home.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.33',
  'unifunc' => 'content_5cf456076f37d3_15964430',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '383deb019372b9685423eca1e41d779af389b68f' => 
    array (
      0 => 'C:\\xampp\\htdocs\\sitio\\templates\\home.tpl',
      1 => 1559516675,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:templates/header.tpl' => 1,
    'file:templates/navBar.tpl' => 1,
    'file:templates/footer.tpl' => 1,
  ),
),false)) {
function content_5cf456076f37d3_15964430 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_subTemplateRender("file:templates/header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
$_smarty_tpl->_subTemplateRender("file:templates/navBar.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

<div class="container form1">
      <h2>Formulario de consultas</h2>
      <form method="get" action="posiciones">
        <div class="form-group">
          <label for="fechaForm">Ingrese fecha</label>
          <input type="date" class="form-control" id="fechaForm" name="fechaForm">
        </div>
        <button type="submit" class="btn btn-primary">Consultar</button>
      </form>
</div>
<div class="container form2">
<form method="get" action="disponibles">
  <div class="form-group">
    <label for="codigoForm">Codigo cliente</label>
    <input type="number" class="form-control" id="codigoForm" name="codigoForm">
  
  </div>
  <button type="submit" class="btn btn-primary">Consultar</button>
</form>
</div>

<?php $_smarty_tpl->_subTemplateRender("file:templates/footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
}
}
