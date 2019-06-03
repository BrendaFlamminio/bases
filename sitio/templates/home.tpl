{include file="templates/header.tpl"}
{include file="templates/navBar.tpl"}

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

{include file="templates/footer.tpl"}
