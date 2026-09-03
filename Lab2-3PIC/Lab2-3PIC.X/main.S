    ; Abel Doyle
    ; RCET3373
    ; Lab2-3PIC
    ; https://github.com/abeldoyl/Lab-02-PIC-I-O/tree/main/Lab2-3PIC/Lab2-3PIC.X
    
; PIC16F883 Configuration Bit Settings

; Assembly source line config statements

; CONFIG1
  CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator: Crystal/resonator on RA6/OSC2/CLKOUT and RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled and can be enabled by SWDTEN bit of the WDTCON register)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = OFF           ; Brown Out Reset Selection bits (BOR disabled)
  CONFIG  IESO = OFF            ; Internal External Switchover bit (Internal/External Switchover mode is disabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is disabled)
  CONFIG  LVP = OFF             ; Low Voltage Programming Enable bit (RB3 pin has digital I/O, HV on MCLR must be used for programming)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

; config statements should precede project file includes.
#include <xc.inc>

; Reset Vector at 0000h. Execution starts here after reset.
PSECT resetVect,class=CODE,delta=2
ResetVector: 
    goto Setup


; Main code section starts at 0008h. User code goes here.
PSECT code,class=CODE,delta=2
 
Setup:
    ; add device setup here
    ; Bank 0
    BCF 0x03,6  ;Set Bank 0
    BCF 0x03,5  ;Set Bank 0
    CLRF 0x06   ;Setting PortB on reset low known
    CLRF 0x07   ;Set PortC on reset to LOW
    
    ; Bank 1
    BCF 0x03,6  ;Set Bank 1
    BSF 0x03,5  ;Set Bank 1
    CLRF 0x0B   ;Set INTCON low to remove interrupt flags 
    CLRF 0x87   ;Set PortC as an Output TRISC
    MOVLW 0xFF  ;Set TRISB high
    MOVWF 0x86  ;Set PortB as an Input TRISB
    
    ;Bank 3
    BSF 0x03,6  ;Set Bank 3
    BSF 0x03,5  ;Set Bank 3
    CLRF 0x89   ;Setting the I/O to digital PortB ANSELH
    
    goto Main
    
    
    Main:
	; main code goes here
	BCF 0x03,6     ;Set Bank 0
	BCF 0x03,5     ;Set Bank 0
	
	BTFSS 0x06,7   ;Skip to next line if RB7 is set 
	goto Test6     ;If not RB7 keep testing
	goto Display7  ;If RB7 display 7
	
	Test6:
        BTFSS 0x06,6   ;Skip to next line if RB6 is set 
	goto Test5     ;If not RB6 keep testing
	goto Display6  ;If RB6 display 6
	
	Test5:
        BTFSS 0x06,5   ;Skip to next line if RB5 is set 
	goto Test4     ;If not RB5 keep testing
	goto Display5  ;If RB5 display 5
	
	Test4:
        BTFSS 0x06,4   ;Skip to next line if RB4 is set 
	goto Test3     ;If not RB4 keep testing
	goto Display4  ;If RB4 display 4
	
	Test3:
        BTFSS 0x06,3   ;Skip to next line if RB3 is set 
	goto Test2     ;If not RB3 keep testing
	goto Display3  ;If RB3 display 3
	
	Test2:
        BTFSS 0x06,2   ;Skip to next line if RB2 is set 
	goto Test1     ;If not RB2 keep testing
	goto Display2  ;If RB2 display 2
	
	Test1:
        BTFSS 0x06,1   ;Skip to next line if RB1 is set 
	goto Test0     ;If not RB1 keep testing
	goto Display1  ;If RB1 display 1
	
	Test0:
        BTFSS 0x06,0    ;Skip to next line if RB0 is set 
	goto DisplayDal ;If not RB0 Low display $
	goto Display0   ;If RB0 high display 0
	
	Display7:
        MOVLW 0x37     ;Set data to display 7
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display6:
        MOVLW 0x36     ;Set data to display 6
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display5:
        MOVLW 0x35     ;Set data to display 5
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display4:
        MOVLW 0x34     ;Set data to display 4
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display3:
        MOVLW 0x33     ;Set data to display 3
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display2:
        MOVLW 0x32     ;Set data to display 2
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display1:    
        MOVLW 0x31     ;Set data to display 1
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
        Display0:
        MOVLW 0x30     ;Set data to display 0
	MOVWF 0x07     ;Send W to PortC
	goto Main
	
	DisplayDal:
        MOVLW 0x24     ;Set data to display $
	MOVWF 0x07     ;Send W to PortC
	
	goto Main
	
    End