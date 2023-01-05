.ORIG X3000
        AND     R0, R0, #0
        AND     R1, R1, #0
        AND     R2, R2, #0
        AND     R3, R3, #0
        AND     R4, R4, #0
        AND     R5, R5, #0
        AND     R6, R6, #0      ;STACKPOINTER
        AND     R7, R7, #0      ;RETURN LINKAGE
        LD      R6, STACKX6000      ;STACKPOINTER
        LD      R0, STOREX4000      ;WHERE THE 16 SCORES ARE STORED
        LD      R1, STOREX5000      ;WHERE THE SORTED SCORES ARE STORED
        JSR     COPY
        JSR     SORT
        JSR     COUNT
        HALT
        ;----------------------------------------------------------------------------------------------------------------
        ;LABEL: COPY
        ;FUNCTION: COPY THE INPUT ARRAY TO THE OUTPUT ARRAY
        ;PARAMETER: I(R2), (I - 16)(R3), (-16)(R4), VALUE OF R0(R5)
        ;INPUT: R0 = INPUT ARRAY
        ;OUTPUT: R1 = OUTPUT ARRAY
        COPY    ADD     R6, R6, #-1
                STR     R7, R6, #0      ;SAVE RETURN LINKAGE
                ADD     R6, R6, #-1
                STR     R2, R6, #0      ;SAVE R2, WHICH WILL BE USEED AS I
                ADD     R6, R6, #-1
                STR     R3, R6, #0      ;SAVE R3, WHICH WILL BE USED AS (I - 16)
                ADD     R6, R6, #-1
                STR     R4, R6, #0      ;SAVE R4, WHICH WILL BE USED AS 16
                ADD     R6, R6, #-1
                STR     R5, R6, #0      ;SAVE R5, WHICH WILL BE USED AS VALUE OF R0
                AND     R2, R2, #0      ;I = 0
                LD      R4, STORE16      ;R4 = 16     
                NOT     R4, R4          
                ADD     R4, R4, #1      ;R4 = -16
        LOOP1   ADD     R3, R2, R4      ;R3 = (I - 16)
                BRZP    ENDCOPY         ;IF R3 < 0, END LOOP
                LDR     R5, R0, #0      ;R5 = VALUE OF R0
                STR     R5, R1, #0      ;STORE R5 IN R1
                ADD     R2, R2, #1      ;I = I + 1
                ADD     R0, R0, #1      ;R0 = R0 + 1
                ADD     R1, R1, #1      ;R1 = R1 + 1
                BRNZP   LOOP1
        
        ENDCOPY LDR     R5, R6, #0      ;RESTORE R5
                ADD     R6, R6, #1
                LDR     R4, R6, #0      ;RESTORE R4
                ADD     R6, R6, #1
                LDR     R3, R6, #0      ;RESTORE R3
                ADD     R6, R6, #1
                LDR     R2, R6, #0      ;RESTORE R2
                ADD     R6, R6, #1
                LDR     R7, R6, #0      ;RESTORE RETURN LINKAGE
                ADD     R6, R6, #1
                RET    
        ;----------------------------------------------------------------------------------------------------------------
        ;LABEL: SORT
        ;FUNCTION: SORT THE ARRAY
        ;PARAMETER: (R1), (R2), (R3), R4, R5
        ;INPUT: 
        ;OUTPUT:Y
        SORT    ADD     R6, R6, #-1
                STR     R7, R6, #0      ;SAVE RETURN LINKAGE
                ADD     R6, R6, #-1
                STR     R1, R6, #0      ;SAVE R1
                ADD     R6, R6, #-1
                STR     R2, R6, #0      ;SAVE R2
                ADD     R6, R6, #-1
                STR     R3, R6, #0      ;SAVE R3, WHICH WILL BE USED AS POINTER TO THE ARRAY
                ADD     R6, R6, #-1
                STR     R4, R6, #0      ;SAVE R4, WHICH WILL BE USEED AS I
                ADD     R6, R6, #-1
                STR     R5, R6, #0      ;SAVE R5, WHICH WILL BE USED AS J
                ;----------------------------------------------------------------------------------------------------------------
                LD      R4, STORE16
                OUTERLOOP       ADD     R4, R4, #-1 ; loop n - 1 times
                                BRNZ    SORTED      ; Looping complete, exit
                                ADD     R5, R4, #0  ; Initialize inner loop counter to outer
                                LD      R3, STOREX5000    ; Set file pointer to beginning of ARRAY
                INNERLOOP       LDR     R0, R3, #0  ; Get item at ARRAY pointer
                                LDR     R1, R3, #1  ; Get next item
                                NOT     R2, R1      ; Negate ...
                                ADD     R2, R2, #1  ;        ... next item
                                ADD     R2, R0, R2  ; swap = item - next item
                                BRNZ    SWAP        ; Don't swap if in order (item <= next item)
                                STR     R1, R3, #0  ; Perform ...
                                STR     R0, R3, #1  ;         ... swap
                SWAP            ADD     R3, R3, #1  ; Increment file pointer
                                ADD     R5, R5, #-1 ; Decrement inner loop counter
                                BRP     INNERLOOP   ; End of inner loop
                                BRNZP   OUTERLOOP   ; End of outer loop
                        ;----------------------------------------------------------------------------------------------------------------			
        SORTED  LDR     R5, R6, #0      ;RESTORE R5
                ADD     R6, R6, #1
                LDR     R4, R6, #0      ;RESTORE R4
                ADD     R6, R6, #1
                LDR     R3, R6, #0      ;RESTORE R3
                ADD     R6, R6, #1
                LDR     R2, R6, #0      ;RESTORE R2
                ADD     R6, R6, #1
                LDR     R1, R6, #0      ;RESTORE R1
                ADD     R6, R6, #1
                LDR     R7, R6, #0      ;RESTORE RETURN LINKAGE
                ADD     R6, R6, #1
                RET    
        ;---------------------------------------------------------------------------------------------------
        ;LABEL: COUNTA
        COUNT   ADD     R6, R6, #-1
                STR     R7, R6, #0      ;SAVE RETURN LINKAGE
                ADD     R6, R6, #-1
                STR     R0, R6, #0      ;SAVE R0
                ADD     R6, R6, #-1
                STR     R1, R6, #0      ;SAVE R1
                ADD     R6, R6, #-1
                STR     R2, R6, #0      ;SAVE R2
                ADD     R6, R6, #-1
                STR     R3, R6, #0      ;SAVE R3
                ADD     R6, R6, #-1
                STR     R4, R6, #0      ;SAVE R4
                ADD     R6, R6, #-1
                STR     R5, R6, #0      ;SAVE R5
                LD      R0, STOREX500F  ;ARRAY POINTER
                LDR     R1, R0, #0      ;R1 = A[15]
                AND     R2, R2, #0      ;R2 = 0, USED AS LOOP COUNTER
                ADD     R2, R2, #4      ;COUNTER = 4
                AND     R4, R4, #0      ;R4 IS COUNTA
                AND     R5, R5, #0      ;R5 IS COUNTB
                LOOPA   ADD     R2, R2, #-1     ;
                        BRN     OUTLOOPA
                        IFA     ADD     R6, R6, #-1
                                STR     R2, R6, #0
                                LD      R3, STOREN85
                                ADD     R2, R1, R3      ;R2 = R1 - 85
                                BRN     ELIFA
                                ADD     R4, R4, #1      ;COUNTA++
                                BRNZP   ENDIFA
                        ELIFA   LD      R3, STOREN75
                                ADD     R2, R1, R3      ;R2 = R1 - 75
                                BRN     ENDIFA
                                ADD     R5, R5, #1
                        ENDIFA  LDR     R2, R6, #0
                                STR     R6, R6, #1
                        ADD     R0, R0, #-1
                        LDR     R1, R0, #0
                        BRNZP   LOOPA
                OUTLOOPA    
                AND     R2, R2, #0      ;R2 = 0, USED AS LOOP COUNTER
                ADD     R2, R2, #4      ;COUNTER = 4
                LOOPB   ADD     R2, R2, #-1     ;
                        BRN     OUTLOOPB
                        IFB     ADD     R6, R6, #-1
                                STR     R2, R6, #0
                                LD      R3, STOREN75
                                ADD     R2, R1, R3      ;R2 = R1 - 75
                                BRN     ENDIFB
                                ADD     R5, R5, #1      ;COUNTA++
                        ENDIFB  LDR     R2, R6, #0
                                STR     R6, R6, #1
                        ADD     R0, R0, #-1
                        LDR     R1, R0, #0
                        BRNZP   LOOPB
                OUTLOOPB    
                STI    R4, STOREX5100
                STI    R5, STOREX5101
                LDR     R5, R6, #0      ;RESTORE R5
                ADD     R6, R6, #1
                LDR     R4, R6, #0      ;RESTORE R4
                ADD     R6, R6, #1
                LDR     R3, R6, #0      ;RESTORE R3
                ADD     R6, R6, #1
                LDR     R2, R6, #0      ;RESTORE R2
                ADD     R6, R6, #1
                LDR     R1, R6, #0      ;RESTORE R1
                ADD     R6, R6, #1
                LDR     R0, R6, #0      ;RESTORE R0
                ADD     R6, R6, #1  
                RET
        ;---------------------------------------------------------------
        STOREX4000  .FILL   X4000
        STOREX5000  .FILL   X5000
        STOREX5100  .FILL   X5100
        STOREX5101  .FILL   X5101
        STACKX6000  .FILL   X6000
        STOREX500F  .FILL   X500F
        STORE16     .FILL   X0010
        STOREN75    .FILL   XFFB5
        STOREN85    .FILL   XFFAB
.END