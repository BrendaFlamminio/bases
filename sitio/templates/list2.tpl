{include file="templates/header.tpl"}
{include file="templates/navBar.tpl"}

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
{foreach from=$Resultados item=resultado}
<tbody>
  <tr>
    <td  >{$resultado['codigo']} </td>
    <td  >{$resultado['posicion']} </td>
    <td  >{$resultado['estanteria']} </td>
    <td  >{$resultado['fila']} </td>
    <td  >No </td>
  </tr>
</tbody>
{/foreach}
</table>

{include file="templates/footer.tpl"}
