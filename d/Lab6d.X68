*-----------------------------------------------------------
* Title      : Lab6d
* Written by : Ankush Madharha
* Date       : 11/11/2022
* Description: displays integers of a digit
*-----------------------------------------------------------
            ORG             $8000
            
MAIN:       MOVE.W          n,-(SP)             ; passing n            
            BSR             DISPLAY             ; subroutine
            LEA             2(SP),SP            ; removing parmeters 
            
            SIMHALT                             ; halt simulator
        
DISPLAY     LINK            A6,#-4              ; 1 longword 
            MOVEM.L         D0-D2/A1,-(SP)      ; saving working registers  
            
            MOVE            nOffset(A6),D0      ; moving  N into D0
            TST             D0                  ; n == 0    
            BEQ             RETURN              ; return
            
            CLR.L           D2                  ; clear D2
            MOVE            D0,D2               ; move n to D2
            DIVU            #10,D2              ; divide n by 10
            MOVE.L          D2,remainder(A6)    ; moving remainder and quotient
       
            MOVE            quotient(A6),-(SP)  ; push quotient
            BSR             DISPLAY             ; calculating display
            LEA             2(SP),SP            ; removing quotient
       
            MOVE.L          #3,D0               ; output mode 3         
            MOVE            remainder(A6),D1    
            TRAP            #15                 ; system call
            
            MOVE.L          #14,D0              ; output mode 14
            LEA             COMMA,A1            
            TRAP            #15                 ; system call
            
RETURN      MOVEM.L         (SP)+,D0-D2/A1      ; restoring working registers
            UNLK            A6                  ; deallocate
            RTS                                 ; return main                             
        
            ORG             $9000
n           DC.W            1234                ; n
COMMA       DC.B            ', ',0              ; comma
            
*** Setting all displacement offsets from frame pointer ***

nOffset     EQU             8
quotient    EQU             -2
remainder   EQU             -4  
          
            END    MAIN                         ; last line of source









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
