<?php
/* Smarty version 3.1.33, created on 2019-06-03 01:38:41
  from 'C:\xampp\htdocs\sitio\templates\list2.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.33',
  'unifunc' => 'content_5cf45e010089f9_51384433',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '67b97666ecf5fb659183acf51d51aeed85a05c7a' => 
    array (
      0 => 'C:\\xampp\\htdocs\\sitio\\templates\\list2.tpl',
      1 => 1559518162,
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
function content_5cf45e010089f9_51384433 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_subTemplateRender("file:templates/header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
$_smarty_tpl->_subTemplateRender("file:templates/navBar.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

<table class="table">
  <thead>
    <tr>
      <th scope="col">Cliente</th>
      <th scope="col">Posicion</th>
      <th scope="col">Estanteria</th>
      <th scope="col">Fila</th>
      <th scope="col">Disponible</th>
    </tr>
  </thead>
<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['Resultados']->value, 'resultado');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['resultado']->value) {
?>
<tbody>
  <tr>
    <td  ><?php echo $_smarty_tpl->tpl_vars['resultado']->value['codigo'];?>
 </td>
    <td  ><?php echo $_smarty_tpl->tpl_vars['resultado']->value['posicion'];?>
 </td>
    <td  ><?php echo $_smarty_tpl->tpl_vars['resultado']->value['estanteria'];?>
 </td>
    <td  ><?php echo $_smarty_tpl->tpl_vars['resultado']->value['fila'];?>
 </td>
    <td  >No </td>
  </tr>
</tbody>
<?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>
</table>

<?php $_smarty_tpl->_subTemplateRender("file:templates/footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
}
}
