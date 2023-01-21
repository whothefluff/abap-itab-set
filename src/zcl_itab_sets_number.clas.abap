"! <p class="shorttext synchronized" lang="EN">Number of sets of n rows in an internal table</p>
class zcl_itab_sets_number definition
                           public
                           create public.

  public section.

    types t_value type int8.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_value | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_value type zcl_itab_sets_number=>t_value.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter r_value | <p class="shorttext synchronized" lang="EN"></p>
    methods value
              returning
                value(r_value) type zcl_itab_sets_number=>t_value.

  protected section.

    data a_value type zcl_itab_sets_number=>t_value.

endclass.



class ZCL_ITAB_SETS_NUMBER implementation.

  method constructor.

    test-seam constructor_assignments_start.
    end-test-seam.

    me->a_value = i_value.

    test-seam constructor_assignments_end.
    end-test-seam.

  endmethod.

  method value.

    test-seam value_read_start.
    end-test-seam.

    r_value = me->a_value.

    test-seam value_read_end.
    end-test-seam.

  endmethod.

endclass.

