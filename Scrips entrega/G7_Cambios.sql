-- B - RESTRICCIONES

-- Chequeo de fecha
--A
ALTER TABLE gr7_alquiler
ADD CONSTRAINT ck_gr7_alquiler_fecha_valida CHECK (fecha_desde < fecha_hasta);
--INSERT INTO gr7_alquiler
--VALUES (2019-05-02,2018-05-04,25,20124);

--B

CREATE OR REPLACE FUNCTION TRFN_GR7_CTRL_PESO()
RETURNS trigger AS $body$
BEGIN

IF NOT((select f.peso_max_kg
  from gr7_fila f
  where f.nro_fila = new.nro_fila AND f.nro_estanteria=new.nro_estanteria)>
  SUM(
    coalesce((
      select SUM(pallet.peso) from gr7_mov_entrada move join gr7_pallet pallet on move.cod_pallet=pallet.cod_pallet where move.nro_fila=new.nro_fila and move.nro_estanteria=new.nro_estanteria
      and move.id_movimiento not in (select movi.id_movimiento_entrada
        from gr7_mov_interno movi)),0)
        +
        coalesce((
          select sum(pallet.peso) from gr7_mov_interno movi join gr7_pallet pallet on movi.cod_pallet=pallet.cod_pallet where movi.nro_fila=new.nro_fila and movi.nro_estanteria=new.nro_estanteria
          and movi.id_movimiento in (SELECT movi1.id_movimiento
            from gr7_mov_interno movi1 JOIN gr7_movimiento m
            ON movi1.id_movimiento=m.id_movimiento
            WHERE movi1.cod_pallet=pallet.cod_pallet
            ORDER BY m.fecha DESC
            limit 1)
          ),0) + (select pal.peso from gr7_pallet pal where pal.cod_pallet=new.cod_pallet))) THEN

          raise exception 'LA FILA NO PUEDE SOPORTAR MAS PESO';


          END IF;
          RETURN NEW;

          END; $body$ LANGUAGE 'plpgsql';
--TRIGGER PARA LA TABLA GR7_MOV_ENTRADA
CREATE TRIGGER TRFN_GR7_MOV_ENTRADA_CTRL_PESO
BEFORE INSERT OR UPDATE
ON gr7_mov_entrada
FOR EACH ROW
EXECUTE PROCEDURE  TRFN_GR7_CTRL_PESO();

--INSERT INTO gr7_mov_entrada VALUES
--('transporte 1','guia 1',1174,2,1,1,1,1);

--C
-- Chequeo de tipo
ALTER TABLE gr7_posicion
ADD CONSTRAINT ck_gr7_posicion_tipo_valido CHECK (tipo IN ('general','vidrio', 'insecticidas', 'inflamable'));
--INSERT INTO gr7_posicion
--VALUES (1,2,3,'comida',20);


-- C - SERVICIOS

-- Posiciones libres

CREATE FUNCTION fn_gr7_posicioneslibres(fecha date) RETURNS SETOF gr7_posicion
LANGUAGE plpgsql
AS $$
DECLARE
fila gr7_posicion%rowtype;
BEGIN
FOR fila IN
SELECT  *  FROM gr7_posicion
WHERE (nro_posicion, nro_fila, nro_estanteria) NOT IN(
  SELECT nro_posicion, nro_fila, nro_estanteria FROM gr7_alquiler_posiciones ap
  JOIN gr7_alquiler a ON (a.id_alquiler = ap.id_alquiler)
  WHERE fecha BETWEEN a.fecha_desde AND a.fecha_hasta)
  LOOP
  RETURN NEXT fila;
  END LOOP;
RETURN;
END;
$$;

-- Notificación clientes

CREATE FUNCTION fn_gr7_notificacionclientes(integer) RETURNS SETOF gr7_cliente
LANGUAGE plpgsql
AS $_$
DECLARE
fila GR7_CLIENTE%rowtype;
BEGIN
FOR fila IN
SELECT *
FROM GR7_CLIENTE c
JOIN GR7_ALQUILER a ON (a.id_cliente = c.cuit_cuil)
WHERE fecha_hasta - $1 = CURRENT_DATE
LOOP
RETURN NEXT fila;
END LOOP;
RETURN;
END;
$_$;

-- D - VISTAS

-- Estado de Posiciones

CREATE VIEW gr7_estado_posiciones AS
SELECT e.nombre_estanteria,
f.nombre_fila,
p.nro_posicion,
CASE
WHEN (ap.estado = true) THEN
CASE
WHEN (date_part('days', (now() - (a.fecha_hasta))) < (0)) THEN '0'
ELSE date_part('days', (now() - (a.fecha_hasta)))
END
ELSE '0'
END AS "días restantes"
FROM ((((gr7_estanteria e
  JOIN gr7_fila f USING (nro_estanteria))
  JOIN gr7_posicion p USING (nro_estanteria, nro_fila))
  JOIN gr7_alquiler_posiciones ap USING (nro_estanteria, nro_fila, nro_posicion))
  JOIN gr7_alquiler a USING (id_alquiler));

-- Top clientes

CREATE VIEW gr7_top_clientes_anual AS
SELECT a.id_cliente,
c.apellido,
c.nombre,
sum(((a.importe_dia) *
CASE
WHEN ((a.fecha_desde <= (CURRENT_DATE - interval '1 year')) AND (a.fecha_hasta >= CURRENT_DATE)) THEN date_part('day', (now() - interval '1 year'))
ELSE date_part('day', (now() - (a.fecha_desde)))
END)) AS invertido
FROM (gr7_cliente c
  JOIN gr7_alquiler a ON ((c.cuit_cuil = a.id_cliente)))
  GROUP BY a.id_cliente, c.apellido, c.nombre
  ORDER BY (sum(((a.importe_dia) *
  CASE
  WHEN ((a.fecha_desde <= (CURRENT_DATE - interval '1 year')) AND (a.fecha_hasta >= CURRENT_DATE)) THEN date_part('day', (now() - interval '1 year'))
  ELSE date_part('day', (now() - (a.fecha_desde)))
  END))) DESC
  LIMIT 10;