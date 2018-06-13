*&---------------------------------------------------------------------*
*&  Include           ZFI_COMPAR_DEUDORES_V
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&  Include           ZFI_COMPAR_DEUDORESV
*&---------------------------------------------------------------------*

TYPES:

BEGIN OF gty_entry_customer,
  documento(100),
  nombre1(100),
  nombre2(100),
  apellido1(100),
  apellido2(100),
  ciudad(100),
  departamento(100),
  latitud(100),
  longitud(100),
  estrato_cliente(100),
  fecha_exp_doc(100),
  estado_cliente(100),
  barrio(100),
  tipo_documento(100),
  direccion(100),
  comp_direccion(100),
  telefono(100),
  celular(100),
  correo1(100),
  correo2(100),
  cuenta_contable(100),
  condicion_pago(100),
  grupo_tesoreria(100),
  fecha_nac(100),
*  marca(100),
*  usuario_creacion(100),
*  fecha_creacion(100),
  bloqueado(100),
  mail_plan(100),
*  zona_ventas(100),
  tipo_cliente(100),
  tipo_zona(100),
  ultima_camp(100),
  divisional(100),
  estado_stencil(100),
  clasifi_valor(100),
  cupo_credito(100),
  tipo_cartera(100),
  seccion(100),
  codeudor(100),
  dir_zona(100),
  referente(100),
END OF gty_entry_customer,

gty_zfi_deud_compa TYPE zfi_deud_compa,

BEGIN OF gty_alv_customer,
  documento(100),
  zona TYPE icon_d,
  nombre1_sap(100),
  nombre1_legado(100),
  nombre2_sap(100),
  nombre2_legado(100),
  apellido1_sap(100),
  apellido1_legado(100),
  apellido2_sap(100),
  apellido2_legado(100),
  ciudad_sap(100),
  ciudad_legado(100),
  departamento_sap(100),
  departamento_legado(100),
  latitud_sap(100),
  latitud_legado(100),
  longitud_sap(100),
  longitud_legado(100),
  estrato_cliente_sap(100),
  estrato_cliente_legado(100),
  fecha_expdoc_sap(100),
  fecha_expdoc_legado(100),
  estado_cliente_sap(100),
  estado_cliente_legado(100),
  barrio_sap(100),
  barrio_legado(100),
  tipo_documento_sap(100),
  tipo_documento_legado(100),
  direccion_sap(100),
  direccion_legado(100),
  comp_direccion_sap(100),
  comp_direccion_legado(100),
  telefono_sap(100),
  telefono_legado(100),
  celular_sap(100),
  celular_legado(100),
  correo1_sap(100),
  correo1_legado(100),
  correo2_sap(100),
  correo2_legado(100),
  cuenta_contable_sap(100),
  cuenta_contable_legado(100),
  condicion_pago_sap(100),
  condicion_pago_legado(100),
  grupo_tesoreria_sap(100),
  grupo_tesoreria_legado(100),
  fecha_nac_sap(100),
  fecha_nac_legado(100),
*  marca_sap(100),
*  marca_legado(100),
*  usuario_creacion_sap(100),
*  usuario_creacion_legado(100),
*  fecha_creacion_sap(100),
*  fecha_creacion_legado(100),
  bloqueado_sap(100),
  bloqueado_legado(100),
  mail_plan_sap(100),
  mail_plan_legado(100),
*  zona_ventas_sap(100),
*  zona_ventas_legado(100),
  tipo_cliente_sap(100),
  tipo_cliente_legado(100),
  tipo_zona_sap(100),
  tipo_zona_legado(100),
  ultima_camp_sap(100),
  ultima_camp_legado(100),
  divisional_sap(100),
  divisional_legado(100),
  estado_stencil_sap(100),
  estado_stencil_legado(100),
  clasifi_valor_sap(100),
  clasifi_valor_legado(100),
  cupo_credito_sap(100),
  cupo_credito_legado(100),
  tipo_cartera_sap(100),
  tipo_cartera_legado(100),
  seccion_sap(100),
  seccion_legado(100),
  codeudor_sap(100),
  codeudor_legado(100),
  dir_zona_sap(100),
  dir_zona_legado(100),
  referente_sap(100),
  referente_legado(100),
END OF gty_alv_customer.

  CONSTANTS:g_cte_icono_verde(4) TYPE c VALUE '@5B@',
     g_cte_icono_amarillo(4) TYPE c VALUE '@5D@',
     g_cte_icono_rojo(4) TYPE c VALUE '@5C@'.

SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE text-001.

"Pantalla se seleccion
PARAMETERS:p_file(128) OBLIGATORY,
           p_vkorg TYPE vkorg OBLIGATORY,
           p_vtweg TYPE vtweg OBLIGATORY,
           p_spart TYPE spart OBLIGATORY,
           p_bzirk TYPE bzirk OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b01.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  CALL FUNCTION 'WS_FILENAME_GET'
    EXPORTING
      def_filename = text-005
      mask         = ',*.*,*.*.'
      mode         = 'O'
      title        = text-002
    IMPORTING
      filename     = p_file
    EXCEPTIONS
      OTHERS.