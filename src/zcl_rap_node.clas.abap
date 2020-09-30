CLASS zcl_rap_node DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      "the RAP generator only supports certain combinations of implementation type and key type
      BEGIN OF implementation_type,
        managed_uuid      TYPE string VALUE 'managed_uuid',
        managed_semantic  TYPE string VALUE 'managed_semantic',
        unmanged_semantic TYPE string VALUE 'unmanaged_semantic',
      END OF implementation_type,

      BEGIN OF data_source_types,
        table    TYPE string VALUE 'table',
        cds_view TYPE string VALUE 'cds_view',
      END OF data_source_types,

      BEGIN OF cardinality,
        zero_to_one TYPE string VALUE 'zero_to_one',
        one         TYPE string VALUE 'one',
        zero_to_n   TYPE string VALUE 'zero_to_n',
        one_to_n    TYPE string VALUE 'one_to_n',
        one_to_one  TYPE string VALUE 'one_to_one',
      END OF cardinality,

      BEGIN OF additionalBinding_usage,
        filter            TYPE string VALUE 'FILTER',
        filter_and_result TYPE string VALUE 'FILTER_AND_RESULT',
        result            TYPE string VALUE 'RESULT',
      END OF additionalBinding_usage.


    TYPES:
      BEGIN OF root_cause_textid,
        msgid TYPE symsgid,
        msgno TYPE symsgno,
        attr1 TYPE scx_attrname,
        attr2 TYPE scx_attrname,
        attr3 TYPE scx_attrname,
        attr4 TYPE scx_attrname,
      END OF root_cause_textid.


    TYPES:
      BEGIN OF ts_field_name,
        client                         TYPE string,
        uuid                           TYPE string,
        parent_uuid                    TYPE string,
        root_uuid                      TYPE string,
        created_by                     TYPE string,
        created_at                     TYPE string,
        last_changed_by                TYPE string,
        last_changed_at                TYPE string,
        local_instance_last_changed_at TYPE string,
      END OF ts_field_name.

    TYPES :  tt_childnodes TYPE STANDARD TABLE OF REF TO zcl_rap_node WITH EMPTY KEY.
    TYPES :  ty_childnode TYPE REF TO zcl_rap_node.

    TYPES :  tt_semantic_key_fields TYPE TABLE OF sxco_ad_field_name.
    TYPES :
      BEGIN OF ts_semantic_key,
        name           TYPE sxco_ad_field_name,
        cds_view_field TYPE sxco_ad_field_name,
      END OF ts_semantic_key.
    TYPES    : tt_semantic_key TYPE TABLE OF  ts_semantic_key.

    TYPES:
      BEGIN OF ts_field,
        name               TYPE sxco_ad_object_name,
        doma               TYPE sxco_ad_object_name,
        key_indicator      TYPE abap_bool,
        not_null           TYPE abap_bool,
        domain_fixed_value TYPE abap_bool,
        cds_view_field     TYPE sxco_cds_field_name,
        has_association    TYPE abap_bool,
        has_valuehelp      TYPE abap_bool,
        currencyCode       TYPE sxco_cds_field_name,
        unitOfMeasure      TYPE sxco_cds_field_name,
        is_data_element    TYPE abap_bool,
        is_built_in_type   TYPE abap_bool,
      END OF ts_field.

    TYPES : tt_fields TYPE STANDARD TABLE OF ts_field WITH EMPTY KEY.

    TYPES:
      BEGIN OF ts_node_objects,
        cds_view_i              TYPE sxco_cds_object_name,
        ddic_view_i             TYPE sxco_dbt_object_name,
        cds_view_p              TYPE sxco_cds_object_name,
        meta_data_extension     TYPE sxco_cds_object_name,
        alias                   TYPE sxco_ddef_alias_name,
        behavior_implementation TYPE sxco_ao_object_name,
        control_structure       TYPE sxco_ad_object_name,
      END OF ts_node_objects.

    TYPES:
      BEGIN OF ts_root_node_objects,
        behavior_definition_i TYPE sxco_cds_object_name,
        behavior_definition_p TYPE sxco_cds_object_name,
        service_definition    TYPE sxco_ao_object_name,
        service_binding       TYPE sxco_ao_object_name,
      END OF ts_root_node_objects.

    TYPES:
      BEGIN OF ts_condition_fields,
        projection_field  TYPE sxco_cds_field_name,
        association_field TYPE sxco_cds_field_name,
      END OF ts_condition_fields,


      tt_condition_fields TYPE STANDARD TABLE OF ts_condition_fields WITH EMPTY KEY,

      BEGIN OF ts_assocation,
        name                 TYPE sxco_ddef_alias_name,
        target               TYPE sxco_cds_object_name,
        condition_components TYPE tt_condition_fields,
        cardinality          TYPE string,
      END OF ts_assocation,

      tt_assocation TYPE STANDARD TABLE OF ts_assocation,

      BEGIN OF ts_additionalBinding,
        localElement TYPE sxco_cds_field_name,
        element      TYPE sxco_cds_field_name,
        usage        TYPE string,
      END OF ts_additionalBinding,

      tt_addtionalBinding TYPE STANDARD TABLE OF ts_additionalbinding WITH DEFAULT KEY,

      BEGIN OF ts_valuehelp,
        name              TYPE sxco_cds_object_name,
        alias             TYPE sxco_ddef_alias_name,
        localElement      TYPE sxco_cds_field_name,
        element           TYPE sxco_cds_field_name,
        additionalBinding TYPE tt_addtionalbinding,
      END OF ts_valuehelp,

      tt_valuehelp TYPE STANDARD TABLE OF ts_valuehelp WITH DEFAULT KEY.

    DATA xco_lib TYPE REF TO zcl_rap_xco_lib.
    DATA data_source_type    TYPE string READ-ONLY.
    DATA lt_valuehelp TYPE tt_valuehelp READ-ONLY.
    DATA lt_messages TYPE TABLE OF string READ-ONLY.
    DATA field_name TYPE ts_field_name READ-ONLY.
    DATA lt_association TYPE tt_assocation READ-ONLY.
    DATA rap_node_objects TYPE ts_node_objects READ-ONLY.
    DATA rap_root_node_objects TYPE ts_root_node_objects READ-ONLY.
    DATA lt_fields TYPE STANDARD TABLE OF ts_field WITH DEFAULT KEY READ-ONLY.
    DATA lt_fields_persistent_table TYPE STANDARD TABLE OF ts_field WITH DEFAULT KEY READ-ONLY.
    DATA table_name          TYPE sxco_dbt_object_name READ-ONLY.
    DATA semantic_key TYPE tt_semantic_key.
    DATA suffix              TYPE string READ-ONLY.
    DATA prefix              TYPE string READ-ONLY.
    DATA namespace           TYPE string READ-ONLY.
    DATA entityname          TYPE sxco_ddef_alias_name READ-ONLY.
    DATA node_number         TYPE i READ-ONLY.
    DATA object_id           TYPE sxco_ad_field_name READ-ONLY.
    DATA object_id_cds_field_name TYPE sxco_ad_field_name READ-ONLY.
    DATA all_childnodes TYPE STANDARD TABLE OF REF TO zcl_rap_node READ-ONLY.
    DATA childnodes TYPE STANDARD TABLE OF REF TO zcl_rap_node READ-ONLY.
    DATA root_node TYPE REF TO zcl_rap_node READ-ONLY.
    DATA parent_node TYPE REF TO zcl_rap_node READ-ONLY.
    DATA is_finalized           TYPE abap_bool READ-ONLY .
    DATA package          TYPE sxco_package READ-ONLY.
    DATA lt_mapping TYPE HASHED TABLE OF  if_xco_gen_bdef_s_fo_b_mapping=>ts_field_mapping
                                  WITH UNIQUE KEY cds_view_field dbtable_field.
    DATA ls_mapping TYPE if_xco_gen_bdef_s_fo_b_mapping=>ts_field_mapping  .
    DATA transactional_behavior TYPE abap_bool READ-ONLY.
    DATA publish_service            TYPE abap_bool READ-ONLY.
    DATA cds_view_name TYPE string READ-ONLY.
    DATA data_source_name TYPE string READ-ONLY.
    DATA persistent_table_name TYPE string READ-ONLY.

    " DATA rap_generator_xco_lib TYPE REF TO zif_rap_generator_xco_lib.

    METHODS constructor
      RAISING zcx_rap_generator.

*    METHODS set_rap_generator_xco_lib
*      IMPORTING
*        iv_rap_generator_xco_lib TYPE zif_rap_generator_xco_lib.

    METHODS set_xco_lib
      IMPORTING io_xco_lib TYPE REF TO zcl_rap_xco_lib
      RAISING   zcx_rap_generator.
    METHODS add_transactional_behavior
      IMPORTING iv_value TYPE abap_bool .
    METHODS  set_publish_service
      IMPORTING iv_value TYPE abap_bool .

    METHODS add_to_all_childnodes
      IMPORTING VALUE(io_child_node) TYPE REF TO zcl_rap_node.

    METHODS set_mapping
      IMPORTING it_field_mappings TYPE if_xco_gen_bdef_s_fo_b_mapping=>tt_field_mapping OPTIONAL
      RAISING   zcx_rap_generator.

    METHODS set_package
      IMPORTING VALUE(iv_package) TYPE sxco_package
      RAISING   zcx_rap_generator.

    METHODS set_entity_name
      IMPORTING VALUE(iv_entity_name) TYPE sxco_ddef_alias_name
      RAISING   zcx_rap_generator.

    METHODS get_implementation_type
      RETURNING VALUE(rv_implementation_type) TYPE string.

    METHODS get_root_exception
      IMPORTING
        !ix_exception  TYPE REF TO cx_root
      RETURNING
        VALUE(rx_root) TYPE REF TO cx_root .

    METHODS get_root_cause_textid
      IMPORTING
                ix_previous                 TYPE REF TO cx_root
      RETURNING VALUE(rs_root_cause_textid) TYPE root_cause_textid.

    METHODS set_implementation_type
      IMPORTING
                VALUE(iv_implementation_type) TYPE string
      RAISING   zcx_rap_generator.



    METHODS add_child
      RETURNING VALUE(ro_child_node)
                  TYPE REF TO zcl_rap_node
      RAISING   zcx_rap_generator.

    METHODS check_repository_object_name
      IMPORTING
                iv_type TYPE sxco_ar_object_type
                iv_name TYPE string
      RAISING   zcx_rap_generator.

    METHODS check_parameter
      IMPORTING
                iv_parameter_name TYPE string
                iv_value          TYPE string
      RAISING   zcx_rap_generator.

    METHODS finalize
      RAISING zcx_rap_generator.

    METHODS validate_bo
      RAISING zcx_rap_generator.

    METHODS get_fields
      RAISING zcx_rap_generator.

    METHODS get_fields_persistent_table
      RAISING zcx_rap_generator.

    METHODS set_namespace
      IMPORTING
                iv_namespace TYPE sxco_ar_object_name
      RAISING   zcx_rap_generator.

    METHODS set_prefix
      IMPORTING
                iv_prefix TYPE    sxco_ar_object_name
      RAISING   zcx_rap_generator.

    METHODS set_suffix
      IMPORTING
                iv_suffix TYPE    sxco_ar_object_name
      RAISING   zcx_rap_generator.

    METHODS set_parent
      IMPORTING
                io_parent_node TYPE REF TO zcl_rap_node
      RAISING   zcx_rap_generator.

    METHODS set_root
      IMPORTING
                io_root_node TYPE REF TO zcl_rap_node
      RAISING   zcx_rap_generator.

    METHODS is_root RETURNING VALUE(rv_is_root) TYPE abap_bool.

    METHODS is_child RETURNING VALUE(rv_is_child) TYPE abap_bool.

    METHODS is_grand_child_or_deeper RETURNING VALUE(rv_is_grand_child) TYPE abap_bool.

    METHODS set_table
      IMPORTING
                iv_table TYPE sxco_ar_object_name
      RAISING   zcx_rap_generator.

    METHODS set_cds_view
      IMPORTING
                iv_cds_view TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_data_source
      IMPORTING
                iv_data_source TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_persistent_table
      IMPORTING
                iv_persistent_table TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_data_source_type
      IMPORTING
                iv_data_source_type TYPE string
      RAISING   zcx_rap_generator.

    METHODS has_childs
      RETURNING VALUE(rv_has_childs) TYPE abap_bool.

    METHODS set_semantic_key_fields
      IMPORTING it_semantic_key TYPE tt_semantic_key_fields
      RAISING   zcx_rap_generator.

    METHODS set_cds_view_i_name
      RETURNING VALUE(rv_cds_i_view_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_cds_view_p_name
      RETURNING VALUE(rv_cds_p_view_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_mde_name
      RETURNING VALUE(rv_mde_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_ddic_view_i_name
      RETURNING VALUE(rv_ddic_i_view_name) TYPE sxco_dbt_object_name
      RAISING   zcx_rap_generator.

    METHODS set_behavior_impl_name
      RETURNING VALUE(rv_behavior_imp_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_behavior_def_i_name
      RETURNING VALUE(rv_behavior_dev_i_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_behavior_def_p_name
      RETURNING VALUE(rv_behavior_dev_p_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_service_definition_name
      RETURNING VALUE(rv_service_definition_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_service_binding_name
      RETURNING VALUE(rv_service_binding_name) TYPE sxco_cds_object_name
      RAISING   zcx_rap_generator.

    METHODS set_control_structure_name
      RETURNING VALUE(rv_controle_structure_name) TYPE sxco_dbt_object_name
      RAISING   zcx_rap_generator.

    METHODS is_alpha_numeric
      IMPORTING iv_string                  TYPE string
      RETURNING VALUE(rv_is_alpha_numeric) TYPE abap_bool.

    METHODS contains_no_blanks
      IMPORTING iv_string                    TYPE string
      RETURNING VALUE(rv_contains_no_blanks) TYPE abap_bool.

    METHODS is_consistent
      RETURNING VALUE(rv_is_consistent) TYPE abap_bool.

    METHODS set_field_name_uuid
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_field_name_parent_uuid
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_field_name_root_uuid
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_field_name_created_by
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_field_name_created_at
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_field_name_last_changed_by
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.

    METHODS set_field_name_last_changed_at
      IMPORTING iv_string TYPE string
      RAISING   zcx_rap_generator.


    METHODS add_association
      IMPORTING
        iv_name             TYPE sxco_ddef_alias_name
        iv_target           TYPE sxco_cds_object_name
        it_condition_fields TYPE tt_condition_fields
        iv_cardinality      TYPE string
      RAISING
        zcx_rap_generator.


    METHODS add_valuehelp
      IMPORTING
        "alias used in service definition
        iv_alias              TYPE sxco_ddef_alias_name
        "name of CDS view used as value help
        iv_name               TYPE sxco_cds_object_name
        iv_localElement       TYPE sxco_cds_field_name
        iv_element            TYPE sxco_cds_field_name
        it_additional_Binding TYPE tt_addtionalbinding OPTIONAL
      RAISING
        zcx_rap_generator.


    METHODS set_is_root_node.

    METHODS set_object_id
      IMPORTING
        iv_object_id TYPE sxco_ad_field_name
      RAISING
        zcx_rap_generator.

  PROTECTED SECTION.

    DATA is_test_run TYPE abap_bool.
    DATA implementationtype  TYPE string.
    DATA is_root_node        TYPE abap_bool.
    DATA is_child_node       TYPE abap_bool.
    DATA is_grand_child_node TYPE abap_bool.
    DATA bo_node_is_consistent  TYPE abap_bool.
    DATA keytype             TYPE string.

    METHODS right_string
      IMPORTING
                iv_length        TYPE i
                iv_string        TYPE string
      RETURNING VALUE(rv_string) TYPE string.

    METHODS set_number
      IMPORTING
                iv_number TYPE i
      RAISING   cx_parameter_invalid.


    METHODS field_name_exists_in_cds_view
      IMPORTING
                iv_field_name               TYPE string
      RETURNING VALUE(rv_field_name_exists) TYPE abap_bool.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_rap_node IMPLEMENTATION.

  METHOD set_data_source_type.

    CASE iv_data_source_type.

      WHEN 'table'.
        data_source_type = data_source_types-table.
      WHEN 'cds_view'.
        data_source_type = data_source_types-cds_view.
      WHEN OTHERS.

        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>invalid_data_source_type
            mv_value = iv_data_source_type.

    ENDCASE.

  ENDMETHOD.


  METHOD set_ddic_view_i_name.

    "lv_name will be shortened to 16 characters
    DATA lv_name TYPE string.
    DATA lv_entityname TYPE sxco_ddef_alias_name.

    DATA(lv_mandatory_name_components) =  to_upper( namespace ) &&  to_upper( prefix )  && to_upper( suffix  ).
    DATA(max_length_mandatory_name_comp) = 10.
    DATA(length_mandatory_name_comp) = strlen( lv_mandatory_name_components ).
    DATA(remaining_num_characters) = 16 - length_mandatory_name_comp.

    IF length_mandatory_name_comp > max_length_mandatory_name_comp.
      APPEND |{ lv_mandatory_name_components } mandatory components are too long more than { max_length_mandatory_name_comp } characters| TO lt_messages.
      bo_node_is_consistent = abap_false.
    ENDIF.

    DATA(lv_node_number_as_hex) = CONV xstring( node_number ).

    IF strlen( entityname ) > remaining_num_characters - 2.
      lv_entityname = substring( val = entityname len = remaining_num_characters - 2 ).
    ELSE.
      lv_entityname = entityname.
    ENDIF.

    lv_name =  to_upper( namespace ) &&  to_upper( prefix )  && to_upper( lv_entityname ) && lv_node_number_as_hex && to_upper( suffix  ).

    "check if name already exists within the BO
    TEST-SEAM is_not_a_root_node.
      LOOP AT me->root_node->all_childnodes INTO DATA(lo_bo_node).
        IF lo_bo_node->rap_node_objects-ddic_view_i = lv_name.
          APPEND |Name of DDIC view { lv_name } for CDS interface view is not unique in this BO. Check { lo_bo_node->entityname }  and { me->entityname } | TO lt_messages.
          bo_node_is_consistent = abap_false.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid   = zcx_rap_generator=>object_name_is_not_unique
              mv_value = |DDIC view: { lv_name }|.
        ENDIF.
      ENDLOOP.
    END-TEST-SEAM.

    check_repository_object_name(
     EXPORTING
       iv_type = 'TABL'
       iv_name = lv_name
   ).

    rap_node_objects-ddic_view_i = lv_name.

    rv_ddic_i_view_name = lv_name.

  ENDMETHOD.


  METHOD set_entity_name.

    DATA lt_all_childnodes  TYPE STANDARD TABLE OF REF TO zcl_rap_node .

    check_parameter(
          EXPORTING
            iv_parameter_name = 'Entity'
            iv_value          = CONV #( iv_entity_name )
        ).

    IF me->root_node IS NOT INITIAL.

      lt_all_childnodes = me->root_node->all_childnodes.

      LOOP AT lt_all_childnodes INTO DATA(ls_childnode).
        IF ls_childnode->entityname = iv_entity_name.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid    = zcx_rap_generator=>entity_name_is_not_unique
              mv_entity = ls_childnode->entityname.
        ENDIF.
      ENDLOOP.

    ENDIF.

    entityname = iv_entity_name .
    rap_node_objects-alias = entityname.

  ENDMETHOD.


  METHOD set_field_name_created_at.
    check_parameter(
      EXPORTING
        iv_parameter_name = 'field_name-created_at'
        iv_value          = iv_string
    ).
    field_name-created_at = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_field_name_created_by.
    check_parameter(
      EXPORTING
        iv_parameter_name = 'field_name-created_by'
        iv_value          = iv_string
    ).
    field_name-created_by = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_field_name_last_changed_at.
    check_parameter(
      EXPORTING
        iv_parameter_name = 'field_name-last_changed_at'
        iv_value          = iv_string
    ).
    field_name-last_changed_at = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_field_name_last_changed_by.
    check_parameter(
      EXPORTING
        iv_parameter_name = 'field_name-last_changed_by'
        iv_value          = iv_string
    ).
    field_name-last_changed_by = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_field_name_parent_uuid.
    check_parameter(
      EXPORTING
        iv_parameter_name = 'field_name-parent_uuid'
        iv_value          = iv_string
    ).
    field_name-parent_uuid = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_field_name_root_uuid.
    check_parameter(
      EXPORTING
        iv_parameter_name = 'field_name-root_uuid'
        iv_value          = iv_string
    ).
    field_name-root_uuid = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_field_name_uuid.
    check_parameter(
          EXPORTING
            iv_parameter_name = 'field_name-uuid'
            iv_value          = iv_string
        ).
    field_name-uuid = to_upper( iv_string ).
  ENDMETHOD.


  METHOD set_implementation_type.

    CASE iv_implementation_type.

      WHEN implementation_type-managed_uuid.
        implementationtype = implementation_type-managed_uuid.
      WHEN implementation_type-managed_semantic.
        implementationtype = implementation_type-managed_semantic.
      WHEN implementation_type-unmanged_semantic.
        implementationtype = implementation_type-unmanged_semantic.
      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>implementation_type_not_valid
            mv_value = iv_implementation_type.
    ENDCASE.

  ENDMETHOD.


  METHOD set_is_root_node.
    is_root_node = abap_true.
    set_root( me ).
    set_parent( me ).
  ENDMETHOD.


  METHOD set_mapping.
    "an automatic mapping can only be calculated if the data source is a table
    IF it_field_mappings IS INITIAL AND data_source_type = data_source_types-table.
      LOOP AT lt_fields INTO  DATA(ls_fields).
        ls_mapping-dbtable_field =  ls_fields-name .
        ls_mapping-cds_view_field =  ls_fields-cds_view_field .
        IF  ls_fields-name  <> field_name-client.
          INSERT ls_mapping INTO TABLE lt_mapping.
        ENDIF.
      ENDLOOP.
    ELSE.

      LOOP AT it_field_mappings INTO DATA(ls_field_mapping).
        ls_mapping-dbtable_field = ls_field_mapping-dbtable_field.
        ls_mapping-cds_view_field =  ls_field_mapping-cds_view_field .
        IF  ls_fields-name  <> field_name-client.
          INSERT ls_mapping INTO TABLE lt_mapping.
        ENDIF.
      ENDLOOP.

    ENDIF.
  ENDMETHOD.


  METHOD set_mde_name.

    DATA(lv_name) = |{ namespace }C_{ prefix }{ entityname }{ suffix }|.

    IF lv_name IS INITIAL.
      APPEND | Projection view name is still initial | TO lt_messages.
      bo_node_is_consistent = abap_false.
    ENDIF.

    check_repository_object_name(
       EXPORTING
         iv_type = 'DDLX'
         iv_name = lv_name
     ).

    rap_node_objects-meta_data_extension = lv_name.

    rv_mde_name  = lv_name.

  ENDMETHOD.


  METHOD set_namespace.

    DATA(number_of_characters) = strlen( iv_namespace ).
    DATA(first_character) = substring( val = iv_namespace  len = 1 ).
    DATA(last_character) =  substring( val = iv_namespace off = number_of_characters - 1  len = 1 ).

    IF to_upper( first_character ) = 'Z' OR
       to_upper( first_character ) = 'Y'.
      check_parameter(
        EXPORTING
           iv_parameter_name = 'Namespace'
           iv_value          = CONV #( iv_namespace )
        ).


    ELSEIF first_character = '/' AND last_character = '/'.

      DATA(remaining_characters) = substring( val = iv_namespace off = 1  len = number_of_characters - 2 ).

      check_parameter(
        EXPORTING
           iv_parameter_name = 'Namespace without slashes'
           iv_value          = CONV #( remaining_characters )
        ).

    ELSE.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>invalid_namespace
          mv_value = |iv_namespace|.
    ENDIF.

    namespace = iv_namespace.

  ENDMETHOD.


  METHOD set_number.
    node_number = iv_number.
  ENDMETHOD.


  METHOD set_object_id.

    check_parameter(
          EXPORTING
             iv_parameter_name = 'ObjectId'
             iv_value          = CONV #( iv_object_id )
          ).

    object_id = to_upper( iv_object_id ).

  ENDMETHOD.


  METHOD set_package.

    check_parameter(
            EXPORTING
              iv_parameter_name = 'package'
              iv_value          = CONV #( iv_package )
          ).
    IF xco_lib->get_package( iv_package )->exists(  ).
      "IF xco_cp_abap_repository=>object->devc->for( iv_package )->exists( ).
      package = iv_package.
      "temporary fix since
      package = to_upper( package ).
    ELSE.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>package_does_not_exist
          mv_value = CONV #( iv_package ).
    ENDIF.

  ENDMETHOD.


  METHOD set_parent.
    IF io_parent_node IS NOT INITIAL.
      parent_node = io_parent_node.
    ELSE.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid            = zcx_rap_generator=>parameter_is_initial
          mv_parameter_name = 'Parent node'.
    ENDIF.
  ENDMETHOD.


  METHOD set_prefix.
    check_parameter(
      EXPORTING
         iv_parameter_name = 'Prefix'
         iv_value          = CONV #( iv_prefix )
      ).
    prefix = iv_prefix.
  ENDMETHOD.


  METHOD set_publish_service.
    publish_service = iv_value.
  ENDMETHOD.


  METHOD set_root.
    IF  io_root_node IS INITIAL.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid            = zcx_rap_generator=>parameter_is_initial
          mv_parameter_name = 'Parent node'.
    ENDIF.
    IF me <> io_root_node.
      root_node = io_root_node.
    ELSE.

      IF me->is_root(  ) .
        root_node = io_root_node.
      ELSE.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid    = zcx_rap_generator=>is_not_a_root_node
            mv_entity = io_root_node->entityname.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD set_semantic_key_fields.
    DATA ls_semantic_key TYPE ts_semantic_key.
    IF it_semantic_key IS INITIAL.

      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid            = zcx_rap_generator=>parameter_is_initial
          mv_parameter_name = 'Semantic key field(s)'.

    ELSE.

      LOOP AT it_semantic_key INTO DATA(ls_semantic_key_field).

        "the cds view field name will be retrieved in the
        "finalize method because it can not
        "be assumed that at this point that set_datasource
        "has already been called.
        "This is because JSON files are used as input where the order of items
        "can be arbitrary
        "Hence the order of the methods for setting the values cannot be enforced
        "the semantic key field is  data base field. The name has to be converted
        "to uppercase since otherwise checks for field names will fail

        ls_semantic_key-name = to_upper( ls_semantic_key_field ).
        APPEND ls_semantic_key TO semantic_key.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD set_service_binding_name.

    " From SAP Online Help
    " Use the prefix
    " UI_ if the service is exposed as a UI service.
    " API_ if the service is exposed as Web API.
    " Use the suffix
    " _O2 if the service is bound to OData protocol version 2.
    " _O4 if the service is bound to OData protocol version 4.
    " Example: /DMO/UI_TRAVEL_U_O2

    DATA(lv_name) =  |{ namespace }UI_{ prefix }{ entityname }{ suffix }_02|.

    IF rap_root_node_objects-service_definition IS INITIAL.
      APPEND | service binding name is still initial | TO lt_messages.
      bo_node_is_consistent = abap_false.
    ENDIF.

    check_repository_object_name(
       EXPORTING
         iv_type = 'SRVB'
         iv_name = lv_name
     ).


    IF is_root( ).
      rap_root_node_objects-service_binding = lv_name.
      rv_service_binding_name = lv_name.
    ELSEIF is_test_run = abap_true.
      rap_root_node_objects-service_binding = lv_name.
      rv_service_binding_name = lv_name.
    ELSE.
      APPEND | { me->entityname } is not a root node. Service binding can only be created for the root node| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid    = zcx_rap_generator=>is_not_a_root_node
          mv_entity = me->entityname.
    ENDIF.

  ENDMETHOD.


  METHOD set_service_definition_name.

    " Since a service definition - as a part of a business service - does not have different types or different specifications, there is (in general) no need for a prefix or suffix to differentiate meaning.
    " Example: /DMO/TRAVEL_U
    " However, in use cases where no reuse of the same service definition is planned for UI and API services, the prefix may follow the rules of the service binding.
    " Example: /DMO/UI_TRAVEL_U

    DATA(lv_name) =  |{ namespace }UI_{ prefix }{ entityname }{ suffix }|.

    check_repository_object_name(
          EXPORTING
            iv_type = 'SRVD'
            iv_name = lv_name
        ).


    IF is_root( ).
      rap_root_node_objects-service_definition = lv_name.
      rv_service_definition_name = lv_name.
    ELSEIF is_test_run = abap_true.
      rap_root_node_objects-service_definition = lv_name.
      rv_service_definition_name = lv_name.
    ELSE.
      APPEND | { me->entityname } is not a root node. Service defintion can only be created for the root node| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid    = zcx_rap_generator=>is_not_a_root_node
          mv_entity = me->entityname.
    ENDIF.



  ENDMETHOD.


  METHOD set_suffix.

    check_parameter(
      EXPORTING
         iv_parameter_name = 'Prefix'
         iv_value          = CONV #( iv_suffix )
      ).

    suffix = iv_suffix.

  ENDMETHOD.


  METHOD set_table.

    DATA(lv_table) = to_upper( iv_table ) .

    TEST-SEAM omit_table_existence_check.

      "check if table exists
      IF xco_lib->get_database_table( CONV #( lv_table ) )->exists( ) = abap_false.
        "IF xco_cp_abap_repository=>object->for( iv_type = CONV #( 'TABL' ) iv_name = CONV #( lv_table ) )->exists( ) = abap_false.
        APPEND | Table { lv_table } does not exist| TO lt_messages.
        bo_node_is_consistent = abap_false.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>table_does_not_exist
            mv_value = CONV #( lv_table ).
      ENDIF.

    END-TEST-SEAM.

    table_name = iv_table.

    set_persistent_table( CONV #( iv_table ) ).

    get_fields(  ).




  ENDMETHOD.


  METHOD validate_bo.

    "validate field names

    IF implementationtype = implementation_type-managed_uuid.

      SELECT name FROM @lt_fields AS fields WHERE name  = @field_name-uuid INTO TABLE @DATA(result_uuid).

      IF result_uuid IS INITIAL.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>field_uuid_missing
            mv_value = CONV #( field_name-uuid ).
      ENDIF.

      IF is_child( ) OR is_grand_child_or_deeper(  ).

        SELECT name FROM @lt_fields AS fields WHERE name  = @field_name-parent_uuid INTO TABLE @DATA(result_parent_uuid).

        IF result_parent_uuid IS INITIAL.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid   = zcx_rap_generator=>field_parent_uuid_missing
              mv_value = CONV #( field_name-parent_uuid ).
        ENDIF.

      ENDIF.

      IF is_grand_child_or_deeper(  ).

        SELECT name FROM @lt_fields AS fields WHERE name  = @field_name-root_uuid INTO TABLE @DATA(result_root_uuid).

        IF result_root_uuid IS INITIAL.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid   = zcx_rap_generator=>field_root_uuid_missing
              mv_value = CONV #( field_name-root_uuid ).
        ENDIF.

      ENDIF.


    ENDIF.


    "validate value helps

    DATA lv_target TYPE string.
    DATA ls_valuehelp TYPE ts_valuehelp.
    FIELD-SYMBOLS: <fields> TYPE ts_field.

    LOOP AT lt_valuehelp INTO ls_valuehelp.

      lv_target = to_upper( ls_valuehelp-name ).

      SELECT * FROM I_APIsForSAPCloudPlatform WHERE ReleasedObjectType = 'CDS_STOB' AND ReleasedObjectName = @lv_target INTO TABLE @DATA(lt_result)..

      "check if CDS view used as target exists
      IF NOT ( lt_result IS NOT INITIAL OR xco_lib->get_data_definition( CONV #(  lv_target ) )->exists( ) ).
        "IF NOT ( lt_result IS NOT INITIAL OR xco_cp_abap_repository=>object->for( iv_type =  'DDLS'  iv_name = CONV #(  lv_target ) )->exists( ) ).
        APPEND | CDS View {  lv_target  } does not exist | TO lt_messages.
        bo_node_is_consistent = abap_false.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>cds_view_does_not_exist
            mv_value = CONV #( lv_target ).
      ENDIF.

      IF table_name IS INITIAL.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid = zcx_rap_generator=>no_table_set.
      ENDIF.

      IF NOT field_name_exists_in_cds_view( CONV #(  ls_valuehelp-localelement  ) ).
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid    = zcx_rap_generator=>not_a_field_in_cds_view
            mv_value  = CONV #( ls_valuehelp-localelement )
            mv_entity = me->entityname.
      ENDIF.

    ENDLOOP.

    "validate associations

    LOOP AT lt_association INTO DATA(ls_assocation).

      lv_target = to_upper( ls_assocation-target ).

      SELECT * FROM I_APIsForSAPCloudPlatform WHERE ReleasedObjectType = 'CDS_STOB' AND ReleasedObjectName = @lv_target INTO TABLE @lt_result.

      "check if CDS view used as target exists
      IF NOT ( lt_result IS NOT INITIAL OR xco_lib->get_data_definition( CONV #(  lv_target ) )->exists( ) ).
        "IF NOT ( lt_result IS NOT INITIAL OR xco_cp_abap_repository=>object->for( iv_type =  'DDLS'  iv_name = CONV #(  lv_target ) )->exists( ) ).
        APPEND | CDS View {  lv_target  } does not exist | TO lt_messages.
        bo_node_is_consistent = abap_false.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>cds_view_does_not_exist
            mv_value = CONV #( lv_target ).
      ENDIF.


      LOOP AT ls_assocation-condition_components INTO DATA(ls_condition_fields).
        IF NOT field_name_exists_in_cds_view( CONV #( ls_condition_fields-projection_field ) ).
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid    = zcx_rap_generator=>not_a_field_in_cds_view
              mv_value  = CONV #( ls_condition_fields-projection_field )
              mv_entity = me->entityname.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    "validate object id
    IF object_id IS INITIAL.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid    = zcx_rap_generator=>no_object_id_set
          mv_entity = entityname.

    ELSE.
      DATA object_id_upper_case  TYPE sxco_ad_field_name.
      object_id_upper_case = to_upper( object_id ).

      CASE data_source_type.
        WHEN data_source_types-table.
          SELECT SINGLE * FROM @lt_fields AS db_field WHERE name  = @object_id_upper_case INTO @DATA(result).
          IF result IS INITIAL.
            RAISE EXCEPTION TYPE zcx_rap_generator
              EXPORTING
                textid        = zcx_rap_generator=>field_is_not_in_datasource
                mv_value      = CONV #( object_id_upper_case )
                mv_table_name = CONV #( table_name ).
          ENDIF.

        WHEN data_source_types-cds_view.
          SELECT SINGLE * FROM @lt_fields AS db_field WHERE name  = @object_id_upper_case INTO @result.
          IF result IS INITIAL.
            RAISE EXCEPTION TYPE zcx_rap_generator
              EXPORTING
                textid        = zcx_rap_generator=>field_is_not_in_datasource
                mv_value      = CONV #( object_id_upper_case )
                mv_table_name = CONV #( cds_view_name ).
          ENDIF.

        WHEN OTHERS.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid   = zcx_rap_generator=>invalid_data_source_type
              mv_value = data_source_type.
      ENDCASE.

      object_id_cds_field_name = result-cds_view_field.

    ENDIF.

    " validate semantic key fields

    IF implementationtype = implementation_type-unmanged_semantic OR
            implementationtype = implementation_type-managed_semantic.

      IF semantic_key IS INITIAL.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid = zcx_rap_generator=>no_semantic_key_set.
      ENDIF.

      FIELD-SYMBOLS <ls_semantic_key> LIKE LINE OF semantic_key.

      LOOP AT semantic_key ASSIGNING <ls_semantic_key>.

        SELECT SINGLE * FROM @lt_fields AS SemanticKeyAlias WHERE name  = @<ls_semantic_key>-name INTO @DATA(resultSemanticKeyAlias).

        IF resultSemanticKeyAlias IS INITIAL.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid                = zcx_rap_generator=>sematic_key_is_not_in_table
              mv_semantic_key_field = CONV #( <ls_semantic_key>-name )
              mv_table_name         = CONV #( table_name ).
        ELSE.
          <ls_semantic_key>-cds_view_field = resultSemanticKeyAlias-cds_view_field.
        ENDIF.
        CLEAR resultSemanticKeyAlias.
      ENDLOOP.

    ENDIF.

    "validate mapping

    LOOP AT lt_mapping INTO DATA(ls_field_mapping).

      DATA(lv_dbtablefield) = to_upper( ls_field_mapping-dbtable_field ).


      "check if database table field is part of the persistence table
      "if table is set as datasource it is automatically set as persistence table
      "if an unmanaged scenario is used no mapping can be derived from the data source
      "or from the persistence table
      IF implementationtype <> implementation_type-unmanged_semantic.
        SELECT SINGLE * FROM @lt_fields_persistent_table AS db_field WHERE name  = @lv_dbtablefield INTO @DATA(result_dbtable_field).

        IF result_dbtable_field IS INITIAL.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid        = zcx_rap_generator=>field_is_not_in_datasource
              mv_value      = CONV #( ls_field_mapping-dbtable_field )
              mv_table_name = CONV #( table_name ).
        ENDIF.
        CLEAR result_dbtable_field.
      ENDIF.


      SELECT SINGLE * FROM @lt_fields AS cds_view_field WHERE cds_view_field  = @ls_field_mapping-cds_view_field INTO @DATA(result_cds_view_field).
      IF result_cds_view_field IS INITIAL.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid    = zcx_rap_generator=>field_is_not_in_cds_view
            mv_value  = CONV #( ls_field_mapping-cds_view_field )
            mv_entity = CONV #( rap_node_objects-cds_view_i ).
      ENDIF.
      CLEAR result_cds_view_field.
    ENDLOOP.

  ENDMETHOD.


  METHOD add_association.
    DATA lv_target TYPE string.
    DATA ls_assocation TYPE ts_assocation.

    check_parameter(
      EXPORTING
        iv_parameter_name = 'Association'
        iv_value          = CONV #( iv_name )
    ).

    lv_target = to_upper( iv_target ).

    DATA(underscore) = substring( val = iv_name  len = 1 ).

    IF underscore <> '_'.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>starts_not_with_underscore
          mv_value = CONV #( iv_name ).
    ENDIF.


    IF  iv_cardinality = cardinality-one OR iv_cardinality = cardinality-one_to_n OR
             iv_cardinality = cardinality-zero_to_n OR iv_cardinality = cardinality-zero_to_one
             OR iv_cardinality = cardinality-one_to_one.
      ls_assocation-cardinality = iv_cardinality.
    ELSE.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>assocation_is_not_supported
          mv_value = iv_cardinality.
    ENDIF.

    FIELD-SYMBOLS: <fields> TYPE ts_field.

    "we only support the simple case where the condition contains only one field
    IF lines( it_condition_fields ) = 1.
      LOOP AT lt_fields  ASSIGNING <fields> WHERE cds_view_field = it_condition_fields[ 1 ]-projection_field.
        <fields>-has_association = abap_true.
      ENDLOOP.


      ls_assocation-name = iv_name.
      ls_assocation-target = iv_target.
      ls_assocation-condition_components = it_condition_fields.

      APPEND  ls_assocation TO lt_association.

    ENDIF.

  ENDMETHOD.


  METHOD add_child.

    DATA lt_all_childnodes  TYPE STANDARD TABLE OF REF TO zcl_rap_node .

    DATA   ls_childnode  TYPE REF TO zcl_rap_node  .

    ro_child_node = NEW zcl_rap_node( ).


    "get settings from parent node
    ro_child_node->set_parent( me ).
    ro_child_node->set_root( me->root_node ).
    ro_child_node->set_namespace( CONV #( me->namespace ) ).
    ro_child_node->set_prefix( CONV #( me->prefix ) ).
    ro_child_node->set_suffix( CONV #( me->suffix ) ).
    ro_child_node->set_implementation_type( me->get_implementation_type(  ) ).
    ro_child_node->set_data_source_type( me->data_source_type ).
    ro_child_node->set_xco_lib( me->xco_lib ).




    ro_child_node->set_number( lines( me->root_node->all_childnodes ) + 1 ).

    APPEND ro_child_node TO childnodes.

    lt_all_childnodes = me->root_node->all_childnodes.
    me->root_node->add_to_all_childnodes( ro_child_node ).

  ENDMETHOD.


  METHOD add_to_all_childnodes.
    APPEND io_child_node TO all_childnodes.
  ENDMETHOD.


  METHOD add_transactional_behavior.
    transactional_behavior = iv_value.
  ENDMETHOD.


  METHOD add_valuehelp.

    DATA lv_target TYPE string.
    DATA ls_valuehelp TYPE ts_valuehelp.
    FIELD-SYMBOLS: <fields> TYPE ts_field.

*    check_parameter(
*      EXPORTING
*        iv_parameter_name = 'Alias'
*        iv_value          = CONV #( iv_name )
*    ).

    lv_target = to_upper( iv_name ).

    ls_valuehelp-alias = iv_alias.
    ls_valuehelp-element = iv_element.
    ls_valuehelp-localelement = iv_localelement.
    ls_valuehelp-name = iv_name.

    IF it_additional_binding IS NOT INITIAL.

      LOOP AT it_additional_binding INTO DATA(ls_additional_binding).

        CASE ls_additional_binding-usage .
          WHEN additionalbinding_usage-filter .
          WHEN additionalbinding_usage-filter_and_result.
          WHEN additionalbinding_usage-result .
          WHEN '' .
          WHEN OTHERS.
            RAISE EXCEPTION TYPE zcx_rap_generator
              EXPORTING
                textid   = zcx_rap_generator=>usage_is_not_supported
                mv_value = ls_additional_binding-usage.
        ENDCASE.

      ENDLOOP.

    ENDIF.


    ls_valuehelp-additionalbinding = it_additional_binding.

    APPEND ls_valuehelp TO lt_valuehelp.

    LOOP AT lt_fields  ASSIGNING <fields> WHERE cds_view_field = iv_localelement.
      <fields>-has_valuehelp = abap_true.
    ENDLOOP.


  ENDMETHOD.


  METHOD check_parameter.

    "search for spaces
    IF contains_no_blanks( CONV #( iv_value ) ) = abap_false.
      APPEND |Name of { iv_parameter_name } { iv_value } contains spaces| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>contains_spaces
          mv_value = |Object:{ iv_parameter_name } Name:{ iv_value }|.
    ENDIF.

    "search for non alpha numeric characters
    IF is_alpha_numeric( CONV #( iv_value ) ) = abap_false.
      APPEND |Name of { iv_parameter_name } { iv_value } contains non alpha numeric characters| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>non_alpha_numeric_characters
          mv_value = |Object:{ iv_parameter_name } Name:{ iv_value }|.
    ENDIF.

    "check length
    DATA(lv_max_length) = 30.

    IF strlen( iv_value ) > lv_max_length.
      APPEND |Name of { iv_value } is too long ( { lv_max_length } chararcters max)| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid        = zcx_rap_generator=>is_too_long
          mv_value      = iv_value
          mv_max_length = lv_max_length.
    ENDIF.


  ENDMETHOD.


  METHOD check_repository_object_name.

    "parameters have to be set to upper case
    "this will not be necessary in an upcomming release

    DATA lv_max_length TYPE i.
    DATA(lv_type) = to_upper( iv_type ).
    DATA(lv_name) = to_upper( iv_name ).
    DATA lv_object_already_exists TYPE abap_bool.

    "check if repository already exists

    lv_object_already_exists = abap_false.

    CASE lv_type.
      WHEN 'BDEF' .
        IF  xco_lib->get_behavior_definition( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'DDLS' .
        IF  xco_lib->get_data_definition( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'DDLX' .
        IF  xco_lib->get_metadata_extension( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'SRVD' .
        IF  xco_lib->get_service_definition( CONV #( lv_name ) )->if_xco_ar_object~exists(  ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'SRVB'.
        IF  xco_lib->get_service_binding( CONV #( lv_name ) )->if_xco_ar_object~exists(  ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'CLAS'.
        IF  xco_lib->get_class( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'DEVC'.
        IF  xco_lib->get_package( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'TABL'.
        IF  xco_lib->get_database_table( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN 'STRU'.
        IF  xco_lib->get_structure( CONV #( lv_name ) )->exists( ).
          lv_object_already_exists = abap_true.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.

    IF lv_object_already_exists = abap_true.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>repository_already_exists
          mv_value = lv_name.
    ENDIF.




    CASE lv_type.
      WHEN 'BDEF' OR 'DDLS' OR 'DDLX' OR 'SRVD' OR 'STRU'.
        lv_max_length = 30.
      WHEN 'SRVB'.
        lv_max_length = 26.
      WHEN 'CLAS'.
        lv_max_length = 30.
      WHEN 'DEVC'.
        lv_max_length = 20.
      WHEN 'TABL'.
        lv_max_length = 16.
      WHEN OTHERS.
    ENDCASE.

    IF lv_type = 'STRU'.
      lv_type = 'TABL(Structure)'.
    ENDIF.

    IF lv_type = 'TABL'.
      lv_type = 'TABL(Database Table)'.
    ENDIF.

    "search for non alpha numeric characters
    IF is_alpha_numeric( CONV #( lv_name ) ) = abap_false.
      APPEND |Name of { lv_type } { lv_name } contains non alpha numeric characters| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>non_alpha_numeric_characters
          mv_value = |Object Type: { lv_type } Object Name:{ lv_name }|.
    ENDIF.

    "search for spaces
    IF contains_no_blanks( CONV #( lv_name ) ) = abap_false.
      APPEND |Name of { lv_type } { lv_name } contains spaces| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>contains_spaces
          mv_value = |Object Type: { lv_type } Object Name:{ lv_name }|.
    ENDIF.

    "check length
    IF strlen( lv_name ) > lv_max_length.
      APPEND |Name of { lv_type } is too long ( { lv_max_length } chararcters max)| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid        = zcx_rap_generator=>is_too_long
          mv_value      = lv_name
          mv_max_length = lv_max_length.
    ENDIF.



*    IF xco_cp_abap_repository=>object->for( iv_type = CONV #( lv_type ) iv_name = CONV #( lv_name ) )->exists( ).
*      APPEND | meta data extension view { lv_name } already exists| TO lt_messages.
*      bo_node_is_consistent = abap_false.
*      RAISE EXCEPTION TYPE zcx_rap_generator
*        EXPORTING
*          textid   = zcx_rap_generator=>repository_already_exists
*          mv_value = lv_name.
*    ENDIF.

  ENDMETHOD.


  METHOD constructor.

    bo_node_is_consistent = abap_true.
    is_finalized = abap_false.

    field_name-client          = 'CLIENT'.
    field_name-uuid            = 'UUID'.
    field_name-parent_uuid     = 'PARENT_UUID'.
    field_name-root_uuid       = 'ROOT_UUID'.
    field_name-created_by      = 'CREATED_BY'.
    field_name-created_at      = 'CREATED_AT'.
    field_name-last_changed_by = 'LAST_CHANGED_BY'.
    field_name-last_changed_at = 'LAST_CHANGED_AT'.
    field_name-local_instance_last_changed_at = 'LOCAL_LAST_CHANGED_AT'.

    publish_service = abap_true.
    transactional_behavior = abap_true.

    xco_lib = NEW zcl_rap_xco_cloud_lib( ).

    TEST-SEAM runs_as_cut.
      is_test_run = abap_false.
    end-test-SEAM.

  ENDMETHOD.


  METHOD contains_no_blanks.
    rv_contains_no_blanks = abap_true.
    FIND ALL OCCURRENCES OF REGEX  '[[:space:]]' IN iv_string RESULTS DATA(blanks).
    IF blanks IS NOT INITIAL.
      rv_contains_no_blanks = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD field_name_exists_in_cds_view.

    rv_field_name_exists = abap_false.
    LOOP AT lt_fields INTO DATA(ls_field).
      IF ls_field-cds_view_field = iv_field_name.
        rv_field_name_exists = abap_true.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD finalize.
    "namespace must be set for root node
    "namespace for child objects will be set in method add_child( )
    IF namespace IS INITIAL.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid = zcx_rap_generator=>no_namespace_set.
    ENDIF.

    CASE data_source_type.
      WHEN data_source_types-table.
        IF table_name IS INITIAL.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid    = zcx_rap_generator=>no_data_source_set
              mv_entity = entityname.
        ENDIF.
      WHEN data_source_types-cds_view.
        IF cds_view_name IS INITIAL.
          RAISE EXCEPTION TYPE zcx_rap_generator
            EXPORTING
              textid    = zcx_rap_generator=>no_data_source_set
              mv_entity = entityname.
        ENDIF.
    ENDCASE.
    IF implementationtype = implementation_type-unmanged_semantic OR
         implementationtype = implementation_type-managed_semantic.
      IF semantic_key IS INITIAL .
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid = zcx_rap_generator=>no_semantic_key_set.
      ENDIF.
    ENDIF.

    IF object_id IS INITIAL.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid    = zcx_rap_generator=>no_object_id_set
          mv_entity = entityname.
    ENDIF.

    "add additional checks from methods add_valuehelp( ), set_semantic_key_fields( ) and ADD ASSOCIATION( )
    validate_bo( ).

    set_cds_view_i_name(  ).
    "we are using view entities as of 2008 and don't need to generate DDIC views anymore
    "set_ddic_view_i_name(  ).
    set_cds_view_p_name(  ).
    set_mde_name(  ).
    set_behavior_impl_name(  ).

    set_control_structure_name(  ).


    IF is_root(  ).
      set_behavior_def_i_name(  ).
      set_behavior_def_p_name(  ).
      set_service_definition_name(  ).
      set_service_binding_name(  ).
    ENDIF.

    IF lt_messages IS NOT INITIAL AND is_root(  ) = abap_false.
      APPEND | Messages from { entityname } | TO me->root_node->lt_messages.
      APPEND LINES OF lt_messages TO me->root_node->lt_messages.
    ENDIF.



    IF bo_node_is_consistent = abap_true.
      is_finalized = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD get_fields.



    DATA lo_struct_desc           TYPE REF TO cl_abap_structdescr.
    DATA lo_type_desc             TYPE REF TO cl_abap_typedescr.
    DATA lt_components TYPE cl_abap_structdescr=>component_table .
    DATA ls_components LIKE LINE OF lt_components.
    DATA dref_table TYPE REF TO data.
    DATA ls_fields TYPE ts_field.
    DATA semantic_key_fields  TYPE tt_semantic_key_fields .


    CASE data_source_type.
      WHEN data_source_types-table.


        TEST-SEAM get_mock_data_fields.

          "me->table_name

          DATA(lo_database_table) = xco_cp_abap_dictionary=>database_table( table_name ).
          "DATA(lo_database_table) = xco_lib->get_database_table( iv_name = table_name  ).

          DATA(lt_fields_from_xco) = lo_database_table->fields->all->get( ).

          LOOP AT lt_fields_from_xco INTO DATA(lo_field_from_xco).
            DATA(ls_field_from_xco) = lo_field_from_xco->content( )->get( ).
            CLEAR ls_fields.
            ls_fields-name = lo_field_from_xco->name.
            ls_fields-cds_view_field = to_mixed( ls_fields-name ).
            ls_fields-key_indicator =  lo_field_from_xco->content(  )->get_key_indicator( ).
            ls_fields-not_null = lo_field_from_xco->content(  )->get_not_null(  ).

            DATA(currency_quantity) = lo_field_from_xco->content(  )->get_currency_quantity( )-reference_field.
            IF currency_quantity IS NOT INITIAL.




              IF lo_field_from_xco->content(  )->get_type(  )->is_built_in_type(  ).
*              DATA(lv_built_in_type_obj) = lv_type->get_built_in_type(  ).
*              IF lv_built_in_type_obj IS NOT INITIAL.
*                DATA(lv_built_in_type) = lv_built_in_type_obj->type.
*              ENDIF.
                DATA(lv_built_in_type) = lo_field_from_xco->content(  )->get_type(  )->get_built_in_type(  )->type.
              ENDIF.

              IF lo_field_from_xco->content(  )->get_type(  )->is_data_element( ).


                DATA(lo_data_element) = ls_field_from_xco-type->get_data_element( ).
                DATA(ls_data_element) = lo_data_element->content( )->get( ).
                DATA(lo_data_type) = lo_data_element->content( )->get_data_type(  ).

                DATA(built_in_data_type) = lo_data_type->get_built_in_type(  ).
                IF  ls_data_element-data_type->is_domain( ) EQ abap_true.
                  DATA(lo_domain) = ls_data_element-data_type->get_domain( ).
                  DATA(lo_read_state) = xco_cp_abap_dictionary=>object_read_state->newest_version.
                  DATA(ls_domain) = lo_domain->content( lo_read_state )->get( ).
                  DATA(domain_built_in_type) = ls_domain-format->get_built_in_type(  ).
                  IF domain_built_in_type IS NOT INITIAL.
                    lv_built_in_type = domain_built_in_type->type.
                  ENDIF.

                ENDIF.
*DATA(lo_data_element) = ls_fields_from_xco-type->get_data_element( ).
*
*DATA(ls_data_element) = lo_data_element->content( )->get( ).

*                DATA(lv_data_element) = ls_fields_from_xco->content(  )->get_type(  )->get_data_element(  ).
*
*                DATA(lv_data_type) = lv_data_element->content(  )->get_data_type( ).

                "lv_built_in_type = lv_data_element->content(  )->get_data_type( )->get_built_in_type(  )->type.

*IF ls_data_element-data_type->is_domain( ) EQ abap_true.
*      DATA(lo_domain) = ls_data_element-data_type->get_domain( ).
*
*      out->write( |\n| ).
*      read_domain(
*        io_domain = lo_domain
*        out       = out
*      ).
*    ENDIF.


              ENDIF.

              CASE lv_built_in_type.
                WHEN 'CURR'.
                  ls_fields-currencycode = lo_field_from_xco->content(  )->get_currency_quantity( )-reference_field.
                WHEN 'QUAN'.
                  ls_fields-unitofmeasure = lo_field_from_xco->content(  )->get_currency_quantity( )-reference_field.
              ENDCASE.
            ENDIF.

            ls_fields-is_data_element = lo_field_from_xco->content(  )->get_type(  )->is_data_element( ).
            ls_fields-is_built_in_type = lo_field_from_xco->content(  )->get_type(  )->is_built_in_type(  ).

            IF lo_field_from_xco->foreign_key->exists(  ).
              "ls_fields_from_xco->foreign_key->content(  )->get_field_assignments
            ENDIF.

            IF to_upper( right_string( iv_length = 2 iv_string = CONV #( ls_fields-cds_view_field ) ) ) = 'ID'.
              ls_fields-cds_view_field = substring( val = ls_fields-cds_view_field len = strlen( ls_fields-cds_view_field ) - 2 ) && 'ID' .
            ENDIF.

            IF to_upper( right_string( iv_length = 4 iv_string = CONV #( ls_fields-cds_view_field ) ) ) = 'UUID'.
              ls_fields-cds_view_field = substring( val = ls_fields-cds_view_field len = strlen( ls_fields-cds_view_field ) - 4 ) && 'UUID' .
            ENDIF.

            APPEND ls_fields TO lt_fields.

          ENDLOOP.


        END-TEST-SEAM.

        set_mapping(  ).

      WHEN data_source_types-cds_view.

        TYPES:
          BEGIN OF ts_semantics_amount,
            currencyCode TYPE string,
          END OF ts_semantics_amount.
        DATA semantic_amount TYPE ts_semantics_amount.

        TYPES:
          BEGIN OF ts_semantics_quantity,
            unitOfMeasure TYPE string,
          END OF ts_semantics_quantity.
        DATA semantic_quantity TYPE ts_semantics_quantity.


*        DATA(lo_view_entity) = xco_cp_cds=>view_entity( CONV #( cds_view_name ) ). " type ref to if_xco_cds_view_entity
*        DATA(lo_view) = xco_cp_cds=>view( CONV #( cds_view_name ) ). "  type ref to if_xco_cds_view
        "DATA(lo_entity) = xco_cp_cds=>entity( CONV #( cds_view_name ) ). " type ref to if_xco_cds_entity
        DATA(lo_entity) = xco_lib->get_entity( CONV #( cds_view_name ) ).

        LOOP AT lo_entity->fields->all->get( ) INTO DATA(lo_field).

          CLEAR ls_fields.
          DATA(underscore) = substring( val = lo_field->name  len = 1 ).

          "skip associations that are added as field names as well
          IF underscore <> '_'.

            ls_fields-name = lo_field->name.
            ls_fields-cds_view_field = lo_field->content( )->get( )-alias.
            ls_fields-key_indicator =  lo_field->content(  )->get_key_indicator( ).

            "DATA(aggregated_annotations) = xco_cp_cds=>annotations->aggregated->of( lo_field ).
            DATA(aggregated_annotations) = xco_lib->get_aggregated_annotations( lo_field ).

            IF aggregated_annotations->contain( 'SEMANTICS.AMOUNT' ).
              TRY.
                  DATA(semantics_amount_annotation) = aggregated_annotations->pick( 'SEMANTICS.AMOUNT' )->get_value( ).
                  semantics_amount_annotation->write_to(  REF #( semantic_amount ) ).
                  IF semantic_amount IS NOT INITIAL.
                    ls_fields-currencycode = semantic_amount-currencycode .
                  ENDIF.
                CATCH cx_root INTO DATA(exception).
              ENDTRY.
            ENDIF.

            "for example @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
            IF aggregated_annotations->contain( 'SEMANTICS.QUANTITY' ).
              TRY.
                  DATA(semantics_quantity_annotation) = aggregated_annotations->pick( 'SEMANTICS.QUANTITY' )->get_value( ).
                  semantics_quantity_annotation->write_to(  REF #( semantic_quantity ) ).
                  IF semantic_quantity IS NOT INITIAL.
                    ls_fields-unitofmeasure = semantic_quantity-unitofmeasure .
                  ENDIF.
                CATCH cx_root INTO exception.
              ENDTRY.
            ENDIF.


            APPEND ls_fields TO lt_fields.
          ENDIF.
        ENDLOOP.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>invalid_data_source_type
            mv_value = data_source_type.


    ENDCASE.

    IF implementationtype = implementation_type-managed_semantic OR
       implementationtype = implementation_type-unmanged_semantic.

      CLEAR semantic_key_fields.
      CLEAR semantic_key.

      LOOP AT lt_fields INTO ls_fields WHERE key_indicator = abap_true AND name <> field_name-client.
        APPEND ls_fields-name TO semantic_key_fields.
      ENDLOOP.

      set_semantic_key_fields( semantic_key_fields ).

    ENDIF.

  ENDMETHOD.


  METHOD get_implementation_type.
    rv_implementation_type = implementationtype.
  ENDMETHOD.


  METHOD get_root_cause_textid.
    "error and success messages
    TYPES: BEGIN OF ty_exception_text,
             msgv1(50),
             msgv2(50),
             msgv3(50),
             msgv4(50),
           END OF ty_exception_text.

    DATA : lx_root_cause     TYPE REF TO cx_root,
           ls_exception_text TYPE ty_exception_text.

    "the caller of this method should retrieve the error message of the root cause
    "that has been originally raised by the config facade

    lx_root_cause = ix_previous.

    WHILE lx_root_cause->previous IS BOUND.
      lx_root_cause = lx_root_cause->previous.    " Get the exception that caused this exception
    ENDWHILE.

    "move the (long) text to a structure with 4 fields of length 50 characters each
    "error messages longer than 200 characters are truncated.
    "no exception is thrown opposed to using substring
    ls_exception_text = lx_root_cause->get_longtext( ).

    IF ls_exception_text IS INITIAL.
      ls_exception_text = lx_root_cause->get_text( ).
    ENDIF.

    rs_root_cause_textid-attr1 = CONV #( ls_exception_text-msgv1 ).
    rs_root_cause_textid-attr2 = CONV #( ls_exception_text-msgv2 ).
    rs_root_cause_textid-attr3 = CONV #( ls_exception_text-msgv3 ).
    rs_root_cause_textid-attr4 = CONV #( ls_exception_text-msgv4 ).
    rs_root_cause_textid-msgid = 'ZCM_RAP_GENERATOR'.
    rs_root_cause_textid-msgno = 016.

  ENDMETHOD.


  METHOD get_root_exception.
    rx_root = ix_exception.
    WHILE rx_root->previous IS BOUND.
      rx_root ?= rx_root->previous.
    ENDWHILE.
  ENDMETHOD.


  METHOD has_childs.
    IF childnodes IS NOT INITIAL.
      rv_has_childs = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_alpha_numeric.
    rv_is_alpha_numeric = abap_true.
    FIND ALL OCCURRENCES OF REGEX '[^[:word:]]' IN iv_string RESULTS DATA(non_alpha_numeric_characters).
    IF non_alpha_numeric_characters IS NOT INITIAL.
      rv_is_alpha_numeric = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD is_child.
    rv_is_child = abap_false.
    IF me->root_node = me->parent_node AND
    me->is_root(  ) = abap_false.
      rv_is_child = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_consistent.
    rv_is_consistent = bo_node_is_consistent.
  ENDMETHOD.


  METHOD is_grand_child_or_deeper.
    rv_is_grand_child = abap_false.
    IF me->root_node <> me->parent_node.
      rv_is_grand_child = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_root.
    rv_is_root = is_root_node.
  ENDMETHOD.


  METHOD right_string.
    DATA(length_of_string) = strlen( iv_string ).
    IF length_of_string >= iv_length.
      rv_string = substring( val = iv_string off = length_of_string - iv_length len = iv_length ).
    ENDIF.
  ENDMETHOD.


  METHOD set_behavior_def_i_name.

    DATA(lv_name) = |{ namespace }I_{ prefix }{ entityname }{ suffix }|.

    check_repository_object_name(
          EXPORTING
            iv_type = 'BDEF'
            iv_name = lv_name
        ).


    IF is_root( ).
      rap_root_node_objects-behavior_definition_i = lv_name.
      rv_behavior_dev_i_name = lv_name.
    ELSEIF is_test_run = abap_true.
      rap_root_node_objects-behavior_definition_i = lv_name.
      rv_behavior_dev_i_name = lv_name.
    ELSE.
      APPEND | { me->entityname } is not a root node. BDEF for an interface view is only generated for the root node| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid    = zcx_rap_generator=>is_not_a_root_node
          mv_entity = me->entityname.
    ENDIF.



  ENDMETHOD.


  METHOD set_behavior_def_p_name.

    DATA(lv_name) = |{ namespace }C_{ prefix }{ entityname }{ suffix }|.

    check_repository_object_name(
          EXPORTING
            iv_type = 'BDEF'
            iv_name = lv_name
        ).

    IF is_root( ).
      rap_root_node_objects-behavior_definition_p = lv_name.
      rv_behavior_dev_p_name = lv_name.
    ELSEIF is_test_run = abap_true.
      rap_root_node_objects-behavior_definition_p = lv_name.
      rv_behavior_dev_p_name = lv_name.
    ELSE.
      APPEND | { me->entityname } is not a root node. BDEF for a projection view is only generated for the root node| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid    = zcx_rap_generator=>is_not_a_root_node
          mv_entity = me->entityname.
    ENDIF.

  ENDMETHOD.


  METHOD set_behavior_impl_name.

    DATA(lv_name) = |{ namespace }BP_I_{ prefix }{ entityname }{ suffix }|.

    check_repository_object_name(
       EXPORTING
          iv_type = 'CLAS'
          iv_name = lv_name
         ).

    rap_node_objects-behavior_implementation = lv_name.
    rv_behavior_imp_name = lv_name.


  ENDMETHOD.


  METHOD set_cds_view_i_name.

    DATA(lv_name) = |{ namespace }I_{ prefix }{ entityname }{ suffix }|.

    check_repository_object_name(
      EXPORTING
        iv_type = 'DDLS'
        iv_name = lv_name
    ).

    rap_node_objects-cds_view_i = lv_name.

    rv_cds_i_view_name = lv_name.

  ENDMETHOD.


  METHOD set_cds_view_p_name.

    DATA(lv_name) = |{ namespace }C_{ prefix }{ entityname }{ suffix }|.

    check_repository_object_name(
         EXPORTING
           iv_type = 'DDLS'
           iv_name = lv_name
       ).

    rap_node_objects-cds_view_p = lv_name.

    rv_cds_p_view_name = lv_name.

  ENDMETHOD.


  METHOD set_control_structure_name.

    DATA(lv_name) = |{ namespace }S{ prefix }{ entityname }_X{ suffix }|.

    "four letter acronym for structures is normally 'TABL' but this is also used for tables.
    "unfortunately tables in DDIC only allow names of length 16
    "so using anther abbreviation

    check_repository_object_name(
      EXPORTING
        iv_type = 'STRU'
        iv_name = lv_name
    ).

    rap_node_objects-control_structure = lv_name.

    rv_controle_structure_name = lv_name.

  ENDMETHOD.

  METHOD set_cds_view.

    DATA(lv_cds_view) = to_upper( iv_cds_view ) .


    SELECT * FROM I_APIsForSAPCloudPlatform WHERE ReleasedObjectType = 'CDS_STOB' AND ReleasedObjectName = @lv_cds_view INTO TABLE @DATA(lt_result)..

    "check if CDS view used as target exists
    IF  lt_result IS INITIAL .
      IF xco_lib->get_data_definition( CONV #(  lv_cds_view )  )->exists( ) = abap_false .
        "IF xco_cp_abap_repository=>object->for( iv_type =  'DDLS'  iv_name = CONV #(  lv_cds_view ) )->exists( ) = abap_false .
        APPEND | CDS View {  lv_cds_view  } does not exist | TO lt_messages.
        bo_node_is_consistent = abap_false.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>cds_view_does_not_exist
            mv_value = CONV #( lv_cds_view ).
      ENDIF.
    ENDIF.


    cds_view_name = lv_cds_view.



    get_fields(  ).





  ENDMETHOD.

  METHOD set_data_source.

    CASE data_source_type.
      WHEN data_source_types-table.
        set_table( CONV sxco_ar_object_name( iv_data_source ) ).
      WHEN data_source_types-cds_view.
        set_cds_view( CONV sxco_cds_object_name( iv_data_source ) ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_rap_generator
          EXPORTING
            textid   = zcx_rap_generator=>invalid_data_source_type
            mv_value = data_source_type.
    ENDCASE.
    data_source_name = iv_data_source .


  ENDMETHOD.

  METHOD set_persistent_table.


    DATA(lv_table) = to_upper( iv_persistent_table ) .

    "check if table exists
    " IF xco_cp_abap_repository=>object->for( iv_type = CONV #( 'TABL' ) iv_name = CONV #( lv_table ) )->exists( ) = abap_false.
    IF xco_lib->get_database_table(  CONV #( lv_table ) )->exists( ) = abap_false.
      APPEND | Table { lv_table } does not exist| TO lt_messages.
      bo_node_is_consistent = abap_false.
      RAISE EXCEPTION TYPE zcx_rap_generator
        EXPORTING
          textid   = zcx_rap_generator=>table_does_not_exist
          mv_value = CONV #( lv_table ).
    ENDIF.

    persistent_table_name =  iv_persistent_table .

    get_fields_persistent_table(  ).

  ENDMETHOD.

  METHOD get_fields_persistent_table.

    DATA lt_components TYPE cl_abap_structdescr=>component_table .
    DATA ls_fields TYPE ts_field.
    "DATA(lo_database_table) = xco_cp_abap_dictionary=>database_table( CONV  sxco_dbt_object_name( persistent_table_name ) ).
    DATA(lo_database_table) = xco_lib->get_database_table( CONV  sxco_dbt_object_name( persistent_table_name ) ).
    DATA(lt_fields_from_xco) = lo_database_table->fields->all->get( ).
    LOOP AT lt_fields_from_xco INTO DATA(ls_fields_from_xco).
      ls_fields-name = ls_fields_from_xco->name.
      APPEND ls_fields TO lt_fields_persistent_table.
    ENDLOOP.

  ENDMETHOD.

  METHOD set_xco_lib.
    xco_lib = io_xco_lib.
  ENDMETHOD.

ENDCLASS.
