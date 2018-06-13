*&---------------------------------------------------------------------*
*&  Include           ZFI_COMPAR_DEUDORES_C
*&---------------------------------------------------------------------*
CLASS zcl_fi_comparacion_deudores DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA: gti_entry_customer TYPE TABLE OF gty_entry_customer,
                gti_customer TYPE TABLE OF gty_zfi_deud_compa,
                gti_alv_customer TYPE TABLE OF gty_alv_customer,
                gc_root TYPE REF TO cx_root,
                gc_message TYPE string.

    CLASS-METHODS: get_file EXCEPTIONS no_data,
                   get_data EXCEPTIONS no_data,
                   get_comparacion EXCEPTIONS no_data,
                   if_comparacion IMPORTING i_es_entry_customer TYPE gty_entry_customer
                                            i_es_customer TYPE gty_zfi_deud_compa
                                  CHANGING  i_es_alv_customer TYPE gty_alv_customer,
                   show_alv.

ENDCLASS.                    "zcl_fi_comparacion_deudores DEFINITION

*----------------------------------------------------------------------*
*       CLASS zcl_fi_comparacion_deudores IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS zcl_fi_comparacion_deudores IMPLEMENTATION.

  METHOD get_file.

    DATA filename TYPE string.
    filename = p_file.

    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        percentage = 30
        text       = 'Cargando archivo'.

    TRY.

        CALL FUNCTION 'GUI_UPLOAD'
          EXPORTING
            filename                = filename
            filetype                = 'ASC'
            has_field_separator     = 'X'
          TABLES
            data_tab                = gti_entry_customer
          EXCEPTIONS
            file_open_error         = 1
            file_read_error         = 2
            no_batch                = 3
            gui_refuse_filetransfer = 4
            invalid_type            = 5
            no_authority            = 6
            unknown_error           = 7
            bad_data_format         = 8
            header_not_allowed      = 9
            separator_not_allowed   = 10
            header_too_long         = 11
            unknown_dp_error        = 12
            access_denied           = 13
            dp_out_of_memory        = 14
            disk_full               = 15
            dp_timeout              = 16
            OTHERS                  = 17.

        IF gti_entry_customer IS INITIAL.
          RAISE no_data.
        ENDIF.

      CATCH cx_root INTO gc_root.
        gc_message = gc_root->if_message~get_longtext( ).
        MESSAGE gc_message TYPE 'E'.
    ENDTRY.

  ENDMETHOD.                    "get_file

  METHOD get_data.

    FIELD-SYMBOLS <lfs_customer> LIKE LINE OF gti_customer.

    TRY .
        CALL FUNCTION 'ZFI_DATOS_DEUDORES'
          EXPORTING
            p_vkorg  = p_vkorg
            p_vtweg  = p_vtweg
            p_spart  = p_spart
            p_bzirk  = p_bzirk
          TABLES
            ti_retur = gti_customer.

        LOOP AT gti_customer ASSIGNING <lfs_customer>.

          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
            EXPORTING
              input  = <lfs_customer>-kunnr
            IMPORTING
              output = <lfs_customer>-kunnr.

          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
            EXPORTING
              input  = <lfs_customer>-zc
            IMPORTING
              output = <lfs_customer>-zc.

          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
            EXPORTING
              input  = <lfs_customer>-zr
            IMPORTING
              output = <lfs_customer>-zr.

        ENDLOOP.

        IF gti_customer IS INITIAL.
          RAISE no_data.
        ENDIF.

      CATCH cx_root INTO gc_root.
        gc_message = gc_root->if_message~get_longtext( ).
        MESSAGE gc_message TYPE 'E'.
    ENDTRY.

  ENDMETHOD.                    "get_data

  METHOD get_comparacion.

    DATA: les_customer LIKE LINE OF gti_customer,
          les_entry_customer LIKE LINE OF gti_entry_customer,
          les_alv_customer LIKE LINE OF gti_alv_customer.
    DATA lv_lines TYPE i.
    DESCRIBE TABLE gti_entry_customer LINES lv_lines.
    DATA lv_porc(15) TYPE c.

    TRY.

        LOOP AT gti_entry_customer INTO les_entry_customer.

          CLEAR les_alv_customer.

          READ TABLE gti_customer INTO les_customer WITH KEY kunnr = les_entry_customer-documento.

          les_alv_customer-documento = les_entry_customer-documento.

          "Genera registro para los deudores con la zona incorrecta
          IF sy-subrc NE 0.
            les_alv_customer-zona = g_cte_icono_rojo.
            APPEND les_alv_customer TO gti_alv_customer.
            CONTINUE.
          ENDIF.

          "Si estan en la zona correcta, pasa a realizar comparacion
          les_alv_customer-zona = g_cte_icono_verde.
          lv_porc = ( sy-tabix * 100 ) / lv_lines.

          IF lv_porc < 1.
            lv_porc = 1.
          ENDIF.

          CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
            EXPORTING
              percentage = lv_porc
              text       = 'Comparando campos localmente'.

          "INICIO de comparacion de campo por campo

          if_comparacion( EXPORTING i_es_entry_customer = les_entry_customer
                                    i_es_customer = les_customer
                          CHANGING  i_es_alv_customer = les_alv_customer ).

          "FIN de comparacion de campo por campo

          APPEND les_alv_customer TO gti_alv_customer.

        ENDLOOP.

        IF les_alv_customer IS INITIAL.
          RAISE no_data.
        ENDIF.

      CATCH cx_root INTO gc_root.
        gc_message = gc_root->if_message~get_longtext( ).
        MESSAGE gc_message TYPE 'E'.
    ENDTRY.

  ENDMETHOD.                    "get_comparacion

  METHOD if_comparacion.

    DATA posicion TYPE i VALUE 0.
    DATA logitud TYPE i VALUE 0.
    DATA numero_caracteres TYPE i VALUE 0.
    DATA dire_com_sap TYPE string.

    TRY.

        "Comparar nombres
        SEARCH i_es_customer-name3 FOR ','.
        IF sy-subrc = 0.
          posicion = ( sy-fdpos + 1 ).
          logitud = strlen( i_es_customer-name3 ).
          numero_caracteres = logitud - posicion.

          IF i_es_entry_customer-nombre1 <> i_es_customer-name3(sy-fdpos).
            i_es_alv_customer-nombre1_legado = i_es_entry_customer-nombre1.
            i_es_alv_customer-nombre1_sap = i_es_customer-name3(sy-fdpos).
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

          IF i_es_entry_customer-nombre2 <> i_es_customer-name3+posicion(numero_caracteres).
            i_es_alv_customer-nombre2_legado = i_es_entry_customer-nombre2.
            i_es_alv_customer-nombre2_sap = i_es_customer-name3+posicion(numero_caracteres).
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

        ELSE.
          IF i_es_entry_customer-nombre1 <> i_es_customer-name3.
            i_es_alv_customer-nombre1_legado = i_es_entry_customer-nombre1.
            i_es_alv_customer-nombre1_sap = i_es_customer-name3.
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

          IF i_es_entry_customer-nombre2 IS NOT INITIAL.
            i_es_alv_customer-nombre2_legado = i_es_entry_customer-nombre2.
            i_es_alv_customer-nombre2_sap = abap_off.
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

        ENDIF.

        "Comparar apellidos
        SEARCH i_es_customer-name4 FOR ','.
        IF sy-subrc = 0.
          posicion = ( sy-fdpos + 1 ).
          logitud = strlen( i_es_customer-name4 ).
          numero_caracteres = logitud - posicion.

          IF i_es_entry_customer-apellido1 <> i_es_customer-name4(sy-fdpos).
            i_es_alv_customer-apellido1_legado = i_es_entry_customer-apellido1.
            i_es_alv_customer-apellido1_sap = i_es_customer-name4(sy-fdpos).
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

          IF i_es_entry_customer-apellido2 <> i_es_customer-name4+posicion(numero_caracteres).
            i_es_alv_customer-apellido2_legado = i_es_entry_customer-apellido2.
            i_es_alv_customer-apellido2_sap = i_es_customer-name4+posicion(numero_caracteres).
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

        ELSE.
          IF i_es_entry_customer-apellido1 <> i_es_customer-name4.
            i_es_alv_customer-apellido1_legado = i_es_entry_customer-apellido1.
            i_es_alv_customer-apellido1_sap = i_es_customer-name4.
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.

          IF i_es_entry_customer-apellido2 IS NOT INITIAL.
            i_es_alv_customer-apellido2_legado = i_es_entry_customer-apellido2.
            i_es_alv_customer-apellido2_sap = abap_off.
            i_es_alv_customer-zona = g_cte_icono_amarillo.
          ENDIF.
        ENDIF.

        "Compara ciudad
        IF i_es_entry_customer-ciudad <> i_es_customer-ort01.
          i_es_alv_customer-ciudad_legado = i_es_entry_customer-ciudad.
          i_es_alv_customer-ciudad_sap = i_es_customer-ort01.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara departamento
        IF i_es_entry_customer-departamento <> i_es_customer-regio.
          i_es_alv_customer-departamento_legado = i_es_entry_customer-departamento.
          i_es_alv_customer-departamento_sap = i_es_customer-regio.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara latitud
        IF i_es_entry_customer-latitud <> i_es_customer-bahne.
          i_es_alv_customer-latitud_legado = i_es_entry_customer-latitud.
          i_es_alv_customer-latitud_sap = i_es_customer-bahne.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara longitud
        IF i_es_entry_customer-longitud <> i_es_customer-bahns.
          i_es_alv_customer-longitud_legado = i_es_entry_customer-longitud.
          i_es_alv_customer-longitud_sap = i_es_customer-bahns.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara estrato cliente
        IF i_es_entry_customer-estrato_cliente <> i_es_customer-kukla.
          i_es_alv_customer-estrato_cliente_legado = i_es_entry_customer-estrato_cliente.
          i_es_alv_customer-estrato_cliente_sap = i_es_customer-kukla.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara fecha expedicion de documento
        IF i_es_entry_customer-fecha_exp_doc <> i_es_customer-locco.
          i_es_alv_customer-fecha_expdoc_legado = i_es_entry_customer-fecha_exp_doc.
          i_es_alv_customer-fecha_expdoc_sap = i_es_customer-locco.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara estado del cliente
        IF i_es_entry_customer-estado_cliente <> i_es_customer-niels.
          i_es_alv_customer-estado_cliente_legado = i_es_entry_customer-estado_cliente.
          i_es_alv_customer-estado_cliente_sap = i_es_customer-niels.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara Barrio
        IF i_es_entry_customer-barrio <> i_es_customer-ort01.
          i_es_alv_customer-barrio_legado = i_es_entry_customer-barrio.
          i_es_alv_customer-barrio_sap = i_es_customer-ort01.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara tipo de documento
        IF i_es_entry_customer-tipo_documento <> i_es_customer-stcdt.
          i_es_alv_customer-tipo_documento_legado = i_es_entry_customer-tipo_documento.
          i_es_alv_customer-tipo_documento_sap = i_es_customer-stcdt.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara direccion
        IF i_es_entry_customer-direccion <> i_es_customer-street.
          i_es_alv_customer-direccion_legado = i_es_entry_customer-direccion.
          i_es_alv_customer-direccion_sap = i_es_customer-street.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara direccion complemento
        CONCATENATE i_es_customer-str_suppl1 i_es_customer-str_suppl2 i_es_customer-str_suppl3 INTO dire_com_sap.
        IF i_es_entry_customer-comp_direccion <> dire_com_sap.
          i_es_alv_customer-comp_direccion_legado = i_es_entry_customer-comp_direccion.
          i_es_alv_customer-comp_direccion_sap = dire_com_sap.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara telefono1
        IF i_es_entry_customer-telefono <> i_es_customer-tel_number1.
          i_es_alv_customer-telefono_legado = i_es_entry_customer-telefono.
          i_es_alv_customer-telefono_sap = i_es_customer-tel_number1.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara celular
        IF i_es_entry_customer-celular <> i_es_customer-tel_number2.
          i_es_alv_customer-celular_legado = i_es_entry_customer-celular.
          i_es_alv_customer-celular_sap = i_es_customer-tel_number2.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara correo1
        IF i_es_entry_customer-correo1 <> i_es_customer-smtp_addr1.
          i_es_alv_customer-correo1_legado = i_es_entry_customer-correo1.
          i_es_alv_customer-correo1_sap = i_es_customer-smtp_addr1.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara correo2
        IF i_es_entry_customer-correo2 <> i_es_customer-smtp_addr2.
          i_es_alv_customer-correo2_legado = i_es_entry_customer-correo2.
          i_es_alv_customer-correo2_sap = i_es_customer-smtp_addr2.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.


        "Compara cuenta contable
        IF i_es_entry_customer-cuenta_contable <> i_es_customer-akont.
          i_es_alv_customer-cuenta_contable_legado = i_es_entry_customer-cuenta_contable.
          i_es_alv_customer-cuenta_contable_sap = i_es_customer-akont.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara condicion de pago
        IF i_es_entry_customer-condicion_pago <> i_es_customer-zterm_knb1.
          i_es_alv_customer-condicion_pago_legado = i_es_entry_customer-condicion_pago.
          i_es_alv_customer-condicion_pago_sap = i_es_customer-zterm_knb1.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara grupo tesoreria
        IF i_es_entry_customer-grupo_tesoreria <> i_es_customer-fdgrv.
          i_es_alv_customer-grupo_tesoreria_legado = i_es_entry_customer-grupo_tesoreria.
          i_es_alv_customer-grupo_tesoreria_sap = i_es_customer-fdgrv.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara fecha nacimento
        IF i_es_entry_customer-fecha_nac <> i_es_customer-altkn.
          i_es_alv_customer-fecha_nac_legado = i_es_entry_customer-fecha_nac.
          i_es_alv_customer-fecha_nac_sap = i_es_customer-altkn.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara bloqueado
        IF i_es_entry_customer-bloqueado <> i_es_customer-aufsd_knvv.
          i_es_alv_customer-bloqueado_legado = i_es_entry_customer-bloqueado.
          i_es_alv_customer-bloqueado_sap = i_es_customer-aufsd_knvv.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara mail plan
        IF i_es_entry_customer-mail_plan <> i_es_customer-kdgrp.
          i_es_alv_customer-mail_plan_legado = i_es_entry_customer-mail_plan.
          i_es_alv_customer-mail_plan_sap = i_es_customer-kdgrp.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara tipo deudor
        IF i_es_entry_customer-tipo_cliente <> i_es_customer-konda.
          i_es_alv_customer-tipo_cliente_legado = i_es_entry_customer-tipo_cliente.
          i_es_alv_customer-tipo_cliente_sap = i_es_customer-konda.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara tipo zona
        IF i_es_entry_customer-tipo_zona <> i_es_customer-pltyp.
          i_es_alv_customer-tipo_zona_legado = i_es_entry_customer-tipo_zona.
          i_es_alv_customer-tipo_zona_sap = i_es_customer-pltyp.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara ulitma campaña
        IF i_es_entry_customer-ultima_camp <> i_es_customer-eikto.
          i_es_alv_customer-ultima_camp_legado = i_es_entry_customer-ultima_camp.
          i_es_alv_customer-ultima_camp_sap = i_es_customer-eikto.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara divisional
        IF i_es_entry_customer-divisional <> i_es_customer-vkgrp.
          i_es_alv_customer-divisional_legado = i_es_entry_customer-divisional.
          i_es_alv_customer-divisional_sap = i_es_customer-vkgrp.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara estado stencil
        IF i_es_entry_customer-estado_stencil <> i_es_customer-kvgr1.
          i_es_alv_customer-estado_stencil_legado = i_es_entry_customer-estado_stencil.
          i_es_alv_customer-estado_stencil_sap = i_es_customer-kvgr1.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara clasificacion por valor
        IF i_es_entry_customer-clasifi_valor <> i_es_customer-kvgr2.
          i_es_alv_customer-clasifi_valor_legado = i_es_entry_customer-clasifi_valor.
          i_es_alv_customer-clasifi_valor_sap = i_es_customer-kvgr2.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara cupo credito
        IF i_es_entry_customer-cupo_credito <> i_es_customer-cupocredito.
          i_es_alv_customer-cupo_credito_legado = i_es_entry_customer-cupo_credito.
          i_es_alv_customer-cupo_credito_sap = i_es_customer-cupocredito.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara tipo cartera
        IF i_es_entry_customer-tipo_cartera <> i_es_customer-tipocartera.
          i_es_alv_customer-tipo_cartera_legado = i_es_entry_customer-tipo_cartera.
          i_es_alv_customer-tipo_cartera_sap = i_es_customer-tipocartera.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara seccion
        IF i_es_entry_customer-seccion <> i_es_customer-seccion.
          i_es_alv_customer-seccion_legado = i_es_entry_customer-seccion.
          i_es_alv_customer-seccion_sap = i_es_customer-seccion.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara codeudor
        IF i_es_entry_customer-codeudor <> i_es_customer-zc.
          i_es_alv_customer-codeudor_legado = i_es_entry_customer-codeudor.
          i_es_alv_customer-codeudor_sap = i_es_customer-zc.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara directora de zona
        IF i_es_entry_customer-dir_zona <> i_es_customer-zd.
          i_es_alv_customer-dir_zona_legado = i_es_entry_customer-dir_zona.
          i_es_alv_customer-dir_zona_sap = i_es_customer-zd.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

        "Compara referente
        IF i_es_entry_customer-referente <> i_es_customer-zr.
          i_es_alv_customer-referente_legado = i_es_entry_customer-referente.
          i_es_alv_customer-referente_sap = i_es_customer-zr.
          i_es_alv_customer-zona = g_cte_icono_amarillo.
        ENDIF.

      CATCH cx_root INTO gc_root.
        gc_message = gc_root->if_message~get_longtext( ).
        MESSAGE gc_message TYPE 'E'.
    ENDTRY.

  ENDMETHOD.                    "if_comparacion

  METHOD show_alv.

    TRY.

*.. objeto referenciado
        DATA:l_c_alv TYPE REF TO zcl_cx_cl_salv_table.
*.. Crear instancia para controlar ALV OM
        CREATE OBJECT l_c_alv.
*.. Se crea la instancia con la tabla interna
        TRY .
            cl_salv_table=>factory(
            IMPORTING
              r_salv_table = l_c_alv->r_alv
            CHANGING
              t_table = gti_alv_customer ).
          CATCH cx_salv_msg.

        ENDTRY.

*.. Definir funciones
        l_c_alv->r_functions = l_c_alv->r_alv->get_functions( ).
        l_c_alv->r_functions->set_all( ).

*.. Asignar opciones
        l_c_alv->r_aggre = l_c_alv->r_alv->get_aggregations( ).
        l_c_alv->r_aggre->set_numerical_aggregation('X').

*.. Definir opciones de selección
        l_c_alv->r_selections = l_c_alv->r_alv->get_selections( ).
        l_c_alv->r_selections->set_selection_mode( 3 ).

*.. Configuramos las opciones de layout
        l_c_alv->r_layout = l_c_alv->r_alv->get_layout( ).
        l_c_alv->es_key-report = sy-repid.
        l_c_alv->es_key-handle = '1' .
        l_c_alv->r_layout->set_key( l_c_alv->es_key ).

        CALL METHOD l_c_alv->set_titulo
          EXPORTING
            i_titulo = 'Resultado de la comparacion'.

*.. Optimizar columna
        CALL METHOD l_c_alv->set_optimize.

**.. Definir catalogo

        DATA l_ref TYPE REF TO cl_abap_tabledescr.
        DATA l_column TYPE TABLE OF abap_keydescr.
        DATA es_column LIKE LINE OF l_column.
        DATA logitud TYPE i VALUE 0.
        DATA: i_short_text TYPE scrtext_s,
              i_medium_text TYPE scrtext_m,
              i_long_text TYPE scrtext_l,
              i_column TYPE	lvc_fname.

        l_ref ?= cl_abap_typedescr=>describe_by_data( gti_alv_customer ).
        l_column = l_ref->key.

        LOOP AT l_column INTO es_column.

          i_column = es_column-name.

          logitud = strlen( es_column-name ) - 1.
          TRANSLATE es_column-name+1(logitud) TO LOWER CASE.

          i_short_text = es_column-name.
          i_medium_text = es_column-name.
          i_long_text = ( es_column-name ).

          CALL METHOD l_c_alv->set_column_names
            EXPORTING
              i_column      = i_column
              i_long_text   = i_long_text
              i_medium_text = i_medium_text
              i_short_text  = i_short_text.

        ENDLOOP.

* Mostrar ALV
        l_c_alv->r_alv->display( ).

      CATCH cx_root INTO gc_root.
        gc_message = gc_root->if_message~get_longtext( ).
        MESSAGE gc_message TYPE 'E'.
    ENDTRY.

  ENDMETHOD.                    "show_alv

ENDCLASS.                    "zcl_fi_comparacion_deudores IMPLEMENTATION