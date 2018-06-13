*&---------------------------------------------------------------------*
*&  Include           ZFI_COMPAR_DEUDORES_E
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  "Obtener el archivo plano
  zcl_fi_comparacion_deudores=>get_file( EXCEPTIONS no_data = 1 ).

  IF sy-subrc NE 0.
    MESSAGE text-002 TYPE 'S'.
    EXIT.
  ENDIF.

  "Obtener datos de deudores en SAP
  zcl_fi_comparacion_deudores=>get_data( EXCEPTIONS no_data = 1 ).

  IF sy-subrc NE 0.
    MESSAGE text-003 TYPE 'S'.
    EXIT.
  ENDIF.

  "Realizar comparacion
  zcl_fi_comparacion_deudores=>get_comparacion( EXCEPTIONS no_data = 1 ).

  IF sy-subrc NE 0.
    MESSAGE text-004 TYPE 'S'.
    EXIT.
  ENDIF.

  "Mostrar ALV
  zcl_fi_comparacion_deudores=>show_alv( ).