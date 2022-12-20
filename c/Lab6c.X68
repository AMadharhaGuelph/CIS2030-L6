*-----------------------------------------------------------
* Title      : Lab6c
* Written by : Ankush Madharha
* Date       : 11/11/2022
* Description: compute c = (a+2)^2
*-----------------------------------------------------------

aOffset     EQU     14  
bOffset     EQU     12
cOffset     EQU     8
xOffset     EQU     -4
yOffset     EQU     -8
zOffset     EQU     -12   

        ORG         $8000
START:  MOVE.W      #4,-(A7)        ;push a = 4
        MOVE.W      #5,-(A7)        ;push b = 5
        PEA         c               ;push address of c
        BSR         sumSquared      ; call subroutine
        LEA         8(A7),A7        ;remove parameters from stack        

        SIMHALT           

sumSquared
        LINK        A6,#-12         ;allocates storage for three longwards
        MOVEM.L     D0/A0,-(A7)     ;save working register
        
        MOVE.W      aOffset(A6),D0  ;get a
        MULS        D0,D0           ;compute a*a
        MOVE.L      D0,xOffset(A6)  ;x = a*a
        
        CLR.L       D0              ;clear D0
        
        MOVE.W      bOffset(A6),D0  ;get b
        MULS        D0,D0           ;compute b*b
        MOVE.L      D0,yOffset(A6)  ;y = b*b
        
        CLR.L       D0              ;clear D0
        
        MOVE.W      #2,D0           ;get 2
        MULS        aOffset(A6),D0  ;2 * a
        MULS        bOffset(A6),D0  ;2 * a * b
        MOVE.L      D0,zOffset(A6)  ;z = 2 * a * b
        
        CLR.L       D0              ;clear D0
        
        MOVE.L      xOffset(A6),D0  ;get x
        ADD.L       yOffset(A6),D0  ;x + y
        ADD.L       zOffset(A6),D0  ;x + y + z
        
        MOVEA.L     cOffset(A6),A0  ;get address of c
        MOVE.L      D0,(A0)         ;save x+y+z in c
        
        MOVEM.L     (A7)+,A0/D0     ;restore working registers
        UNLK        A6              ;deallocate stack frame
        
        RTS                         ;return


        ORG         $9000
c       DS.L        1               ;variable c

        END         START        

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
