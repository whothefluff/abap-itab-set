class _FakeClass definition
                 create public
                 inheriting from zcl_itab_sets_number.

endclass.

"! @testing ZCL_ITAB_SETS_NUMBER
class _Tests definition
             final
             for testing
             duration short
             risk level harmless.

  private section.

    methods constructorAssignsParamsToAtts for testing raising cx_static_check.

    methods methValueRetsAttrAValue for testing raising cx_static_check.

endclass.
class _Tests implementation.

  method constructorAssignsParamsToAtts.

    test-injection constructor_assignments_start.

      me->a_value = -14.

    end-test-injection.

    test-injection constructor_assignments_end.

      cl_abap_unit_assert=>assert_equals( act = me->a_value
                                          exp = i_value ).

    end-test-injection.

    data(someValue) = cl_abap_random_int8=>create( seed = conv #( cl_abap_context_info=>get_system_time( ) )
                                                   min = 1 )->get_next( ).

    new _FakeClass( someValue ).

  endmethod.
  method methValueRetsAttrAValue.

    test-injection value_read_start.

      r_value = -14.

    end-test-injection.

    test-injection value_read_end.

      cl_abap_unit_assert=>assert_equals( act = r_value
                                          exp = me->a_value ).

    end-test-injection.

    data(someValue) = cl_abap_random_int8=>create( seed = conv #( cl_abap_context_info=>get_system_time( ) )
                                                   min = 1 )->get_next( ).

    new _FakeClass( someValue )->value( ).

  endmethod.

endclass.
