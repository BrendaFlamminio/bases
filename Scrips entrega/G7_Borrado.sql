-- Borrado de vistas

DROP VIEW GR7_TOP_CLIENTES_ANUAL;

DROP VIEW GR7_ESTADO_POSICIONES;

-- Borrado de funciones

DROP FUNCTION FN_GR7_NOTIFICACIONCLIENTES(integer);

DROP FUNCTION FN_GR7_POSICIONESLIBRES(fecha date);

-- Borrado triggers y funciones de triggers

DROP TRIGGER TR_GR7_MOV_ENTRADA_CTRL_PESO ON GR7_MOV_ENTRADA;

DROP TRIGGER TR_GR7_MOV_INTERNO_CTRL_PESO2 ON GR7_MOV_INTERNO;

DROP FUNCTION TRFN_GR7_CTRL_PESO();

DROP FUNCTION TRFN_GR7_CTRL_PESO2();

-- Borrado de chequeos

ALTER TABLE GR7_ALQUILER
DROP CONSTRAINT CK_GR7_ALQUILER_FECHA_VALIDA;

ALTER TABLE GR7_POSICION
DROP CONSTRAINT CK_GR7_POSICION_TIPO_VALIDO;

-- Borrado de foreign keys

ALTER TABLE GR7_ALQUILER
    DROP CONSTRAINT FK_GR7_ALQUILER_CLIENTE;

ALTER TABLE GR7_ALQUILER_POSICIONES
    DROP CONSTRAINT FK_GR7_ALQUILER_POSICIONES_ALQUILER;

ALTER TABLE GR7_ALQUILER_POSICIONES
    DROP CONSTRAINT FK_GR7_ALQUILER_POSICIONES_POSICION;

ALTER TABLE GR7_FILA
    DROP CONSTRAINT FK_GR7_FILA_ESTANTERIA;

ALTER TABLE GR7_MOV_ENTRADA
    DROP CONSTRAINT FK_GR7_MOV_ENTRADA_ALQUILER_POSICIONES;

ALTER TABLE GR7_MOV_ENTRADA
    DROP CONSTRAINT FK_GR7_MOV_ENTRADA_MOVIMIENTO;

ALTER TABLE GR7_MOV_ENTRADA
    DROP CONSTRAINT FK_GR7_MOV_ENTRADA_PALLET;

ALTER TABLE GR7_MOV_INTERNO
    DROP CONSTRAINT FK_GR7_MOV_INTERNO_MOVIMIENTO;

ALTER TABLE GR7_MOV_INTERNO
    DROP CONSTRAINT FK_GR7_MOV_INTERNO_MOV_ENTRADA;

ALTER TABLE GR7_MOV_INTERNO
    DROP CONSTRAINT FK_GR7_MOV_INTERNO_MOV_INTERNO;

ALTER TABLE GR7_MOV_INTERNO
    DROP CONSTRAINT FK_GR7_MOV_INTERNO_POSICION;

ALTER TABLE GR7_MOV_SALIDA
    DROP CONSTRAINT FK_GR7_MOV_SALIDA_MOVIMIENTO;

ALTER TABLE GR7_MOV_SALIDA
    DROP CONSTRAINT FK_GR7_MOV_SALIDA_MOV_ENTRADA;

ALTER TABLE GR7_POSICION
    DROP CONSTRAINT FK_GR7_POSICION_FILA;

-- Borrado de tablas

DROP TABLE GR7_ALQUILER;

DROP TABLE GR7_ALQUILER_POSICIONES;

DROP TABLE GR7_CLIENTE;

DROP TABLE GR7_ESTANTERIA;

DROP TABLE GR7_FILA;

DROP TABLE GR7_MOVIMIENTO;

DROP TABLE GR7_MOV_ENTRADA;

DROP TABLE GR7_MOV_INTERNO;

DROP TABLE GR7_MOV_SALIDA;

DROP TABLE GR7_PALLET;

DROP TABLE GR7_POSICION;
