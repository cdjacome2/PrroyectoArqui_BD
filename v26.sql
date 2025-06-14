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

/*==============================================================*/
/* Diccionario de Datos                                         */
/*==============================================================*/

-- tabla: pagares
comment on table pagares is 'tabla que registra los pagarés asociados a una solicitud de crédito.';
comment on column pagares.id_pagare is 'identificador único del pagaré.';
comment on column pagares.id_solicitud is 'referencia a la solicitud de crédito relacionada.';
comment on column pagares.numero_cuota is 'número de la cuota correspondiente al pagaré.';
comment on column pagares.ruta_archivo is 'ruta donde se almacena digitalmente el archivo del pagaré.';
comment on column pagares.fecha_generado is 'fecha en la que fue generado el pagaré.';
comment on column pagares.version is 'versión del registro para control de cambios.';

-- tabla: solicitudes_creditos
comment on table solicitudes_creditos is 'tabla que contiene todas las solicitudes de crédito realizadas por los clientes.';
comment on column solicitudes_creditos.id_solicitud is 'identificador único de la solicitud de crédito.';
comment on column solicitudes_creditos.id_cliente_prospecto is 'referencia al cliente prospecto que realiza la solicitud.';
comment on column solicitudes_creditos.id_vehiculo is 'referencia al vehículo que se desea financiar.';
comment on column solicitudes_creditos.id_vendedor is 'referencia al vendedor que gestionó la solicitud.';
comment on column solicitudes_creditos.numero_solicitud is 'número o código único de la solicitud.';
comment on column solicitudes_creditos.monto_solicitado is 'monto total del crédito solicitado.';
comment on column solicitudes_creditos.plazo_meses is 'plazo del crédito expresado en meses.';
comment on column solicitudes_creditos.fecha_solicitud is 'fecha en que se registró la solicitud.';
comment on column solicitudes_creditos.entrada is 'valor de entrada o pago inicial del crédito.';
comment on column solicitudes_creditos.score_interno is 'puntaje interno de riesgo calculado por la entidad.';
comment on column solicitudes_creditos.score_externo is 'puntaje de riesgo obtenido de entidades externas.';
comment on column solicitudes_creditos.relacion_cuota_ingreso is 'relación entre la cuota mensual y los ingresos del cliente.';
comment on column solicitudes_creditos.tasa_anual is 'tasa de interés anual aplicada.';
comment on column solicitudes_creditos.cuota_mensual is 'valor estimado de la cuota mensual a pagar.';
comment on column solicitudes_creditos.total_pagar is 'monto total a pagar al finalizar el crédito.';
comment on column solicitudes_creditos.estado is 'estado actual de la solicitud: Borrador, En revisión, Aprobada, Rechazada o Cancelada.';
comment on column solicitudes_creditos.version is 'versión del registro para control de cambios.';

-- tabla: tipos_documentos
comment on table tipos_documentos is 'tabla que define los tipos de documentos que se pueden adjuntar en una solicitud.';
comment on column tipos_documentos.id_tipo_documento is 'identificador único del tipo de documento.';
comment on column tipos_documentos.nombre is 'nombre del tipo de documento (ej. cédula, papeleta, etc.).';
comment on column tipos_documentos.descripcion is 'descripción del tipo de documento.';
comment on column tipos_documentos.estado is 'estado del tipo de documento: activo o inactivo.';
comment on column tipos_documentos.version is 'versión del registro para control de cambios.';

-- tabla: vehiculos
comment on table vehiculos is 'tabla que contiene los datos de los vehículos disponibles para financiamiento.';
comment on column vehiculos.id_vehiculo is 'identificador único del vehículo.';
comment on column vehiculos.id_concesionario is 'referencia al concesionario al que pertenece el vehículo.';
comment on column vehiculos.id_identificador_vehiculo is 'referencia al registro de identificación del vehículo.';
comment on column vehiculos.marca is 'marca del vehículo.';
comment on column vehiculos.modelo is 'modelo del vehículo.';
comment on column vehiculos.anio is 'año de fabricación del vehículo.';
comment on column vehiculos.valor is 'valor comercial del vehículo.';
comment on column vehiculos.color is 'color principal del vehículo.';
comment on column vehiculos.extras is 'características adicionales u opcionales del vehículo.';
comment on column vehiculos.estado is 'estado del vehículo: nuevo o usado.';
comment on column vehiculos.version is 'versión del registro para control de cambios.';

-- tabla: vendedores
comment on table vendedores is 'tabla que almacena información de los vendedores de los concesionarios.';
comment on column vendedores.id_vendedor is 'identificador único del vendedor.';
comment on column vendedores.id_concesionario is 'referencia al concesionario al que pertenece el vendedor.';
comment on column vendedores.nombre is 'nombre completo del vendedor.';
comment on column vendedores.telefono is 'número de contacto del vendedor.';
comment on column vendedores.email is 'correo electrónico del vendedor.';
comment on column vendedores.estado is 'estado del vendedor: activo o inactivo.';
comment on column vendedores.version is 'versión del registro para control de cambios.';

-- tabla: contratos
comment on table contratos is 'tabla que contiene los contratos generados a partir de las solicitudes de crédito.';
comment on column contratos.id_contrato is 'identificador único del contrato.';
comment on column contratos.id_solicitud is 'referencia a la solicitud de crédito asociada.';
comment on column contratos.ruta_archivo is 'ruta donde se almacena el archivo del contrato.';
comment on column contratos.fecha_generado is 'fecha en que fue generado el contrato.';
comment on column contratos.fecha_firma is 'fecha en la que se firmó el contrato.';
comment on column contratos.estado is 'estado actual del contrato: Draft, Firmado, Cancelado.';
comment on column contratos.condicion_especial is 'observaciones o condiciones especiales aplicables al contrato.';
comment on column contratos.version is 'versión del registro para control de cambios.';

-- tabla: documentos_adjuntos
comment on table documentos_adjuntos is 'tabla que almacena los documentos adjuntos a una solicitud de crédito.';
comment on column documentos_adjuntos.id_documento is 'identificador único del documento adjunto.';
comment on column documentos_adjuntos.id_solicitud is 'referencia a la solicitud de crédito correspondiente.';
comment on column documentos_adjuntos.id_tipo_documento is 'referencia al tipo de documento.';
comment on column documentos_adjuntos.ruta_archivo is 'ruta del sistema donde se almacena el archivo.';
comment on column documentos_adjuntos.fecha_cargado is 'fecha en la que se cargó el documento.';
comment on column documentos_adjuntos.version is 'versión del registro para control de cambios.';

-- tabla: historial_estados
comment on table historial_estados is 'tabla que registra el historial de cambios de estado de una solicitud de crédito.';
comment on column historial_estados.id_historial is 'identificador único del historial.';
comment on column historial_estados.id_solicitud is 'referencia a la solicitud de crédito.';
comment on column historial_estados.estado is 'estado asignado en el evento registrado.';
comment on column historial_estados.fecha_hora is 'fecha y hora del cambio de estado.';
comment on column historial_estados.usuario is 'usuario que realizó el cambio.';
comment on column historial_estados.motivo is 'motivo del cambio de estado.';
comment on column historial_estados.version is 'versión del registro para control de cambios.';

-- tabla: identificadores_vehiculos
comment on table identificadores_vehiculos is 'tabla que almacena identificadores únicos de los vehículos.';
comment on column identificadores_vehiculos.id_identificador_vehiculo is 'identificador único del registro de identificación.';
comment on column identificadores_vehiculos.vin is 'número de identificación del vehículo (VIN).';
comment on column identificadores_vehiculos.numero_motor is 'número de motor del vehículo.';
comment on column identificadores_vehiculos.placa is 'número de placa del vehículo.';
comment on column identificadores_vehiculos.version is 'versión del registro para control de cambios.';

-- tabla: observacion_analistas
comment on table observacion_analistas is 'tabla que registra observaciones realizadas por los analistas sobre una solicitud.';
comment on column observacion_analistas.id_observacion_analista is 'identificador único de la observación.';
comment on column observacion_analistas.id_solicitud is 'referencia a la solicitud asociada.';
comment on column observacion_analistas.usuario is 'usuario que realizó la observación.';
comment on column observacion_analistas.fecha_hora is 'fecha y hora en que se registró la observación.';
comment on column observacion_analistas.razon_intervencion is 'razón o justificación de la intervención del analista.';
comment on column observacion_analistas.version is 'versión del registro para control de cambios.';

-- tabla: auditorias
comment on table auditorias is 'tabla que contiene información sobre auditorias.';
comment on column auditorias.id_auditoria is 'identificador único de auditoria, relacionado con la tabla auditorias.';
comment on column auditorias.tabla is 'nombre de la tabla afectada en la auditoría.';
comment on column auditorias.accion is 'acción realizada: INSERT, UPDATE o DELETE.';
comment on column auditorias.fecha_hora is 'fecha y hora del evento registrado.';

-- tabla: clientes_prospectos
comment on table clientes_prospectos is 'tabla que contiene información sobre clientes prospectos.';
comment on column clientes_prospectos.id_cliente_prospecto is 'identificador único de cliente prospecto.';
comment on column clientes_prospectos.cedula is 'número de cédula del cliente prospecto.';
comment on column clientes_prospectos.nombre is 'nombres del cliente prospecto.';
comment on column clientes_prospectos.apellido is 'apellidos del cliente prospecto.';
comment on column clientes_prospectos.telefono is 'número de teléfono del cliente prospecto.';
comment on column clientes_prospectos.email is 'correo electrónico registrado del cliente prospecto.';
comment on column clientes_prospectos.direccion is 'dirección física del cliente prospecto.';
comment on column clientes_prospectos.ingresos is 'ingresos mensuales declarados.';
comment on column clientes_prospectos.egresos is 'egresos mensuales declarados.';
comment on column clientes_prospectos.actividad_economica is 'actividad económica del cliente prospecto.';
comment on column clientes_prospectos.estado is 'estado del cliente prospecto: Activo, Nuevo, Prospecto, etc.';
comment on column clientes_prospectos.version is 'versión del registro para control de cambios.';

-- tabla: concesionarios
comment on table concesionarios is 'tabla que contiene información sobre concesionarios registrados.';
comment on column concesionarios.id_concesionario is 'identificador único del concesionario.';
comment on column concesionarios.razon_social is 'razón social del concesionario.';
comment on column concesionarios.direccion is 'dirección física del concesionario.';
comment on column concesionarios.telefono is 'número de contacto del concesionario.';
comment on column concesionarios.email_contacto is 'correo electrónico de contacto del concesionario.';
comment on column concesionarios.estado is 'estado del concesionario: activo o inactivo.';
comment on column concesionarios.version is 'versión del registro para control de cambios.';

/*==============================================================*/
/* Creación de ENUMS                                            */
/*==============================================================*/

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