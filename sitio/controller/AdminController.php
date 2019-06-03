<?php

require_once "./model/AdminModel.php";
require_once "./view/AdminView.php";


class AdminController {
  private $view;
  private $model;
  private $Titulo;

  function __construct()
  {
    //parent::__construct();

    $this->model = new AdminModel();
    $this->Titulo = "Warehouse Management System";
    $this->view = new AdminView();
  }

  function home(){
    $this->view->home($this->Titulo);
  }

function getPosiciones(){
  $fecha = $_GET["fechaForm"];
  $Resultados = $this->model->getPosiciones($fecha);
  $this->view->servicioUno($this->Titulo,$Resultados);
}
function getDisponibles(){
  $fecha=date('Y/m/d', time());
  $codigo = $_GET["codigoForm"];
  $Resultados = $this->model->getDisponibles($codigo,$fecha);
  $this->view->servicioDos($this->Titulo,$Resultados);
}





}
?>
