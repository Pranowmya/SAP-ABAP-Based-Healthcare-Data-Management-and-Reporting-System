*&---------------------------------------------------------------------*
*& Report  ZMP_02_SF
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zmp_02_sf.

DATA: lv_name TYPE rs38l_fnam.

DATA: it_kna1 TYPE TABLE OF zsf_str_kna1,
      wa_kna1 TYPE zsf_str_kna1,
      wa_bp   TYPE zsf_str_bp.

PARAMETERS: p_kunnr TYPE kna1-kunnr.

SELECT kunnr
       name1
       ort01
       land1
FROM kna1
INTO TABLE it_kna1
WHERE kunnr = p_kunnr.

SELECT SINGLE partner
              type
              bu_group
              name_org1
              crdat
FROM but000
INTO wa_bp
WHERE partner = p_kunnr.


CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname           = 'ZMP_02_SF'
*   VARIANT            = ' '
*   DIRECT_CALL        = ' '
  IMPORTING
    fm_name            = lv_name
  EXCEPTIONS
    no_form            = 1
    no_function_module = 2
    OTHERS             = 3.
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

CALL FUNCTION lv_name               "   '/1BCDWB/SF00000962'
  EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
*   CONTROL_PARAMETERS         =
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
*   OUTPUT_OPTIONS             =
*   USER_SETTINGS              = 'X'
    wa_bp                      = wa_bp
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
  tables
    it_kna1                    = it_kna1
 EXCEPTIONS
   FORMATTING_ERROR           = 1
   INTERNAL_ERROR             = 2
   SEND_ERROR                 = 3
   USER_CANCELED              = 4
   OTHERS                     = 5
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.
