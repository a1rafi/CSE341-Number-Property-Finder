.MODEL SMALL
.STACK 100H
.DATA


a dw 00H
          
n db 3 dup(?)
          
b dw ?

c dw ?

d dw ?
       
e dw ?

f dw ?

g dw ?

h dw ? 

i dw ? 

j db ? ;f

k db ? ;f

l db ? ;f 

m db ?

n1 dw ?

o dw ?

p dw ?

idx dw 03H

count dw 00H

dg db ?

digit db "How many digits in the number (1 to 3)? : $"

inp db "Enter the number: $"
      
pr db " is a prime number$"

prn db " is not a prime number$"

ev db " is an even number$"

od db " is an odd number$"

pft db " is a perfect number$"

npft db " is not a perfect number$"

hpy db " is a happy number$"

nhpy db " is an unhappy number$"

palin db " is a palindrome number$"

npalin db " is not a palindrome number$"

parm db " is an armstrong number$"

narm db " is not an armstrong number$" 


.CODE


MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;code for input starts
    MOV AH,9
    LEA DX,digit
    INT 21H
    MOV AH,1
    INT 21H
    SUB Al,030H
    MOV dg,Al
    
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    MOV AH,9
    LEA DX,inp
    INT 21H
    
    CMP dg,03H
    JE tdg
    MOV n[0],00H
    CMP dg,02H
    JE  twdg
    MOV n[1],00H
    JMP onedg
    
    
    tdg:
    MOV AH,1
    INT 21H
    MOV AH,0
    SUB Al,030H
    MOV n[0],al
    PUSH AX
    MOV Bl,064H
    MUL Bl    
    MOV a,AX
    DEC idx
    INC count
    
    twdg:
    MOV AH,1
    INT 21H
    MOV AH,0
    SUB Al,030H
    MOV n[1],al
    PUSH AX
    MOV Bl,0AH
    MUL Bl    
    ADD a,AX
    DEC idx
    INC count
    
    onedg:
    MOV AH,1
    INT 21H
    MOV AH,00H
    SUB Al,030H
    MOV n[2],al
    PUSH AX
    ADD a,AX
    DEC idx
    INC count
    
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    ;code for input ends
    
    ;code for prime check starts
    MOV BX,2
    p_check:
    CMP a,1
    JE prime
    CMP a,0
    JE prime
    CMP BX,a
    JE prime
    MOV AX,a
    MOV DX,00H
    DIV BX
    CMP DX,0
    JE n_prime
    INC BX
    JMP p_check
    
    
    prime:
    MOV AH,2
    CMP a,99
    JG tpr
    CMP a,9
    JG twpr
    JLE onepr
    tpr:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twpr:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onepr:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    MOV AH,9
    LEA DX,pr
    INT 21H
    JMP second
    
    n_prime:
    MOV AH,2
    CMP a,99
    JG tprn
    CMP a,9
    JG twprn
    JLE oneprn
    tprn:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twprn:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    oneprn:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    MOV AH,9
    LEA DX,prn
    INT 21H
    JMP second
    ;code for prime check end
    
    ;code for odd/even starts
    second:
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    MOV AX,a
    MOV DX,00H
    MOV BX,02H
    DIV BX
    CMP DX,0
    JE even
    MOV AH,2
    CMP a,99
    JG tod
    CMP a,9
    JG twod
    JLE oneod
    tod:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twod:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    oneod:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    MOV AH,9
    LEA DX,od
    INT 21H
    JMP third

    even:
    MOV AH,2
    CMP a,99
    JG tev
    CMP a,9
    JG twev
    JLE oneev
    tev:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twev:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    oneev:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    MOV AH,9
    LEA DX,ev
    INT 21H
    JMP third
    ;code for odd/even ends
    
    ;code for perfect check starts
    third:
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    
    MOV BX,01H
    perfecto:
    CMP a,0
    JE pft_n
    CMP BX,a
    JE pft_check
    MOV AX,a
    MOV DX,0
    MOV CX,BX
    DIV CX
    CMP DX,0
    JE inr
    INC BX
    JMP perfecto
    inr:
    ADD b,CX
    INC BX
    JMP perfecto
    
    pft_check:
    MOV CX,b
    CMP CX,a
    JE pft_p
    pft_n:
    MOV AH,2
    CMP a,99
    JG tnpft
    CMP a,9
    JG twnpft
    JLE onenpft
    tnpft:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twnpft:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onenpft:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    MOV AH,9
    LEA DX,npft
    INT 21H
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    JMP fourth

    
    pft_p:
    MOV AH,2
    CMP a,99
    JG tpft
    CMP a,9
    JG twpft
    JLE onepft
    tpft:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twpft:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onepft:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    MOV AH,9
    LEA DX,pft
    INT 21H
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    JMP fourth
    
    ;code for perfect check ends
    
    
    ;Happy number starts 
    
     fourth:
    ;storing inside reg from val
    MOV AX, a
    MOV h, AX
    JMP start1
    
    start1:
    MOV AX, h
    MOV DX, 0000H
    MOV CX, 0AH
    DIV CX
    MOV BL, DL ;2 , 0
    
    CMP AL, 09H
    JG another_reg
    JMP CONTINUE
    
    another_reg:
    MOV DL, 0AH
    DIV DL
    MOV DL, AL ;1
    MOV BH, AH ;3
    JMP double_digit
    
    CONTINUE:
    MOV BH, AL ;5   
    ;Happy calculation start
    CMP h, 0000H
    JE hpy_p1
    MOV j, BH
    MOV k, BL
    MOV AL, j
    MUL BH
    MOV CL, AL
    MOV AL,k
    MUL BL
    MOV CH, AL
    ADD CL, CH
    
    CMP CL, 01H
    JE hpy_p1
    CMP CL, 91H
    JE hpy_n1
    MOV CH, 00H
    MOV h, CX
    JMP start1
    
    hpy_p1:
    MOV AH,2
    CMP a,99
    JG thpy_p1
    CMP a,9
    JG twhpy_p1
    JLE onehpy_p1
    thpy_p1:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twhpy_p1:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onehpy_p1:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, hpy
    MOV AH, 9
    int 21h
    JMP fifth 
    
    hpy_n1:
    MOV AH,2
    CMP a,99
    JG thpy_n1
    CMP a,9
    JG twhpy_n1
    JLE onehpy_n1
    thpy_n1:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twhpy_n1:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onehpy_n1:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, nhpy
    MOV AH, 9
    int 21h
    JMP fifth
    ;Happy number ends  
    
    
    ;Happy calculation start again  
    double_digit:
    MOV j, BH
    MOV k, BL
    MOV l, DL
    MOV AL, l
    MUL DL
    MOV DH, AL
    MOV AL, j
    MUL BH
    MOV CL, AL
    MOV AL, k
    MUL BL
    MOV CH, AL
    ADD CL, CH
    ADD CL, DH
    
    CMP CL, 01H
    JE hpy_p2
    CMP CL, 91H
    JE hpy_n2
    MOV CH, 00H
    MOV h, CX
    JMP start1
    
    hpy_p2:
    MOV AH,2
    CMP a,99
    JG thpy_p2
    CMP a,9
    JG twhpy_p2
    JLE onehpy_p2
    thpy_p2:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twhpy_p2:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onehpy_p2:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, hpy
    MOV AH, 9
    int 21h
    JMP fifth 
    
    hpy_n2:
    MOV AH,2
    CMP a,99
    JG thpy_n2
    CMP a,9
    JG twhpy_n2
    JLE onehpy_n2
    thpy_n2:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twhpy_n2:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onehpy_n2:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, nhpy
    MOV AH, 9
    int 21h
    ;Happy number ends here
    
    ;Palindrome Starts here
    fifth:
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    
    
    MOV SI,idx
    MOV CX,count
    pal:
    POP BX
    CMP n[SI],Bl
    JNE nopali:
    INC SI
    Loop pal
    
    pali: 
    MOV AH,2
    CMP a,99
    JG tpali
    CMP a,9
    JG twpali
    JLE onepali
    tpali:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twpali:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onepali:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, palin
    MOV AH, 9
    int 21h
    JMP sixth
    
    
    nopali: 
    MOV AH,2
    CMP a,99
    JG tnopali
    CMP a,9
    JG twnopali
    JLE onenopali
    tnopali:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twnopali:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onenopali:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, npalin
    MOV AH, 9
    int 21h
    JMP sixth 
    
    ;Palindrome ends here         
             
    ;Armstrong starts:
    
    sixth:
    MOV AH,2 ;double next line start
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H
    MOV AH,2
    MOV Dl,0DH
    INT 21H
    MOV Dl,0AH
    INT 21H ; double next line end    
    MOV BL, dg
    ADD BL, 30H 
    CMP BL, 31H
    JE COMPARE1
    CMP BL, 32H
    JE COMPARE2
    CMP BL, 33H
    JE COMPARE3
    
    COMPARE1:
    MOV CX, 0000H
    MOV CX, a
    ADD CX, 30H
    CMP CX, 30H
    JE parm1
    CMP CX, 31H
    JE parm1
    CMP CX, 32H
    JE parm1
    CMP CX, 33H
    JE parm1
    CMP CX, 34H
    JE parm1
    CMP CX, 35H
    JE parm1
    CMP CX, 36H
    JE parm1
    CMP CX, 37H
    JE parm1
    CMP CX, 38H
    JE parm1
    CMP CX, 39H
    JE parm1          
           
    COMPARE2:
    JMP nparm1
    
    COMPARE3:
    MOV AX, 0000H
    MOV DX, 0000H
    MOV AX, a
    MOV h, AX
    MOV BX, 0AH
    DIV BX
    MOV AH, 00H
    MOV BL, 0AH
    DIV BL ;24/10, AL=24, BL=0AH
    MOV k, AH ;QUET=2
    MOV CL, AL
    MOV CH, 00H
    MOV p, CX ;REMINDER=4
   
    MOV AL, DL ;DL=3
    MUL DL ;AL= 3*3
    ;MOV AH, 00H
    MOV BL, DL ;DL=3, BL=3
    ;MOV BH, 00H 
    MUL BX ;9*3=27
    MOV n1, AX ;3*3*3
    
    MOV AH, 00H
    MOV AX, p ;AL=4
    MOV DL, AL ;DL=4
    MUL DL ;AL= 4*4
    MOV AH, 00H
    MOV BL, DL ;BL=4, AL=16
    MOV BH, 00H
    MUL BX ;16*4=64
    MOV o, AX ;4*4*4
    
    MOV AL, k ;AL=2
    MOV DL, AL ;DL=2
    MUL DL ;AL= 2*2
    MOV AH, 00H
    MOV BL, DL ;DL= 2, BL=2, AL=4
    MOV BH, 00H
    MUL BX ;4*2=8
    MOV p, AX ;3*3*3
    
    MOV BX, 0000H
    MOV BX, n1
    MOV CX, 0000H
    MOV CX, o
    MOV DX, 0000H
    MOV DX, p
    ADD BX, CX
    ADD BX, DX
    
    CMP BX, a
    JE  parm1
    JMP nparm1
    
    parm1:
    MOV AH,2
    CMP a,99
    JG tparm1
    CMP a,9
    JG twparm1
    JLE oneparm1
    tparm1:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twparm1:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    oneparm1:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, parm
    MOV AH, 9
    int 21h
    JMP END
    
    nparm1:
    MOV AH,2
    CMP a,99
    JG tnparm1
    CMP a,9
    JG twnparm1
    JLE onenparm1
    tnparm1:
    MOV Dl,n[0]
    ADD Dl,030H
    INT 21H
    twnparm1:
    MOV Dl,n[1]
    ADD Dl,030H
    INT 21H
    onenparm1:
    MOV Dl,n[2]
    ADD Dl,030H
    INT 21H
    LEA DX, narm
    MOV AH, 9
    int 21h
    JMP END      
                          
             
    ;Armstrong ends here
      
    END:
    MAIN ENDP
END MAIN