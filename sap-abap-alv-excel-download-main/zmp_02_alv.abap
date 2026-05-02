*&---------------------------------------------------------------------*
*& Report  ZMP_02_ALV
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZMP_02_ALV.

TABLES: mkpf, mseg.

TYPES: BEGIN OF ty_data,
         mblnr TYPE mkpf-mblnr,
         mjahr TYPE mkpf-mjahr,
         budat TYPE mkpf-budat,
         matnr TYPE mseg-matnr,
         werks TYPE mseg-werks,
         menge TYPE mseg-menge,
       END OF ty_data.

DATA: gt_data TYPE TABLE OF ty_data,
      gs_data TYPE ty_data.

DATA: gt_fieldcat TYPE lvc_t_fcat,
      gs_fieldcat TYPE lvc_s_fcat.

DATA: gt_excel TYPE TABLE OF string,
      gv_line  TYPE string.

DATA: lv_menge TYPE c LENGTH 20,
      lv_budat TYPE c LENGTH 20.

SELECT-OPTIONS: s_budat FOR mkpf-budat.

DATA: gr_container TYPE REF TO cl_gui_custom_container,
      gr_grid      TYPE REF TO cl_gui_alv_grid.

CLASS lcl_event_handler DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_toolbar
               FOR EVENT toolbar OF cl_gui_alv_grid
               IMPORTING e_object,

             handle_user_command
               FOR EVENT user_command OF cl_gui_alv_grid
               IMPORTING e_ucomm.
ENDCLASS.

CLASS lcl_event_handler IMPLEMENTATION.

  METHOD handle_toolbar.
    DATA ls_toolbar TYPE stb_button.

    CLEAR ls_toolbar.
    ls_toolbar-function  = 'EXCEL'.
    ls_toolbar-text      = 'Download Excel'.
    ls_toolbar-icon      = icon_export.
    ls_toolbar-quickinfo = 'Download to Excel'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_user_command.
    CASE e_ucomm.
      WHEN 'EXCEL'.
        PERFORM prepare_excel.
        PERFORM download_excel.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

DATA: gr_handler TYPE REF TO lcl_event_handler.

START-OF-SELECTION.

  SELECT mkpf~mblnr
         mkpf~mjahr
         mkpf~budat
         mseg~matnr
         mseg~werks
         mseg~menge
    INTO TABLE gt_data
    FROM mkpf
    INNER JOIN mseg
      ON mkpf~mblnr = mseg~mblnr
     AND mkpf~mjahr = mseg~mjahr
    WHERE mkpf~budat IN s_budat.

  IF gt_data IS INITIAL.
    MESSAGE 'No Data Found' TYPE 'I'.
    EXIT.
  ENDIF.

  CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  IF gr_container IS INITIAL.

    CREATE OBJECT gr_container
      EXPORTING container_name = 'ALV_CONTAINER'.

    CREATE OBJECT gr_grid
      EXPORTING i_parent = gr_container.

    PERFORM build_fieldcat.
    CREATE OBJECT gr_handler.
    SET HANDLER gr_handler->handle_toolbar FOR gr_grid.
    SET HANDLER gr_handler->handle_user_command FOR gr_grid.

    CALL METHOD gr_grid->set_table_for_first_display
      CHANGING
        it_outtab       = gt_data
        it_fieldcatalog = gt_fieldcat.

  ENDIF.
ENDMODULE.

FORM build_fieldcat.

  CLEAR gt_fieldcat.

  DEFINE add_fcat.
    CLEAR gs_fieldcat.
    gs_fieldcat-fieldname = &1.
    gs_fieldcat-coltext   = &2.
    gs_fieldcat-outputlen = 15.
    APPEND gs_fieldcat TO gt_fieldcat.
  END-OF-DEFINITION.

  add_fcat 'MBLNR' 'Material Doc'.
  add_fcat 'MJAHR' 'Year'.
  add_fcat 'BUDAT' 'Posting Date'.
  add_fcat 'MATNR' 'Material'.
  add_fcat 'WERKS' 'Plant'.
  add_fcat 'MENGE' 'Quantity'.

ENDFORM.

FORM prepare_excel.

  CLEAR gt_excel.
  DATA lv_sep TYPE c VALUE ','.

* Header
  CONCATENATE 'Material Doc' 'Year' 'Posting Date'
              'Material' 'Plant' 'Quantity'
    INTO gv_line SEPARATED BY lv_sep.
  APPEND gv_line TO gt_excel.

* Data
  LOOP AT gt_data INTO gs_data.

    WRITE gs_data-menge TO lv_menge DECIMALS 2.
    WRITE gs_data-budat TO lv_budat.

    CONCATENATE gs_data-mblnr gs_data-mjahr lv_budat
                gs_data-matnr gs_data-werks lv_menge
      INTO gv_line SEPARATED BY lv_sep.

    APPEND gv_line TO gt_excel.

  ENDLOOP.

ENDFORM.

FORM download_excel.

  DATA: lv_filename TYPE string,
        lv_path     TYPE string,
        lv_fullpath TYPE string.

  CALL METHOD cl_gui_frontend_services=>file_save_dialog
    EXPORTING
      default_extension = 'csv'
      default_file_name = 'ALV_Report'
    CHANGING
      filename          = lv_filename
      path              = lv_path
      fullpath          = lv_fullpath.

  IF lv_fullpath IS INITIAL.
    MESSAGE 'Download Cancelled' TYPE 'I'.
    EXIT.
  ENDIF.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename              = lv_fullpath
      filetype              = 'ASC'
      write_field_separator = 'X'
    TABLES
      data_tab              = gt_excel.

  MESSAGE 'Excel downloaded successfully' TYPE 'S'.

ENDFORM.
