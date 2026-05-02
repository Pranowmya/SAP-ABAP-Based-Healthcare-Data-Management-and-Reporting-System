REPORT Z_MP_ME2M_03.

PARAMETERS: p_matnr TYPE ekpo-matnr,
            p_werks TYPE ekpo-werks.

START-OF-SELECTION.

  SUBMIT rm06em00
  WITH matnr = p_matnr
  WITH werks = p_werks
  AND RETURN.
