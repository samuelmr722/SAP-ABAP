FUNCTION zfi_datos_deudores.
*"----------------------------------------------------------------------
*"*"Interfase local
*"  IMPORTING
*"     REFERENCE(P_VKORG) TYPE  VKORG
*"     REFERENCE(P_VTWEG) TYPE  VTWEG
*"     REFERENCE(P_SPART) TYPE  SPART
*"     REFERENCE(P_BZIRK) TYPE  BZIRK
*"  TABLES
*"      TI_RETUR STRUCTURE  ZFI_DEUD_COMPA
*"----------------------------------------------------------------------
  DATA: l_c_root   TYPE REF TO cx_root,
        l_c_message  TYPE string.

  DATA l_ti_kna1 TYPE STANDARD TABLE OF g_ty_kna1.
  DATA l_ti_adrc TYPE STANDARD TABLE OF g_ty_adrc.
  DATA l_ti_adr2 TYPE STANDARD TABLE OF g_ty_adr2.
  DATA l_ti_adr6 TYPE STANDARD TABLE OF g_ty_adr6.
  DATA l_ti_knb1 TYPE STANDARD TABLE OF g_ty_knb1.
  DATA l_ti_knvv TYPE STANDARD TABLE OF g_ty_knvv.
  DATA l_ti_knvp TYPE STANDARD TABLE OF g_ty_knvp.
  DATA l_ti_text TYPE STANDARD TABLE OF g_ty_text.
  DATA l_es_text LIKE LINE OF l_ti_text.
  DATA tdname TYPE  thead-tdname.
  DATA l_es_knvv LIKE LINE OF l_ti_knvv.
  DATA ltxt TYPE  line1000.

  TRY.

      "RECUPERACION DE DATOS

      "Datos comerciales
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 12
          text       = 'Recuperando en SAP datos comerciales'.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_knvv
      FROM knvv AS kv
      WHERE vkorg EQ p_vkorg
      AND vtweg EQ p_vtweg
      AND spart EQ p_spart
      AND bzirk EQ p_bzirk.

      "Datos generales
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 24
          text       = 'Recuperando en SAP datos generales'.

      CHECK l_ti_knvv IS NOT INITIAL.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_kna1
      FROM kna1 AS ka
      FOR ALL ENTRIES IN l_ti_knvv
      WHERE ka~kunnr EQ l_ti_knvv-kunnr.


      "Datos de direccion
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 36
          text       = 'Recuperando en SAP datos de direccion'.

      CHECK l_ti_kna1 IS NOT INITIAL.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_adrc
      FROM adrc AS ad
      FOR ALL ENTRIES IN l_ti_kna1
      WHERE ad~addrnumber EQ l_ti_kna1-adrnr.


      "Datos de telefonos
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 48
          text       = 'Recuperando en SAP datos de telefonos'.

      CHECK l_ti_kna1 IS NOT INITIAL.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_adr2
      FROM adr2 AS ad2
      FOR ALL ENTRIES IN l_ti_kna1
      WHERE consnumber IN ('001','002')
      AND ad2~addrnumber EQ l_ti_kna1-adrnr. "AND addrnumber EQ '0000460487'.


      "Datos de correo
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 60
          text       = 'Recuperando en SAP datos de correo'.

      CHECK l_ti_kna1 IS NOT INITIAL.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_adr6
      FROM adr6 AS ad6
      FOR ALL ENTRIES IN l_ti_kna1
      WHERE consnumber IN ('001','002')
      AND ad6~addrnumber EQ l_ti_kna1-adrnr. "AND addrnumber EQ '0000460487'.


      "Datos de sociedad
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 72
          text       = 'Recuperando en SAP datos de sociedad'.

      CHECK l_ti_knvv IS NOT INITIAL.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_knb1
      FROM knb1 AS ab
      FOR ALL ENTRIES IN l_ti_knvv
      WHERE ab~kunnr EQ l_ti_knvv-kunnr.


      "Datos de interlocutores
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 84
          text       = 'Recuperando en SAP datos de interlocutores'.

      CHECK l_ti_knvv IS NOT INITIAL.

      SELECT *
      INTO CORRESPONDING FIELDS OF TABLE l_ti_knvp
      FROM knvp AS kv
      FOR ALL ENTRIES IN l_ti_knvv
      WHERE parvw IN ('ZC','ZD','ZR')
      AND kv~kunnr EQ l_ti_knvv-kunnr. "AND kunnr EQ '1017164186'.


      "Datos de textos
      CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
        EXPORTING
          percentage = 96
          text       = 'Recuperando en SAP datos de textos'.

      LOOP AT l_ti_knvv INTO l_es_knvv.

        CONCATENATE l_es_knvv-kunnr l_es_knvv-vkorg l_es_knvv-vtweg l_es_knvv-spart INTO tdname.

        "cupo credito
        CALL FUNCTION 'Z_PI_READ_TEXT'
          EXPORTING
            tdobject = 'KNVV'
            tdid     = '0007'
            tdspras  = sy-langu
            tdname   = tdname
          IMPORTING
            ltxt     = ltxt.
        l_es_text-cupocredito = ltxt.

        "tipo cartera
        CALL FUNCTION 'Z_PI_READ_TEXT'
          EXPORTING
            tdobject = 'KNVV'
            tdid     = '0010'
            tdspras  = sy-langu
            tdname   = tdname
          IMPORTING
            ltxt     = ltxt.
        l_es_text-tipocartera = ltxt.

        "seccion
        CALL FUNCTION 'Z_PI_READ_TEXT'
          EXPORTING
            tdobject = 'KNVV'
            tdid     = '0011'
            tdspras  = sy-langu
            tdname   = tdname
          IMPORTING
            ltxt     = ltxt.
        l_es_text-seccion = ltxt.

        l_es_text-kunnr = l_es_knvv-kunnr.
        l_es_text-vkorg = l_es_knvv-vkorg.
        l_es_text-vtweg = l_es_knvv-vtweg.
        l_es_text-spart = l_es_knvv-spart.

        APPEND l_es_text TO l_ti_text.

      ENDLOOP.

      "ESTRUCTURACION DE DATOS
      DATA l_ti_final TYPE STANDARD TABLE OF zfi_deud_compa.
      DATA l_es_final LIKE LINE OF l_ti_final.

      DATA l_es_kna1 LIKE LINE OF l_ti_kna1.
      DATA l_es_adrc LIKE LINE OF l_ti_adrc.
      DATA l_es_knb1 LIKE LINE OF l_ti_knb1.
      DATA l_es_knvp LIKE LINE OF l_ti_knvp.
      DATA l_es_adr2 LIKE LINE OF l_ti_adr2.
      DATA l_es_adr6 LIKE LINE OF l_ti_adr6.

      DATA lv_lines TYPE i.
      DESCRIBE TABLE l_ti_knvv LINES lv_lines.
      DATA lv_porc(15) TYPE c.

      LOOP AT l_ti_knvv INTO l_es_knvv.
        "limpieza de estrucuras
        CLEAR: l_es_final, l_es_kna1, l_es_adrc, l_es_knb1, l_es_knvp, l_es_adr2, l_es_adr6.

        "datos comerciales
        l_es_final-vkorg = l_es_knvv-vkorg.
        l_es_final-vtweg = l_es_knvv-vtweg.
        l_es_final-spart = l_es_knvv-spart.
        l_es_final-ernam_knvv = l_es_knvv-ernam.
        l_es_final-erdat_knvv = l_es_knvv-erdat.
        l_es_final-aufsd_knvv = l_es_knvv-aufsd.
        l_es_final-kalks = l_es_knvv-kalks.
        l_es_final-kdgrp = l_es_knvv-kdgrp.
        l_es_final-bzirk = l_es_knvv-bzirk.
        l_es_final-konda = l_es_knvv-konda.
        l_es_final-pltyp = l_es_knvv-pltyp.
        l_es_final-lifsd_knvv = l_es_knvv-lifsd.
        l_es_final-lprio = l_es_knvv-lprio.
        l_es_final-eikto = l_es_knvv-eikto.
        l_es_final-vsbed = l_es_knvv-vsbed.
        l_es_final-faksd_knvv = l_es_knvv-faksd.
        l_es_final-mrnkz = l_es_knvv-mrnkz.
        l_es_final-waers = l_es_knvv-waers.
        l_es_final-ktgrd = l_es_knvv-ktgrd.
        l_es_final-zterm_knvv = l_es_knvv-zterm.
        l_es_final-vwerk = l_es_knvv-vwerk.
        l_es_final-vkgrp = l_es_knvv-vkgrp.
        l_es_final-vkbur = l_es_knvv-vkbur.
        l_es_final-kvgr1 = l_es_knvv-kvgr1.
        l_es_final-kvgr2 = l_es_knvv-kvgr2.
        l_es_final-prfre = l_es_knvv-prfre.

        "datos textos
        READ TABLE l_ti_text INTO l_es_text WITH KEY kunnr = l_es_knvv-kunnr
                                                     vkorg = l_es_knvv-vkorg
                                                     vtweg = l_es_knvv-vtweg
                                                     spart = l_es_knvv-spart.

        l_es_final-cupocredito = l_es_text-cupocredito.
        l_es_final-tipocartera = l_es_text-tipocartera.
        l_es_final-seccion = l_es_text-seccion.

        "datos generales
        READ TABLE l_ti_kna1 INTO l_es_kna1 WITH KEY kunnr = l_es_knvv-kunnr.
        l_es_final-kunnr = l_es_kna1-kunnr.
        l_es_final-land1 = l_es_kna1-land1.
        l_es_final-name1 = l_es_kna1-name1.
        l_es_final-name2 = l_es_kna1-name2.
        l_es_final-ort01 = l_es_kna1-ort01.
        l_es_final-regio = l_es_kna1-regio.
        l_es_final-sortl = l_es_kna1-sortl.
        l_es_final-adrnr = l_es_kna1-adrnr.
        l_es_final-anred = l_es_kna1-anred.
        l_es_final-aufsd_kna1 = l_es_kna1-aufsd.
        l_es_final-bahne = l_es_kna1-bahne.
        l_es_final-bahns = l_es_kna1-bahns.
        l_es_final-brsch = l_es_kna1-brsch.
        l_es_final-erdat_kna1 = l_es_kna1-erdat.
        l_es_final-ernam_kna1 = l_es_kna1-ernam.
        l_es_final-faksd_kna1 = l_es_kna1-faksd.
        l_es_final-ktokd = l_es_kna1-ktokd.
        l_es_final-kukla = l_es_kna1-kukla.
        l_es_final-lifnr = l_es_kna1-lifnr.
        l_es_final-lifsd_kna1 = l_es_kna1-lifsd.
        l_es_final-locco = l_es_kna1-locco.
        l_es_final-name3 = l_es_kna1-name3.
        l_es_final-name4 = l_es_kna1-name4.
        l_es_final-loevm_kna1 = l_es_kna1-loevm.
        l_es_final-niels = l_es_kna1-niels.
        l_es_final-ort02 = l_es_kna1-ort02.
        l_es_final-sperr_kna1 = l_es_kna1-sperr.
        l_es_final-stcd1 = l_es_kna1-stcd1.
        l_es_final-lzone = l_es_kna1-lzone.
        l_es_final-stkzn = l_es_kna1-stkzn.
        l_es_final-fityp = l_es_kna1-fityp.
        l_es_final-stcdt = l_es_kna1-stcdt.
        l_es_final-cassd = l_es_kna1-cassd.
        l_es_final-nodel = l_es_kna1-nodel.

        "datos direcciones
        READ TABLE l_ti_adrc INTO l_es_adrc WITH KEY addrnumber = l_es_kna1-adrnr.
        l_es_final-street = l_es_adrc-street.
        l_es_final-str_suppl1 = l_es_adrc-str_suppl1.
        l_es_final-str_suppl2 = l_es_adrc-str_suppl2.
        l_es_final-str_suppl3 = l_es_adrc-str_suppl3.
        l_es_final-location = l_es_adrc-location.

        "datos sociedad
        READ TABLE l_ti_knb1 INTO l_es_knb1 WITH KEY kunnr = l_es_knvv-kunnr.
        l_es_final-bukrs = l_es_knb1-bukrs.
        l_es_final-pernr = l_es_knb1-pernr.
        l_es_final-erdat_knb1 = l_es_knb1-erdat.
        l_es_final-ernam_knb1 = l_es_knb1-ernam.
        l_es_final-sperr_knb1 = l_es_knb1-sperr.
        l_es_final-loevm_knb1 = l_es_knb1-loevm.
        l_es_final-akont = l_es_knb1-akont.
        l_es_final-zwels = l_es_knb1-zwels.
        l_es_final-zahls = l_es_knb1-zahls.
        l_es_final-zterm_knb1 = l_es_knb1-zterm.
        l_es_final-fdgrv = l_es_knb1-fdgrv.
        l_es_final-xzver = l_es_knb1-xzver.
        l_es_final-altkn = l_es_knb1-altkn.
        l_es_final-ciiucode = l_es_knb1-ciiucode.

        "datos interlocutor ZC
        READ TABLE l_ti_knvp INTO l_es_knvp WITH KEY kunnr = l_es_knvv-kunnr
                                                     vkorg = l_es_knvv-vkorg
                                                     vtweg = l_es_knvv-vtweg
                                                     spart = l_es_knvv-spart
                                                     parvw = 'ZC'.
        l_es_final-zc = l_es_knvp-kunn2.

        "datos interlocutor ZD
        READ TABLE l_ti_knvp INTO l_es_knvp WITH KEY kunnr = l_es_knvv-kunnr
                                                     vkorg = l_es_knvv-vkorg
                                                     vtweg = l_es_knvv-vtweg
                                                     spart = l_es_knvv-spart
                                                     parvw = 'ZD'.
        l_es_final-zd = l_es_knvp-pernr.

        "datos interlocutor ZR
        READ TABLE l_ti_knvp INTO l_es_knvp WITH KEY kunnr = l_es_knvv-kunnr
                                                     vkorg = l_es_knvv-vkorg
                                                     vtweg = l_es_knvv-vtweg
                                                     spart = l_es_knvv-spart
                                                     parvw = 'ZR'.
        l_es_final-zr = l_es_knvp-kunn2.

        "telefono1
        READ TABLE l_ti_adr2 INTO l_es_adr2 WITH KEY addrnumber = l_es_kna1-adrnr
                                                     consnumber = '001'.
        l_es_final-tel_number1 = l_es_adr2-tel_number.

        "telefono2
        READ TABLE l_ti_adr2 INTO l_es_adr2 WITH KEY addrnumber = l_es_kna1-adrnr
                                                     consnumber = '002'.
        l_es_final-tel_number2 = l_es_adr2-tel_number.

        "correo1
        READ TABLE l_ti_adr6 INTO l_es_adr6 WITH KEY addrnumber = l_es_kna1-adrnr
                                                     consnumber = '001'.
        l_es_final-smtp_addr1 = l_es_adr6-smtp_addr.

        "correo2
        READ TABLE l_ti_adr6 INTO l_es_adr6 WITH KEY addrnumber = l_es_kna1-adrnr
                                                     consnumber = '002'.
        l_es_final-smtp_addr2 = l_es_adr6-smtp_addr.

        "Ingreso el registro del cliente
        APPEND l_es_final TO l_ti_final.

        lv_porc = ( sy-tabix * 100 ) / lv_lines.

        IF lv_porc < 1.
          lv_porc = 1.
        ENDIF.

        CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
          EXPORTING
            percentage = lv_porc
            text       = 'ESTRUCTURANDO DATOS DE SAP LOCALMENTE'.
      ENDLOOP.

      ti_retur[] = l_ti_final[].

    CATCH cx_root INTO l_c_root.
      l_c_message = l_c_root->if_message~get_longtext( ).
      MESSAGE l_c_message TYPE 'E'.
  ENDTRY.

ENDFUNCTION.