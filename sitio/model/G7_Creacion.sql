-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2019-06-03 22:43:53.576

-- tables
-- Table: GR7_ALQUILER
CREATE TABLE GR7_ALQUILER (
    id_alquiler serial  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NULL,
    importe_dia decimal(10,2)  NOT NULL,
    id_cliente int  NOT NULL,
    CONSTRAINT PK_GR7_ALQUILER PRIMARY KEY (id_alquiler)
);

-- Table: GR7_ALQUILER_POSICIONES
CREATE TABLE GR7_ALQUILER_POSICIONES (
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    estado boolean  NOT NULL,
    id_alquiler int  NOT NULL,
    CONSTRAINT PK_GR7_ALQUILER_POSICIONES PRIMARY KEY (nro_posicion,nro_estanteria,nro_fila,id_alquiler)
);

-- Table: GR7_CLIENTE
CREATE TABLE GR7_CLIENTE (
    cuit_cuil int  NOT NULL,
    apellido varchar(60)  NOT NULL,
    nombre varchar(40)  NOT NULL,
    fecha_alta date  NOT NULL,
    CONSTRAINT PK_GR7_CLIENTE PRIMARY KEY (cuit_cuil)
);

-- Table: GR7_ESTANTERIA
CREATE TABLE GR7_ESTANTERIA (
    nro_estanteria int  NOT NULL,
    nombre_estanteria varchar(80)  NOT NULL,
    CONSTRAINT PK_GR7_ESTANTERIA PRIMARY KEY (nro_estanteria)
);

-- Table: GR7_FILA
CREATE TABLE GR7_FILA (
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    nombre_fila varchar(80)  NOT NULL,
    peso_max_kg decimal(10,2)  NOT NULL,
    altura_max decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR7_FILA PRIMARY KEY (nro_estanteria,nro_fila)
);

-- Table: GR7_MOVIMIENTO
CREATE TABLE GR7_MOVIMIENTO (
    id_movimiento serial  NOT NULL,
    fecha timestamp  NOT NULL,
    responsable varchar(80)  NOT NULL,
    tipo char(1)  NOT NULL,
    CONSTRAINT PK_GR7_MOVIMIENTO PRIMARY KEY (id_movimiento)
);

-- Table: GR7_MOV_ENTRADA
CREATE TABLE GR7_MOV_ENTRADA (
    transporte varchar(80)  NOT NULL,
    guia varchar(80)  NOT NULL,
    cod_pallet varchar(20)  NOT NULL,
    id_movimiento int  NOT NULL,
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    id_alquiler int  NOT NULL,
    CONSTRAINT PK_GR7_MOV_ENTRADA PRIMARY KEY (cod_pallet,id_movimiento,id_alquiler)
);

-- Table: GR7_MOV_INTERNO
CREATE TABLE GR7_MOV_INTERNO (
    razon varchar(200)  NULL,
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    id_movimiento int  NOT NULL,
    id_movimiento_cambio int  NULL,
    cod_pallet varchar(20)  NOT NULL,
    id_movimiento_entrada int  NOT NULL,
    id_alquiler int  NOT NULL,
    CONSTRAINT PK_GR7_MOV_INTERNO PRIMARY KEY (id_movimiento)
);

-- Table: GR7_MOV_SALIDA
CREATE TABLE GR7_MOV_SALIDA (
    transporte varchar(80)  NOT NULL,
    guia varchar(80)  NOT NULL,
    id_movimiento int  NOT NULL,
    cod_pallet varchar(20)  NOT NULL,
    id_movimiento_entrada int  NOT NULL,
    id_alquiler int  NOT NULL,
    CONSTRAINT PK_GR7_MOV_SALIDA PRIMARY KEY (id_movimiento)
);

-- Table: GR7_PALLET
CREATE TABLE GR7_PALLET (
    cod_pallet varchar(20)  NOT NULL,
    descripcion varchar(200)  NOT NULL,
    peso decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR7_PALLET PRIMARY KEY (cod_pallet)
);

-- Table: GR7_POSICION
CREATE TABLE GR7_POSICION (
    nro_posicion int  NOT NULL,
    nro_estanteria int  NOT NULL,
    nro_fila int  NOT NULL,
    tipo varchar(40)  NOT NULL,
    id_posicion serial  NOT NULL,
    CONSTRAINT UQ_GR7_ID_POSICION UNIQUE (id_posicion) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT PK_GR7_POSICION PRIMARY KEY (nro_posicion,nro_estanteria,nro_fila)
);

-- foreign keys
-- Reference: FK_GR7_ALQUILER_CLIENTE (table: GR7_ALQUILER)
ALTER TABLE GR7_ALQUILER ADD CONSTRAINT FK_GR7_ALQUILER_CLIENTE
    FOREIGN KEY (id_cliente)
    REFERENCES GR7_CLIENTE (cuit_cuil)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_ALQUILER_POSICIONES_ALQUILER (table: GR7_ALQUILER_POSICIONES)
ALTER TABLE GR7_ALQUILER_POSICIONES ADD CONSTRAINT FK_GR7_ALQUILER_POSICIONES_ALQUILER
    FOREIGN KEY (id_alquiler)
    REFERENCES GR7_ALQUILER (id_alquiler)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_ALQUILER_POSICIONES_POSICION (table: GR7_ALQUILER_POSICIONES)
ALTER TABLE GR7_ALQUILER_POSICIONES ADD CONSTRAINT FK_GR7_ALQUILER_POSICIONES_POSICION
    FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila)
    REFERENCES GR7_POSICION (nro_posicion, nro_estanteria, nro_fila)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_FILA_ESTANTERIA (table: GR7_FILA)
ALTER TABLE GR7_FILA ADD CONSTRAINT FK_GR7_FILA_ESTANTERIA
    FOREIGN KEY (nro_estanteria)
    REFERENCES GR7_ESTANTERIA (nro_estanteria)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_ENTRADA_ALQUILER_POSICIONES (table: GR7_MOV_ENTRADA)
ALTER TABLE GR7_MOV_ENTRADA ADD CONSTRAINT FK_GR7_MOV_ENTRADA_ALQUILER_POSICIONES
    FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila, id_alquiler)
    REFERENCES GR7_ALQUILER_POSICIONES (nro_posicion, nro_estanteria, nro_fila, id_alquiler)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_ENTRADA_MOVIMIENTO (table: GR7_MOV_ENTRADA)
ALTER TABLE GR7_MOV_ENTRADA ADD CONSTRAINT FK_GR7_MOV_ENTRADA_MOVIMIENTO
    FOREIGN KEY (id_movimiento)
    REFERENCES GR7_MOVIMIENTO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_ENTRADA_PALLET (table: GR7_MOV_ENTRADA)
ALTER TABLE GR7_MOV_ENTRADA ADD CONSTRAINT FK_GR7_MOV_ENTRADA_PALLET
    FOREIGN KEY (cod_pallet)
    REFERENCES GR7_PALLET (cod_pallet)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_INTERNO_MOVIMIENTO (table: GR7_MOV_INTERNO)
ALTER TABLE GR7_MOV_INTERNO ADD CONSTRAINT FK_GR7_MOV_INTERNO_MOVIMIENTO
    FOREIGN KEY (id_movimiento)
    REFERENCES GR7_MOVIMIENTO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_INTERNO_MOV_ENTRADA (table: GR7_MOV_INTERNO)
ALTER TABLE GR7_MOV_INTERNO ADD CONSTRAINT FK_GR7_MOV_INTERNO_MOV_ENTRADA
    FOREIGN KEY (cod_pallet, id_movimiento_entrada, id_alquiler)
    REFERENCES GR7_MOV_ENTRADA (cod_pallet, id_movimiento, id_alquiler)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_INTERNO_MOV_INTERNO (table: GR7_MOV_INTERNO)
ALTER TABLE GR7_MOV_INTERNO ADD CONSTRAINT FK_GR7_MOV_INTERNO_MOV_INTERNO
    FOREIGN KEY (id_movimiento_cambio)
    REFERENCES GR7_MOV_INTERNO (id_movimiento)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_INTERNO_POSICION (table: GR7_MOV_INTERNO)
ALTER TABLE GR7_MOV_INTERNO ADD CONSTRAINT FK_GR7_MOV_INTERNO_POSICION
    FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila)
    REFERENCES GR7_POSICION (nro_posicion, nro_estanteria, nro_fila)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_SALIDA_MOVIMIENTO (table: GR7_MOV_SALIDA)
ALTER TABLE GR7_MOV_SALIDA ADD CONSTRAINT FK_GR7_MOV_SALIDA_MOVIMIENTO
    FOREIGN KEY (id_movimiento)
    REFERENCES GR7_MOVIMIENTO (id_movimiento)
    ON DELETE  CASCADE 
    ON UPDATE  CASCADE 
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_SALIDA_MOV_ENTRADA (table: GR7_MOV_SALIDA)
ALTER TABLE GR7_MOV_SALIDA ADD CONSTRAINT FK_GR7_MOV_SALIDA_MOV_ENTRADA
    FOREIGN KEY (cod_pallet, id_movimiento_entrada, id_alquiler)
    REFERENCES GR7_MOV_ENTRADA (cod_pallet, id_movimiento, id_alquiler)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_POSICION_FILA (table: GR7_POSICION)
ALTER TABLE GR7_POSICION ADD CONSTRAINT FK_GR7_POSICION_FILA
    FOREIGN KEY (nro_estanteria, nro_fila)
    REFERENCES GR7_FILA (nro_estanteria, nro_fila)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

