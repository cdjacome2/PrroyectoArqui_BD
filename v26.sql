DROP TABLE IF EXISTS auditorias CASCADE;

DROP TABLE IF EXISTS clientes_prospectos CASCADE;

DROP TABLE IF EXISTS concesionarios CASCADE;

DROP TABLE IF EXISTS contratos CASCADE;

DROP TABLE IF EXISTS documentos_adjuntos CASCADE;

DROP TABLE IF EXISTS historial_estados CASCADE;

DROP TABLE IF EXISTS identificadores_vehiculos CASCADE;

DROP TABLE IF EXISTS observacion_analistas CASCADE;

DROP TABLE IF EXISTS pagares CASCADE;

DROP TABLE IF EXISTS solicitudes_creditos CASCADE;

DROP TABLE IF EXISTS tipos_documentos CASCADE;

DROP TABLE IF EXISTS vehiculos CASCADE;

DROP TABLE IF EXISTS vendedores CASCADE;

CREATE TYPE estado_clientes_enum AS ENUM ('Activo', 'Nuevo', 'ActivoCreditosVencidos', 'Prospecto');
CREATE TYPE estado_concesio_enum AS ENUM ('Activo', 'Inactivo');
CREATE TYPE estado_contrato_enum AS ENUM ('Draft', 'Firmado', 'Cancelado');
CREATE TYPE estado_solicitu_enum AS ENUM ('Borrador', 'EnRevision', 'Aprobada', 'Rechazada', 'Cancelada');
CREATE TYPE estado_tiposdoc_enum AS ENUM ('Activo', 'Inactivo');
CREATE TYPE estado_vendedor_enum AS ENUM ('Activo', 'Inactivo');
CREATE TYPE estado_vehiculo_enum AS ENUM ('Nuevo', 'Usado');

/*==============================================================*/
/* Table: auditorias                                           */
/*==============================================================*/
create table auditorias (
   id_auditoria          SERIAL               not null,
   tabla                 VARCHAR(40)          not null,
   accion                VARCHAR(6)           not null,
   fecha_hora            TIMESTAMP            not null default CURRENT_TIMESTAMP,
   constraint pk_auditorias primary key (id_auditoria),
   constraint ck_auditorias_accion check (accion IN ('INSERT','UPDATE','DELETE'))
);

/*==============================================================*/
/* Table: clientes_prospectos                                   */
/*==============================================================*/
create table clientes_prospectos (
   id_cliente_prospecto   SERIAL               not null,
   cedula                VARCHAR(10)          not null,
   nombre                VARCHAR(50)          not null,
   apellido              VARCHAR(50)          not null,
   telefono              VARCHAR(20)          not null,
   email                 VARCHAR(60)          not null,
   direccion             VARCHAR(120)         not null,
   ingresos              NUMERIC(12,2)        not null,
   egresos               NUMERIC(12,2)        not null,
   actividad_economica   VARCHAR(120)         not null,
   estado                estado_clientes_enum not null,
   version               NUMERIC(9)           not null,
   constraint pk_clientes_prospectos primary key (id_cliente_prospecto),
   constraint ak_key_2_clientes unique (cedula)
);

/*==============================================================*/
/* Table: concesionarios                                         */
/*==============================================================*/
create table concesionarios (
   id_concesionario      SERIAL               not null,
   razon_social          VARCHAR(80)          not null,
   direccion             VARCHAR(120)         not null,
   telefono              VARCHAR(20)          not null,
   email_contacto        VARCHAR(50)          not null,
   estado                estado_concesio_enum not null,
   version               NUMERIC(9)           not null,
   constraint pk_concesionarios primary key (id_concesionario)
);

/*==============================================================*/
/* Table: contratos                                              */
/*==============================================================*/
create table contratos (
   id_contrato           SERIAL               not null,
   id_solicitud          INT                  not null,
   ruta_archivo          VARCHAR(150)         not null,
   fecha_generado        TIMESTAMP            not null default CURRENT_TIMESTAMP,
   fecha_firma           TIMESTAMP            not null,
   estado                estado_contrato_enum not null,
   condicion_especial    VARCHAR(120)         null,
   version               NUMERIC(9)           not null,
   constraint pk_contratos primary key (id_contrato)
);

/*==============================================================*/
/* Table: documentos_adjuntos                                    */
/*==============================================================*/
create table documentos_adjuntos (
   id_documento          SERIAL               not null,
   id_solicitud          INT                  not null,
   id_tipo_documento     INT                  not null,
   ruta_archivo          VARCHAR(150)         not null,
   fecha_cargado         TIMESTAMP            not null default CURRENT_TIMESTAMP,
   version               NUMERIC(9)           not null,
   constraint pk_documentos_adjuntos primary key (id_documento)
);

/*==============================================================*/
/* Table: historial_estados                                      */
/*==============================================================*/
create table historial_estados (
   id_historial          SERIAL               not null,
   id_solicitud          INT                  not null,
   estado                VARCHAR(12)          not null,
   fecha_hora            TIMESTAMP            not null default CURRENT_TIMESTAMP,
   usuario              VARCHAR(50)          not null,
   motivo               VARCHAR(120)         not null,
   version              NUMERIC(9)           not null,
   constraint pk_historial_estados primary key (id_historial)
);

/*==============================================================*/
/* Table: identificadores_vehiculos                              */
/*==============================================================*/
create table identificadores_vehiculos (
   id_identificador_vehiculo SERIAL               not null,
   vin                    VARCHAR(17)          not null,
   numero_motor           VARCHAR(20)          not null,
   placa                  VARCHAR(7)           not null,
   version                NUMERIC(9)           not null,
   constraint pk_identificadores_vehiculos primary key (id_identificador_vehiculo),
   constraint ak_key_2_identifi unique (vin),
   constraint ak_key_3_identifi unique (numero_motor),
   constraint ak_key_4_identifi unique (placa)
);

/*==============================================================*/
/* Table: observacion_analistas                                  */
/*==============================================================*/
create table observacion_analistas (
   id_observacion_analista SERIAL               not null,
   id_solicitud          INT                  not null,
   usuario              VARCHAR(50)          not null,
   fecha_hora            TIMESTAMP            not null default CURRENT_TIMESTAMP,
   razon_intervencion    VARCHAR(500)         not null,
   version              NUMERIC(9)           not null,
   constraint pk_observacion_analistas primary key (id_observacion_analista)
);

/*==============================================================*/
/* Table: pagares                                               */
/*==============================================================*/
create table pagares (
   id_pagare             SERIAL               not null,
   id_solicitud          INT                  not null,
   numero_cuota          NUMERIC(3)           not null,
   ruta_archivo          VARCHAR(150)         not null,
   fecha_generado        TIMESTAMP            not null default CURRENT_TIMESTAMP,
   version               NUMERIC(9)           not null,
   constraint pk_pagares primary key (id_pagare)
);

/*==============================================================*/
/* Table: solicitudes_creditos                                   */
/*==============================================================*/
create table solicitudes_creditos (
   id_solicitud          SERIAL               not null,
   id_cliente_prospecto  INT                  not null,
   id_vehiculo           INT                  not null,
   id_vendedor           INT                  not null,
   numero_solicitud      VARCHAR(50)          not null,
   monto_solicitado      NUMERIC(12,2)        not null,
   plazo_meses           NUMERIC(3)           not null,
   fecha_solicitud       TIMESTAMP            not null default CURRENT_TIMESTAMP,
   entrada              NUMERIC(12,2)        not null,
   score_interno         NUMERIC(6,2)         not null,
   score_externo         NUMERIC(6,2)         not null,
   relacion_cuota_ingreso NUMERIC(5,2)        not null,
   tasa_anual            NUMERIC(5,2)         not null,
   cuota_mensual         NUMERIC(8,2)         not null,
   total_pagar           NUMERIC(12,2)        not null,
   estado                estado_solicitu_enum not null,
   version               NUMERIC(9)           not null,
   constraint pk_solicitudes_creditos primary key (id_solicitud),
   constraint ak_key_2_solicitu unique (numero_solicitud),
   constraint ak_key_4_solicitu unique (id_vehiculo)
);

/*==============================================================*/
/* Table: tipos_documentos                                       */
/*==============================================================*/
create table tipos_documentos (
   id_tipo_documento      SERIAL               not null,
   nombre                VARCHAR(40)          not null,
   descripcion           VARCHAR(150)         not null,
   estado                estado_tiposdoc_enum not null,
   version               NUMERIC(9)           not null,
   constraint pk_tipos_documentos primary key (id_tipo_documento)
);

/*==============================================================*/
/* Table: vehiculos                                             */
/*==============================================================*/
create table vehiculos (
   id_vehiculo           SERIAL               not null,
   id_concesionario      INT                  not null,
   id_identificador_vehiculo INT                not null,
   marca                 VARCHAR(40)          not null,
   modelo                VARCHAR(40)          not null,
   anio                  NUMERIC(4)           not null,
   valor                 NUMERIC(10,2)        not null,
   color                 VARCHAR(30)          not null,
   extras                VARCHAR(150)         null,
   estado                estado_vehiculo_enum not null,
   version               NUMERIC(9)           not null,
   constraint pk_vehiculos primary key (id_vehiculo)
);

/*==============================================================*/
/* Table: vendedores                                            */
/*==============================================================*/
create table vendedores (
   id_vendedor           SERIAL               not null,
   id_concesionario      INT                  not null,
   nombre                VARCHAR(100)         not null,
   telefono              VARCHAR(20)          not null,
   email                 VARCHAR(60)          not null,
   estado                estado_vendedor_enum not null,
   version               NUMERIC(9)           not null,
   constraint pk_vendedores primary key (id_vendedor)
);

/*==============================================================*/
/* Relational Constraints (Foreign Keys)                         */
/*==============================================================*/

alter table contratos
   add constraint fk_contratos_solicitudes foreign key (id_solicitud)
      references solicitudes_creditos (id_solicitud)
      on delete restrict on update restrict;

alter table documentos_adjuntos
   add constraint fk_documentos_solicitudes foreign key (id_solicitud)
      references solicitudes_creditos (id_solicitud)
      on delete restrict on update restrict;

alter table documentos_adjuntos
   add constraint fk_document_reference_tiposdoc foreign key (id_tipo_documento)
      references tipos_documentos (id_tipo_documento)
      on delete restrict on update restrict;

alter table historial_estados
   add constraint fk_historiales_solicitudes foreign key (id_solicitud)
      references solicitudes_creditos (id_solicitud)
      on delete restrict on update restrict;

alter table observacion_analistas
   add constraint fk_observaciones_solicitudes foreign key (id_solicitud)
      references solicitudes_creditos (id_solicitud)
      on delete restrict on update restrict;

alter table pagares
   add constraint fk_pagares_solicitudes foreign key (id_solicitud)
      references solicitudes_creditos (id_solicitud)
      on delete restrict on update restrict;

alter table solicitudes_creditos
   add constraint fk_solicitu_reference_vendedor foreign key (id_vendedor)
      references vendedores (id_vendedor)
      on delete restrict on update restrict;

alter table solicitudes_creditos
   add constraint fk_solicitu_reference_vehiculo foreign key (id_vehiculo)
      references vehiculos (id_vehiculo)
      on delete restrict on update restrict;

alter table solicitudes_creditos
   add constraint fk_solicitu_reference_clientes foreign key (id_cliente_prospecto)
      references clientes_prospectos (id_cliente_prospecto)
      on delete restrict on update restrict;

alter table vehiculos
   add constraint fk_vehiculos_concesionarios foreign key (id_concesionario)
      references concesionarios (id_concesionario)
      on delete restrict on update restrict;

alter table vehiculos
   add constraint fk_vehiculo_reference_identifi foreign key (id_identificador_vehiculo)
      references identificadores_vehiculos (id_identificador_vehiculo)
      on delete restrict on update restrict;

alter table vendedores
   add constraint fk_vendedor_reference_concesio foreign key (id_concesionario)
      references concesionarios (id_concesionario)
      on delete restrict on update restrict;