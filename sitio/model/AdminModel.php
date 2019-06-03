<?php

class AdminModel{
  private $db;

  function __construct(){
    $this->db = $this->Connect();
  }

  function Connect(){
    return new PDO('pgsql:host=dbases.exa.unicen.edu.ar;port=6432; dbname=cursada;
    user=unc_249257; password=jz159753');
  }

  function getPosiciones($fecha){
    $sentencia = $this->db->prepare( "select * from  where id_usuario=? ");
    $sentencia->execute(array($fecha));
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }

  function getDisponibles($codigo,$fecha){
    $sentencia = $this->db->prepare( "
SELECT ap.nro_posicion AS Posicion, ap.nro_estanteria AS Estanteria, ap.nro_fila AS Fila,c.cuit_cuil AS Codigo, ap.estado AS Disponible
FROM gr7_cliente c NATURAL JOIN gr7_alquiler a
NATURAL JOIN gr7_alquiler_posiciones ap
WHERE c.cuit_cuil = ?
AND ? BETWEEN a.fecha_desde AND a.fecha_hasta
AND ap.estado = false
 ");
    $sentencia->execute(array($codigo,$fecha));
    return $sentencia->fetchAll(PDO::FETCH_ASSOC);
  }
}
 ?>
