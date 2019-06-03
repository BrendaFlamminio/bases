<?php
require_once('libs/Smarty.class.php');

class AdminView
{
  private  $Smarty;

  function __construct(){
    $this->Smarty = new Smarty();

  }

  function home($Titulo){
    $this->Smarty->assign('Titulo',$Titulo);
    $this->Smarty->display("templates/home.tpl");
  }
function servicioUno($Titulo,$Resultados){
  $this->Smarty->assign('Titulo',$Titulo);
  $this->Smarty->assign('Resultados',$Resultados);
  $this->Smarty->display("templates/list1.tpl");
}
function servicioDos($Titulo,$Resultados){
  $this->Smarty->assign('Titulo',$Titulo);
  $this->Smarty->assign('Resultados',$Resultados);
  $this->Smarty->display("templates/list2.tpl");
}

}

 ?>
