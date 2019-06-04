--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3 (Ubuntu 11.3-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.3 (Ubuntu 11.3-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: unc_249257; Type: SCHEMA; Schema: -; Owner: unc_249257
--

CREATE SCHEMA unc_249257;


ALTER SCHEMA unc_249257 OWNER TO unc_249257;

--
-- Name: SCHEMA unc_249257; Type: COMMENT; Schema: -; Owner: unc_249257
--

COMMENT ON SCHEMA unc_249257 IS 'Zapata, Joaquín';


--
-- Name: ctrl_fecha(); Type: FUNCTION; Schema: unc_249257; Owner: unc_249257
--

CREATE FUNCTION unc_249257.ctrl_fecha() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	IF 
         (NOT EXISTS(SELECT 1
            FROM GR7_ALQUILER
	  WHERE (fecha_desde > fecha_hasta))) THEN
	  RETURN NEW;
           ELSE 
           RAISE EXCEPTION 'FECHAS INGRESADAS INVALIDAS';
	END IF;
END; $$;


ALTER FUNCTION unc_249257.ctrl_fecha() OWNER TO unc_249257;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: gr7_alquiler; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_alquiler (
    id_alquiler integer NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date,
    importe_dia numeric(10,2) NOT NULL,
    id_cliente integer NOT NULL
);


ALTER TABLE unc_249257.gr7_alquiler OWNER TO unc_249257;

--
-- Name: gr7_alquiler_id_alquiler_seq; Type: SEQUENCE; Schema: unc_249257; Owner: unc_249257
--

CREATE SEQUENCE unc_249257.gr7_alquiler_id_alquiler_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unc_249257.gr7_alquiler_id_alquiler_seq OWNER TO unc_249257;

--
-- Name: gr7_alquiler_id_alquiler_seq; Type: SEQUENCE OWNED BY; Schema: unc_249257; Owner: unc_249257
--

ALTER SEQUENCE unc_249257.gr7_alquiler_id_alquiler_seq OWNED BY unc_249257.gr7_alquiler.id_alquiler;


--
-- Name: gr7_alquiler_posiciones; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_alquiler_posiciones (
    nro_posicion integer NOT NULL,
    nro_estanteria integer NOT NULL,
    nro_fila integer NOT NULL,
    estado boolean NOT NULL,
    id_alquiler integer NOT NULL
);


ALTER TABLE unc_249257.gr7_alquiler_posiciones OWNER TO unc_249257;

--
-- Name: gr7_cliente; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_cliente (
    cuit_cuil integer NOT NULL,
    apellido character varying(60) NOT NULL,
    nombre character varying(40) NOT NULL,
    fecha_alta date NOT NULL
);


ALTER TABLE unc_249257.gr7_cliente OWNER TO unc_249257;

--
-- Name: gr7_estanteria; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_estanteria (
    nro_estanteria integer NOT NULL,
    nombre_estanteria character varying(80) NOT NULL
);


ALTER TABLE unc_249257.gr7_estanteria OWNER TO unc_249257;

--
-- Name: gr7_fila; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_fila (
    nro_estanteria integer NOT NULL,
    nro_fila integer NOT NULL,
    nombre_fila character varying(80) NOT NULL,
    peso_max_kg numeric(10,2) NOT NULL,
    altura_max numeric(10,2) NOT NULL
);


ALTER TABLE unc_249257.gr7_fila OWNER TO unc_249257;

--
-- Name: gr7_mov_entrada; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_mov_entrada (
    transporte character varying(80) NOT NULL,
    guia character varying(80) NOT NULL,
    cod_pallet character varying(20) NOT NULL,
    id_movimiento integer NOT NULL,
    nro_posicion integer NOT NULL,
    nro_estanteria integer NOT NULL,
    nro_fila integer NOT NULL,
    id_alquiler integer NOT NULL
);


ALTER TABLE unc_249257.gr7_mov_entrada OWNER TO unc_249257;

--
-- Name: gr7_mov_interno; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_mov_interno (
    razon character varying(200),
    nro_posicion integer NOT NULL,
    nro_estanteria integer NOT NULL,
    nro_fila integer NOT NULL,
    id_movimiento integer NOT NULL,
    id_movimiento_cambio integer,
    cod_pallet character varying(20) NOT NULL,
    id_movimiento_entrada integer NOT NULL,
    id_alquiler integer NOT NULL
);


ALTER TABLE unc_249257.gr7_mov_interno OWNER TO unc_249257;

--
-- Name: gr7_mov_salida; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_mov_salida (
    transporte character varying(80) NOT NULL,
    guia character varying(80) NOT NULL,
    id_movimiento integer NOT NULL,
    cod_pallet character varying(20) NOT NULL,
    id_movimiento_entrada integer NOT NULL,
    id_alquiler integer NOT NULL
);


ALTER TABLE unc_249257.gr7_mov_salida OWNER TO unc_249257;

--
-- Name: gr7_movimiento; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_movimiento (
    id_movimiento integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    responsable character varying(80) NOT NULL,
    tipo character(1) NOT NULL
);


ALTER TABLE unc_249257.gr7_movimiento OWNER TO unc_249257;

--
-- Name: gr7_movimiento_id_movimiento_seq; Type: SEQUENCE; Schema: unc_249257; Owner: unc_249257
--

CREATE SEQUENCE unc_249257.gr7_movimiento_id_movimiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unc_249257.gr7_movimiento_id_movimiento_seq OWNER TO unc_249257;

--
-- Name: gr7_movimiento_id_movimiento_seq; Type: SEQUENCE OWNED BY; Schema: unc_249257; Owner: unc_249257
--

ALTER SEQUENCE unc_249257.gr7_movimiento_id_movimiento_seq OWNED BY unc_249257.gr7_movimiento.id_movimiento;


--
-- Name: gr7_pallet; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_pallet (
    cod_pallet character varying(20) NOT NULL,
    descripcion character varying(200) NOT NULL,
    peso numeric(10,2) NOT NULL
);


ALTER TABLE unc_249257.gr7_pallet OWNER TO unc_249257;

--
-- Name: gr7_posicion; Type: TABLE; Schema: unc_249257; Owner: unc_249257
--

CREATE TABLE unc_249257.gr7_posicion (
    nro_posicion integer NOT NULL,
    nro_estanteria integer NOT NULL,
    nro_fila integer NOT NULL,
    tipo character varying(40) NOT NULL,
    id_posicion integer NOT NULL
);


ALTER TABLE unc_249257.gr7_posicion OWNER TO unc_249257;

--
-- Name: gr7_posicion_id_posicion_seq; Type: SEQUENCE; Schema: unc_249257; Owner: unc_249257
--

CREATE SEQUENCE unc_249257.gr7_posicion_id_posicion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE unc_249257.gr7_posicion_id_posicion_seq OWNER TO unc_249257;

--
-- Name: gr7_posicion_id_posicion_seq; Type: SEQUENCE OWNED BY; Schema: unc_249257; Owner: unc_249257
--

ALTER SEQUENCE unc_249257.gr7_posicion_id_posicion_seq OWNED BY unc_249257.gr7_posicion.id_posicion;


--
-- Name: gr7_alquiler id_alquiler; Type: DEFAULT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_alquiler ALTER COLUMN id_alquiler SET DEFAULT nextval('unc_249257.gr7_alquiler_id_alquiler_seq'::regclass);


--
-- Name: gr7_movimiento id_movimiento; Type: DEFAULT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_movimiento ALTER COLUMN id_movimiento SET DEFAULT nextval('unc_249257.gr7_movimiento_id_movimiento_seq'::regclass);


--
-- Name: gr7_posicion id_posicion; Type: DEFAULT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_posicion ALTER COLUMN id_posicion SET DEFAULT nextval('unc_249257.gr7_posicion_id_posicion_seq'::regclass);


--
-- Data for Name: gr7_alquiler; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_alquiler VALUES (1, '2018-11-25', '2018-12-04', 25.00, 20458);
INSERT INTO unc_249257.gr7_alquiler VALUES (2, '2018-11-14', '2018-12-02', 25.00, 22158);
INSERT INTO unc_249257.gr7_alquiler VALUES (3, '2018-10-02', '2018-10-12', 25.00, 20124);
INSERT INTO unc_249257.gr7_alquiler VALUES (4, '2019-02-01', '2019-02-28', 25.00, 21731);
INSERT INTO unc_249257.gr7_alquiler VALUES (5, '2019-05-10', '2019-06-02', 25.00, 22944);
INSERT INTO unc_249257.gr7_alquiler VALUES (6, '2019-01-01', '2019-08-12', 25.00, 20458);
INSERT INTO unc_249257.gr7_alquiler VALUES (7, '2019-03-14', '2019-04-02', 25.00, 22158);
INSERT INTO unc_249257.gr7_alquiler VALUES (8, '2019-04-20', '2019-05-01', 25.00, 21731);


--
-- Data for Name: gr7_alquiler_posiciones; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (1, 1, 1, true, 1);
INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (2, 1, 1, true, 2);
INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (1, 2, 1, true, 3);
INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (1, 1, 2, true, 4);
INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (2, 1, 1, true, 5);
INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (3, 1, 2, false, 6);
INSERT INTO unc_249257.gr7_alquiler_posiciones VALUES (5, 3, 1, false, 7);


--
-- Data for Name: gr7_cliente; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_cliente VALUES (20458, 'Gomez', 'Miguel', '2018-05-12');
INSERT INTO unc_249257.gr7_cliente VALUES (20182, 'Hernandez', 'Jose', '2019-03-25');
INSERT INTO unc_249257.gr7_cliente VALUES (21731, 'Arias', 'Julieta', '2019-01-31');
INSERT INTO unc_249257.gr7_cliente VALUES (22158, 'Sanchez', 'Mario', '2018-11-14');
INSERT INTO unc_249257.gr7_cliente VALUES (22944, 'Artiguenabe', 'Camila', '2019-05-10');
INSERT INTO unc_249257.gr7_cliente VALUES (20124, 'Pastor', 'Daiana', '2018-10-02');
INSERT INTO unc_249257.gr7_cliente VALUES (21753, 'Acosta', 'Hector', '2019-06-01');


--
-- Data for Name: gr7_estanteria; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_estanteria VALUES (1, 'perro');
INSERT INTO unc_249257.gr7_estanteria VALUES (2, 'gato');
INSERT INTO unc_249257.gr7_estanteria VALUES (3, 'pez');
INSERT INTO unc_249257.gr7_estanteria VALUES (4, 'caballo');
INSERT INTO unc_249257.gr7_estanteria VALUES (5, 'conejo');


--
-- Data for Name: gr7_fila; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_fila VALUES (1, 1, 'fila 1', 85.00, 1.50);
INSERT INTO unc_249257.gr7_fila VALUES (2, 1, 'fila 1', 140.00, 1.00);
INSERT INTO unc_249257.gr7_fila VALUES (3, 1, 'fila 1', 75.00, 0.50);
INSERT INTO unc_249257.gr7_fila VALUES (4, 1, 'fila 1', 200.00, 15.00);
INSERT INTO unc_249257.gr7_fila VALUES (1, 2, 'fila 2', 115.00, 10.50);


--
-- Data for Name: gr7_mov_entrada; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_mov_entrada VALUES ('Trasporte 1', 'Empleado 1', '1174', 1, 1, 1, 1, 1);
INSERT INTO unc_249257.gr7_mov_entrada VALUES ('Transporte 1', 'Empleado 1', '124', 2, 2, 1, 1, 2);
INSERT INTO unc_249257.gr7_mov_entrada VALUES ('Transporte 2', 'empleado 2', '1321', 3, 1, 2, 1, 3);
INSERT INTO unc_249257.gr7_mov_entrada VALUES ('Transporte 2', 'Empleado 2', '1424', 4, 1, 1, 2, 4);
INSERT INTO unc_249257.gr7_mov_entrada VALUES ('transporte 2', 'transporte 2', '2124', 5, 2, 1, 1, 5);
INSERT INTO unc_249257.gr7_mov_entrada VALUES ('transporte 2', 'empleado 2', '2489', 6, 3, 1, 2, 6);
INSERT INTO unc_249257.gr7_mov_entrada VALUES ('transporte 3', 'empleado 3', '548', 7, 5, 3, 1, 7);


--
-- Data for Name: gr7_mov_interno; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_mov_interno VALUES ('mejor ubicacion', 2, 2, 1, 8, 8, '1174', 1, 1);
INSERT INTO unc_249257.gr7_mov_interno VALUES ('mas cerca de la entrada', 3, 2, 1, 9, 9, '124', 2, 2);
INSERT INTO unc_249257.gr7_mov_interno VALUES ('mejor ubicacion', 4, 2, 1, 10, 10, '1424', 4, 4);
INSERT INTO unc_249257.gr7_mov_interno VALUES ('estanteria mas adecuada', 5, 2, 1, 11, 11, '1424', 4, 4);
INSERT INTO unc_249257.gr7_mov_interno VALUES ('mas cerca de la puerta', 7, 2, 1, 12, 12, '548', 7, 7);


--
-- Data for Name: gr7_mov_salida; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 13, '1174', 1, 1);
INSERT INTO unc_249257.gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 14, '124', 2, 2);
INSERT INTO unc_249257.gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 15, '1321', 3, 3);
INSERT INTO unc_249257.gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 16, '1424', 4, 4);
INSERT INTO unc_249257.gr7_mov_salida VALUES ('transporte 3', 'empleado 3', 18, '548', 7, 7);


--
-- Data for Name: gr7_movimiento; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_movimiento VALUES (1, '2018-11-25 00:00:00', 'Empleado 1', 'e');
INSERT INTO unc_249257.gr7_movimiento VALUES (2, '2018-11-14 00:00:00', 'Empleado 1', 'E');
INSERT INTO unc_249257.gr7_movimiento VALUES (3, '2018-10-02 00:00:00', 'Empleado 2', 'e');
INSERT INTO unc_249257.gr7_movimiento VALUES (4, '2019-02-01 00:00:00', 'Empleado 2', 'e');
INSERT INTO unc_249257.gr7_movimiento VALUES (5, '2019-05-10 00:00:00', 'Empleado 1', 'e');
INSERT INTO unc_249257.gr7_movimiento VALUES (6, '2019-01-01 00:00:00', 'Empleado 3', 'e');
INSERT INTO unc_249257.gr7_movimiento VALUES (7, '2019-03-14 00:00:00', 'Empleado 3', 'e');
INSERT INTO unc_249257.gr7_movimiento VALUES (9, '2018-11-29 00:00:00', 'empleado 1', 'i');
INSERT INTO unc_249257.gr7_movimiento VALUES (10, '2019-02-15 00:00:00', 'empleado 2', 'i');
INSERT INTO unc_249257.gr7_movimiento VALUES (11, '2019-04-22 00:00:00', 'empleado 2', 'i');
INSERT INTO unc_249257.gr7_movimiento VALUES (12, '2019-03-28 00:00:00', 'empleado 2', 'i');
INSERT INTO unc_249257.gr7_movimiento VALUES (8, '2018-11-02 00:00:00', 'empleado 1', 'i');
INSERT INTO unc_249257.gr7_movimiento VALUES (13, '2018-12-04 00:00:00', 'empleado 3', 's');
INSERT INTO unc_249257.gr7_movimiento VALUES (14, '2018-12-02 00:00:00', 'empleado 3', 's');
INSERT INTO unc_249257.gr7_movimiento VALUES (15, '2018-10-12 00:00:00', 'empleado 3', 's');
INSERT INTO unc_249257.gr7_movimiento VALUES (16, '2019-02-28 00:00:00', 'empleado 3', 's');
INSERT INTO unc_249257.gr7_movimiento VALUES (18, '2019-04-02 00:00:00', 'empleado 3', 's');


--
-- Data for Name: gr7_pallet; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_pallet VALUES ('124', 'espejo fragil', 1.00);
INSERT INTO unc_249257.gr7_pallet VALUES ('1174', 'Randa', 95.00);
INSERT INTO unc_249257.gr7_pallet VALUES ('2489', 'caja grande', 25.00);
INSERT INTO unc_249257.gr7_pallet VALUES ('548', 'llantas', 30.00);
INSERT INTO unc_249257.gr7_pallet VALUES ('1424', 'bidones de gaoil', 60.00);
INSERT INTO unc_249257.gr7_pallet VALUES ('2124', 'escultura de marmol', 81.00);
INSERT INTO unc_249257.gr7_pallet VALUES ('1321', 'planchas de vidrios', 18.50);


--
-- Data for Name: gr7_posicion; Type: TABLE DATA; Schema: unc_249257; Owner: unc_249257
--

INSERT INTO unc_249257.gr7_posicion VALUES (1, 1, 1, 'general', 1);
INSERT INTO unc_249257.gr7_posicion VALUES (2, 1, 1, 'vidrio', 2);
INSERT INTO unc_249257.gr7_posicion VALUES (1, 1, 2, 'general', 3);
INSERT INTO unc_249257.gr7_posicion VALUES (1, 2, 1, 'vidrio', 4);
INSERT INTO unc_249257.gr7_posicion VALUES (3, 1, 2, 'general', 5);
INSERT INTO unc_249257.gr7_posicion VALUES (5, 3, 1, 'vidrio', 6);
INSERT INTO unc_249257.gr7_posicion VALUES (1, 3, 1, 'inflamable', 7);
INSERT INTO unc_249257.gr7_posicion VALUES (2, 4, 1, 'insecticidas', 8);
INSERT INTO unc_249257.gr7_posicion VALUES (2, 2, 1, 'general', 9);
INSERT INTO unc_249257.gr7_posicion VALUES (3, 2, 1, 'general', 10);
INSERT INTO unc_249257.gr7_posicion VALUES (4, 2, 1, 'vidrio', 11);
INSERT INTO unc_249257.gr7_posicion VALUES (5, 2, 1, 'general', 12);
INSERT INTO unc_249257.gr7_posicion VALUES (6, 2, 1, 'vidrio', 13);
INSERT INTO unc_249257.gr7_posicion VALUES (7, 2, 1, 'general', 14);


--
-- Name: gr7_alquiler_id_alquiler_seq; Type: SEQUENCE SET; Schema: unc_249257; Owner: unc_249257
--

SELECT pg_catalog.setval('unc_249257.gr7_alquiler_id_alquiler_seq', 1, false);


--
-- Name: gr7_movimiento_id_movimiento_seq; Type: SEQUENCE SET; Schema: unc_249257; Owner: unc_249257
--

SELECT pg_catalog.setval('unc_249257.gr7_movimiento_id_movimiento_seq', 18, true);


--
-- Name: gr7_posicion_id_posicion_seq; Type: SEQUENCE SET; Schema: unc_249257; Owner: unc_249257
--

SELECT pg_catalog.setval('unc_249257.gr7_posicion_id_posicion_seq', 14, true);


--
-- Name: gr7_alquiler pk_gr7_alquiler; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_alquiler
    ADD CONSTRAINT pk_gr7_alquiler PRIMARY KEY (id_alquiler);


--
-- Name: gr7_alquiler_posiciones pk_gr7_alquiler_posiciones; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_alquiler_posiciones
    ADD CONSTRAINT pk_gr7_alquiler_posiciones PRIMARY KEY (nro_posicion, nro_estanteria, nro_fila, id_alquiler);


--
-- Name: gr7_cliente pk_gr7_cliente; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_cliente
    ADD CONSTRAINT pk_gr7_cliente PRIMARY KEY (cuit_cuil);


--
-- Name: gr7_estanteria pk_gr7_estanteria; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_estanteria
    ADD CONSTRAINT pk_gr7_estanteria PRIMARY KEY (nro_estanteria);


--
-- Name: gr7_fila pk_gr7_fila; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_fila
    ADD CONSTRAINT pk_gr7_fila PRIMARY KEY (nro_estanteria, nro_fila);


--
-- Name: gr7_mov_entrada pk_gr7_mov_entrada; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_entrada
    ADD CONSTRAINT pk_gr7_mov_entrada PRIMARY KEY (cod_pallet, id_movimiento, id_alquiler);


--
-- Name: gr7_mov_interno pk_gr7_mov_interno; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_interno
    ADD CONSTRAINT pk_gr7_mov_interno PRIMARY KEY (id_movimiento);


--
-- Name: gr7_mov_salida pk_gr7_mov_salida; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_salida
    ADD CONSTRAINT pk_gr7_mov_salida PRIMARY KEY (id_movimiento);


--
-- Name: gr7_movimiento pk_gr7_movimiento; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_movimiento
    ADD CONSTRAINT pk_gr7_movimiento PRIMARY KEY (id_movimiento);


--
-- Name: gr7_pallet pk_gr7_pallet; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_pallet
    ADD CONSTRAINT pk_gr7_pallet PRIMARY KEY (cod_pallet);


--
-- Name: gr7_posicion pk_gr7_posicion; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_posicion
    ADD CONSTRAINT pk_gr7_posicion PRIMARY KEY (nro_posicion, nro_estanteria, nro_fila);


--
-- Name: gr7_posicion uq_gr7_id_posicion; Type: CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_posicion
    ADD CONSTRAINT uq_gr7_id_posicion UNIQUE (id_posicion);


--
-- Name: gr7_alquiler fk_gr7_alquiler_cliente; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_alquiler
    ADD CONSTRAINT fk_gr7_alquiler_cliente FOREIGN KEY (id_cliente) REFERENCES unc_249257.gr7_cliente(cuit_cuil) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_alquiler_posiciones fk_gr7_alquiler_posiciones_alquiler; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_alquiler_posiciones
    ADD CONSTRAINT fk_gr7_alquiler_posiciones_alquiler FOREIGN KEY (id_alquiler) REFERENCES unc_249257.gr7_alquiler(id_alquiler) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_alquiler_posiciones fk_gr7_alquiler_posiciones_posicion; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_alquiler_posiciones
    ADD CONSTRAINT fk_gr7_alquiler_posiciones_posicion FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila) REFERENCES unc_249257.gr7_posicion(nro_posicion, nro_estanteria, nro_fila) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_fila fk_gr7_fila_estanteria; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_fila
    ADD CONSTRAINT fk_gr7_fila_estanteria FOREIGN KEY (nro_estanteria) REFERENCES unc_249257.gr7_estanteria(nro_estanteria) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_entrada fk_gr7_mov_entrada_alquiler_posiciones; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_entrada
    ADD CONSTRAINT fk_gr7_mov_entrada_alquiler_posiciones FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila, id_alquiler) REFERENCES unc_249257.gr7_alquiler_posiciones(nro_posicion, nro_estanteria, nro_fila, id_alquiler) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_entrada fk_gr7_mov_entrada_movimiento; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_entrada
    ADD CONSTRAINT fk_gr7_mov_entrada_movimiento FOREIGN KEY (id_movimiento) REFERENCES unc_249257.gr7_movimiento(id_movimiento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_entrada fk_gr7_mov_entrada_pallet; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_entrada
    ADD CONSTRAINT fk_gr7_mov_entrada_pallet FOREIGN KEY (cod_pallet) REFERENCES unc_249257.gr7_pallet(cod_pallet) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_interno fk_gr7_mov_interno_mov_entrada; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_interno
    ADD CONSTRAINT fk_gr7_mov_interno_mov_entrada FOREIGN KEY (cod_pallet, id_movimiento_entrada, id_alquiler) REFERENCES unc_249257.gr7_mov_entrada(cod_pallet, id_movimiento, id_alquiler) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_interno fk_gr7_mov_interno_mov_interno; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_interno
    ADD CONSTRAINT fk_gr7_mov_interno_mov_interno FOREIGN KEY (id_movimiento_cambio) REFERENCES unc_249257.gr7_mov_interno(id_movimiento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_interno fk_gr7_mov_interno_movimiento; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_interno
    ADD CONSTRAINT fk_gr7_mov_interno_movimiento FOREIGN KEY (id_movimiento) REFERENCES unc_249257.gr7_movimiento(id_movimiento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_interno fk_gr7_mov_interno_posicion; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_interno
    ADD CONSTRAINT fk_gr7_mov_interno_posicion FOREIGN KEY (nro_posicion, nro_estanteria, nro_fila) REFERENCES unc_249257.gr7_posicion(nro_posicion, nro_estanteria, nro_fila) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_salida fk_gr7_mov_salida_mov_entrada; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_salida
    ADD CONSTRAINT fk_gr7_mov_salida_mov_entrada FOREIGN KEY (cod_pallet, id_movimiento_entrada, id_alquiler) REFERENCES unc_249257.gr7_mov_entrada(cod_pallet, id_movimiento, id_alquiler) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_mov_salida fk_gr7_mov_salida_movimiento; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_mov_salida
    ADD CONSTRAINT fk_gr7_mov_salida_movimiento FOREIGN KEY (id_movimiento) REFERENCES unc_249257.gr7_movimiento(id_movimiento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: gr7_posicion fk_gr7_posicion_fila; Type: FK CONSTRAINT; Schema: unc_249257; Owner: unc_249257
--

ALTER TABLE ONLY unc_249257.gr7_posicion
    ADD CONSTRAINT fk_gr7_posicion_fila FOREIGN KEY (nro_estanteria, nro_fila) REFERENCES unc_249257.gr7_fila(nro_estanteria, nro_fila) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA unc_249257; Type: ACL; Schema: -; Owner: unc_249257
--

GRANT USAGE ON SCHEMA unc_249257 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

