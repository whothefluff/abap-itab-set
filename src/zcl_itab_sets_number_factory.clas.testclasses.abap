class _FakeClass definition
                 create public
                 inheriting from zcl_itab_sets_number_factory.

endclass.

"! @testing ZCL_ITAB_SETS_NUMBER_FACTORY
class _Tests definition
             final
             for testing
             duration short
             risk level harmless.

  private section.

    methods methCreateWithSize0ThrowsErr for testing raising cx_static_check.

    methods methCreateWithNegSizeThrowsErr for testing raising cx_static_check.

    methods methCreateWithEmptyItabRets0 for testing raising cx_static_check.

    "! Check for quotient lesser than .5
    methods methCreateWithItabLTSizeRets1a for testing raising cx_static_check.

    "! Check for quotient greater than .5
    methods methCreateWithItabLTSizeRets1b for testing raising cx_static_check.

    methods methCreateWithItabEQSizeRets1 for testing raising cx_static_check.

    methods methCreateWithItabGTSizeRetsN for testing raising cx_static_check.

endclass.
class _Tests implementation.

  method methCreateWithEmptyItabRets0.

    data emptyTab type standard table of string with empty key.

    cl_abap_unit_assert=>assert_equals( act = new _FakeClass( )->create( i_itab = emptyTab
                                                                         i_set_size = 100 )->value( )
                                        exp = 0 ).

  endmethod.
  method methCreateWithItabEQSizeRets1.

    types someTab type standard table of string with empty key.

    data(tabEqualToSetSize) = value someTab( ( )
                                             ( )
                                             ( )
                                             ( )
                                             ( ) ).

    cl_abap_unit_assert=>assert_equals( act = new _FakeClass( )->create( i_itab = tabEqualToSetSize
                                                                         i_set_size = 5 )->value( )
                                        exp = 1 ).

  endmethod.
  method methCreateWithItabGTSizeRetsN.

    types someTab type standard table of string with empty key.

    constants someSetSize type int8 value 8.

    data(someInt) = cl_abap_random_int=>create( seed = conv #( cl_abap_context_info=>get_system_time( ) )
                                                min = someSetSize + 1
                                                max = 255 )->get_next( ).

    data(someTab) = value someTab( ).

    data(someTabSize) = 0.

    do someInt times.

      someTab = value #( base someTab
                         ( ) ).

      someTabSize += 1.

    enddo.

    data(tabGreaterThanSetSize) = someTab.

    data(sizeOfTabGreaterThanSetSize) = someTabSize.

    cl_abap_unit_assert=>assert_equals( act = new _FakeClass( )->create( i_itab = tabGreaterThanSetSize
                                                                         i_set_size = someSetSize )->value( )
                                        exp = floor( conv decfloat34( sizeOfTabGreaterThanSetSize / someSetSize ) ) + 1 ).

  endmethod.
  method methCreateWithItabLTSizeRets1a.

    types someTab type standard table of string with empty key.

    data(tabSmallerThanSetSize) = value someTab( ( )
                                                 ( ) ).

    cl_abap_unit_assert=>assert_equals( act = new _FakeClass( )->create( i_itab = tabSmallerThanSetSize
                                                                         i_set_size = 5 )->value( )
                                        exp = 1 ).

  endmethod.
  method methCreateWithItabLTSizeRets1b.

    types someTab type standard table of string with empty key.

    data(tabSmallerThanSetSize) = value someTab( ( )
                                                 ( )
                                                 ( ) ).

    cl_abap_unit_assert=>assert_equals( act = new _FakeClass( )->create( i_itab = tabSmallerThanSetSize
                                                                         i_set_size = 5 )->value( )
                                        exp = 1 ).

  endmethod.
  method methCreateWithNegSizeThrowsErr.

    data emptyTab type standard table of string with empty key.

    try.

      new _FakeClass( )->create( i_itab = emptyTab
                                 i_set_size = -100 )->value( ).

      cl_abap_unit_assert=>fail( ).

    catch zcx_dynamic_check.

      return.

    endtry.

  endmethod.
  method methCreateWithSize0ThrowsErr.

    data emptyTab type standard table of string with empty key.

    try.

      new _FakeClass( )->create( i_itab = emptyTab
                                 i_set_size = 0 )->value( ).

      cl_abap_unit_assert=>fail( ).

    catch zcx_dynamic_check.

      return.

    endtry.

  endmethod.

endclass.
