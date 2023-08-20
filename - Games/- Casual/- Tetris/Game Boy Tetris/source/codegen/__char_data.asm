
; -----------------------------------------------------------------------------
; Copyright © 2020 Lee Fastenau
; Tetris™️ is copyright © The Tetris Company, LLC
; Game Boy™️ is copyright © Nintendo Co., Ltd.
;
; This file is part of GB Tetris for Apple II.
;
; GB Tetris for Apple II is free software: you can redistribute it
; and/or modify it under the terms of the GNU General Public License as
; published by the Free Software Foundation, either version 3 of the
; License, or any later version.
;
; GB Tetris for Apple II is distributed in the hope that it will be
; useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with GB Tetris for Apple II.  If not, see:
; https://choosealicense.com/licenses/gpl-3.0/
; -----------------------------------------------------------------------------
;
; 🛑 THIS IS A GENERATED FILE. MANUAL EDITS MAY BE LOST.
;

; char_data
			DC.B $ff	;          - $00
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $7f	;        #

			DC.B $ff	;          - $01
			DC.B $ff	;         
			DC.B $83	;   ##### 
			DC.B $7d	;  #     #
			DC.B $fe	; #       
			DC.B $3f	;       ##
			DC.B $0f	;     ####
			DC.B $73	;   ##   #

			DC.B $ff	;          - $02
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $f1	;  ###    
			DC.B $ee	; #   #   
			DC.B $2e	; #   # ##
			DC.B $df	;      #  
			DC.B $0b	;   # ####

			DC.B $9f	;      ##  - $03
			DC.B $9f	;      ## 
			DC.B $df	;      #  
			DC.B $1f	;      ###
			DC.B $5f	;      # #
			DC.B $3e	; #     ##
			DC.B $5d	;  #   # #
			DC.B $8d	;  #  ### 

			DC.B $f9	;  ##      - $04
			DC.B $f9	;  ##     
			DC.B $fb	;   #     
			DC.B $f8	; ###     
			DC.B $fa	; # #     
			DC.B $7c	; ##     #
			DC.B $ba	; # #   # 
			DC.B $b1	;  ###  # 

			DC.B $ff	;          - $05
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $8f	;     ### 
			DC.B $77	;    #   #
			DC.B $74	; ## #   #
			DC.B $fb	;   #     
			DC.B $d0	; #### #  

			DC.B $57	;    # # # - $06
			DC.B $e7	;    ##   
			DC.B $41	;  ##### #
			DC.B $be	; #     # 
			DC.B $77	;    #   #
			DC.B $e4	; ## ##   
			DC.B $d0	; #### #  
			DC.B $8e	; #   ### 

			DC.B $fd	;  #       - $07
			DC.B $fc	; ##      
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $fc	; ##      

			DC.B $7f	;        # - $08
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $bf	;       # 
			DC.B $3f	;       ##
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $bf	;       # 

			DC.B $fe	; #        - $09
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fd	;  #      
			DC.B $fc	; ##      
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fd	;  #      

			DC.B $df	;      #   - $0a
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $4f	;     ## #
			DC.B $4f	;     ## #
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $bf	;       # 

			DC.B $fb	;   #      - $0b
			DC.B $fb	;   #     
			DC.B $fb	;   #     
			DC.B $f2	; # ##    
			DC.B $f2	; # ##    
			DC.B $fb	;   #     
			DC.B $fb	;   #     
			DC.B $fd	;  #      

			DC.B $3f	;       ## - $0c
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $1f	;      ###
			DC.B $1f	;      ###
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $1f	;      ###

			DC.B $fc	; ##       - $0d
			DC.B $fb	;   #     
			DC.B $fb	;   #     
			DC.B $f8	; ###     
			DC.B $f8	; ###     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     
			DC.B $f8	; ###     

			DC.B $df	;      #   - $0e
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $9f	;      ## 

			DC.B $fb	;   #      - $0f
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     

			DC.B $5f	;      # # - $10
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $df	;      #  

			DC.B $f9	;  ##      - $11
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $fb	;   #     

			DC.B $6f	;     #  # - $12
			DC.B $af	;     # # 
			DC.B $af	;     # # 
			DC.B $b7	;    #  # 
			DC.B $c7	;    ###  
			DC.B $17	;    # ###
			DC.B $57	;    # # #
			DC.B $9b	;   #  ## 

			DC.B $f6	; #  #     - $13
			DC.B $f5	;  # #    
			DC.B $f5	;  # #    
			DC.B $ed	;  #  #   
			DC.B $e3	;   ###   
			DC.B $e8	; ### #   
			DC.B $e9	;  ## #   
			DC.B $da	; # #  #  

			DC.B $5b	;   #  # # - $14
			DC.B $9b	;   #  ## 
			DC.B $5b	;   #  # #
			DC.B $9b	;   #  ## 
			DC.B $41	;  ##### #
			DC.B $0a	; # # ####
			DC.B $d0	; #### #  
			DC.B $27	;    ## ##

			DC.B $9c	; ##   ##  - $15
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 
			DC.B $94	; ## # ## 
			DC.B $94	; ## # ## 
			DC.B $8c	; ##  ### 
			DC.B $8c	; ##  ### 
			DC.B $9c	; ##   ## 

			DC.B $fc	; ##       - $16
			DC.B $fc	; ##      
			DC.B $ff	;         
			DC.B $24	; ## ## ##
			DC.B $44	; ## ### #
			DC.B $64	; ## ##  #
			DC.B $64	; ## ##  #
			DC.B $64	; ## ##  #

			DC.B $ff	;          - $17
			DC.B $f3	;   ##    
			DC.B $e1	;  ####   
			DC.B $33	;   ##  ##
			DC.B $92	; # ## ## 
			DC.B $12	; # ## ###
			DC.B $92	; # ## ## 
			DC.B $32	; # ##  ##

			DC.B $ff	;          - $18
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $4c	; ##  ## #
			DC.B $89	;  ## ### 
			DC.B $c8	; ### ##  
			DC.B $cf	;     ##  
			DC.B $c8	; ### ##  

			DC.B $7f	;        # - $19
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $0e	; #   ####
			DC.B $64	; ## ##  #
			DC.B $64	; ## ##  #
			DC.B $64	; ## ##  #
			DC.B $0c	; ##  ####

			DC.B $fe	; #        - $1a
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $86	; #  #### 
			DC.B $32	; # ##  ##
			DC.B $32	; # ##  ##
			DC.B $32	; # ##  ##
			DC.B $86	; #  #### 

			DC.B $d9	;  ##  #   - $1b
			DC.B $da	; # #  #  
			DC.B $d9	;  ##  #  
			DC.B $da	; # #  #  
			DC.B $81	;  ###### 
			DC.B $48	; ### ## #
			DC.B $13	;   ## ###
			DC.B $e4	; ## ##   

			DC.B $df	;      #   - $1c
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $bf	;       # 
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $f9	;  ##      - $1d
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $fc	; ##      
			DC.B $fe	; #       
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $f7	;    #     - $1e
			DC.B $07	;    #####
			DC.B $57	;    # # #
			DC.B $a7	;    ## # 
			DC.B $57	;    # # #
			DC.B $a7	;    ## # 
			DC.B $05	;  # #####
			DC.B $f7	;    #    

			DC.B $ff	;          - $1f
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $ff	;          - $20
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $21
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $ff	;         
			DC.B $e7	;    ##   
			DC.B $ff	;         

			DC.B $27	;    ## ## - $22
			DC.B $27	;    ## ##
			DC.B $6f	;     #  #
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $27	;    ## ## - $23
			DC.B $27	;    ## ##
			DC.B $6f	;     #  #
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $ff	;         

			DC.B $ff	;          - $24
			DC.B $cf	;     ##  
			DC.B $87	;    #### 
			DC.B $f3	;   ##    
			DC.B $87	;    #### 
			DC.B $1d	;  #   ###
			DC.B $83	;   ##### 
			DC.B $e7	;    ##   

			DC.B $ff	;          - $25
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $aa	; # # # # 
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $26
			DC.B $93	;   ## ## 
			DC.B $4d	;  #  ## #
			DC.B $2d	;  #  # ##
			DC.B $55	;  # # # #
			DC.B $ab	;   # # # 
			DC.B $d7	;    # #  
			DC.B $ef	;     #   

			DC.B $ff	;          - $27
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $f7	;    #    
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ef	;     #    - $28
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $f7	;    #     - $29
			DC.B $f7	;    #    
			DC.B $f7	;    #    
			DC.B $f5	;  # #    
			DC.B $f7	;    #    
			DC.B $f7	;    #    
			DC.B $f7	;    #    
			DC.B $f7	;    #    

			DC.B $ff	;          - $2a
			DC.B $ff	;         
			DC.B $bb	;   #   # 
			DC.B $d7	;    # #  
			DC.B $ef	;     #   
			DC.B $d7	;    # #  
			DC.B $bb	;   #   # 
			DC.B $ff	;         

			DC.B $ff	;          - $2b
			DC.B $f9	;  ##     
			DC.B $f1	;  ###    
			DC.B $e1	;  ####   
			DC.B $e1	;  ####   
			DC.B $f1	;  ###    
			DC.B $f9	;  ##     
			DC.B $ff	;         

			DC.B $ff	;          - $2c
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $fb	;   #     
			DC.B $ff	;         

			DC.B $ff	;          - $2d
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $c3	;   ####  
			DC.B $c3	;   ####  
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $2e
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $ff	;         

			DC.B $55	;  # # # # - $2f
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $30
			DC.B $c3	;   ####  
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $31
			DC.B $e7	;    ##   
			DC.B $e3	;   ###   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $32
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $8f	;     ### 
			DC.B $c3	;   ####  
			DC.B $f1	;  ###    
			DC.B $81	;  ###### 
			DC.B $ff	;         

			DC.B $ff	;          - $33
			DC.B $c1	;  #####  
			DC.B $8f	;     ### 
			DC.B $c3	;   ####  
			DC.B $8f	;     ### 
			DC.B $8f	;     ### 
			DC.B $c1	;  #####  
			DC.B $ff	;         

			DC.B $ff	;          - $34
			DC.B $c3	;   ####  
			DC.B $c9	;  ## ##  
			DC.B $cd	;  #  ##  
			DC.B $8d	;  #  ### 
			DC.B $81	;  ###### 
			DC.B $cf	;     ##  
			DC.B $ff	;         

			DC.B $ff	;          - $35
			DC.B $c1	;  #####  
			DC.B $f9	;  ##     
			DC.B $c1	;  #####  
			DC.B $8f	;     ### 
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $36
			DC.B $c3	;   ####  
			DC.B $f9	;  ##     
			DC.B $c1	;  #####  
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $37
			DC.B $81	;  ###### 
			DC.B $9f	;      ## 
			DC.B $cf	;     ##  
			DC.B $e7	;    ##   
			DC.B $e3	;   ###   
			DC.B $e3	;   ###   
			DC.B $ff	;         

			DC.B $ff	;          - $38
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $39
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $83	;   ##### 
			DC.B $8f	;     ### 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ef	;     #    - $3a
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   

			DC.B $f7	;    #     - $3b
			DC.B $07	;    #####
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fd	;  #      
			DC.B $ff	;         

			DC.B $ff	;          - $3c
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $df	;      #  
			DC.B $ff	;         

			DC.B $ef	;     #    - $3d
			DC.B $00	; ########
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         

			DC.B $ef	;     #    - $3e
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $0f	;     ####

			DC.B $ff	;          - $3f
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $ff	;          - $40
			DC.B $e3	;   ###   
			DC.B $dd	;  #   #  
			DC.B $a2	; # ### # 
			DC.B $ba	; # #   # 
			DC.B $a2	; # ### # 
			DC.B $dd	;  #   #  
			DC.B $e3	;   ###   

			DC.B $ff	;          - $41
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $81	;  ###### 
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $ff	;         

			DC.B $ff	;          - $42
			DC.B $c1	;  #####  
			DC.B $99	;  ##  ## 
			DC.B $c1	;  #####  
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c1	;  #####  
			DC.B $ff	;         

			DC.B $ff	;          - $43
			DC.B $c3	;   ####  
			DC.B $99	;  ##  ## 
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $99	;  ##  ## 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $44
			DC.B $c1	;  #####  
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $c1	;  #####  
			DC.B $ff	;         

			DC.B $ff	;          - $45
			DC.B $81	;  ###### 
			DC.B $f9	;  ##     
			DC.B $c1	;  #####  
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $81	;  ###### 
			DC.B $ff	;         

			DC.B $ff	;          - $46
			DC.B $81	;  ###### 
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $c1	;  #####  
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $ff	;         

			DC.B $ff	;          - $47
			DC.B $c3	;   ####  
			DC.B $99	;  ##  ## 
			DC.B $f9	;  ##     
			DC.B $89	;  ## ### 
			DC.B $99	;  ##  ## 
			DC.B $83	;   ##### 
			DC.B $ff	;         

			DC.B $ff	;          - $48
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $81	;  ###### 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $ff	;         

			DC.B $ff	;          - $49
			DC.B $c3	;   ####  
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $4a
			DC.B $87	;    #### 
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $c9	;  ## ##  
			DC.B $c9	;  ## ##  
			DC.B $e3	;   ###   
			DC.B $ff	;         

			DC.B $ff	;          - $4b
			DC.B $99	;  ##  ## 
			DC.B $c9	;  ## ##  
			DC.B $e1	;  ####   
			DC.B $e1	;  ####   
			DC.B $c9	;  ## ##  
			DC.B $99	;  ##  ## 
			DC.B $ff	;         

			DC.B $ff	;          - $4c
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $81	;  ###### 
			DC.B $ff	;         

			DC.B $ff	;          - $4d
			DC.B $9d	;  #   ## 
			DC.B $89	;  ## ### 
			DC.B $81	;  ###### 
			DC.B $95	;  # # ## 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $ff	;         

			DC.B $ff	;          - $4e
			DC.B $9d	;  #   ## 
			DC.B $99	;  ##  ## 
			DC.B $91	;  ### ## 
			DC.B $85	;  # #### 
			DC.B $8d	;  #  ### 
			DC.B $9d	;  #   ## 
			DC.B $ff	;         

			DC.B $ff	;          - $4f
			DC.B $c3	;   ####  
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $50
			DC.B $c1	;  #####  
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c1	;  #####  
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $ff	;         

			DC.B $ff	;          - $51
			DC.B $c3	;   ####  
			DC.B $b9	;  ##   # 
			DC.B $b9	;  ##   # 
			DC.B $a9	;  ## # # 
			DC.B $d9	;  ##  #  
			DC.B $a3	;   ### # 
			DC.B $ff	;         

			DC.B $ff	;          - $52
			DC.B $c1	;  #####  
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c1	;  #####  
			DC.B $e9	;  ## #   
			DC.B $99	;  ##  ## 
			DC.B $ff	;         

			DC.B $ff	;          - $53
			DC.B $c3	;   ####  
			DC.B $f9	;  ##     
			DC.B $c3	;   ####  
			DC.B $8f	;     ### 
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $54
			DC.B $81	;  ###### 
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $ff	;         

			DC.B $ff	;          - $55
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  
			DC.B $ff	;         

			DC.B $ff	;          - $56
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $cb	;   # ##  
			DC.B $e7	;    ##   
			DC.B $ff	;         

			DC.B $ff	;          - $57
			DC.B $9d	;  #   ## 
			DC.B $9d	;  #   ## 
			DC.B $95	;  # # ## 
			DC.B $81	;  ###### 
			DC.B $89	;  ## ### 
			DC.B $9d	;  #   ## 
			DC.B $ff	;         

			DC.B $ff	;          - $58
			DC.B $9d	;  #   ## 
			DC.B $cb	;   # ##  
			DC.B $e7	;    ##   
			DC.B $e3	;   ###   
			DC.B $d9	;  ##  #  
			DC.B $bd	;  #    # 
			DC.B $ff	;         

			DC.B $ff	;          - $59
			DC.B $99	;  ##  ## 
			DC.B $99	;  ##  ## 
			DC.B $c3	;   ####  
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $ff	;         

			DC.B $ff	;          - $5a
			DC.B $81	;  ###### 
			DC.B $8f	;     ### 
			DC.B $c7	;    ###  
			DC.B $e3	;   ###   
			DC.B $f1	;  ###    
			DC.B $81	;  ###### 
			DC.B $ff	;         

			DC.B $ef	;     #    - $5b
			DC.B $e0	; #####   
			DC.B $e5	;  # ##   
			DC.B $ea	; # # #   
			DC.B $e5	;  # ##   
			DC.B $ea	; # # #   
			DC.B $a0	; ##### # 
			DC.B $e0	; #####   

			DC.B $8f	;     ###  - $5c
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $8f	;     ### 

			DC.B $e3	;   ###    - $5d
			DC.B $a7	;    ## # 
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $67	;    ##  #
			DC.B $e3	;   ###   

			DC.B $0f	;     #### - $5e
			DC.B $00	; ########
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         

			DC.B $00	; ######## - $5f
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $df	;      #  
			DC.B $ff	;         

			DC.B $e0	; #####    - $60
			DC.B $e0	; #####   
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $bf	;       # 
			DC.B $ff	;         

			DC.B $fe	; #        - $61
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $f8	; ###      - $62
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $f8	; ###     

			DC.B $00	; ######## - $63
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ef	;     #    - $64
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $e0	; #####   

			DC.B $e3	;   ###    - $65
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e3	;   ###   

			DC.B $e0	; #####    - $66
			DC.B $00	; ########
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         

			DC.B $9f	;      ##  - $67
			DC.B $9f	;      ## 
			DC.B $df	;      #  
			DC.B $1f	;      ###
			DC.B $5f	;      # #
			DC.B $3f	;       ##
			DC.B $5f	;      # #
			DC.B $8f	;     ### 

			DC.B $f9	;  ##      - $68
			DC.B $f9	;  ##     
			DC.B $fb	;   #     
			DC.B $f8	; ###     
			DC.B $fa	; # #     
			DC.B $fc	; ##      
			DC.B $fa	; # #     
			DC.B $f1	;  ###    

			DC.B $57	;    # # # - $69
			DC.B $e7	;    ##   
			DC.B $57	;    # # #
			DC.B $b7	;    #  # 
			DC.B $57	;    # # #
			DC.B $e7	;    ##   
			DC.B $57	;    # # #
			DC.B $b7	;    #  # 

			DC.B $fd	;  #       - $6a
			DC.B $fc	; ##      
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fc	; ##      
			DC.B $fd	;  #      
			DC.B $fd	;  #      

			DC.B $9f	;      ##  - $6b
			DC.B $8f	;     ### 
			DC.B $cf	;     ##  
			DC.B $8f	;     ### 
			DC.B $4f	;     ## #
			DC.B $9f	;      ## 
			DC.B $1f	;      ###
			DC.B $bf	;       # 

			DC.B $f9	;  ##      - $6c
			DC.B $f1	;  ###    
			DC.B $f1	;  ###    
			DC.B $f2	; # ##    
			DC.B $f1	;  ###    
			DC.B $fa	; # #     
			DC.B $f9	;  ##     
			DC.B $f8	; ###     

			DC.B $3f	;       ## - $6d
			DC.B $bf	;       # 
			DC.B $3f	;       ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $fd	;  #       - $6e
			DC.B $fc	; ##      
			DC.B $fd	;  #      
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $ff	;         

			DC.B $ff	;          - $6f
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $f8	; ###      - $70
			DC.B $ec	; ##  #   
			DC.B $fe	; #       
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $bf	;       #  - $71
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $df	;      #  
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $ff	;          - $72
			DC.B $bf	;       # 
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $e0	; #####   
			DC.B $e0	; #####   

			DC.B $bf	;       #  - $73
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ef	;     #   
			DC.B $fe	; #       
			DC.B $07	;    #####
			DC.B $f7	;    #    

			DC.B $bf	;       #  - $74
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $df	;      #  
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $1f	;      ### - $75
			DC.B $37	;    #  ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $ff	;          - $76
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $ff	;          - $77
			DC.B $ff	;         
			DC.B $03	;   ######
			DC.B $03	;   ######
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $b3	;   ##  # 
			DC.B $f3	;   ##    

			DC.B $ff	;          - $78
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     

			DC.B $ff	;          - $79
			DC.B $ff	;         
			DC.B $c0	; ######  
			DC.B $c0	; ######  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  

			DC.B $f3	;   ##     - $7a
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $b3	;   ##  # 
			DC.B $f3	;   ##    

			DC.B $ff	;          - $7b
			DC.B $fd	;  #      
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $f7	;    #    
			DC.B $fe	; #       
			DC.B $bf	;       # 
			DC.B $ff	;         

			DC.B $cf	;     ##   - $7c
			DC.B $cd	;  #  ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $ce	; #   ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  

			DC.B $ff	;          - $7d
			DC.B $bf	;       # 
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $ef	;     #   
			DC.B $7f	;        #
			DC.B $3d	;  #    ##
			DC.B $1f	;      ###

			DC.B $df	;      #   - $7e
			DC.B $fd	;  #      
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $ff	;          - $7f
			DC.B $fd	;  #      
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $f7	;    #    
			DC.B $fe	; #       
			DC.B $bc	; ##    # 
			DC.B $f8	; ###     

			DC.B $9f	;      ##  - $80
			DC.B $9d	;  #   ## 
			DC.B $9f	;      ## 
			DC.B $9f	;      ## 
			DC.B $97	;    # ## 
			DC.B $9e	; #    ## 
			DC.B $9f	;      ## 
			DC.B $9f	;      ## 

			DC.B $d9	;  ##  #   - $81
			DC.B $f9	;  ##     
			DC.B $b9	;  ##   # 
			DC.B $f9	;  ##     
			DC.B $f9	;  ##     
			DC.B $e9	;  ## #   
			DC.B $b9	;  ##   # 
			DC.B $f9	;  ##     

			DC.B $ff	;          - $82
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $00	; ########
			DC.B $fe	; #       

			DC.B $f8	; ###      - $83
			DC.B $ec	; ##  #   
			DC.B $fe	; #       
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $ff	;          - $84
			DC.B $bf	;       # 
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $e0	; #####   
			DC.B $ef	;     #   

			DC.B $fe	; #        - $85
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fe	; #       

			DC.B $ef	;     #    - $86
			DC.B $af	;     # # 
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $ef	;     #   
			DC.B $6f	;     #  #
			DC.B $ef	;     #   

			DC.B $fe	; #        - $87
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ef	;     #    - $88
			DC.B $e0	; #####   
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $bf	;       # 
			DC.B $ff	;         

			DC.B $fe	; #        - $89
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $fe	; #       

			DC.B $ef	;     #    - $8a
			DC.B $e0	; #####   
			DC.B $e5	;  # ##   
			DC.B $ea	; # # #   
			DC.B $e5	;  # ##   
			DC.B $ea	; # # #   
			DC.B $a0	; ##### # 
			DC.B $ef	;     #   

			DC.B $f3	;   ##     - $8b
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $03	;   ######
			DC.B $03	;   ######
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $df	;      #   - $8c
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $cf	;     ##   - $8d
			DC.B $cd	;  #  ##  
			DC.B $cf	;     ##  
			DC.B $cf	;     ##  
			DC.B $c0	; ######  
			DC.B $c0	; ######  
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $8e
			DC.B $f3	;   ##    
			DC.B $f1	;  ###    
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $f3	;   ##    
			DC.B $e1	;  ####   
			DC.B $ff	;         

			DC.B $ff	;          - $8f
			DC.B $e1	;  ####   
			DC.B $c6	; #  ###  
			DC.B $c7	;    ###  
			DC.B $e1	;  ####   
			DC.B $f8	; ###     
			DC.B $c0	; ######  
			DC.B $ff	;         

			DC.B $ff	;          - $90
			DC.B $ff	;         
			DC.B $e7	;    ##   
			DC.B $e3	;   ###   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $c3	;   ####  

			DC.B $ff	;          - $91
			DC.B $ff	;         
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $83	;   ##### 
			DC.B $8f	;     ### 
			DC.B $c3	;   ####  

			DC.B $ff	;          - $92
			DC.B $ff	;         
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  
			DC.B $8d	;  #  ### 
			DC.B $8d	;  #  ### 
			DC.B $c3	;   ####  

			DC.B $f7	;    #     - $93
			DC.B $07	;    #####
			DC.B $57	;    # # #
			DC.B $a7	;    ## # 
			DC.B $57	;    # # #
			DC.B $a7	;    ## # 
			DC.B $05	;  # #####
			DC.B $07	;    #####

			DC.B $c7	;    ###   - $94
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e5	;  # ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $e7	;    ##   
			DC.B $c7	;    ###  

			DC.B $07	;    ##### - $95
			DC.B $07	;    #####
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fd	;  #      
			DC.B $ff	;         

			DC.B $f8	; ###      - $96
			DC.B $ec	; ##  #   
			DC.B $fe	; #       
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $ff	;          - $97
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $bf	;       # 
			DC.B $bf	;       # 

			DC.B $ff	;          - $98
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fd	;  #      
			DC.B $fd	;  #      

			DC.B $bf	;       #  - $99
			DC.B $bf	;       # 
			DC.B $bf	;       # 
			DC.B $7f	;        #
			DC.B $bf	;       # 
			DC.B $bf	;       # 
			DC.B $bf	;       # 
			DC.B $3f	;       ##

			DC.B $fd	;  #       - $9a
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fe	; #       
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fc	; ##      

			DC.B $3f	;       ## - $9b
			DC.B $bf	;       # 
			DC.B $bf	;       # 
			DC.B $3f	;       ##
			DC.B $bf	;       # 
			DC.B $9f	;      ## 
			DC.B $af	;     # # 
			DC.B $af	;     # # 

			DC.B $fc	; ##       - $9c
			DC.B $fd	;  #      
			DC.B $fd	;  #      
			DC.B $fc	; ##      
			DC.B $fd	;  #      
			DC.B $f9	;  ##     
			DC.B $f5	;  # #    
			DC.B $f4	; ## #    

			DC.B $2f	;     # ## - $9d
			DC.B $af	;     # # 
			DC.B $2f	;     # ##
			DC.B $af	;     # # 
			DC.B $9f	;      ## 
			DC.B $af	;     # # 
			DC.B $b7	;    #  # 
			DC.B $07	;    #####

			DC.B $f5	;  # #     - $9e
			DC.B $f4	; ## #    
			DC.B $f5	;  # #    
			DC.B $f5	;  # #    
			DC.B $f9	;  ##     
			DC.B $f5	;  # #    
			DC.B $ed	;  #  #   
			DC.B $e0	; #####   

			DC.B $1f	;      ### - $9f
			DC.B $37	;    #  ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $0f	;     ####

			DC.B $ff	;          - $a0
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $00	; ########
			DC.B $e0	; #####   

			DC.B $0f	;     #### - $a1
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $00	; ######## - $a2
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $e0	; #####    - $a3
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $2f	;     # ## - $a4
			DC.B $af	;     # # 
			DC.B $2f	;     # ##
			DC.B $af	;     # # 
			DC.B $9f	;      ## 
			DC.B $ae	; #   # # 
			DC.B $b5	;  # #  # 
			DC.B $05	;  # #####

			DC.B $f5	;  # #     - $a5
			DC.B $f4	; ## #    
			DC.B $f5	;  # #    
			DC.B $f5	;  # #    
			DC.B $f9	;  ##     
			DC.B $75	;  # #   #
			DC.B $ad	;  #  # # 
			DC.B $a0	; ##### # 

			DC.B $3f	;       ## - $a6
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $3f	;       ##

			DC.B $5b	;   #  # # - $a7
			DC.B $9b	;   #  ## 
			DC.B $5b	;   #  # #
			DC.B $9b	;   #  ## 
			DC.B $41	;  ##### #
			DC.B $0a	; # # ####
			DC.B $d1	;  ### #  
			DC.B $25	;  # ## ##

			DC.B $d9	;  ##  #   - $a8
			DC.B $da	; # #  #  
			DC.B $d9	;  ##  #  
			DC.B $da	; # #  #  
			DC.B $81	;  ###### 
			DC.B $48	; ### ## #
			DC.B $93	;   ## ## 
			DC.B $a4	; ## ## # 

			DC.B $ff	;          - $a9
			DC.B $ff	;         
			DC.B $7f	;        #
			DC.B $7f	;        #
			DC.B $3f	;       ##
			DC.B $3f	;       ##
			DC.B $bf	;       # 
			DC.B $df	;      #  

			DC.B $ff	;          - $aa
			DC.B $ff	;         
			DC.B $fe	; #       
			DC.B $fe	; #       
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $fd	;  #      
			DC.B $fb	;   #     

			DC.B $1f	;      ### - $ab
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $9f	;      ## 
			DC.B $5f	;      # #
			DC.B $5f	;      # #
			DC.B $9f	;      ## 

			DC.B $f8	; ###      - $ac
			DC.B $fb	;   #     
			DC.B $fb	;   #     
			DC.B $fb	;   #     
			DC.B $f9	;  ##     
			DC.B $fa	; # #     
			DC.B $fa	; # #     
			DC.B $f9	;  ##     

			DC.B $5f	;      # # - $ad
			DC.B $9f	;      ## 
			DC.B $1f	;      ###
			DC.B $df	;      #  
			DC.B $df	;      #  
			DC.B $1f	;      ###
			DC.B $1f	;      ###
			DC.B $9f	;      ## 

			DC.B $f9	;  ##      - $ae
			DC.B $fa	; # #     
			DC.B $f8	; ###     
			DC.B $fb	;   #     
			DC.B $fb	;   #     
			DC.B $f8	; ###     
			DC.B $f8	; ###     
			DC.B $f9	;  ##     

			DC.B $ff	;          - $af
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $00	; ########
			DC.B $0f	;     ####

			DC.B $bf	;       #  - $b0
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ef	;     #   
			DC.B $fe	; #       
			DC.B $07	;    #####
			DC.B $07	;    #####

			DC.B $1f	;      ### - $b1
			DC.B $37	;    #  ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $07	;    ##### - $b2
			DC.B $07	;    #####
			DC.B $57	;    # # #
			DC.B $a7	;    ## # 
			DC.B $57	;    # # #
			DC.B $a7	;    ## # 
			DC.B $05	;  # #####
			DC.B $f7	;    #    

			DC.B $01	;  ####### - $b3
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $c1	;  #####  
			DC.B $61	;  ####  #
			DC.B $21	;  #### ##

			DC.B $00	; ######## - $b4
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $00	; ######## - $b5
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $03	;   ######
			DC.B $06	; #  #####
			DC.B $04	; ## #####

			DC.B $a1	;  #### #  - $b6
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 

			DC.B $05	;  # ##### - $b7
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####

			DC.B $21	;  #### ## - $b8
			DC.B $61	;  ####  #
			DC.B $c1	;  #####  
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $c1	;  #####  
			DC.B $61	;  ####  #
			DC.B $21	;  #### ##

			DC.B $ff	;          - $b9
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $04	; ## ##### - $ba
			DC.B $06	; #  #####
			DC.B $03	;   ######
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $03	;   ######
			DC.B $06	; #  #####
			DC.B $04	; ## #####

			DC.B $21	;  #### ## - $bb
			DC.B $61	;  ####  #
			DC.B $c1	;  #####  
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######

			DC.B $ff	;          - $bc
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $04	; ## ##### - $bd
			DC.B $06	; #  #####
			DC.B $03	;   ######
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $01	;  ####### - $be
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######

			DC.B $00	; ######## - $bf
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $00	; ######## - $c0
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $e0	; #####   
			DC.B $f0	; ####    
			DC.B $38	; ###   ##
			DC.B $18	; ###  ###
			DC.B $98	; ###  ## 

			DC.B $00	; ######## - $c1
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $00	; ######## - $c2
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $07	;    #####
			DC.B $0f	;     ####
			DC.B $1c	; ##   ###
			DC.B $18	; ###  ###
			DC.B $19	;  ##  ###

			DC.B $98	; ###  ##  - $c3
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 
			DC.B $98	; ###  ## 

			DC.B $19	;  ##  ### - $c4
			DC.B $19	;  ##  ###
			DC.B $19	;  ##  ###
			DC.B $19	;  ##  ###
			DC.B $19	;  ##  ###
			DC.B $19	;  ##  ###
			DC.B $19	;  ##  ###
			DC.B $19	;  ##  ###

			DC.B $98	; ###  ##  - $c5
			DC.B $18	; ###  ###
			DC.B $38	; ###   ##
			DC.B $f0	; ####    
			DC.B $e0	; #####   
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $ff	;          - $c6
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $19	;  ##  ### - $c7
			DC.B $18	; ###  ###
			DC.B $1c	; ##   ###
			DC.B $0f	;     ####
			DC.B $07	;    #####
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $00	; ########

			DC.B $f8	; ###      - $c8
			DC.B $ec	; ##  #   
			DC.B $fe	; #       
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $e0	; #####   

			DC.B $ff	;          - $c9
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $fb	;   #     
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $aa	; # # # #  - $ca
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $1f	;      ### - $cb
			DC.B $37	;    #  ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $1f	;      ### - $cc
			DC.B $3d	;  #    ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $fe	; #       
			DC.B $07	;    #####
			DC.B $f7	;    #    

			DC.B $ff	;          - $cd
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $fb	;   #     
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ef	;     #   

			DC.B $f8	; ###      - $ce
			DC.B $ec	; ##  #   
			DC.B $fe	; #       
			DC.B $ff	;         
			DC.B $bf	;       # 
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $0f	;     ####

			DC.B $e0	; #####    - $cf
			DC.B $e0	; #####   
			DC.B $e5	;  # ##   
			DC.B $ea	; # # #   
			DC.B $e5	;  # ##   
			DC.B $ea	; # # #   
			DC.B $a0	; ##### # 
			DC.B $ef	;     #   

			DC.B $bf	;       #  - $d0
			DC.B $3f	;       ##
			DC.B $1f	;      ###
			DC.B $ef	;     #   
			DC.B $f7	;    #    
			DC.B $3b	;   #   ##
			DC.B $3b	;   #   ##
			DC.B $9b	;   #  ## 

			DC.B $ea	; # # #    - $d1
			DC.B $e7	;    ##   
			DC.B $e8	; ### #   
			DC.B $8b	;   # ### 
			DC.B $72	; # ##   #
			DC.B $71	;  ###   #
			DC.B $f8	; ###     
			DC.B $4b	;   # ## #

			DC.B $e7	;    ##    - $d2
			DC.B $f3	;   ##    
			DC.B $f9	;  ##     
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $00	; ########
			DC.B $2e	; #   # ##
			DC.B $a8	; ### # # 

			DC.B $af	;     # #  - $d3
			DC.B $ef	;     #   
			DC.B $0f	;     ####
			DC.B $ef	;     #   
			DC.B $6f	;     #  #
			DC.B $60	; #####  #
			DC.B $60	; #####  #
			DC.B $6f	;     #  #

			DC.B $d1	;  ### #   - $d4
			DC.B $e3	;   ###   
			DC.B $50	; #### # #
			DC.B $63	;   ###  #
			DC.B $d2	; # ## #  
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $e0	; #####   

			DC.B $e7	;    ##    - $d5
			DC.B $cf	;     ##  
			DC.B $9c	; ##   ## 
			DC.B $3c	; ##    ##
			DC.B $3f	;       ##
			DC.B $00	; ########
			DC.B $74	; ## #   #
			DC.B $15	;  # # ###

			DC.B $57	;    # # # - $d6
			DC.B $e7	;    ##   
			DC.B $17	;    # ###
			DC.B $d1	;  ### #  
			DC.B $4e	; #   ## #
			DC.B $8e	; #   ### 
			DC.B $1f	;      ###
			DC.B $d2	; # ## #  

			DC.B $fd	;  #       - $d7
			DC.B $fc	; ##      
			DC.B $f8	; ###     
			DC.B $f7	;    #    
			DC.B $ef	;     #   
			DC.B $dc	; ##   #  
			DC.B $dc	; ##   #  
			DC.B $d9	;  ##  #  

			DC.B $d7	;    # #   - $d8
			DC.B $6b	;   # #  #
			DC.B $eb	;   # #   
			DC.B $a7	;    ## # 
			DC.B $9b	;   #  ## 
			DC.B $7d	;  #     #
			DC.B $bd	;  #    # 
			DC.B $3b	;   #   ##

			DC.B $83	;   #####  - $d9
			DC.B $87	;    #### 
			DC.B $72	; # ##   #
			DC.B $fb	;   #     
			DC.B $ea	; # # #   
			DC.B $67	;    ##  #
			DC.B $be	; #     # 
			DC.B $ce	; #   ##  

			DC.B $07	;    ##### - $da
			DC.B $67	;    ##  #
			DC.B $57	;    # # #
			DC.B $c6	; #  ###  
			DC.B $a2	; # ### # 
			DC.B $18	; ###  ###
			DC.B $63	;   ###  #
			DC.B $07	;    #####

			DC.B $6f	;     #  # - $db
			DC.B $60	; #####  #
			DC.B $0c	; ##  ####
			DC.B $1c	; ##   ###
			DC.B $42	; # #### #
			DC.B $4a	; # # ## #
			DC.B $0d	;  #  ####
			DC.B $81	;  ###### 

			DC.B $d0	; #### #   - $dc
			DC.B $00	; ########
			DC.B $10	; #### ###
			DC.B $08	; ### ####
			DC.B $42	; # #### #
			DC.B $4a	; # # ## #
			DC.B $00	; ########
			DC.B $01	;  #######

			DC.B $e0	; #####    - $dd
			DC.B $e0	; #####   
			DC.B $e8	; ### #   
			DC.B $62	; # ###  #
			DC.B $4d	;  #  ## #
			DC.B $18	; ###  ###
			DC.B $c3	;   ####  
			DC.B $ec	; ##  #   

			DC.B $c1	;  #####   - $de
			DC.B $e1	;  ####   
			DC.B $4e	; #   ## #
			DC.B $df	;      #  
			DC.B $57	;    # # #
			DC.B $e6	; #  ##   
			DC.B $7d	;  #     #
			DC.B $73	;   ##   #

			DC.B $eb	;   # #    - $df
			DC.B $d6	; #  # #  
			DC.B $d7	;    # #  
			DC.B $e5	;  # ##   
			DC.B $d9	;  ##  #  
			DC.B $be	; #     # 
			DC.B $bd	;  #    # 
			DC.B $dc	; ##   #  

			DC.B $ff	;          - $e0
			DC.B $ff	;         
			DC.B $0f	;     ####
			DC.B $07	;    #####
			DC.B $e3	;   ###   
			DC.B $33	;   ##  ##
			DC.B $93	;   ## ## 
			DC.B $d3	;   ## #  

			DC.B $ff	;          - $e1
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $e2
			DC.B $ff	;         
			DC.B $f0	; ####    
			DC.B $e0	; #####   
			DC.B $c7	;    ###  
			DC.B $cc	; ##  ##  
			DC.B $c9	;  ## ##  
			DC.B $cb	;   # ##  

			DC.B $d3	;   ## #   - $e3
			DC.B $d3	;   ## #  
			DC.B $d3	;   ## #  
			DC.B $d3	;   ## #  
			DC.B $d3	;   ## #  
			DC.B $d3	;   ## #  
			DC.B $d3	;   ## #  
			DC.B $d3	;   ## #  

			DC.B $cb	;   # ##   - $e4
			DC.B $cb	;   # ##  
			DC.B $cb	;   # ##  
			DC.B $cb	;   # ##  
			DC.B $cb	;   # ##  
			DC.B $cb	;   # ##  
			DC.B $cb	;   # ##  
			DC.B $cb	;   # ##  

			DC.B $d3	;   ## #   - $e5
			DC.B $93	;   ## ## 
			DC.B $33	;   ##  ##
			DC.B $e3	;   ###   
			DC.B $07	;    #####
			DC.B $0f	;     ####
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $ff	;          - $e6
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $cb	;   # ##   - $e7
			DC.B $c9	;  ## ##  
			DC.B $cc	; ##  ##  
			DC.B $c7	;    ###  
			DC.B $e0	; #####   
			DC.B $f0	; ####    
			DC.B $ff	;         
			DC.B $ff	;         

			DC.B $00	; ######## - $e8
			DC.B $00	; ########
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $aa	; # # # # 
			DC.B $00	; ########
			DC.B $fe	; #       

			DC.B $a1	;  #### #  - $e9
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $a1	;  #### # 
			DC.B $bf	;       # 
			DC.B $b5	;  # #  # 
			DC.B $ab	;   # # # 

			DC.B $05	;  # ##### - $ea
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $05	;  # #####
			DC.B $fd	;  #      
			DC.B $55	;  # # # #
			DC.B $ad	;  #  # # 

			DC.B $35	;  # #  ## - $eb
			DC.B $6b	;   # #  #
			DC.B $d5	;  # # #  
			DC.B $ab	;   # # # 
			DC.B $55	;  # # # #
			DC.B $ff	;         
			DC.B $01	;  #######
			DC.B $ff	;         

			DC.B $ff	;          - $ec
			DC.B $00	; ########
			DC.B $ff	;         
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $54	; ## # # # - $ed
			DC.B $ae	; #   # # 
			DC.B $57	;    # # #
			DC.B $aa	; # # # # 
			DC.B $55	;  # # # #
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $ff	;         

			DC.B $ff	;          - $ee
			DC.B $01	;  #######
			DC.B $ff	;         
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######
			DC.B $01	;  #######

			DC.B $1f	;      ### - $ef
			DC.B $37	;    #  ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $fd	;  #      
			DC.B $ff	;         
			DC.B $00	; ########
			DC.B $e0	; #####   

			DC.B $07	;    ##### - $f0
			DC.B $77	;    #   #
			DC.B $77	;    #   #
			DC.B $77	;    #   #
			DC.B $6f	;     #  #
			DC.B $11	;  ### ###
			DC.B $6e	; #   #  #
			DC.B $08	; ### ####

			DC.B $6f	;     #  # - $f1
			DC.B $60	; #####  #
			DC.B $0c	; ##  ####
			DC.B $1c	; ##   ###
			DC.B $42	; # #### #
			DC.B $4a	; # # ## #
			DC.B $0c	; ##  ####
			DC.B $80	; ####### 

			DC.B $e0	; #####    - $f2
			DC.B $e8	; ### #   
			DC.B $e4	; ## ##   
			DC.B $ea	; # # #   
			DC.B $f5	;  # #    
			DC.B $88	; ### ### 
			DC.B $73	;   ##   #
			DC.B $10	; #### ###

			DC.B $bf	;       #  - $f3
			DC.B $3f	;       ##
			DC.B $bf	;       # 
			DC.B $bf	;       # 
			DC.B $bf	;       # 
			DC.B $3f	;       ##
			DC.B $bf	;       # 
			DC.B $bf	;       # 

			DC.B $ea	; # # #    - $f4
			DC.B $e7	;    ##   
			DC.B $ea	; # # #   
			DC.B $ed	;  #  #   
			DC.B $ea	; # # #   
			DC.B $e7	;    ##   
			DC.B $ea	; # # #   
			DC.B $ed	;  #  #   

			DC.B $e7	;    ##    - $f5
			DC.B $f3	;   ##    
			DC.B $f9	;  ##     
			DC.B $fc	; ##      
			DC.B $fc	; ##      
			DC.B $00	; ########
			DC.B $3e	; #     ##
			DC.B $b9	;  ##   # 

			DC.B $e7	;    ##    - $f6
			DC.B $cf	;     ##  
			DC.B $9c	; ##   ## 
			DC.B $3c	; ##    ##
			DC.B $3f	;       ##
			DC.B $00	; ########
			DC.B $7c	; ##     #
			DC.B $9d	;  #   ## 

			DC.B $07	;    ##### - $f7
			DC.B $77	;    #   #
			DC.B $77	;    #   #
			DC.B $77	;    #   #
			DC.B $6f	;     #  #
			DC.B $1f	;      ###
			DC.B $4f	;     ## #
			DC.B $0f	;     ####

			DC.B $e0	; #####    - $f8
			DC.B $e8	; ### #   
			DC.B $e4	; ## ##   
			DC.B $ea	; # # #   
			DC.B $f5	;  # #    
			DC.B $f8	; ###     
			DC.B $f1	;  ###    
			DC.B $f0	; ####    

			DC.B $1f	;      ### - $f9
			DC.B $3d	;  #    ##
			DC.B $7f	;        #
			DC.B $ff	;         
			DC.B $ff	;         
			DC.B $fe	; #       
			DC.B $07	;    #####
			DC.B $07	;    #####

