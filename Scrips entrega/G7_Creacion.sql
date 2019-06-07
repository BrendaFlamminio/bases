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
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
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
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_FILA_ESTANTERIA (table: GR7_FILA)
ALTER TABLE GR7_FILA ADD CONSTRAINT FK_GR7_FILA_ESTANTERIA
    FOREIGN KEY (nro_estanteria)
    REFERENCES GR7_ESTANTERIA (nro_estanteria)
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
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
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
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
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_MOV_INTERNO_POSICION (table: GR7_MOV_INTERNO)
ALTER TABLE GR7_MOV_INTERNO ADD CONSTRAINT FK_GR7_MOV_INTERNO_POSICION
    FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila)
    REFERENCES GR7_POSICION (nro_posicion, nro_estanteria, nro_fila)
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
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
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_GR7_POSICION_FILA (table: GR7_POSICION)
ALTER TABLE GR7_POSICION ADD CONSTRAINT FK_GR7_POSICION_FILA
    FOREIGN KEY (nro_estanteria, nro_fila)
    REFERENCES GR7_FILA (nro_estanteria, nro_fila)
    ON DELETE  CASCADE
    ON UPDATE  CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

--
--agregado de registros
--

--
--gr7_cliente
--

INSERT INTO gr7_cliente VALUES (20458, 'Gomez', 'Miguel', '2018-05-12');
INSERT INTO gr7_cliente VALUES (20182, 'Hernandez', 'Jose', '2019-03-25');
INSERT INTO gr7_cliente VALUES (21731, 'Arias', 'Julieta', '2019-01-31');
INSERT INTO gr7_cliente VALUES (22158, 'Sanchez', 'Mario', '2018-11-14');
INSERT INTO gr7_cliente VALUES (22944, 'Artiguenabe', 'Camila', '2019-05-10');
INSERT INTO gr7_cliente VALUES (20124, 'Pastor', 'Daiana', '2018-10-02');
INSERT INTO gr7_cliente VALUES (21753, 'Acosta', 'Hector', '2019-06-01');

--
--gr7_alquiler
--

INSERT INTO gr7_alquiler VALUES (DEFAULT, '2018-11-25', '2018-12-04', 25.00, 20458);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2018-11-14', '2018-12-02', 25.00, 22158);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2018-10-02', '2018-10-12', 25.00, 20124);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2019-02-01', '2019-02-28', 25.00, 21731);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2019-05-10', '2019-06-02', 25.00, 22944);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2019-01-01', '2019-08-12', 25.00, 20458);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2019-03-14', '2019-04-02', 25.00, 22158);
INSERT INTO gr7_alquiler VALUES (DEFAULT, '2019-04-20', '2019-05-01', 25.00, 21731);

--
--gr7_estanteria
--

INSERT INTO gr7_estanteria VALUES (1, 'perro');
INSERT INTO gr7_estanteria VALUES (2, 'gato');
INSERT INTO gr7_estanteria VALUES (3, 'pez');
INSERT INTO gr7_estanteria VALUES (4, 'caballo');
INSERT INTO gr7_estanteria VALUES (5, 'conejo');

--
--gr7_fila
--

INSERT INTO gr7_fila VALUES (1, 1, 'fila 1', 85.00, 1.50);
INSERT INTO gr7_fila VALUES (2, 1, 'fila 1', 140.00, 1.00);
INSERT INTO gr7_fila VALUES (3, 1, 'fila 1', 75.00, 0.50);
INSERT INTO gr7_fila VALUES (4, 1, 'fila 1', 200.00, 15.00);
INSERT INTO gr7_fila VALUES (1, 2, 'fila 2', 115.00, 10.50);

--
--gr7_posicion
--

INSERT INTO gr7_posicion VALUES (1, 1, 1, 'general', DEFAULT);
INSERT INTO gr7_posicion VALUES (2, 1, 1, 'vidrio', DEFAULT);
INSERT INTO gr7_posicion VALUES (1, 1, 2, 'general', DEFAULT);
INSERT INTO gr7_posicion VALUES (1, 2, 1, 'vidrio', DEFAULT);
INSERT INTO gr7_posicion VALUES (3, 1, 2, 'general', DEFAULT);
INSERT INTO gr7_posicion VALUES (5, 3, 1, 'vidrio', DEFAULT);
INSERT INTO gr7_posicion VALUES (1, 3, 1, 'inflamable', DEFAULT);
INSERT INTO gr7_posicion VALUES (2, 4, 1, 'insecticidas', DEFAULT);
INSERT INTO gr7_posicion VALUES (2, 2, 1, 'general', DEFAULT);
INSERT INTO gr7_posicion VALUES (3, 2, 1, 'general', DEFAULT);
INSERT INTO gr7_posicion VALUES (4, 2, 1, 'vidrio', DEFAULT);
INSERT INTO gr7_posicion VALUES (5, 2, 1, 'general', DEFAULT);
INSERT INTO gr7_posicion VALUES (6, 2, 1, 'vidrio', DEFAULT);
INSERT INTO gr7_posicion VALUES (7, 2, 1, 'general', DEFAULT);

--
--gr7_alquiler_posiciones
--

INSERT INTO gr7_alquiler_posiciones VALUES (1, 1, 1, true, 1);
INSERT INTO gr7_alquiler_posiciones VALUES (2, 1, 1, true, 2);
INSERT INTO gr7_alquiler_posiciones VALUES (1, 2, 1, true, 3);
INSERT INTO gr7_alquiler_posiciones VALUES (1, 1, 2, true, 4);
INSERT INTO gr7_alquiler_posiciones VALUES (2, 1, 1, true, 5);
INSERT INTO gr7_alquiler_posiciones VALUES (3, 1, 2, false, 6);
INSERT INTO gr7_alquiler_posiciones VALUES (5, 3, 1, false, 7);

--
--gr7_pallet
--

INSERT INTO gr7_pallet VALUES ('124', 'espejo fragil', 1.00);
INSERT INTO gr7_pallet VALUES ('1174', 'Randa', 95.00);
INSERT INTO gr7_pallet VALUES ('2489', 'caja grande', 25.00);
INSERT INTO gr7_pallet VALUES ('548', 'llantas', 30.00);
INSERT INTO gr7_pallet VALUES ('1424', 'bidones de gaoil', 60.00);
INSERT INTO gr7_pallet VALUES ('2124', 'escultura de marmol', 81.00);
INSERT INTO gr7_pallet VALUES ('1321', 'planchas de vidrios', 18.50);

--
--gr7_movimiento
--

INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-11-25 00:00:00', 'Empleado 1', 'e');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-11-14 00:00:00', 'Empleado 1', 'E');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-10-02 00:00:00', 'Empleado 2', 'e');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-02-01 00:00:00', 'Empleado 2', 'e');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-05-10 00:00:00', 'Empleado 1', 'e');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-01-01 00:00:00', 'Empleado 3', 'e');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-03-14 00:00:00', 'Empleado 3', 'e');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-11-29 00:00:00', 'empleado 1', 'i');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-02-15 00:00:00', 'empleado 2', 'i');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-04-22 00:00:00', 'empleado 2', 'i');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-03-28 00:00:00', 'empleado 2', 'i');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-11-02 00:00:00', 'empleado 1', 'i');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-12-04 00:00:00', 'empleado 3', 's');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-12-02 00:00:00', 'empleado 3', 's');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2018-10-12 00:00:00', 'empleado 3', 's');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-02-28 00:00:00', 'empleado 3', 's');
INSERT INTO gr7_movimiento VALUES (DEFAULT, '2019-04-02 00:00:00', 'empleado 3', 's');

--
--gr7_mov_entrada
--

INSERT INTO gr7_mov_entrada VALUES ('Trasporte 1', 'Empleado 1', '1174', 1, 1, 1, 1, 1);
INSERT INTO gr7_mov_entrada VALUES ('Transporte 1', 'Empleado 1', '124', 2, 2, 1, 1, 2);
INSERT INTO gr7_mov_entrada VALUES ('Transporte 2', 'empleado 2', '1321', 3, 1, 2, 1, 3);
INSERT INTO gr7_mov_entrada VALUES ('Transporte 2', 'Empleado 2', '1424', 4, 1, 1, 2, 4);
INSERT INTO gr7_mov_entrada VALUES ('transporte 2', 'transporte 2', '2124', 5, 2, 1, 1, 5);
INSERT INTO gr7_mov_entrada VALUES ('transporte 2', 'empleado 2', '2489', 6, 3, 1, 2, 6);
INSERT INTO gr7_mov_entrada VALUES ('transporte 3', 'empleado 3', '548', 7, 5, 3, 1, 7);

--
--gr7_mov_interno
--

INSERT INTO gr7_mov_interno VALUES ('mejor ubicacion', 2, 2, 1, 8, 8, '1174', 1, 1);
INSERT INTO gr7_mov_interno VALUES ('mas cerca de la entrada', 3, 2, 1, 9, 9, '124', 2, 2);
INSERT INTO gr7_mov_interno VALUES ('mejor ubicacion', 4, 2, 1, 10, 10, '1424', 4, 4);
INSERT INTO gr7_mov_interno VALUES ('estanteria mas adecuada', 5, 2, 1, 11, 11, '1424', 4, 4);
INSERT INTO gr7_mov_interno VALUES ('mas cerca de la puerta', 7, 2, 1, 12, 12, '548', 7, 7);

--
--gr7_mov_salida
--

INSERT INTO gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 13, '1174', 1, 1);
INSERT INTO gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 14, '124', 2, 2);
INSERT INTO gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 15, '1321', 3, 3);
INSERT INTO gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 16, '1424', 4, 4);
