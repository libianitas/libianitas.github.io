
# 📚 Diccionario de Datos — OTM Data Warehouse (Esquema: `DWADW`)

Este repositorio documenta el **modelo dimensional (DW)** para datos de **Oracle Transportation Management (OTM)**, incluyendo **dimensiones (DIM)**, **hechos (FACT)** y sus **restricciones** (PK/UK/FK), **índices** y **reglas** (CHECK/DEFAULT).

---

## 🧭 Menú de Tablas (clic para navegar)

### Dimensiones (DIM)
- [DWADW.DIM_BULKPLAN_OTM](#dwadwdim_bulkplan_otm)
- [DWADW.DIM_CEDI_OTM](#dwadwdim_cedi_otm)
- [DWADW.DIM_CITY_OTM](#dwadwdim_city_otm)
- [DWADW.DIM_COMMODITY_OTM](#dwadwdim_commodity_otm)
- [DWADW.DIM_CONTACT_OTM](#dwadwdim_contact_otm)
- [DWADW.DIM_DOMAIN_OTM](#dwadwdim_domain_otm)
- [DWADW.DIM_DRIVER_OTM](#dwadwdim_driver_otm)
- [DWADW.DIM_FLEET_ASSIGNMENT_OTM](#dwadwdim_fleet_assignment_otm)
- [DWADW.DIM_ITEM_OTM](#dwadwdim_item_otm)
- [DWADW.DIM_ITINERARY_OTM](#dwadwdim_itinerary_otm)
- [DWADW.DIM_LICENSETYPE_OTM](#dwadwdim_licensetype_otm)
- [DWADW.DIM_LOADINGPATTERN_OTM](#dwadwdim_loadingpattern_otm)
- [DWADW.DIM_LOCATION_ADDRESS_OTM](#dwadwdim_location_address_otm)
- [DWADW.DIM_LOCATION_OTM](#dwadwdim_location_otm)
- [DWADW.DIM_ORDERRELEASESTATUS_HISTORY_OTM](#dwadwdim_orderreleasestatus_history_otm)
- [DWADW.DIM_ORDERRELEASESTATUS_OTM](#dwadwdim_orderreleasestatus_otm)
- [DWADW.DIM_ORDERRELEASETYPE_OTM](#dwadwdim_orderreleasetype_otm)
- [DWADW.DIM_PEOPLE_OTM](#dwadwdim_people_otm)
- [DWADW.DIM_REF_NUM_OTM](#dwadwdim_ref_num_otm)
- [DWADW.DIM_ROUTE_OTM](#dwadwdim_route_otm)
- [DWADW.DIM_SEQUIPMENT_OTM](#dwadwdim_sequipment_otm)
- [DWADW.DIM_SHIPMENT_S_EQUIPMENT_JOIN_OTM](#dwadwdim_shipment_s_equipment_join_otm)
- [DWADW.DIM_SHIPMENTESTATUS_HISTORY_OTM](#dwadwdim_shipmentestatus_history_otm)
- [DWADW.DIM_SHIPMENTREFNUM_OTM](#dwadwdim_shipmentrefnum_otm)
- [DWADW.DIM_SHIPMENTSTATUS_OTM](#dwadwdim_shipmentstatus_otm)
- [DWADW.DIM_SHIPUNIT_OTM](#dwadwdim_shipunit_otm)
- [DWADW.DIM_STATUSTYPE_OTM](#dwadwdim_statustype_otm)
- [DWADW.DIM_STATUSVALUE_OTM](#dwadwdim_statusvalue_otm)
- [DWADW.DIM_STOPTYPE_OTM](#dwadwdim_stoptype_otm)
- [DWADW.DIM_TIME_OTM](#dwadwdim_time_otm)
- [DWADW.DIM_TRANSPORTMODE_OTM](#dwadwdim_transportmode_otm)
- [DWADW.DIM_VIABILITY_CODE_OTM](#dwadwdim_viability_code_otm)

### Hechos (FACT)
- [DWADW.FACT_ORDERMOVEMENT_OTM](#dwadwfact_ordermovement_otm)
- [DWADW.FACT_ORDERRELEASE_OTM](#dwadwfact_orderrelease_otm)
- [DWADW.FACT_ORDERRELEASELINES_OTM](#dwadwfact_orderreleaselines_otm)
- [DWADW.FACT_PACKAGEDITEM_OTM](#dwadwfact_packageditem_otm)
- [DWADW.FACT_SEQUIPMENTSSHIPUNITJOIN_OTM](#dwadwfact_sequipmentsshipunitjoin_otm)
- [DWADW.FACT_SHIP_ITEM_BOV_OTM](#dwadwfact_ship_item_bov_otm)
- [DWADW.FACT_SHIPMENT_OTM](#dwadwfact_shipment_otm)
- [DWADW.FACT_SHIPMENTSTOP_OTM](#dwadwfact_shipmentstop_otm)
- [DWADW.FACT_SSHIPMENTUNITLINE_OTM](#dwadwfact_sshipmentunitline_otm)

---

> **Convenciones rápidas**
> - `*_otm_id`: clave surrogate (IDENTITY) usada como PK.
> - `*_gid`: identificador natural proveniente de OTM.
> - `*_active`: estado lógico (`A`=Activo, `I`=Inactivo) cuando aplica.
> - `insert_* / update_*`: auditoría.
> - `load_date`: fecha de carga al DW.

---

## DWADW.DIM_BULKPLAN_OTM
<a id="dwadwdim_bulkplan_otm"></a>

**Descripción:** Catálogo de *Bulk Plans* (planes/bloques de consolidación) de OTM.  
**Granularidad:** 1 fila por **bulk plan** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| BULKPLAN_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_BULKPLAN_OTM_PK`. |
| BULKPLAN_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción del bulk plan. **UK** `DIM_BULKPLAN_OTM_UN`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM (texto). |
| BULKPLAN_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_BULKPLAN_OTM_AI_CK` IN (`A`,`I`). |
| INSERT_USER | VARCHAR2(512) | NO |  | Usuario de inserción. |
| INSERT_DATE | DATE | NO |  | Fecha de inserción. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Usuario de actualización. |
| UPDATE_DATE | DATE | SI |  | Fecha de actualización. |
| LOAD_DATE | DATE | NO |  | Fecha de carga ETL/ELT. |

---

## DWADW.DIM_CEDI_OTM
<a id="dwadwdim_cedi_otm"></a>

**Descripción:** Dimensión de CEDI / centro de distribución (o entidad equivalente) usada en asignación de conductores y operación.  
**Granularidad:** 1 fila por **CEDI** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| CEDI_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_CEDI_OTM_PK`. |
| CEDI_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción del CEDI. **UK** `DIM_CEDI_OTM_UN`. |
| CEDI_NAME | VARCHAR2(960) | SI |  | Nombre del CEDI (si difiere de la descripción). |
| CEDI_VALUE | NUMBER | SI |  | Valor/código numérico (si aplica). |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM. |
| CEDI_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_CEDI_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_CITY_OTM
<a id="dwadwdim_city_otm"></a>

**Descripción:** Catálogo de ciudades asociadas a un dominio OTM.  
**Granularidad:** 1 fila por **ciudad** (por descripción) dentro de dominio lógico (por FK a `DIM_DOMAIN_OTM`).

**Índices / restricciones:** índice `DWADW.DIM_CITY_OTM_IDX` sobre `CITY_DESCRIPTION`.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| CITY_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_CITY_OTM_PK`. |
| CITY_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción/nombre de ciudad. **UK** `DIM_CITY_OTM_UN`. Indexada. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM (texto). |
| CITY_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_CITY_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| DIM_DOMAIN_OTM_ID | NUMBER | NO |  | **FK** `DIM_CITY_OTM_DOMAIN_FK` → `DIM_DOMAIN_OTM.DOMAIN_OTM_ID`. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_COMMODITY_OTM
<a id="dwadwdim_commodity_otm"></a>

**Descripción:** Catálogo de commodities/productos de OTM para clasificación logística.  
**Granularidad:** 1 fila por **commodity** (por `COMMODITY_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| COMMODITY_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_COMMODITY_OTM_PK`. |
| COMMODITY_GID | VARCHAR2(404 BYTE) | NO |  | Identificador natural OTM. **UK** `DIM_COMMODITY_OTM_UN`. |
| COMMODITY_XID | VARCHAR2(200 BYTE) | NO |  | Identificador externo (XID). |
| COMMODITY_NAME | VARCHAR2(480 BYTE) | SI |  | Nombre del commodity. |
| IS_TEMP_CONTROL | CHAR(4 BYTE) | NO |  | Indicador temperatura controlada (texto tipo flag). |
| COMMODITY_DESCRIPTION | VARCHAR2(4000 BYTE) | SI |  | Descripción extendida. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_CONTACT_OTM
<a id="dwadwdim_contact_otm"></a>

**Descripción:** Contactos asociados a entidades logísticas (ubicaciones, notificaciones, etc.).  
**Granularidad:** 1 fila por **contacto** (por `CONTACT_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| CONTACT_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_CONTACT_OTM_PK`. |
| CONTACT_GID | VARCHAR2(404 BYTE) | NO |  | Identificador natural OTM. **UK** `DIM_CONTACT_OTM_UN`. |
| CONTACT_XID | VARCHAR2(200 BYTE) | NO |  | XID del contacto. |
| IS_PRIMARY_CONTACT | CHAR(4 BYTE) | NO |  | Flag de contacto principal. |
| ROUTE_THROUGH_LOCATION | CHAR(4 BYTE) | NO |  | Flag de ruteo por ubicación. |
| CONTACT_TYPE | VARCHAR2(120 BYTE) | NO |  | Tipo de contacto. |
| IS_BROADCAST | VARCHAR2(4 BYTE) | NO |  | Flag broadcast. |
| LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Ubicación asociada (natural key). |
| IS_EMAIL_VIRUS_PROTECTED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| CONSOLIDATED_NOTIFY_ONLY | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_NOTIFICATION_ON | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_FROM_ADDRESS | VARCHAR2(4 BYTE) | NO |  | Flag. |
| SEND_AS_MESSAGE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| NAME_ADDRESS_UPDATE_DATE | DATE | SI |  | Última actualización de nombre/dirección. |
| FIRST_NAME | VARCHAR2(600 BYTE) | SI |  | Nombre. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| DIM_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `DIM_CONTACT_OTM_DIM_LOCATION_ADDRESS_OTM_FK` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |

---

## DWADW.DIM_DOMAIN_OTM
<a id="dwadwdim_domain_otm"></a>

**Descripción:** Catálogo de dominios OTM usados para segmentación/partición lógica del dataset.  
**Granularidad:** 1 fila por **dominio** (por descripción).

**Índices / restricciones:** índice `DWADW.DIM_DOMAIN_OTM_IDX` sobre `DOMAIN_DESCRIPTION`.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| DOMAIN_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_DOMAIN_OTM_PK`. |
| DOMAIN_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción del dominio. **UK** `DIM_DOMAIN_OTM_UN`. Indexada. |
| DOMAIN_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_DOMAIN_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_DRIVER_OTM
<a id="dwadwdim_driver_otm"></a>

**Descripción:** Conductores (drivers) provenientes de OTM, con relación a tipo de licencia y CEDI.  
**Granularidad:** 1 fila por **driver** (por `DRIVER_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| DRIVER_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_DRIVER_OTM_PK`. |
| DRIVER_GID | VARCHAR2(404 BYTE) | NO |  | Identificador natural OTM. **UK** `DIM_DRIVER_OTM_UN`. |
| DRIVER_XID | VARCHAR2(200 BYTE) | NO |  | XID del driver. |
| DEF_HOME_LOC_GID | VARCHAR2(404 BYTE) | SI |  | Ubicación base (natural key). |
| FIRST_NAME | VARCHAR2(800 BYTE) | SI |  | Nombres. |
| LAST_NAME | VARCHAR2(800 BYTE) | SI |  | Apellidos. |
| RESOURCE_TYPE | VARCHAR2(4 BYTE) | NO |  | Tipo de recurso. |
| USE_HOS_HISTORY | VARCHAR2(4 BYTE) | NO |  | Flag historial HOS. |
| DRIVER_TYPE_GID | VARCHAR2(404 BYTE) | SI |  | Tipo de conductor (natural key). |
| IS_ACTIVE | VARCHAR2(4 BYTE) | NO |  | Flag activo. |
| DRIVER_ASSIGNMENT_SEQ_NUM | NUMBER | SI |  | Secuencia/asignación. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| DIM_LICENSETYPE_OTM_ID | NUMBER | NO |  | **FK** `DIM_DRIVER_OTM_DIM_LICENCETYPE_OTM_FK` → `DIM_LICENSETYPE_OTM.LICENSETYPE_OTM_ID`. |
| DIM_CEDI_OTM_ID | NUMBER | NO |  | **FK** `DIM_DRIVER_OTM_DIM_CEDI_OTM_FK` → `DIM_CEDI_OTM.CEDI_OTM_ID`. |

---

## DWADW.DIM_FLEET_ASSIGNMENT_OTM
<a id="dwadwdim_fleet_assignment_otm"></a>

**Descripción:** Catálogo de asignaciones de flota (fleet assignment).  
**Granularidad:** 1 fila por **asignación** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| FLEET_ASSIGNMENT_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_FLEET_ASSIGNMENT_OTM_PK`. |
| FLEET_ASSIGNMENT_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_FLEET_ASSIGNMENT_OTM_UN`. |
| FLEET_ASSIGNMENT_NAME | VARCHAR2(960) | NO |  | Nombre. |
| FLEET_ASSIGNMENT_VALUE | NUMBER | SI |  | Valor/código numérico. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM. |
| FLEET_ASSIGNMENT_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_FLEET_ASSIGNMENT_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_ITEM_OTM
<a id="dwadwdim_item_otm"></a>

**Descripción:** Artículos/ítems logísticos (master data) vinculados a commodity.  
**Granularidad:** 1 fila por **item** (por `ITEM_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ITEM_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_ITEM_OTM_PK`. |
| ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Identificador natural OTM. **UK** `DIM_ITEM_OTM_UN`. |
| ITEM_XID | VARCHAR2(200 BYTE) | NO |  | XID del item. |
| ITEM_NAME | VARCHAR2(960 BYTE) | SI |  | Nombre del item. |
| COMMODITY_GID | VARCHAR2(404 BYTE) | SI |  | Commodity natural asociado. |
| DESCRIPTION | VARCHAR2(2000 BYTE) | SI |  | Descripción extendida. |
| IS_DRAWBACK | VARCHAR2(4 BYTE) | NO |  | Flag drawback. |
| MARKED_FOR_PURGE | VARCHAR2(4 BYTE) | SI |  | Flag purge. |
| PRICE_PER_UNIT | NUMBER | SI |  | Precio por unidad. |
| PRICE_PER_UNIT_BASE | NUMBER | SI |  | Precio base. |
| PRICE_PER_UNIT_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda del precio. |
| IS_TEMPLATE | VARCHAR2(4 BYTE) | NO |  | Flag template. |
| WHOLLY_ORIGINATING | VARCHAR2(4 BYTE) | NO |  | Flag origen. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| DIM_COMMODITY_OTM_ID | NUMBER | NO |  | **FK** `DIM_ITEM_OTM_DIM_COMMODITY_OTM_FK` → `DIM_COMMODITY_OTM.COMMODITY_OTM_ID`. |

---

## DWADW.DIM_ITINERARY_OTM
<a id="dwadwdim_itinerary_otm"></a>

**Descripción:** Catálogo de itinerarios utilizados para planificación/ejecución logística.  
**Granularidad:** 1 fila por **itinerario** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ITINERARY_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_ITINERARY_OTM_PK`. |
| ITINERARY_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_ITINERARY_OTM_UN`. |
| ITINERARY_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_ITINERARY_OTM_AI_CK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_LICENSETYPE_OTM
<a id="dwadwdim_licensetype_otm"></a>

**Descripción:** Catálogo de tipos de licencia asociados a conductores.  
**Granularidad:** 1 fila por **tipo de licencia** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| LICENSETYPE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_LICENSETYPE_OTM_PK`. |
| LICENSETYPE_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_LICENSETYPE_OTM_UN`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM. |
| LICENSETYPE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_LICENSETYPE_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | SI |  | Fecha de carga (en DDL no aparece NOT NULL). |

---

## DWADW.DIM_LOADINGPATTERN_OTM
<a id="dwadwdim_loadingpattern_otm"></a>

**Descripción:** Catálogo de patrones de cargue (loading patterns) para configuración de equipo/carga.  
**Granularidad:** 1 fila por **loading pattern** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| LOADINGPATTERN_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_LOADINGPATTERN_OTM_PK`. |
| LOADINGPATTERN_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_LOADINGPATTERN_OTM_UN`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio OTM. |
| LOADINGPATTERN_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_LOADINGPATTERN_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_LOCATION_ADDRESS_OTM
<a id="dwadwdim_location_address_otm"></a>

**Descripción:** Direcciones por ubicación (múltiples líneas por location).  
**Granularidad:** 1 fila por **(LOCATION_GID, LINE_SEQUENCE)**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| LOCATION_ADDRESS_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_LOCATION_ADDRESS_OTM_PK`. |
| LOCATION_GID | VARCHAR2(404 BYTE) | NO |  | Identificador natural de ubicación. Parte de **UK** compuesta. |
| LINE_SEQUENCE | NUMBER | NO |  | Secuencia de línea. Parte de **UK** `DIM_LOCATION_ADDRESS_OTM_UN` (LOCATION_GID, LINE_SEQUENCE). |
| ADDRESS_LINE | VARCHAR2(4000 BYTE) | SI |  | Línea de dirección. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| DIM_LOCATION_OTM_ID | NUMBER | NO |  | **FK** `DIM_LOCADD_LOCAT_OTM_FK` → `DIM_LOCATION_OTM.LOCATION_OTM_ID`. |

---

## DWADW.DIM_LOCATION_OTM
<a id="dwadwdim_location_otm"></a>

**Descripción:** Maestro de ubicaciones (shipper, consignee, depot, etc.) desde OTM.  
**Granularidad:** 1 fila por **location** (por `LOCATION_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| LOCATION_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_LOCATION_OTM_PK`. |
| LOCATION_GID | VARCHAR2(404 BYTE) | NO |  | Identificador natural OTM. **UK** `DIM_LOCATION_OTM_UN`. |
| LOCATION_XID | VARCHAR2(200 BYTE) | SI |  | XID. |
| LOCATION_NAME | VARCHAR2(1440 BYTE) | SI |  | Nombre. |
| CITY | VARCHAR2(960 BYTE) | SI |  | Ciudad (texto). |
| PROVINCE | VARCHAR2(960) | SI |  | Provincia/estado. |
| PROVINCE_CODE | VARCHAR2(24) | SI |  | Código de provincia. |
| COUNTRY_CODE3_GID | VARCHAR2(404 BYTE) | SI |  | País (código). |
| TIME_ZONE_GID | VARCHAR2(404) | SI |  | Zona horaria. |
| IS_TEMPORARY | CHAR(4 BYTE) | NO |  | Flag temporal. |
| IS_MAKE_APPT_BEFORE_PLAN | CHAR(4 BYTE) | NO |  | Flag cita antes de planificar. |
| IS_SHIPPER_KNOWN | CHAR(4 BYTE) | NO |  | Flag shipper conocido. |
| IS_ADDRESS_VALID | VARCHAR2(4 BYTE) | NO |  | Flag dirección válida. |
| IS_LTL_SPLITABLE | VARCHAR2(4 BYTE) | NO |  | Flag LTL splittable. |
| USE_APPOINTMENT_PRIORITY | VARCHAR2(4 BYTE) | SI |  | Flag. |
| SCHEDULE_LOW_PRIORITY_APPOINT | VARCHAR2(4 BYTE) | SI |  | Flag. |
| ENFORCE_TIME_WINDOW_APPOINT | VARCHAR2(4 BYTE) | SI |  | Flag. |
| SCHEDULE_INFEASIBLE_APPOINT | VARCHAR2(4) | SI |  | Flag. |
| BB_IS_NEW_STORE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| EXCLUDE_FROM_ROUTE_EXECUTION | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_TEMPLATE | VARCHAR2(4 BYTE) | NO |  | Flag template. |
| ALLOW_DRIVER_REST | VARCHAR2(4) | SI |  | Flag. |
| APPT_OBJECT_TYPE | VARCHAR2(4 BYTE) | SI |  | Tipo objeto cita. |
| IS_FIXED_ADDRESS | VARCHAR2(4 BYTE) | SI |  | Flag dirección fija. |
| PRIMARY_ADDRESS_LINE_SEQ | NUMBER(22) | NO |  | Secuencia línea primaria. |
| IS_ACTIVE | VARCHAR2(4 BYTE) | NO |  | Flag activo. |
| IS_WMS_FACILITY | VARCHAR2(4) | NO |  | Flag facility WMS. |
| APPT_ENFORCE_ACT_TIME_SG | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio OTM. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_ORDERRELEASESTATUS_HISTORY_OTM
<a id="dwadwdim_orderreleasestatus_history_otm"></a>

**Descripción:** Historial de estados (status value) asociado a Order Release (normalizado para manejo de historiales).  
**Granularidad:** 1 fila por **evento de estado** (surrogate).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ORDERRELEASESTATUS_HISTORY_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_ORDERRELEASESTATUS_HISTORY_OTM_PK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| DIM_STATUSVALUE_ID | NUMBER | NO |  | **FK** `DIM_ORDERRELEASESTATUS_HISTORY_STATUSVALUE_FK` → `DIM_STATUSVALUE_OTM.STATUSVALUE_OTM_ID`. |
| LOAD_DATE | DATE | SI |  | Fecha de carga (no NOT NULL). |

---

## DWADW.DIM_ORDERRELEASESTATUS_OTM
<a id="dwadwdim_orderreleasestatus_otm"></a>

**Descripción:** Estados de Order Release por tipo y valor, vinculados a historial y al hecho de order release.  
**Granularidad:** 1 fila por **(ORDER_RELEASE_GID, STATUS_TYPE_GID, STATUS_VALUE_GID)**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ORDERRELEASESTATUS_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_ORDERRELEASESTATUS_OTM_PK`. |
| ORDER_RELEASE_GID | VARCHAR2(404 BYTE) | NO |  | Order Release natural key. Parte de **UK** compuesta. |
| STATUS_TYPE_GID | VARCHAR2(404 BYTE) | NO |  | Tipo de estado (natural). Parte de **UK** compuesta. |
| STATUS_VALUE_GID | VARCHAR2(404 BYTE) | NO |  | Valor de estado (natural). Parte de **UK** compuesta. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| RN | NUMBER | SI |  | Row number / control de deduplicación. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| DIM_ORDERRELEASESTATUS_HISTORY_ID | NUMBER | NO |  | **FK** `DIM_ORDERRELEASESTATUS_OTM_DIM_ORDERRELEASESTATUS_HISTORY_FK` → `DIM_ORDERRELEASESTATUS_HISTORY_OTM.ORDERRELEASESTATUS_HISTORY_OTM_ID`. |
| FACT_ORDERRELEASE_OTM_ID | NUMBER | NO |  | **FK** `DIM_ORDERRELEASESTATUS_OTM_FACT_ORDERRELEASE_OTM_FK` → `FACT_ORDERRELEASE_OTM.ORDERRELEASE_OTM_ID`. |
| *(UK)* |  |  |  | **UK** `DIM_ORDERRELEASESTATUS_OTM_UN` en (ORDER_RELEASE_GID, STATUS_VALUE_GID, STATUS_TYPE_GID). |

---

## DWADW.DIM_ORDERRELEASETYPE_OTM
<a id="dwadwdim_orderreleasetype_otm"></a>

**Descripción:** Catálogo de tipos de Order Release (OTM).  
**Granularidad:** 1 fila por **order release type** (por `ORDER_RELEASE_TYPE_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ORDERRELEASETYPE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_ORDERRELEASETYPE_OTM_PK`. |
| ORDER_RELEASE_TYPE_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `DIM_ORDERRELEASETYPE_OTM_UN`. |
| ORDER_RELEASE_TYPE_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| ORDER_RELEASE_TYPE_NAME | VARCHAR2(480 BYTE) | SI |  | Nombre. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_PEOPLE_OTM
<a id="dwadwdim_people_otm"></a>

**Descripción:** Catálogo de personas/usuarios de aplicación, asociado a dominio OTM.  
**Granularidad:** 1 fila por **usuario de aplicación**.

**Índices / restricciones:** índice `DWADW.DIM_PEOPLE_OTM_IDX` sobre (PEOPLE_NAME, PEOPLE_LASTNAME).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| PEOPLE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_PEOPLE_OTM_PK`. |
| PEOPLE_NAME | VARCHAR2(960) | NO |  | Nombres. Indexado. |
| PEOPLE_LASTNAME | VARCHAR2(960) | NO |  | Apellidos. Indexado. |
| PEOPLE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_PEOPLE_OTM_AI_CK`. |
| PEOPLE_USER_APLICATION | VARCHAR2(100 BYTE) | SI |  | Usuario app. **UK** `DIM_PEOPLE_OTM_UN`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| DIM_DOMAIN_OTM_ID | NUMBER | NO |  | **FK** `DIM_PEOPLE_DOMAIN_OTM_FK` → `DIM_DOMAIN_OTM.DOMAIN_OTM_ID`. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_REF_NUM_OTM
<a id="dwadwdim_ref_num_otm"></a>

**Descripción:** Catálogo de calificadores de referencia (Reference Number Qualifiers) para shipments.  
**Granularidad:** 1 fila por **qualifier** (por `SHIPMENT_REFNUM_QUAL_GID`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| REFNUM_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_REF_NUM_OTM_PK`. |
| SHIPMENT_REFNUM_QUAL_GID | VARCHAR2(404) | NO |  | Natural key del qualifier. **UK** `DIM_REF_NUM_OTM_UNV1`. |
| SHIPMENT_REFNUM_QUAL | VARCHAR2(960) | NO |  | Nombre/desc del qualifier. |
| REFNUM_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_REF_NUM_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_ROUTE_OTM
<a id="dwadwdim_route_otm"></a>

**Descripción:** Catálogo de rutas asociadas a asignación de flota.  
**Granularidad:** 1 fila por **ruta** (por `ROUTE`).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ROUTE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_ROUTE_OTM_PK`. |
| ROUTE | VARCHAR2(960) | NO |  | Ruta (texto). **UK** `DIM_ROUTE_OTM_UN`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| ROUTE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_ROUTE_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| DIM_FLEET_ASSIGNMENT_OTM_ID | NUMBER | NO |  | **FK** `DIM_RUTA_OTM_DIM_FLEET_ASSIGNMENT_OTM_FK` → `DIM_FLEET_ASSIGNMENT_OTM.FLEET_ASSIGNMENT_OTM_ID`. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_SEQUIPMENT_OTM
<a id="dwadwdim_sequipment_otm"></a>

**Descripción:** Catálogo de equipos secundarios (S-Equipment) para shipments.  
**Granularidad:** 1 fila por **s-equipment** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SEQUIPMENT_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_SEQUIPMENT_OTM_PK`. |
| SEQUIPMENT_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_SEQUIPMENT_OTM_UN`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| SEQUIPMENT_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_SEQUIPMENT_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_SHIPMENT_S_EQUIPMENT_JOIN_OTM
<a id="dwadwdim_shipment_s_equipment_join_otm"></a>

**Descripción:** Tabla puente shipment ↔ s-equipment (relación N:M) y metadatos de stops.  
**Granularidad:** 1 fila por **(SHIPMENT_GID, S_EQUIPMENT_GID)**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPMENT_S_EQUIPMENT_JOIN_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_SHIPMENT_S_EQUIPMENT_JOIN_OTM_PK`. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. Parte de **UK** compuesta. |
| S_EQUIPMENT_GID | VARCHAR2(404) | NO |  | Natural key s-equipment. Parte de **UK** compuesta. |
| PICKUP_STOP_NUM | NUMBER(22) | SI |  | Stop de pickup. |
| DROPOFF_STOP_NUM | NUMBER(22) | SI |  | Stop de dropoff. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| FACT_SHIPMENT_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPMENT_S_EQUIPMENT_JOIN_OTM_FACT_SHIPMENT_OTM_FK` → `FACT_SHIPMENT_OTM.SHIPMENT_OTM_ID`. |
| *(UK)* |  |  |  | **UK** en (SHIPMENT_GID, S_EQUIPMENT_GID). |

---

## DWADW.DIM_SHIPMENTESTATUS_HISTORY_OTM
<a id="dwadwdim_shipmentestatus_history_otm"></a>

**Descripción:** Historial de estados de shipment, normalizado por status value, dominio y tiempo.  
**Granularidad:** 1 fila por **evento de estado** (surrogate).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPMENTSTATUS_HISTORY_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_SHIPMENTESTATUS_HISTORY_OTM_PK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio (texto). |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| DIM_STATUSVALUE_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPMENTESTATUS_HISTORY_OTM_DIM_STATUSVALUE_OTM_FK` → `DIM_STATUSVALUE_OTM.STATUSVALUE_OTM_ID`. |
| DIM_DOMAIN_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPMENTESTATUS_HISTORY_OTM_DIM_DOMAIN_OTM_FK` → `DIM_DOMAIN_OTM.DOMAIN_OTM_ID`. |
| DIM_TIME_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPMENTESTATUS_HISTORY_OTM_DIM_TIME_OTM_FK` → `DIM_TIME_OTM.TIME_OTM_ID`. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_SHIPMENTREFNUM_OTM
<a id="dwadwdim_shipmentrefnum_otm"></a>

**Descripción:** Valores de reference numbers por shipment y qualifier (normalizado).  
**Granularidad:** 1 fila por **(SHIPMENT_GID, SHIPMENT_REFNUM_QUAL_GID, SHIPMENT_REFNUM_VALUE)**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPMENTREFNUM_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_SHIPMENTREFNUM_OTM_PK`. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Natural shipment. Parte de **UK** compuesta. |
| SHIPMENT_REFNUM_QUAL_GID | VARCHAR2(404 BYTE) | NO |  | Qualifier natural. Parte de **UK** compuesta. |
| SHIPMENT_REFNUM_VALUE | VARCHAR2(960 BYTE) | NO |  | Valor del qualifier. Parte de **UK** compuesta. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| FACT_SHIPMENT_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPREFNUM_SHIP_OTM_FK` → `FACT_SHIPMENT_OTM.SHIPMENT_OTM_ID`. |
| DIM_REF_NUM_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPMENTREFNUM_OTM_DIM_REF_NUM_OTM_FK` → `DIM_REF_NUM_OTM.REFNUM_OTM_ID`. |
| *(UK)* |  |  |  | **UK** `DIM_SHIPREFNUM_OTM_UN` en (SHIPMENT_GID, SHIPMENT_REFNUM_VALUE, SHIPMENT_REFNUM_QUAL_GID). |

---

## DWADW.DIM_SHIPMENTSTATUS_OTM
<a id="dwadwdim_shipmentstatus_otm"></a>

**Descripción:** Estados actuales/detalle por shipment, vinculados al historial.  
**Granularidad:** 1 fila por **(SHIPMENT_GID, STATUS_TYPE_GID, STATUS_VALUE_GID)**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPMENTSTATUS_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_SHIPMENTSTATUS_OTM_PK`. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Natural shipment. Parte de **UK** compuesta. |
| STATUS_TYPE_GID | VARCHAR2(404 BYTE) | NO |  | Tipo estado natural. Parte de **UK** compuesta. |
| STATUS_VALUE_GID | VARCHAR2(404 BYTE) | NO |  | Valor estado natural. Parte de **UK** compuesta. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| FACT_SHIPMENT_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPSTATUS_SHIP_OTM_FK` → `FACT_SHIPMENT_OTM.SHIPMENT_OTM_ID`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| DIM_SHIPMENTESTATUS_HISTORY_OTM_ID | NUMBER | NO |  | **FK** `DIM_SHIPMENTSTATUS_OTM_DIM_SHIPMENTESTATUS_HISTORY_OTM_FK` → `DIM_SHIPMENTESTATUS_HISTORY_OTM.SHIPMENTSTATUS_HISTORY_OTM_ID`. |
| *(UK)* |  |  |  | **UK** `DIM_SHIPMENTSTATUS_OTM_UN` en (SHIPMENT_GID, STATUS_TYPE_GID, STATUS_VALUE_GID). |

---

## DWADW.DIM_SHIPUNIT_OTM
<a id="dwadwdim_shipunit_otm"></a>

**Descripción:** Catálogo de unidades de embarque (ship unit) de referencia.  
**Granularidad:** 1 fila por **ship unit** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPUNIT_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_SHIPUNIT_OTM_PK`. |
| SHIPUNIT_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. |
| SHIPUNIT_VALUE | NUMBER | SI |  | Valor/código. |
| SHIPUNIT_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_SHIPUNIT_OTM_AI_CK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_STATUSTYPE_OTM
<a id="dwadwdim_statustype_otm"></a>

**Descripción:** Catálogo de tipos de estado (Status Type).  
**Granularidad:** 1 fila por **tipo de estado** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| STATUSTYPE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_STATUSTYPE_PK`. |
| STATUSTYPE_DESCRIPTION | VARCHAR2(960 BYTE) | NO |  | Descripción. **UK** `DIM_STATUSTYPE_UN`. |
| STATUSTYPE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_STATUSTYPE_OTM_AI_CK`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_STATUSVALUE_OTM
<a id="dwadwdim_statusvalue_otm"></a>

**Descripción:** Catálogo de valores de estado (Status Value) asociado a un tipo de estado.  
**Granularidad:** 1 fila por **status value** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| STATUSVALUE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_STATUSVALUE_OTM_PK`. |
| STATUSVALUE_DESCRIPTION | VARCHAR2(960 BYTE) | NO |  | Descripción. **UK** `DIM_STATUSVALUE_OTM_UN`. |
| STATUSVALUE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_STATUSVALUE_OTM_AI_CK`. |
| DIM_STATUSTYPE_ID | NUMBER | NO |  | **FK** `DIM_STATUSVALUE_DIM_STATUSTYPE_FK` → `DIM_STATUSTYPE_OTM.STATUSTYPE_OTM_ID`. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |

---

## DWADW.DIM_STOPTYPE_OTM
<a id="dwadwdim_stoptype_otm"></a>

**Descripción:** Catálogo de tipos de parada (stop types) con valor numérico.  
**Granularidad:** 1 fila por **stop type** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| STOPTYPE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_STOPTYPE_OTM_PK`. |
| STOPTYPE_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_STOPTYPE_OTM_UN`. |
| STOPTYPE_VALUE | NUMBER | NO |  | Valor/código. |
| STOPTYPE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_STOPTYPE_OTM_AI_CK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_TIME_OTM
<a id="dwadwdim_time_otm"></a>

**Descripción:** Dimensión de tiempo (calendario) a nivel día, con jerarquías y marcadores laborales.  
**Granularidad:** 1 fila por **día** (UNIQUE por año/mes/día).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| TIME_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_TIEMPO_OTM_PK`. |
| TIME_YEAR | NUMBER(4) | NO |  | Año. Parte de **UK** compuesta. |
| TIME_MONTH | NUMBER(2) | NO |  | Mes. Parte de **UK** compuesta. |
| TIME_WEEK | NUMBER(3) | SI |  | Semana. |
| TIME_DAY | NUMBER(2) | NO |  | Día. Parte de **UK** compuesta. |
| TIME_SEMESTER | NUMBER(1) | SI |  | Semestre. |
| TIME_TRIMESTER_Q | NUMBER(1) | SI |  | Trimestre. |
| TIME_WORKING_DAY | CHAR(1 BYTE) | NO |  | Indicador día laboral (definir catálogo interno). |
| TIME_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_TIME_OTM_AI_CK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |
| *(UK)* |  |  |  | **UK** `DIM_TIME_OTM_UN` en (TIME_YEAR, TIME_MONTH, TIME_DAY). |

---

## DWADW.DIM_TRANSPORTMODE_OTM
<a id="dwadwdim_transportmode_otm"></a>

**Descripción:** Catálogo de modos de transporte.  
**Granularidad:** 1 fila por **modo** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| TRANSPORTMODE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_TRANSPORTMODE_OTM_PK`. |
| TRANSPORTMODE_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_TRANSPORTMODE_OTM_UN`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| TRANSPORTMODE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_TRANSPORTMODE_OTM_AI_CK`. |
| TRANSPORTMODE_VALUE | NUMBER | SI |  | Valor/código. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

## DWADW.DIM_VIABILITY_CODE_OTM
<a id="dwadwdim_viability_code_otm"></a>

**Descripción:** Catálogo de códigos de viabilidad (feasibility/viability) usados en planificación/validación.  
**Granularidad:** 1 fila por **código** (por descripción).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| VIABILITY_CODE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_VIABILITY_CODE_OTM_PK`. |
| VIABILITY_CODE_DESCRIPTION | VARCHAR2(960) | NO |  | Descripción. **UK** `DIM_VIABILITY_CODE_OTM_UN`. |
| VIABILITY_CODE_VALOR | NUMBER | SI |  | Valor/código numérico. |
| VIABILITY_CODE_ACTIVE | CHAR(1 BYTE) | NO | `'A'` | Estado lógico. **CHECK** `DIM_VIABILITY_CODE_OTM_AI_CK`. |
| DOMAIN_NAME | VARCHAR2(200) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha de carga. |

---

# FACT TABLES

## DWADW.FACT_ORDERMOVEMENT_OTM
<a id="dwadwfact_ordermovement_otm"></a>

**Descripción:** Hecho de *Order Movement* (movimientos de orden), con métricas de volumen/peso/costo/tiempos esperados, enlazado a shipment y order release.  
**Granularidad:** 1 fila por **ORDER_MOVEMENT_GID**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ORDERMOVEMENT_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_ORDERMOVEMENT_OTM_PK`. |
| ORDER_MOVEMENT_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `FACT_ORDERMOVEMENT_OTM_UN`. |
| ORDER_MOVEMENT_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| ORDER_RELEASE_GID | VARCHAR2(404 BYTE) | SI |  | Order Release natural. |
| IS_TEMPORARY | VARCHAR2(4 BYTE) | NO |  | Flag. |
| CREATION_PROCESS_TYPE | VARCHAR2(200 BYTE) | NO |  | Proceso de creación. |
| PERSPECTIVE | VARCHAR2(4 BYTE) | SI |  | Perspectiva. |
| SOURCE_LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Origen natural. |
| IS_FIXED_SRC | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DEST_LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Destino natural. |
| IS_FIXED_DEST | VARCHAR2(4 BYTE) | NO |  | Flag. |
| EARLY_DELIVERY_DATE | DATE | SI |  | Fecha entrega temprana. |
| REUSE_EQUIPMENT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| ORIGINAL_LEG_GID | VARCHAR2(404 BYTE) | SI |  | Leg natural. |
| ORIGINAL_LEG_POSITION | NUMBER | SI |  | Posición leg. |
| BULK_PLAN_GID | VARCHAR2(404 BYTE) | SI |  | Bulk plan natural. |
| TOTAL_SHIP_UNIT_COUNT | NUMBER | SI |  | Cantidad unidades. |
| TOTAL_WEIGHT | NUMBER | SI |  | Peso total. |
| TOTAL_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM peso. |
| TOTAL_WEIGHT_BASE | NUMBER | SI |  | Peso base. |
| TOTAL_VOLUME | NUMBER | SI |  | Volumen total. |
| TOTAL_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM volumen. |
| TOTAL_VOLUME_BASE | NUMBER | SI |  | Volumen base. |
| SHIP_UNIT_WIDTH | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_WIDTH_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_WIDTH_BASE | NUMBER | SI |  | Base. |
| SHIP_UNIT_LENGTH | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_LENGTH_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_LENGTH_BASE | NUMBER | SI |  | Base. |
| SHIP_UNIT_HEIGHT | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_HEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_HEIGHT_BASE | NUMBER | SI |  | Base. |
| SHIP_UNIT_DIAMETER | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_DIAMETER_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_DIAMETER_BASE | NUMBER | SI |  | Base. |
| PRIORITY | NUMBER | NO |  | Prioridad. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | SI |  | Shipment natural. |
| CALCULATE_SERVICE_TIME | VARCHAR2(4 BYTE) | SI |  | Flag. |
| CALCULATE_CONTRACTED_RATE | VARCHAR2(4 BYTE) | SI |  | Flag. |
| EXPECTED_TRANSIT_TIME | NUMBER | SI |  | Tiempo tránsito. |
| EXPECTED_TRANSIT_TIME_BASE | NUMBER | SI |  | Base. |
| EXPECTED_TRANSIT_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| EXPECTED_COST | NUMBER | SI |  | Costo esperado. |
| EXPECTED_COST_BASE | NUMBER | SI |  | Base. |
| EXPECTED_COST_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| IS_TEMPLATE | VARCHAR2(4 BYTE) | SI |  | Flag. |
| IS_NETWORK_ROUTABLE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_ROUTING_FIXED | VARCHAR2(4 BYTE) | SI |  | Flag. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| DEST_DIM_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `FACT_ORDERMOVEMENT_OTM_DIM_LOCATION_ADDRESS_OTM_FKV2` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| SOURCE_DIM_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `FACT_ORDERMOVEMENT_OTM_DIM_LOCATION_ADDRESS_OTM_FK` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| FACT_SHIPMENT_OTM_ID | NUMBER | SI |  | **FK** `FACT_OM_SHIPMENT_OTM_FK` → `FACT_SHIPMENT_OTM.SHIPMENT_OTM_ID`. |
| FACT_ORDERRELEASE_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERMOVEMENT_OTM_FACT_ORDERRELEASE_OTM_FK` → `FACT_ORDERRELEASE_OTM.ORDERRELEASE_OTM_ID`. |
| DIM_BULKPLAN_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERMOVEMENT_OTM_DIM_BULKPLAN_OTM_FK` → `DIM_BULKPLAN_OTM.BULKPLAN_OTM_ID`. |

---

## DWADW.FACT_ORDERRELEASE_OTM
<a id="dwadwfact_orderrelease_otm"></a>

**Descripción:** Hecho de *Order Release* (orden liberada), con métricas de valor declarado, pesos/volúmenes y banderas de negocio.  
**Granularidad:** 1 fila por **ORDER_RELEASE_GID**.

> Nota: contiene múltiples atributos/flags operacionales; se usa como hecho “cabecera” para análisis por orden.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ORDERRELEASE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_ORDERRELEASE_OTM_PK`. |
| ORDER_RELEASE_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `DIM_ORDERRELEASE_OTM_UN`. |
| ORDER_RELEASE_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| ORDER_RELEASE_NAME | VARCHAR2(480 BYTE) | SI |  | Nombre. |
| ORDER_RELEASE_TYPE_GID | VARCHAR2(404 BYTE) | SI |  | Tipo natural. |
| ASSIGNED_ITINERARY_GID | VARCHAR2(404 BYTE) | SI |  | Itinerario natural. |
| SOURCE_LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Origen natural. |
| DEST_LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Destino natural. |
| EARLY_PICKUP_DATE | DATE | SI |  | Fecha pickup temprana. |
| TOTAL_ITEM_PACKAGE_COUNT | NUMBER | SI |  | Conteo paquetes. |
| INDICATOR | VARCHAR2(4 BYTE) | SI |  | Indicador. |
| TOTAL_NET_WEIGHT | NUMBER | SI |  | Peso neto. |
| TOTAL_NET_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| TOTAL_NET_WEIGHT_BASE | NUMBER | SI |  | Base. |
| TOTAL_NET_VOLUME | NUMBER | SI |  | Volumen neto. |
| TOTAL_NET_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| TOTAL_NET_VOLUME_BASE | NUMBER | SI |  | Base. |
| PICKUP_IS_APPT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DELIVERY_IS_APPT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_KNOWN_SHIPPER | VARCHAR2(4 BYTE) | NO |  | Flag. |
| RELEASE_METHOD_GID | VARCHAR2(404 BYTE) | SI |  | Método release natural. |
| LOC_AMOUNT | NUMBER | NO |  | Monto local. |
| LOC_AMOUNT_CURRENCY_GID | VARCHAR2(404 BYTE) | NO |  | Moneda monto local. |
| LOC_AMOUNT_BASE | NUMBER | NO |  | Monto base. |
| SECONDARY_T_WEIGHT | NUMBER | SI |  | Peso secundario. |
| SECONDARY_T_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SECONDARY_T_WEIGHT_BASE | NUMBER | SI |  | Base. |
| SECONDARY_T_VOLUME | NUMBER | SI |  | Volumen secundario. |
| SECONDARY_T_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SECONDARY_T_VOLUME_BASE | NUMBER | SI |  | Base. |
| MUST_SHIP_DIRECT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| MUST_SHIP_THRU_X_DOCK | VARCHAR2(4 BYTE) | NO |  | Flag. |
| MUST_SHIP_THRU_POOL | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IMPORT_LICENSE_REQUIRED | VARCHAR2(200 BYTE) | SI |  | Licencia requerida. |
| IS_LOC_REQUIRED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| INSPECTION_REQUIRED | VARCHAR2(200 BYTE) | SI |  | Inspección. |
| CUSTOMER_UNITIZATION_REQUEST | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_LOC_STALE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| BUNDLING_TYPE | VARCHAR2(200 BYTE) | NO |  | Tipo bundling. |
| IS_CONSOLIDATE_OR_EQUIPMENT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DUTY_PAID | VARCHAR2(32 BYTE) | NO |  | Duty paid. |
| TOTAL_DECLARED_VALUE | NUMBER | SI |  | Valor declarado total. |
| TOTAL_DECLARED_VALUE_GID | VARCHAR2(404 BYTE) | SI |  | Moneda/valor natural. |
| TOTAL_DECLARED_VALUE_BASE | NUMBER | SI |  | Base. |
| BULK_PLAN_GID | VARCHAR2(404 BYTE) | SI |  | Bulk plan natural. |
| TOTAL_SHIP_UNIT_COUNT | NUMBER | SI |  | Conteo. |
| TOTAL_WEIGHT | NUMBER | SI |  | Peso total. |
| TOTAL_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| TOTAL_WEIGHT_BASE | NUMBER | SI |  | Base. |
| TOTAL_VOLUME | NUMBER | SI |  | Volumen total. |
| TOTAL_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| ON_RT_EXECUTION | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_SPLITTABLE | VARCHAR2(4 BYTE) | SI |  | Flag. |
| OTM_VERSION | VARCHAR2(60 BYTE) | SI |  | Versión OTM. |
| TOTAL_VOLUME_BASE | NUMBER | SI |  | Volumen base (repetido en DDL). |
| MARKED_FOR_PURGE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_PRE_ENTERED_PU | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_TOPOFF | VARCHAR2(4 BYTE) | NO |  | Flag. |
| SHIP_UNIT_WIDTH | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_WIDTH_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_WIDTH_BASE | NUMBER | SI |  | Base. |
| SHIP_UNIT_LENGTH | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_LENGTH_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_LENGTH_BASE | NUMBER | SI |  | Base. |
| SHIP_UNIT_HEIGHT | NUMBER | SI |  | Dimensión. |
| SHIP_UNIT_HEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| SHIP_UNIT_HEIGHT_BASE | NUMBER | SI |  | Base. |
| PRIORITY | NUMBER | NO |  | Prioridad. |
| IS_TEMPLATE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| SOURCE_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `FACT_ORDERRELEASE_OTM_DIM_LOCATION_ADDRESS_OTM_FK` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| DEST_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `FACT_ORDERRELEASE_OTM_DIM_LOCATION_ADDRESS_OTM_FKV2` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| DIM_ORDERRELEASETYPE_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERRELEASE_ORTYPE_OTM_FK` → `DIM_ORDERRELEASETYPE_OTM.ORDERRELEASETYPE_OTM_ID`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| DIM_BULKPLAN_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERRELEASE_OTM_DIM_BULKPLAN_OTM_FK` → `DIM_BULKPLAN_OTM.BULKPLAN_OTM_ID`. |
| DIM_ITINERARY_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERRELEASE_OTM_DIM_ITINERARY_OTM_FK` → `DIM_ITINERARY_OTM.ITINERARY_OTM_ID`. |
| DIM_TIME_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERRELEASE_OTM_DIM_TIME_OTM_FK` → `DIM_TIME_OTM.TIME_OTM_ID`. |

---

## DWADW.FACT_ORDERRELEASELINES_OTM
<a id="dwadwfact_orderreleaselines_otm"></a>

**Descripción:** Hecho de líneas de Order Release (detalle por ítem/packaged item) con valores monetarios y flags HAZ.  
**Granularidad:** 1 fila por **ORDER_RELEASE_LINE_GID**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| ORDERRELEASLINES_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_ORDERRELEASLINES_OTM_PK`. |
| ORDER_RELEASE_LINE_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `FACT_ORDERRELEASLINES_OTM_UN`. |
| ORDER_RELEASE_LINE_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| ORDER_RELEASE_GID | VARCHAR2(404 BYTE) | NO |  | Order Release natural. |
| WEIGHT | NUMBER | SI |  | Peso. |
| WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| WEIGHT_BASE | NUMBER | SI |  | Base. |
| VOLUME | NUMBER | SI |  | Volumen. |
| VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| VOLUME_BASE | NUMBER | SI |  | Base. |
| DECLARED_VALUE | NUMBER | NO |  | Valor declarado. |
| DECLARED_VALUE_BASE | NUMBER | NO |  | Base. |
| DECLARED_VALUE_CURRENCY_GID | VARCHAR2(404 BYTE) | NO |  | Moneda. |
| INITIAL_ITEM_GID | VARCHAR2(404 BYTE) | SI |  | Item natural inicial. |
| ITEM_PACKAGE_COUNT | NUMBER | NO |  | Conteo paquetes. |
| PACKAGED_ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Packaged item natural. |
| FREE_ALONG_SIDE | NUMBER | NO |  | Monto FAS. |
| FREE_ALONG_SIDE_BASE | NUMBER | NO |  | Base. |
| FREE_ALONG_SIDE_CURRENCY_GID | VARCHAR2(404 BYTE) | NO |  | Moneda. |
| HAZ_NET_EXPLOSV_CONTENT_WEIGHT | NUMBER | NO |  | Peso explosivo neto. |
| HAZ_NET_EXPL_CNTNT_WT_UOM_CODE | VARCHAR2(256 BYTE) | NO |  | UOM. |
| HAZ_NET_EXPL_CONTENT_WT_BASE | NUMBER | NO |  | Base. |
| HAZ_IS_LIMITED_QUANTITY | VARCHAR2(4 BYTE) | NO |  | Flag HAZ. |
| HAZ_IS_REPORTABLE_QUANTITY | VARCHAR2(4 BYTE) | NO |  | Flag HAZ. |
| HAZ_IS_TOXIC_INHALATION | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_IS_PASSENGER_AIRCRAFT_FORB | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_IS_COMMERCIAL_AIRCRAFT_FOR | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_IS_OIL_CONTAINED | VARCHAR2(4 BYTE) | NO |  | Flag HAZ. |
| IS_DRAWBACK | VARCHAR2(4 BYTE) | NO |  | Flag. |
| BILLED_QUANTITY | NUMBER | NO |  | Cantidad facturada. |
| PRICE_PER_UNIT | NUMBER | NO |  | Precio unidad. |
| PRICE_PER_UNIT_BASE | NUMBER | NO |  | Base. |
| PRICE_PER_UNIT_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| TOTAL_BILLED_AMT | NUMBER | NO |  | Total facturado. |
| TOTAL_BILLED_AMT_BASE | NUMBER | NO |  | Base. |
| TOTAL_BILLED_AMT_CURRENCY_GID | VARCHAR2(404 BYTE) | NO |  | Moneda. |
| HAZ_IS_NOS | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_IS_MARINE_POLLUTANT | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_ALL_PACKED | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_IS_OVERPACK | VARCHAR2(4 BYTE) | SI |  | Flag HAZ. |
| HAZ_PACKING_COUNT | NUMBER | NO |  | Conteo empaque HAZ. |
| IS_SPLIT_ALLOWED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| RN | NUMBER | SI |  | Row number / control. |
| FACT_PACKAGEDITEM_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORLINES_PITEM_OTM_FK` → `FACT_PACKAGEDITEM_OTM.PACKAGEDITEM_OTM_ID`. |
| FACT_ORDERRELEASE_OTM_ID | NUMBER | NO |  | **FK** `FACT_ORDERRELEASLINES_OTM_FACT_ORDERRELEASE_OTM_FK` → `FACT_ORDERRELEASE_OTM.ORDERRELEASE_OTM_ID`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |

---

## DWADW.FACT_PACKAGEDITEM_OTM
<a id="dwadwfact_packageditem_otm"></a>

**Descripción:** Hecho/maestro de packaged items (empaque), con dimensiones físicas y flags por empaque.  
**Granularidad:** 1 fila por **PACKAGED_ITEM_GID**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| PACKAGEDITEM_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `DIM_PACKAGEDITEM_OTM_PK`. |
| PACKAGED_ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `DIM_PACKAGEDITEM_OTM_UN`. |
| PACKAGED_ITEM_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| DESCRIPTION | VARCHAR2(1020 BYTE) | SI |  | Descripción. |
| ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Item natural. |
| PACKAGE_SHIP_UNIT_WEIGHT | NUMBER | SI |  | Peso unidad. |
| PACKAGE_SHIP_UNIT_WEIGHT_UOM | VARCHAR2(256 BYTE) | SI |  | UOM. |
| PACKAGE_SHIP_UNIT_WEIGHT_BASE | NUMBER | SI |  | Base. |
| PACKAGE_SU_VOLUME | NUMBER | SI |  | Volumen. |
| PACKAGE_SU_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| PACKAGE_SU_VOLUME_BASE | NUMBER | SI |  | Base. |
| PACKAGE_SU_LENGTH | NUMBER | SI |  | Largo. |
| PACKAGE_SU_LENGTH_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| PACKAGE_SU_LENGTH_BASE | NUMBER | SI |  | Base. |
| PACKAGE_SU_WIDTH | NUMBER | SI |  | Ancho. |
| PACKAGE_SU_WIDTH_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| PACKAGE_SU_WIDTH_BASE | NUMBER | SI |  | Base. |
| PACKAGE_SU_HEIGHT | NUMBER | SI |  | Alto. |
| PACKAGE_SU_HEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| PACKAGE_SU_HEIGHT_BASE | NUMBER | SI |  | Base. |
| IS_DEFAULT_PACKAGING | CHAR(4 BYTE) | NO |  | Flag. |
| IS_HAZARDOUS | CHAR(4 BYTE) | NO |  | Flag. |
| IS_ALLOW_MIXED_FREIGHT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_NESTABLE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| DIM_ITEM_OTM_ID | NUMBER | NO |  | **FK** `DIM_PACKAGEDITEM_ITEM_OTM_FK` → `DIM_ITEM_OTM.ITEM_OTM_ID`. |

---

## DWADW.FACT_SEQUIPMENTSSHIPUNITJOIN_OTM
<a id="dwadwfact_sequipmentsshipunitjoin_otm"></a>

**Descripción:** Relación entre s-equipment y s-ship-unit, con parámetros de apilado/filas/secuencia de carga.  
**Granularidad:** 1 fila por **(S_EQUIPMENT_GID, S_SHIP_UNIT_GID)** (según UK).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SEQUIPMENTSSHIPUNITJOIN_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_SEQUIPMENTSSHIPUNITJOIN_OTM_PK`. |
| S_EQUIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. Parte de **UK**. |
| S_SHIP_UNIT_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. Parte de **UK**. |
| COMPARTMENT_NUM | NUMBER | SI |  | Compartimiento. |
| NUM_STACKING_LAYERS | NUMBER | NO |  | Capas apilado. |
| NUM_LOADING_ROWS | NUMBER | NO |  | Filas carga. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| LOADING_PATTERN_GID | VARCHAR2(404 BYTE) | SI |  | Loading pattern natural. |
| LOADING_SEQUENCE | NUMBER | SI |  | Secuencia. |
| FACT_SSHIPMENTUNITLINE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SEQSHIPUJ_SSHIPUL_OTM_FK` → `FACT_SSHIPMENTUNITLINE_OTM.SSHIPMENTUNITLINE_OTM_ID`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría (nota: orden en DDL). |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| DIM_SEQUIPMENT_OTM_ID | NUMBER | NO |  | **FK** `FACT_SEQUIPMENTSSHIPUNITJOIN_OTM_DIM_SEQUIPMENT_OTM_FK` → `DIM_SEQUIPMENT_OTM.SEQUIPMENT_OTM_ID`. |
| DIM_LOADINGPATTERN_OTM_ID | NUMBER | SI |  | **FK** `FACT_SEQUIPMENTSSHIPUNITJOIN_OTM_DIM_LOADINGPATTERN_OTM_FK` → `DIM_LOADINGPATTERN_OTM.LOADINGPATTERN_OTM_ID`. |
| *(UK)* |  |  |  | **UK** `FACT_SEQUIPMENTSSHIPUNITJOIN_OTM_UN` en (S_EQUIPMENT_GID, S_SHIP_UNIT_GID). |

---

## DWADW.FACT_SHIP_ITEM_BOV_OTM
<a id="dwadwfact_ship_item_bov_otm"></a>

**Descripción:** Hecho analítico de detalle shipment–item (BOV), con costos, distancias, tiempos y atributos de línea/packaging.  
**Granularidad:** 1 fila por **(SHIPMENT_GID, ITEM_GID)** (según UK).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIP_ITEM_BOV_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_SHIP_ITEM_BOV_OTM_PK`. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Shipment natural. Parte de **UK**. |
| SHIPMENT_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| IS_TEMPLATE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| TRANSPORT_MODE_GID | VARCHAR2(404 BYTE) | SI |  | Modo natural. |
| TOTAL_ACTUAL_COST | NUMBER(22) | SI |  | Costo actual. |
| TOTAL_ACTUAL_COST_BASE | NUMBER(22) | SI |  | Base. |
| TOTAL_WEIGHTED_COST | NUMBER(22) | SI |  | Costo ponderado. |
| TOTAL_WEIGHTED_COST_BASE | NUMBER(22) | SI |  | Base. |
| T_ACTUAL_COST_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| T_WEIGHTED_COST_CURRENCY_GID | VARCHAR2(404) | SI |  | Moneda. |
| LOADED_DISTANCE | NUMBER(22) | SI |  | Distancia cargado. |
| LOADED_DISTANCE_UOM_CODE | VARCHAR2(256) | SI |  | UOM. |
| LOADED_DISTANCE_BASE | NUMBER(22) | SI |  | Base. |
| UNLOADED_DISTANCE | NUMBER(22) | SI |  | Distancia vacío. |
| UNLOADED_DISTANCE_UOM_CODE | VARCHAR2(256) | SI |  | UOM. |
| UNLOADED_DISTANCE_BASE | NUMBER(22) | SI |  | Base. |
| SHIP_START_TIME | DATE | NO |  | Inicio. |
| SHIP_END_TIME | DATE | NO |  | Fin. |
| PARENT_LEG_GID | VARCHAR2(404 BYTE) | SI |  | Leg natural. |
| SERVPROV_GID | VARCHAR2(404 BYTE) | SI |  | Proveedor servicio natural. |
| SERVPROV_NAME | VARCHAR2(32767 BYTE) | SI |  | Nombre proveedor. |
| SERVPROV_ADDRESS | VARCHAR2(32767 BYTE) | SI |  | Dirección proveedor. |
| RATE_OFFERING_GID | VARCHAR2(404 BYTE) | SI |  | Rate offering natural. |
| RATE_GEO_GID | VARCHAR2(404 BYTE) | SI |  | Rate geo natural. |
| X_LANE_XID | VARCHAR2(32767 BYTE) | SI |  | X-lane. |
| X_LANE_DETAILS | VARCHAR2(32767 BYTE) | SI |  | Detalle. |
| IS_AUTO_MERGE_CONSOLIDATE | CHAR(4 BYTE) | NO |  | Flag. |
| PERSPECTIVE | CHAR(4 BYTE) | NO |  | Perspectiva. |
| TOTAL_WEIGHT | NUMBER(22) | NO |  | Peso total. |
| TOTAL_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | NO |  | UOM. |
| TOTAL_WEIGHT_BASE | NUMBER(22) | NO |  | Base. |
| TOTAL_VOLUME | NUMBER(22) | NO |  | Volumen total. |
| TOTAL_VOLUME_UOM_CODE | VARCHAR2(256) | NO |  | UOM. |
| TOTAL_VOLUME_BASE | NUMBER(22) | NO |  | Base. |
| ORDER_RELEASE_GID | VARCHAR2(404 BYTE) | SI |  | Order release natural. |
| SHIPMENT_AS_WORK | VARCHAR2(4) | NO |  | Flag. |
| CHECK_TIME_CONSTRAINT | CHAR(4) | NO |  | Flag. |
| CHECK_COST_CONSTRAINT | CHAR(4 BYTE) | NO |  | Flag. |
| CHECK_CAPACITY_CONSTRAINT | CHAR(4) | NO |  | Flag. |
| WEIGH_CODE | CHAR(4 BYTE) | NO |  | Código peso. |
| RULE_7 | CHAR(4) | NO |  | Flag/regla. |
| SHIPMENT_RELEASED | CHAR(4 BYTE) | NO |  | Flag. |
| S_SHIP_UNIT_GID | VARCHAR2(404 BYTE) | NO |  | Ship unit natural. |
| S_SHIP_UNIT_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| UNIT_LENGTH | NUMBER(22) | SI |  | Dimensión. |
| UNIT_LENGTH_UOM_CODE | VARCHAR2(256) | SI |  | UOM. |
| UNIT_LENGTH_BASE | NUMBER(22) | SI |  | Base. |
| UNIT_WIDTH | NUMBER(22) | SI |  | Dimensión. |
| UNIT_WIDTH_UOM_CODE | VARCHAR2(256) | SI |  | UOM. |
| UNIT_WIDTH_BASE | NUMBER(22) | SI |  | Base. |
| UNIT_HEIGHT | NUMBER(22) | SI |  | Dimensión. |
| UNIT_HEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| UNIT_HEIGHT_BASE | NUMBER(22) | SI |  | Base. |
| UNIT_WEIGHT | NUMBER(22) | SI |  | Peso unidad. |
| UNIT_WEIGHT_UOM_CODE | VARCHAR2(256) | SI |  | UOM. |
| UNIT_WEIGHT_BASE | NUMBER(22) | SI |  | Base. |
| UNIT_VOLUME | NUMBER(22) | SI |  | Volumen unidad. |
| UNIT_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| UNIT_VOLUME_BASE | NUMBER(22) | SI |  | Base. |
| IS_SPLITABLE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| SHIP_UNIT_COUNT | NUMBER(22) | NO |  | Conteo. |
| S_SHIP_UNIT_LINE_NO | NUMBER(22) | NO |  | Línea. |
| ITEM_WEIGHT | NUMBER | SI |  | Peso ítem. |
| ITEM_WEIGHT_UOM_CODE | VARCHAR2(256) | NO |  | UOM. |
| ITEM_WEIGHT_BASE | NUMBER(22) | SI |  | Base. |
| WEIGHT_BASE_UOM | VARCHAR2(32767 BYTE) | SI |  | UOM base (texto). |
| VOLUME_BASE_UOM | VARCHAR2(32767 BYTE) | SI |  | UOM base (texto). |
| ITEM_VOLUME | NUMBER(22) | SI |  | Volumen ítem. |
| VOLUME_UOM_CODE | VARCHAR2(256) | SI |  | UOM. |
| ITEM_VOLUME_BASE | NUMBER(22) | SI |  | Base. |
| ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Item natural. Parte de **UK**. |
| ITEM_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| ITEM_NAME | VARCHAR2(960) | SI |  | Nombre. |
| ITEM_DESCRIPTION | VARCHAR2(2000 BYTE) | SI |  | Descripción. |
| ITEM_COMMODITY | VARCHAR2(32767 BYTE) | SI |  | Commodity (texto). |
| OR_LINE_GID | VARCHAR2(404 BYTE) | SI |  | Línea OR natural. |
| ITEM_PACKAGE_COUNT | NUMBER(22) | SI |  | Conteo. |
| DECLARED_VALUE | NUMBER(22) | SI |  | Valor declarado. |
| DECLARED_VALUE_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| PACKAGED_ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Packaged item natural. |
| ORDER_RELEASE_XID | VARCHAR2(32767 BYTE) | SI |  | XID OR. |
| RN | NUMBER | SI |  | Control. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| FACT_SHIPMENT_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIP_ITEM_BOV_OTM_FACT_SHIPMENT_OTM_FK` → `FACT_SHIPMENT_OTM.SHIPMENT_OTM_ID`. |
| FACT_ORDERRELEASE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIP_ITEM_BOV_OTM_FACT_ORDERRELEASE_OTM_FK` → `FACT_ORDERRELEASE_OTM.ORDERRELEASE_OTM_ID`. |
| FACT_ORDERRELEASLINES_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIP_ITEM_BOV_OTM_FACT_ORDERRELEASLINES_OTM_FK` → `FACT_ORDERRELEASLINES_OTM.ORDERRELEASLINES_OTM_ID`. |
| DIM_ITEM_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIP_ITEM_BOV_OTM_DIM_ITEM_OTM_FK` → `DIM_ITEM_OTM.ITEM_OTM_ID`. |
| FACT_PACKAGEDITEM_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIP_ITEM_BOV_OTM_FACT_PACKAGEDITEM_OTM_FK` → `FACT_PACKAGEDITEM_OTM.PACKAGEDITEM_OTM_ID`. |
| *(UK)* |  |  |  | **UK** `FACT_SHIP_ITEM_BOV_OTM_UN` en (SHIPMENT_GID, ITEM_GID). |

---

## DWADW.FACT_SHIPMENT_OTM
<a id="dwadwfact_shipment_otm"></a>

**Descripción:** Hecho principal de shipment, con métricas de costo, distancia, peso/volumen y múltiples flags operacionales.  
**Granularidad:** 1 fila por **SHIPMENT_GID**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPMENT_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_SHIPMENT_OTM_PK`. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `FACT_SHIPMENT_OTM_UN`. |
| SHIPMENT_XID | VARCHAR2(200 BYTE) | NO |  | XID. |
| TRANSPORT_MODE_GID | VARCHAR2(404 BYTE) | SI |  | Modo natural. |
| IS_TEMPLATE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_PRIMARY | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_SPOT_COSTED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_CREDIT_NOTE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| TOTAL_ACTUAL_COST | NUMBER | SI |  | Costo. |
| TOTAL_ACTUAL_COST_BASE | NUMBER | SI |  | Base. |
| TOTAL_WEIGHTED_COST | NUMBER | SI |  | Costo ponderado. |
| TOTAL_WEIGHTED_COST_BASE | NUMBER | SI |  | Base. |
| T_ACTUAL_COST_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| T_WEIGHTED_COST_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| LOADED_DISTANCE | NUMBER | SI |  | Distancia. |
| LOADED_DISTANCE_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| LOADED_DISTANCE_BASE | NUMBER | SI |  | Base. |
| UNLOADED_DISTANCE | NUMBER | SI |  | Distancia. |
| UNLOADED_DISTANCE_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| UNLOADED_DISTANCE_BASE | NUMBER | SI |  | Base. |
| SOURCE_LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Origen natural. |
| DEST_LOCATION_GID | VARCHAR2(404 BYTE) | SI |  | Destino natural. |
| START_TIME | DATE | NO |  | Inicio. |
| END_TIME | DATE | NO |  | Fin. |
| PARENT_LEG_GID | VARCHAR2(404 BYTE) | SI |  | Leg natural. |
| SERVPROV_GID | VARCHAR2(404 BYTE) | SI |  | Proveedor natural. |
| RATE_OFFERING_GID | VARCHAR2(404 BYTE) | SI |  | Rate offering. |
| RATE_GEO_GID | VARCHAR2(404 BYTE) | SI |  | Rate geo. |
| IS_AUTO_MERGE_CONSOLIDATE | CHAR(4 BYTE) | NO |  | Flag. |
| PERSPECTIVE | CHAR(4 BYTE) | NO |  | Perspectiva. |
| TOTAL_WEIGHT | NUMBER | NO |  | Peso total. |
| TOTAL_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | NO |  | UOM. |
| TOTAL_WEIGHT_BASE | NUMBER | NO |  | Base. |
| TOTAL_VOLUME | NUMBER | NO |  | Volumen total. |
| TOTAL_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | NO |  | UOM. |
| TOTAL_VOLUME_BASE | NUMBER | NO |  | Base. |
| TOTAL_SHIP_UNIT_COUNT | NUMBER | SI |  | Conteo. |
| TOTAL_PACKAGING_UNIT_COUNT | NUMBER | NO |  | Conteo. |
| TOTAL_ITEM_PACKAGE_COUNT | NUMBER | NO |  | Conteo. |
| SHIPMENT_TYPE_GID | VARCHAR2(404 BYTE) | SI |  | Tipo natural. |
| SHIPMENT_AS_WORK | VARCHAR2(4 BYTE) | NO |  | Flag. |
| CHECK_TIME_CONSTRAINT | CHAR(4 BYTE) | NO |  | Flag. |
| CHECK_COST_CONSTRAINT | CHAR(4 BYTE) | NO |  | Flag. |
| CHECK_CAPACITY_CONSTRAINT | CHAR(4 BYTE) | NO |  | Flag. |
| WEIGH_CODE | CHAR(4 BYTE) | NO |  | Código. |
| RULE_7 | CHAR(4 BYTE) | NO |  | Flag. |
| SHIPMENT_RELEASED | CHAR(4 BYTE) | NO |  | Flag. |
| PLANNED_COST | NUMBER | SI |  | Costo planificado. |
| PLANNED_COST_BASE | NUMBER | SI |  | Base. |
| PLANNED_COST_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| IS_HAZARDOUS | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_TEMPERATURE_CONTROL | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_COST_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_SERVICE_TIME_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_RATE_GEO_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_RATE_OFFERING_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_SERVPROV_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_PRELOAD | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_FIXED_TENDER_CONTACT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_TO_BE_HELD | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_PREFERRED_CARRIER | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_EQUIPMENT_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_RECALC_TOTALS | VARCHAR2(4 BYTE) | NO |  | Flag. |
| HAS_APPOINTMENTS | VARCHAR2(4 BYTE) | NO |  | Flag. |
| INDICATOR | VARCHAR2(4 BYTE) | SI |  | Indicador. |
| BULK_PLAN_GID | VARCHAR2(404 BYTE) | SI |  | Bulk plan natural. |
| ITINERARY_GID | VARCHAR2(404 BYTE) | SI |  | Itinerario natural. |
| FEASIBILITY_CODE_GID | VARCHAR2(404 BYTE) | SI |  | Viability natural. |
| NUM_ORDER_RELEASES | NUMBER | SI |  | Conteo. |
| NUM_STOPS | NUMBER | SI |  | Conteo. |
| TOTAL_NET_WEIGHT | NUMBER | NO |  | Peso neto. |
| TOTAL_NET_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| TOTAL_NET_WEIGHT_BASE | NUMBER | SI |  | Base. |
| TOTAL_NET_VOLUME | NUMBER | NO |  | Volumen neto. |
| TOTAL_NET_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| TOTAL_NET_VOLUME_BASE | NUMBER | SI |  | Base. |
| EARLIEST_START_TIME | DATE | SI |  | Ventana. |
| LATEST_START_TIME | DATE | SI |  | Ventana. |
| IN_TRAILER_BUILD | VARCHAR2(4 BYTE) | NO |  | Flag. |
| FIRST_EQUIPMENT_GROUP_GID | VARCHAR2(404 BYTE) | SI |  | Grupo equipo. |
| WEIGHT_UTILIZATION | NUMBER | NO |  | Utilización. |
| VOLUME_UTILIZATION | NUMBER | NO |  | Utilización. |
| EQUIP_REF_UNIT_UTILIZATION | NUMBER | NO |  | Utilización. |
| IS_CPCTY_OVERRIDE_APPLICABLE | VARCHAR2(4 BYTE) | SI |  | Flag. |
| PLANNED_RATE_OFFERING_GID | VARCHAR2(404 BYTE) | SI |  | Planeado. |
| PLANNED_TRANSPORT_MODE_GID | VARCHAR2(404 BYTE) | SI |  | Planeado. |
| PLANNED_SERVPROV_GID | VARCHAR2(404 BYTE) | SI |  | Planeado. |
| PLANNED_RATE_GEO_GID | VARCHAR2(404 BYTE) | SI |  | Planeado. |
| IS_MEMO_BL | VARCHAR2(4 BYTE) | SI |  | Flag. |
| DUTY_PAID | VARCHAR2(32 BYTE) | NO |  | Duty paid. |
| CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| EXCHANGE_RATE_GID | VARCHAR2(404 BYTE) | SI |  | Tipo cambio. |
| TOTAL_DECLARED_VALUE | NUMBER | SI |  | Valor declarado. |
| TOTAL_DECLARED_VALUE_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| TOTAL_DECLARED_VALUE_BASE | NUMBER | SI |  | Base. |
| IS_PROFIT_SPLIT | VARCHAR2(4 BYTE) | SI |  | Flag. |
| IS_ADVANCED_CHARGE | VARCHAR2(4 BYTE) | SI |  | Flag. |
| CHARGEABLE_WEIGHT | NUMBER | SI |  | Peso cobrado. |
| CHARGEABLE_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| CHARGEABLE_WEIGHT_BASE | NUMBER | SI |  | Base. |
| MARKED_FOR_PURGE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| PREV_DROP_INVENTORY_PROCESSED | VARCHAR2(4 BYTE) | SI |  | Flag. |
| PICK_INVENTORY_PROCESSED | VARCHAR2(4 BYTE) | SI |  | Flag. |
| DROP_INVENTORY_PROCESSED | VARCHAR2(4 BYTE) | SI |  | Flag. |
| CHARGEABLE_VOLUME | NUMBER | SI |  | Volumen cobrado. |
| CHARGEABLE_VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| CHARGEABLE_VOLUME_BASE | NUMBER | SI |  | Base. |
| PLANNING_PARAMETER_SET_GID | VARCHAR2(404 BYTE) | SI |  | Parámetros. |
| IS_FIXED_VOYAGE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| SOLE_PACKAGED_ITEM_GID | VARCHAR2(404 BYTE) | SI |  | Packaged item. |
| IS_AR_ROUTE_CODE_FIXED | VARCHAR2(4 BYTE) | NO |  | Flag. |
| LOADING_HALL_PENALTY | NUMBER | SI |  | Penalidad. |
| IS_PERMANENT | VARCHAR2(4 BYTE) | SI |  | Flag. |
| IS_FIXED_DISTANCE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| DEST_DIM_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `FACT_SHIPMENT_OTM_DIM_LOCATION_ADDRESS_OTM_FKV2` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| SOURCE_DIM_LOCATION_ADDRESS_OTM_ID | NUMBER | SI |  | **FK** `FACT_SHIPMENT_OTM_DIM_LOCATION_ADDRESS_OTM_FK` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| DRIVER_GID | VARCHAR2(404 BYTE) | SI |  | Driver natural. |
| DIM_DRIVER_OTM_ID | NUMBER | SI |  | **FK** `FACT_SHIP_DRIVER_OTM_FK` → `DIM_DRIVER_OTM.DRIVER_OTM_ID`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| DIM_TRANSPORTMODE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENT_OTM_DIM_TRANSPORTMODE_OTM_FK` → `DIM_TRANSPORTMODE_OTM.TRANSPORTMODE_OTM_ID`. |
| DIM_ROUTE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENT_OTM_DIM_ROUTE_OTM_FK` → `DIM_ROUTE_OTM.ROUTE_OTM_ID`. |
| DIM_BULKPLAN_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENT_OTM_DIM_BULKPLAN_OTM_FK` → `DIM_BULKPLAN_OTM.BULKPLAN_OTM_ID`. |
| DIM_VIABILITY_CODE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENT_OTM_DIM_VIABILITY_CODE_OTM_FK` → `DIM_VIABILITY_CODE_OTM.VIABILITY_CODE_OTM_ID`. |

---

## DWADW.FACT_SHIPMENTSTOP_OTM
<a id="dwadwfact_shipmentstop_otm"></a>

**Descripción:** Hecho de paradas de shipment (stops) con tiempos, distancias y actividad.  
**Granularidad:** 1 fila por **(SHIPMENT_GID, STOP_NUM)**.

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SHIPMENTSTOP_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_SHIPMENTSTOP_OTM_PK`. |
| SHIPMENT_GID | VARCHAR2(404 BYTE) | NO |  | Shipment natural. Parte de **UK**. |
| STOP_NUM | NUMBER | NO |  | Número de parada. Parte de **UK**. |
| LOCATION_GID | VARCHAR2(404 BYTE) | NO |  | Ubicación natural. |
| LOCATION_ROLE_GID | VARCHAR2(404 BYTE) | SI |  | Rol ubicación. |
| PLANNED_ARRIVAL | DATE | SI |  | Llegada planificada. |
| ESTIMATED_ARRIVAL | DATE | SI |  | Llegada estimada. |
| IS_FIXED_ARRIVAL | CHAR(4 BYTE) | NO |  | Flag. |
| PLANNED_DEPARTURE | DATE | SI |  | Salida planificada. |
| ESTIMATED_DEPARTURE | DATE | SI |  | Salida estimada. |
| IS_FIXED_DEPARTURE | CHAR(4 BYTE) | NO |  | Flag. |
| WAIT_TIME | NUMBER | SI |  | Tiempo espera. |
| WAIT_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| WAIT_TIME_BASE | NUMBER | SI |  | Base. |
| REST_TIME | NUMBER | SI |  | Tiempo descanso. |
| REST_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| REST_TIME_BASE | NUMBER | SI |  | Base. |
| DRIVE_TIME | NUMBER | SI |  | Tiempo conducción. |
| DRIVE_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| DRIVE_TIME_BASE | NUMBER | SI |  | Base. |
| DIST_FROM_PREV_STOP | NUMBER | SI |  | Distancia. |
| DIST_FROM_PREV_STOP_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| DIST_FROM_PREV_STOP_BASE | NUMBER | SI |  | Base. |
| ACTIVITY_TIME | NUMBER | SI |  | Tiempo actividad. |
| ACTIVITY_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| ACTIVITY_TIME_BASE | NUMBER | SI |  | Base. |
| IS_PERMANENT | VARCHAR2(4 BYTE) | NO |  | Flag. |
| IS_DEPOT | VARCHAR2(4 BYTE) | NO |  | Flag depot. |
| ACCESSORIAL_TIME | NUMBER | SI |  | Tiempo accesorio. |
| ACCESSORIAL_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| ACCESSORIAL_TIME_BASE | NUMBER | SI |  | Base. |
| IS_FIXED_DISTANCE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| RUSH_HOUR_TIME | NUMBER | SI |  | Tiempo hora pico. |
| RUSH_HOUR_TIME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| RUSH_HOUR_TIME_BASE | NUMBER | SI |  | Base. |
| IS_MOTHER_VESSEL | VARCHAR2(4 BYTE) | NO |  | Flag. |
| STOP_TYPE | VARCHAR2(64 BYTE) | SI |  | Tipo (texto). |
| DRIVER_NON_PAYABLE | VARCHAR2(4 BYTE) | NO |  | Flag. |
| DISTANCE_TYPE | VARCHAR2(4 BYTE) | SI |  | Tipo distancia. |
| RUNNING_WEIGHT | NUMBER | SI |  | Peso acumulado. |
| RUNNING_WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| RUNNING_WEIGHT_BASE | NUMBER | SI |  | Base. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| FACT_SHIPMENT_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPSTOP_SHIPMENT_OTM_FK` → `FACT_SHIPMENT_OTM.SHIPMENT_OTM_ID`. |
| DIM_LOCATION_ADDRESS_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENTSTOP_OTM_DIM_LOCATION_ADDRESS_OTM_FK` → `DIM_LOCATION_ADDRESS_OTM.LOCATION_ADDRESS_OTM_ID`. |
| DIM_STOPTYPE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENTSTOP_OTM_DIM_STOPTYPE_OTM_FK` → `DIM_STOPTYPE_OTM.STOPTYPE_OTM_ID`. |
| DIM_TIME_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENTSTOP_OTM_DIM_TIME_OTM_FK` → `DIM_TIME_OTM.TIME_OTM_ID`. |
| DIM_DOMAIN_OTM_ID | NUMBER | NO |  | **FK** `FACT_SHIPMENTSTOP_OTM_DIM_DOMINIO_OTM_FK` → `DIM_DOMAIN_OTM.DOMAIN_OTM_ID`. |
| *(UK)* |  |  |  | **UK** `FACT_SHIPMENTSTOP_OTM_UN` en (SHIPMENT_GID, STOP_NUM). |

---

## DWADW.FACT_SSHIPMENTUNITLINE_OTM
<a id="dwadwfact_sshipmentunitline_otm"></a>

**Descripción:** Líneas de unidades de embarque secundarias (s-ship-unit lines) con valores y vínculo a order release lines.  
**Granularidad:** 1 fila por **S_SHIP_UNIT_GID** (según UK declarada).

| Nombre de Columna | Tipo de Dato | Nulo | Valor por Defecto | Descripción / comentario / observación |
|---|---|---|---|---|
| SSHIPMENTUNITLINE_OTM_ID | NUMBER (IDENTITY) | NO |  | **PK** `FACT_SSHIPMENTUNITLINE_OTM_PK`. |
| S_SHIP_UNIT_GID | VARCHAR2(404 BYTE) | NO |  | Natural key. **UK** `FACT_SSHIPMENTUNITLINE_OTM_UN`. |
| S_SHIP_UNIT_LINE_NO | NUMBER | NO |  | Número de línea. |
| WEIGHT | NUMBER | SI |  | Peso. |
| WEIGHT_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| WEIGHT_BASE | NUMBER | SI |  | Base. |
| VOLUME | NUMBER | SI |  | Volumen. |
| VOLUME_UOM_CODE | VARCHAR2(256 BYTE) | SI |  | UOM. |
| VOLUME_BASE | NUMBER | SI |  | Base. |
| OR_LINE_GID | VARCHAR2(404 BYTE) | SI |  | Línea OR natural. |
| ORDER_RELEASE_GID | VARCHAR2(404 BYTE) | SI |  | OR natural. |
| PACKAGING_UNIT_COUNT | NUMBER | SI |  | Conteo. |
| ITEM_PACKAGE_COUNT | NUMBER | SI |  | Conteo. |
| DECLARED_VALUE | NUMBER | SI |  | Valor declarado. |
| DECLARED_VALUE_BASE | NUMBER | SI |  | Base. |
| DECLARED_VALUE_CURRENCY_GID | VARCHAR2(404 BYTE) | SI |  | Moneda. |
| PACKAGED_ITEM_GID | VARCHAR2(404 BYTE) | NO |  | Packaged item natural. |
| RECEIVED_ITEM_PACKAGE_COUNT | NUMBER | SI |  | Recibidos. |
| SHIP_UNIT_GID | VARCHAR2(404 BYTE) | SI |  | Ship unit natural. |
| SHIP_UNIT_LINE_NO | NUMBER | SI |  | Línea ship unit. |
| COUNT_PER_SHIP_UNIT | NUMBER | SI |  | Conteo. |
| DOMAIN_NAME | VARCHAR2(200 BYTE) | NO |  | Dominio. |
| RN | NUMBER | SI |  | Control. |
| FACT_ORDERRELEASLINES_OTM_ID | NUMBER | NO |  | **FK** `FACT_SSHIPMENTUNITLINE_OTM_FACT_ORDERRELEASLINES_OTM_FK` → `FACT_ORDERRELEASLINES_OTM.ORDERRELEASLINES_OTM_ID`. |
| DIM_PACKAGEDITEM_OTM_ID | NUMBER | NO |  | **FK** `FACT_SSHIPUL_PI_OTM_FK` → `FACT_PACKAGEDITEM_OTM.PACKAGEDITEM_OTM_ID`. |
| INSERT_USER | VARCHAR2(512 BYTE) | NO |  | Auditoría. |
| INSERT_DATE | DATE | NO |  | Auditoría. |
| UPDATE_USER | VARCHAR2(512 BYTE) | SI |  | Auditoría. |
| UPDATE_DATE | DATE | SI |  | Auditoría. |
| LOAD_DATE | DATE | NO |  | Fecha carga. |
| DIM_SHIPUNIT_OTM_ID | NUMBER | NO |  | **FK** `FACT_SSHIPMENTUNITLINE_OTM_DIM_SHIPUNIT_OTM_FK` → `DIM_SHIPUNIT_OTM.SHIPUNIT_OTM_ID`. |
| FACT_ORDERRELEASE_OTM_ID | NUMBER | NO |  | **FK** `FACT_SSHIPMENTUNITLINE_OTM_FACT_ORDERRELEASE_OTM_FK` → `FACT_ORDERRELEASE_OTM.ORDERRELEASE_OTM_ID`. |
