.data
    .align 3
RES: .space 8000
RES_size: .word 0
    .align 2
display_lut: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
    .align 3
    const_zero: .double 0.0
    const_one: .double 1.0
    const_2: .double -5.5
    const_3: .double -2.0
    const_4: .double 11.0
    const_5: .double -10.0
    const_6: .double 2.0
    const_7: .double 3.0
    const_8: .double 4.0
    const_9: .double 10.0
    const_10: .double 5.0
    const_11: .double 123.456
    var_Z: .double 0.0
    var_ULTIMO: .double 0.0
    var_X: .double 0.0
    var_Y: .double 0.0

.text
.global _start
_start:
    LDR R0, =const_2
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_3
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VMUL.F64 D0, D0, D1
    VPUSH {D0}
    VPOP {D0}
save_res_step_0:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_4
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    LDR R0, =var_X
    VSTR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
save_res_step_1:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_5
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    LDR R0, =var_Y
    VSTR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
save_res_step_2:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =var_X
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =var_Y
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VSUB.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VCVT.S32.F64 S2, D1
    VMOV R3, S2
    CMP R3, #0
    BLT throw_error
    LDR R4, =const_one
    VLDR.F64 D2, [R4]
pow_loop_0:
    CMP R3, #0
    BEQ pow_end_0
    VMUL.F64 D2, D2, D0
    SUB R3, R3, #1
    B pow_loop_0
pow_end_0:
    VMOV.F64 D0, D2
    VPUSH {D0}
    VPOP {D0}
save_res_step_3:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_7
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VCVT.S32.F64 S2, D1
    VMOV R3, S2
    CMP R3, #0
    BLT throw_error
    LDR R4, =const_one
    VLDR.F64 D2, [R4]
pow_loop_1:
    CMP R3, #0
    BEQ pow_end_1
    VMUL.F64 D2, D2, D0
    SUB R3, R3, #1
    B pow_loop_1
pow_end_1:
    VMOV.F64 D0, D2
    VPUSH {D0}
    LDR R0, =const_8
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VMUL.F64 D0, D0, D1
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VADD.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_9
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_7
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D0, D0, D1
    VCVT.S32.F64 S0, D0
    VCVT.F64.S32 D0, S0
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VMUL.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_10
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D2, D0, D1
    VCVT.S32.F64 S4, D2
    VCVT.F64.S32 D2, S4
    VMUL.F64 D2, D2, D1
    VSUB.F64 D0, D0, D2
    VPUSH {D0}
    VPOP {D0}
save_res_step_4:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_7
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    LDR R0, =var_Z
    VSTR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
save_res_step_5:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_zero
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    VCVT.S32.F64 S0, D0
    VMOV R1, S0
    CMP R1, #0
    BLT throw_error
    LDR R2, =RES_size
    LDR R2, [R2]
    CMP R1, R2
    BGE throw_error
    SUB R1, R2, R1
    SUB R1, R1, #1
    LDR R0, =RES
    ADD R0, R0, R1, LSL #3
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =var_Z
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VADD.F64 D0, D0, D1
    VPUSH {D0}
    VPOP {D0}
save_res_step_6:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    VCVT.S32.F64 S0, D0
    VMOV R1, S0
    CMP R1, #0
    BLT throw_error
    LDR R2, =RES_size
    LDR R2, [R2]
    CMP R1, R2
    BGE throw_error
    SUB R1, R2, R1
    SUB R1, R1, #1
    LDR R0, =RES
    ADD R0, R0, R1, LSL #3
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =var_X
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D0, D0, D1
    VPUSH {D0}
    VPOP {D0}
save_res_step_7:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_9
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VMUL.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_10
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_one
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VADD.F64 D0, D0, D1
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VSUB.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VCVT.S32.F64 S2, D1
    VMOV R3, S2
    CMP R3, #0
    BLT throw_error
    LDR R4, =const_one
    VLDR.F64 D2, [R4]
pow_loop_2:
    CMP R3, #0
    BEQ pow_end_2
    VMUL.F64 D2, D2, D0
    SUB R3, R3, #1
    B pow_loop_2
pow_end_2:
    VMOV.F64 D0, D2
    VPUSH {D0}
    LDR R0, =const_7
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D0, D0, D1
    VCVT.S32.F64 S0, D0
    VCVT.F64.S32 D0, S0
    VPUSH {D0}
    VPOP {D0}
save_res_step_8:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =var_X
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =var_Y
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VMUL.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =var_Z
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D0, D0, D1
    VCVT.S32.F64 S0, D0
    VCVT.F64.S32 D0, S0
    VPUSH {D0}
    VPOP {D0}
save_res_step_9:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_11
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    LDR R0, =var_ULTIMO
    VSTR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
save_res_step_10:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_8
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    VCVT.S32.F64 S0, D0
    VMOV R1, S0
    CMP R1, #0
    BLT throw_error
    LDR R2, =RES_size
    LDR R2, [R2]
    CMP R1, R2
    BGE throw_error
    SUB R1, R2, R1
    SUB R1, R1, #1
    LDR R0, =RES
    ADD R0, R0, R1, LSL #3
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =var_ULTIMO
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VADD.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_zero
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    VCVT.S32.F64 S0, D0
    VMOV R1, S0
    CMP R1, #0
    BLT throw_error
    LDR R2, =RES_size
    LDR R2, [R2]
    CMP R1, R2
    BGE throw_error
    SUB R1, R2, R1
    SUB R1, R1, #1
    LDR R0, =RES
    ADD R0, R0, R1, LSL #3
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VSUB.F64 D0, D0, D1
    VPUSH {D0}
    VPOP {D0}
save_res_step_11:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =const_9
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
    VCVT.S32.F64 S0, D0
    VMOV R1, S0
    CMP R1, #0
    BLT throw_error
    LDR R2, =RES_size
    LDR R2, [R2]
    CMP R1, R2
    BGE throw_error
    SUB R1, R2, R1
    SUB R1, R1, #1
    LDR R0, =RES
    ADD R0, R0, R1, LSL #3
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D0}
save_res_step_12:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    LDR R0, =var_ULTIMO
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D0, D0, D1
    VPUSH {D0}
    LDR R0, =const_10
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    LDR R4, =const_zero
    VLDR.F64 D2, [R4]
    VCMP.F64 D1, D2
    VMRS APSR_nzcv, FPSCR
    BEQ throw_error
    VDIV.F64 D2, D0, D1
    VCVT.S32.F64 S4, D2
    VCVT.F64.S32 D2, S4
    VMUL.F64 D2, D2, D1
    VSUB.F64 D0, D0, D2
    VPUSH {D0}
    LDR R0, =const_6
    VLDR.F64 D0, [R0]
    VPUSH {D0}
    VPOP {D1}
    VPOP {D0}
    VCVT.S32.F64 S2, D1
    VMOV R3, S2
    CMP R3, #0
    BLT throw_error
    LDR R4, =const_one
    VLDR.F64 D2, [R4]
pow_loop_3:
    CMP R3, #0
    BEQ pow_end_3
    VMUL.F64 D2, D2, D0
    SUB R3, R3, #1
    B pow_loop_3
pow_end_3:
    VMOV.F64 D0, D2
    VPUSH {D0}
    VPOP {D0}
save_res_step_13:
    LDR R0, =RES_size
    LDR R1, [R0]
    CMP R1, #1000
    BGE throw_error
    LDR R2, =RES
    ADD R2, R2, R1, LSL #3
    VSTR.F64 D0, [R2]
    ADD R1, R1, #1
    STR R1, [R0]
    VCVT.S32.F64 S0, D0
    VMOV R1, S0
    LDR R2, =0xFF200020
    LDR R3, =display_lut
    MOV R4, #0
    AND R6, R1, #0xF
    LDR R7, [R3, R6, LSL #2]
    ORR R4, R4, R7
    LSR R1, R1, #4
    AND R6, R1, #0xF
    LDR R7, [R3, R6, LSL #2]
    LSL R7, R7, #8
    ORR R4, R4, R7
    LSR R1, R1, #4
    AND R6, R1, #0xF
    LDR R7, [R3, R6, LSL #2]
    LSL R7, R7, #16
    ORR R4, R4, R7
    LSR R1, R1, #4
    AND R6, R1, #0xF
    LDR R7, [R3, R6, LSL #2]
    LSL R7, R7, #24
    ORR R4, R4, R7
    STR R4, [R2]
    B fim
throw_error:
    LDR R0, =0xFF200000
    LDR R1, =0x3FF
    STR R1, [R0]
    B .
fim:
    NOP
    B .