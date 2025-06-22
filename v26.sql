-- Creación de esquemas
CREATE SCHEMA IF NOT EXISTS originacion;
CREATE SCHEMA IF NOT EXISTS analisis_creditos;
CREATE SCHEMA IF NOT EXISTS gestion_contratos;

-- Eliminación de tablas en sus respectivos esquemas
DROP TABLE IF EXISTS gestion_contratos.pagares CASCADE;
DROP TABLE IF EXISTS gestion_contratos.contratos CASCADE;
DROP TABLE IF EXISTS analisis_creditos.observacion_analistas CASCADE;
DROP TABLE IF EXISTS analisis_creditos.historial_estados CASCADE;
DROP TABLE IF EXISTS originacion.vendedores CASCADE;
DROP TABLE IF EXISTS originacion.vehiculos CASCADE;
DROP TABLE IF EXISTS originacion.tipos_documentos CASCADE;
DROP TABLE IF EXISTS originacion.solicitudes_creditos CASCADE;
DROP TABLE IF EXISTS originacion.documentos_adjuntos CASCADE;
DROP TABLE IF EXISTS originacion.identificadores_vehiculos CASCADE;
DROP TABLE IF EXISTS originacion.clientes_prospectos CASCADE;
DROP TABLE IF EXISTS originacion.concesionarios CASCADE;
DROP TABLE IF EXISTS originacion.auditorias CASCADE;

-- Tipos ENUM 
CREATE TYPE IF NOT EXISTS originacion.estado_clientes_enum AS ENUM ('Activo', 'Nuevo', 'ActivoCreditosVencidos', 'Prospecto');
CREATE TYPE IF NOT EXISTS originacion.estado_concesio_enum AS ENUM ('Activo', 'Inactivo');
CREATE TYPE IF NOT EXISTS gestion_contratos.estado_contrato_enum AS ENUM ('Draft', 'Firmado', 'Cancelado');
CREATE TYPE IF NOT EXISTS originacion.estado_solicitu_enum AS ENUM ('Borrador', 'EnRevision', 'Aprobada', 'Rechazada', 'Cancelada');
CREATE TYPE IF NOT EXISTS originacion.estado_tiposdoc_enum AS ENUM ('Activo', 'Inactivo');
CREATE TYPE IF NOT EXISTS originacion.estado_vendedor_enum AS ENUM ('Activo', 'Inactivo');
CREATE TYPE IF NOT EXISTS originacion.estado_vehiculo_enum AS ENUM ('Nuevo', 'Usado');

/*==============================================================*/
/*================== Esquema: originacion ======================*/
/*==============================================================*/

/*==============================================================*/
/* Table: auditorias                                           */
/*==============================================================*/
CREATE TABLE originacion.auditorias (
   id_auditoria          SERIAL         NOT NULL,
   tabla                 VARCHAR(40)    NOT NULL,
   accion                VARCHAR(6)     NOT NULL,
   fecha_hora            TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT pk_auditorias PRIMARY KEY (id_auditoria),
   CONSTRAINT ck_auditorias_accion CHECK (accion IN ('INSERT','UPDATE','DELETE'))
);

/*==============================================================*/
/* Table: clientes_prospectos                                   */
/*==============================================================*/
CREATE TABLE originacion.clientes_prospectos (
   id_cliente_prospecto   SERIAL                    NOT NULL,
   cedula                 VARCHAR(10)               NOT NULL,
   nombre                 VARCHAR(50)               NOT NULL,
   apellido               VARCHAR(50)               NOT NULL,
   telefono               VARCHAR(20)               NOT NULL,
   email                  VARCHAR(60)               NOT NULL,
   direccion              VARCHAR(120)              NOT NULL,
   ingresos               NUMERIC(12,2)             NOT NULL,
   egresos                NUMERIC(12,2)             NOT NULL,
   actividad_economica    VARCHAR(120)              NOT NULL,
   estado                 originacion.estado_clientes_enum NOT NULL,
   version                NUMERIC(9)                NOT NULL,
   CONSTRAINT pk_clientes_prospectos PRIMARY KEY (id_cliente_prospecto),
   CONSTRAINT uq_clientes_cedula UNIQUE (cedula)
);

/*==============================================================*/
/* Table: documentos_adjuntos                                    */
/*==============================================================*/
CREATE TABLE originacion.documentos_adjuntos (
   id_documento          SERIAL         NOT NULL,
   id_solicitud          INT            NOT NULL,
   id_tipo_documento     INT            NOT NULL,
   ruta_archivo          VARCHAR(150)   NOT NULL,
   fecha_cargado         TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
   version               NUMERIC(9)        NOT NULL,
   CONSTRAINT pk_documentos_adjuntos PRIMARY KEY (id_documento)
);

/*==============================================================*/
/* Table: concesionarios                                         */
/*==============================================================*/
CREATE TABLE originacion.concesionarios (
   id_concesionario      SERIAL                      NOT NULL,
   razon_social          VARCHAR(80)                 NOT NULL,
   direccion             VARCHAR(120)                NOT NULL,
   telefono              VARCHAR(20)                 NOT NULL,
   email_contacto        VARCHAR(50)                 NOT NULL,
   estado                originacion.estado_concesio_enum NOT NULL,
   version               NUMERIC(9)                  NOT NULL,
   CONSTRAINT pk_concesionarios PRIMARY KEY (id_concesionario)
);

/*==============================================================*/
/* Table: identificadores_vehiculos                              */
/*==============================================================*/
CREATE TABLE originacion.identificadores_vehiculos (
   id_identificador_vehiculo SERIAL         NOT NULL,
   vin                     VARCHAR(17)      NOT NULL,
   numero_motor            VARCHAR(20)      NOT NULL,
   placa                   VARCHAR(7)       NOT NULL,
   version                 NUMERIC(9)       NOT NULL,
   CONSTRAINT pk_identificadores_vehiculos PRIMARY KEY (id_identificador_vehiculo),
   CONSTRAINT uq_identifi_vin UNIQUE (vin),
   CONSTRAINT uq_identifi_motor UNIQUE (numero_motor),
   CONSTRAINT uq_identifi_placa UNIQUE (placa)
);

/*==============================================================*/
/* Table: solicitudes_creditos                                   */
/*==============================================================*/
CREATE TABLE originacion.solicitudes_creditos (
   id_solicitud          SERIAL                        NOT NULL,
   id_cliente_prospecto  INT                           NOT NULL,
   id_vehiculo           INT                           NOT NULL,
   id_vendedor           INT                           NOT NULL,
   numero_solicitud      VARCHAR(50)                   NOT NULL,
   monto_solicitado      NUMERIC(12,2)                 NOT NULL,
   plazo_meses           NUMERIC(3)                    NOT NULL,
   fecha_solicitud       TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
   entrada               NUMERIC(12,2)                 NOT NULL,
   score_interno         NUMERIC(6,2)                  NOT NULL,
   score_externo         NUMERIC(6,2)                  NOT NULL,
   relacion_cuota_ingreso NUMERIC(5,2)                 NOT NULL,
   tasa_anual            NUMERIC(5,2)                  NOT NULL,
   cuota_mensual         NUMERIC(8,2)                  NOT NULL,
   total_pagar           NUMERIC(12,2)                 NOT NULL,
   estado               originacion.estado_solicitu_enum    NOT NULL,
   version              NUMERIC(9)                     NOT NULL,
   CONSTRAINT pk_solicitudes_creditos PRIMARY KEY (id_solicitud),
   CONSTRAINT uq_solicitud_numero UNIQUE (numero_solicitud),
   CONSTRAINT uq_solicitud_vehiculo UNIQUE (id_vehiculo)
);

/*==============================================================*/
/* Table: tipos_documentos                                       */
/*==============================================================*/
CREATE TABLE originacion.tipos_documentos (
   id_tipo_documento      SERIAL                     NOT NULL,
   nombre                VARCHAR(40)                 NOT NULL,
   descripcion           VARCHAR(150)                NOT NULL,
   estado                originacion.estado_tiposdoc_enum NOT NULL,
   version               NUMERIC(9)                  NOT NULL,
   CONSTRAINT pk_tipos_documentos PRIMARY KEY (id_tipo_documento)
);

/*==============================================================*/
/* Table: vehiculos                                             */
/*==============================================================*/
CREATE TABLE originacion.vehiculos (
   id_vehiculo           SERIAL                        NOT NULL,
   id_concesionario      INT                           NOT NULL,
   id_identificador_vehiculo INT                       NOT NULL,
   marca                 VARCHAR(40)                   NOT NULL,
   modelo                VARCHAR(40)                   NOT NULL,
   anio                  NUMERIC(4)                    NOT NULL,
   valor                 NUMERIC(10,2)                 NOT NULL,
   color                 VARCHAR(30)                   NOT NULL,
   extras                VARCHAR(150),
   estado                originacion.estado_vehiculo_enum   NOT NULL,
   version               NUMERIC(9)                    NOT NULL,
   CONSTRAINT pk_vehiculos PRIMARY KEY (id_vehiculo)
);

/*==============================================================*/
/* Table: vendedores                                            */
/*==============================================================*/
CREATE TABLE originacion.vendedores (
   id_vendedor           SERIAL                     NOT NULL,
   id_concesionario      INT                        NOT NULL,
   nombre               VARCHAR(100)               NOT NULL,
   telefono             VARCHAR(20)                NOT NULL,
   email                VARCHAR(60)                NOT NULL,
   estado               originacion.estado_vendedor_enum NOT NULL,
   version              NUMERIC(9)                 NOT NULL,
   CONSTRAINT pk_vendedores PRIMARY KEY (id_vendedor)
);

/*==============================================================*/
/*================ Esquema: analisis_creditos ==================*/
/*==============================================================*/

/*==============================================================*/
/* Table: historial_estados                                      */
/*==============================================================*/
CREATE TABLE analisis_creditos.historial_estados (
   id_historial          SERIAL         NOT NULL,
   id_solicitud          INT            NOT NULL,
   estado                VARCHAR(12)    NOT NULL,
   fecha_hora            TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
   usuario              VARCHAR(50)     NOT NULL,
   motivo               VARCHAR(120)    NOT NULL,
   version              NUMERIC(9)      NOT NULL,
   CONSTRAINT pk_historial_estados PRIMARY KEY (id_historial)
);

/*==============================================================*/
/* Table: observacion_analistas                                  */
/*==============================================================*/
CREATE TABLE analisis_creditos.observacion_analistas (
   id_observacion_analista SERIAL       NOT NULL,
   id_solicitud          INT            NOT NULL,
   usuario               VARCHAR(50)    NOT NULL,
   fecha_hora            TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
   razon_intervencion    VARCHAR(500)   NOT NULL,
   version               NUMERIC(9)     NOT NULL,
   CONSTRAINT pk_observacion_analistas PRIMARY KEY (id_observacion_analista)
);

/*==============================================================*/
/*================ Esquema: gestion_contratos ==================*/
/*==============================================================*/

/*==============================================================*/
/* Table: contratos                                              */
/*==============================================================*/
CREATE TABLE gestion_contratos.contratos (
   id_contrato           SERIAL                     NOT NULL,
   id_solicitud          INT                        NOT NULL,
   ruta_archivo          VARCHAR(150)               NOT NULL,
   fecha_generado        TIMESTAMP                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
   fecha_firma           TIMESTAMP                  NOT NULL,
   estado                gestion_contratos.estado_contrato_enum NOT NULL,
   condicion_especial    VARCHAR(120),
   version               NUMERIC(9)                 NOT NULL,
   CONSTRAINT pk_contratos PRIMARY KEY (id_contrato)
);

/*==============================================================*/
/* Table: pagares                                               */
/*==============================================================*/
CREATE TABLE gestion_contratos.pagares (
   id_pagare             SERIAL         NOT NULL,
   id_solicitud          INT            NOT NULL,
   numero_cuota          NUMERIC(3)     NOT NULL,
   ruta_archivo          VARCHAR(150)   NOT NULL,
   fecha_generado        TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
   version               NUMERIC(9)     NOT NULL,
   CONSTRAINT pk_pagares PRIMARY KEY (id_pagare)
);

/*==============================================================*/
/* Relational Constraints (Foreign Keys)                        */
/*==============================================================*/

ALTER TABLE gestion_contratos.contratos
   ADD CONSTRAINT fk_contratos_solicitudes FOREIGN KEY (id_solicitud)
      REFERENCES originacion.solicitudes_creditos (id_solicitud)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.documentos_adjuntos
   ADD CONSTRAINT fk_documentos_solicitudes FOREIGN KEY (id_solicitud)
      REFERENCES originacion.solicitudes_creditos (id_solicitud)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.documentos_adjuntos
   ADD CONSTRAINT fk_document_reference_tiposdoc FOREIGN KEY (id_tipo_documento)
      REFERENCES originacion.tipos_documentos (id_tipo_documento)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE analisis_creditos.historial_estados
   ADD CONSTRAINT fk_historiales_solicitudes FOREIGN KEY (id_solicitud)
      REFERENCES originacion.solicitudes_creditos (id_solicitud)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE analisis_creditos.observacion_analistas
   ADD CONSTRAINT fk_observaciones_solicitudes FOREIGN KEY (id_solicitud)
      REFERENCES originacion.solicitudes_creditos (id_solicitud)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE gestion_contratos.pagares
   ADD CONSTRAINT fk_pagares_solicitudes FOREIGN KEY (id_solicitud)
      REFERENCES originacion.solicitudes_creditos (id_solicitud)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.solicitudes_creditos
   ADD CONSTRAINT fk_solicitu_reference_vendedor FOREIGN KEY (id_vendedor)
      REFERENCES originacion.vendedores (id_vendedor)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.solicitudes_creditos
   ADD CONSTRAINT fk_solicitu_reference_vehiculo FOREIGN KEY (id_vehiculo)
      REFERENCES originacion.vehiculos (id_vehiculo)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.solicitudes_creditos
   ADD CONSTRAINT fk_solicitu_reference_clientes FOREIGN KEY (id_cliente_prospecto)
      REFERENCES originacion.clientes_prospectos (id_cliente_prospecto)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.vehiculos
   ADD CONSTRAINT fk_vehiculos_concesionarios FOREIGN KEY (id_concesionario)
      REFERENCES originacion.concesionarios (id_concesionario)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.vehiculos
   ADD CONSTRAINT fk_vehiculo_reference_identifi FOREIGN KEY (id_identificador_vehiculo)
      REFERENCES originacion.identificadores_vehiculos (id_identificador_vehiculo)
      ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE originacion.vendedores
   ADD CONSTRAINT fk_vendedor_reference_concesio FOREIGN KEY (id_concesionario)
      REFERENCES originacion.concesionarios (id_concesionario)
      ON DELETE RESTRICT ON UPDATE RESTRICT;