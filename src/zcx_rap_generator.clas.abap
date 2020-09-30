CLASS zcx_rap_generator DEFINITION
  PUBLIC
  INHERITING FROM cx_xco_runtime_exception
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*    INTERFACES if_t100_dyn_msg .
*    INTERFACES if_t100_message .

    CONSTANTS:

      gc_msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',


      BEGIN OF is_no_child_nor_grandchild,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE 'MV_ROOT_ENTITY',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF is_no_child_nor_grandchild,
      BEGIN OF non_alpha_numeric_characters,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF non_alpha_numeric_characters,
      BEGIN OF contains_spaces,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF contains_spaces,
      BEGIN OF is_too_long,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE 'MV_MAX_LENGTH',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF is_too_long,
      BEGIN OF node_is_not_consistent,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF node_is_not_consistent,
      BEGIN OF entity_name_is_not_unique,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF entity_name_is_not_unique,
      BEGIN OF implementation_type_not_valid,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF implementation_type_not_valid,
      BEGIN OF no_namespace_set,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_namespace_set,
      BEGIN OF node_is_not_finalized,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF node_is_not_finalized,
      BEGIN OF is_not_a_root_node,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF is_not_a_root_node,
      BEGIN OF sematic_key_is_not_in_table,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE 'MV_SEMANTIC_KEY_FIELD',
        attr2 TYPE scx_attrname VALUE 'MV_TABLE_NAME',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF sematic_key_is_not_in_table,
      BEGIN OF repository_already_exists,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '011',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF repository_already_exists,
      BEGIN OF cannot_check_object_type,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '012',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF cannot_check_object_type,
      BEGIN OF parameter_is_initial,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '013',
        attr1 TYPE scx_attrname VALUE 'MV_PARAMETER_NAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF parameter_is_initial,
      BEGIN OF package_does_not_exist,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '014',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF package_does_not_exist,
      BEGIN OF table_does_not_exist,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '015',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF table_does_not_exist,
      BEGIN OF root_cause_exception,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '016',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF root_cause_exception,
      BEGIN OF field_uuid_missing,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '017',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF field_uuid_missing,
      BEGIN OF field_parent_uuid_missing,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '018',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF FIELD_parent_UUID_MISSING,
      BEGIN OF field_root_uuid_missing,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '019',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF FIELD_root_UUID_MISSING,
      BEGIN OF no_table_set,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '020',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF NO_table_SET,
      BEGIN OF no_semantic_key_set,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '021',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_semantic_key_set,
      BEGIN OF object_name_is_not_unique,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '022',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF object_name_is_not_unique,
      BEGIN OF software_comp_do_not_match,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '023',
        attr1 TYPE scx_attrname VALUE 'MV_TABLE_NAME',
        attr2 TYPE scx_attrname VALUE 'MV_PACKAGE_NAME',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF software_comp_do_not_match,
      BEGIN OF cds_view_does_not_exist,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '024',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF cds_view_does_not_exist,
      BEGIN OF starts_not_with_underscore,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '025',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF starts_not_with_underscore,
      BEGIN OF assocation_is_not_supported,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '026',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF assocation_is_not_supported,
      BEGIN OF not_a_field_in_cds_view,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '027',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_a_field_in_cds_view,
      BEGIN OF usage_is_not_supported,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '028',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF usage_is_not_supported,
      BEGIN OF invalid_json_array_name,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '029',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_json_array_name,
      BEGIN OF invalid_json_object_name,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '030',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_json_object_name,
      BEGIN OF invalid_json_property_name,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '031',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_json_property_name,
      BEGIN OF field_is_not_in_datasource,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '032',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE 'MV_TABLE_NAME',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF field_is_not_in_datasource,
      BEGIN OF field_is_not_in_cds_view,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '033',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF field_is_not_in_cds_view,

      BEGIN OF no_object_id_set,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '034',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_object_id_set,
      BEGIN OF invalid_data_source_type,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '035',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_data_source_type,
      BEGIN OF no_data_source_set,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '036',
        attr1 TYPE scx_attrname VALUE 'MV_ENTITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_data_source_set,
      BEGIN OF invalid_namespace,
        msgid TYPE symsgid VALUE 'ZCM_RAP_GENERATOR',
        msgno TYPE symsgno VALUE '037',
        attr1 TYPE scx_attrname VALUE 'MV_VALUE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_namespace
      .



    DATA mv_entity  TYPE sxco_ddef_alias_name.
    DATA mv_root_entity  TYPE sxco_ddef_alias_name.
    DATA mv_value TYPE string.
    DATA mv_max_length TYPE i.
    DATA mv_parameter_name TYPE string.
    DATA mv_semantic_key_field TYPE string.
    DATA mv_table_name TYPE string.
    DATA mv_package_name TYPE string.

    CLASS-METHODS class_constructor .
    METHODS constructor
      IMPORTING
        !textid                LIKE if_t100_message=>t100key OPTIONAL
        !previous              LIKE previous OPTIONAL
        !mv_entity             TYPE sxco_ddef_alias_name OPTIONAL
        !mv_root_entity        TYPE sxco_ddef_alias_name OPTIONAL
        !mv_value              TYPE string OPTIONAL
        !mv_max_length         TYPE i OPTIONAL
        !mv_parameter_name     TYPE string OPTIONAL
        !mv_semantic_key_field TYPE string OPTIONAL
        !mv_table_name         TYPE string OPTIONAL
        !mv_package_name       TYPE string OPTIONAL .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_rap_generator IMPLEMENTATION.


  METHOD class_constructor.
  ENDMETHOD.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->mv_entity = mv_entity.
    me->mv_root_entity = mv_root_entity.
    me->mv_value = mv_value.
    me->mv_max_length = mv_max_length.
    me->mv_parameter_name = mv_parameter_name.
    me->mv_semantic_key_field = mv_semantic_key_field.
    me->mv_table_name  =       mv_table_name.
    me->mv_package_name = mv_package_name.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
