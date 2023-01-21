"! <p class="shorttext synchronized" lang="EN">Factory for {@link ZCL_ITAB_SETS_NUMBER}</p>
class zcl_itab_sets_number_factory definition
                                   public
                                   create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_itab | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_set_size | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_itab_sets | <p class="shorttext synchronized" lang="EN"></p>
    "! @raising zcx_dynamic_check | <p class="shorttext synchronized" lang="EN"></p>
    methods create
              importing
                i_itab type any table
                i_set_size type int8
              returning
                value(r_itab_sets) type ref to zcl_itab_sets_number
              raising
                zcx_dynamic_check.

endclass.



class ZCL_ITAB_SETS_NUMBER_FACTORY implementation.

  method create.

    r_itab_sets = cond #( when i_set_size gt 1
                          then cond #( when lines( i_itab ) eq 0
                                       then new #( 0 )
                                       when lines( i_itab ) eq i_set_size
                                       then new #( 1 )
                                       else new #( floor( conv decfloat16( lines( i_itab ) / i_set_size ) ) + 1 ) )
                          else throw zcx_dynamic_check( new zcl_text_symbol_msg( 'The size of the set cannot be less than 1'(001) )->as_error( ) ) ).

  endmethod.

endclass.

