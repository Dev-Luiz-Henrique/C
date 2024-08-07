       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX02.
       AUTHOR. GABRIEL GOMES DA CRUZ / LUIZ HENRIQUE DE SANTANA.
       INSTALLATION. FATEC-SP.
       DATE-WRITTEN. 10/10/2023.
       DATE-COMPILED.
       SECURITY. APENAS O AUTOR PODE MODIFICAR.
      *REMARKS.  LER OS DADOS DO ARQUIVO DE ENTRADA CADCLI1 E GRAVAR
      *          NO ARQUIVO DE SAI RELCLI OS CLIENTES DE 2010 A 2011.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
           SOURCE-COMPUTER. IBM-PC.
           OBJECT-COMPUTER. IBM-PC.
           SPECIAL-NAMES.   DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADCLI1 ASSIGN TO DISK ORGANIZATION IS
               LINE SEQUENTIAL.
           SELECT RELCLI ASSIGN TO DISK.

       DATA DIVISION.
       FILE SECTION.
       FD CADCLI1 LABEL RECORD ARE STANDARD VALUE OF FILE-ID IS
           "CADCLI1.DAT".

           01 REG-ENT.
             02 CPF-CLIE-ENT      PIC 9(11).
             02 NOME-CLIE-ENT     PIC X(30).
             02 ESTADO-ENT        PIC X(02).
             02 CIDADE-ENT        PIC X(30).
             02 TELL-ENT          PIC 9(08).
             02 TELL-FORMATADO REDEFINES TELL-ENT.
               03 TELL-PREFIXO    PIC 9999.
               03 TELL-SUFIXO     PIC 9999.
             02 DT-ULT-VISIT-ENT.
               03 DD-ENT    PIC 9(02).
               03 MM-ENT    PIC 9(02).
               03 AAAA-ENT  PIC 9(04).

       FD RELCLI LABEL RECORD IS OMITTED.
           01 REL-CLI PIC X(80).

       WORKING-STORAGE SECTION.
           77 FIM-ARQ PIC X(03) VALUE "NAO".
           77 CT-LIN PIC 9(02) VALUE 26.
           77 CT-PAG PIC 9(02) VALUE ZEROS.
           77 CT-CLIE PIC 9(02) VALUE ZEROS.

           01 CAB-01.
             02 FILLER PIC X(70) VALUE SPACES.
             02 FILLER PIC X(05) VALUE "Pag. ".
             02 CAB-PAG PIC 9(02).
             02 FILLER PIC X(03) VALUE SPACES.

           01 CAB-02.
             02 FILLER PIC X(32) VALUE SPACES.
             02 FILLER PIC X(17) VALUE "TURISMAR TURISMOS".
             02 FILLER PIC X(01) VALUE SPACES.
             02 FILLER PIC X(32) VALUE SPACES.

           01 CAB-03.
             02 FILLER PIC X(22) VALUE SPACES.
             02 FILLER PIC X(24) VALUE "CLIENTES NO PERIODO DE: ".
             02 FILLER PIC X(11) VALUE "2010 A 2011".
             02 FILLER PIC X(01) VALUE SPACES.
             02 FILLER PIC X(22) VALUE SPACES.

           01 CAB-04.          
             02 FILLER PIC X(18) VALUE SPACES.
             02 FILLER PIC X(04) VALUE "NOME".
             02 FILLER PIC X(22) VALUE SPACES.
             02 FILLER PIC X(06) VALUE "ESTADO".
             02 FILLER PIC X(13) VALUE SPACES.
             02 FILLER PIC X(08) VALUE "TELEFONE".
             02 FILLER PIC X(09) VALUE SPACES.

           01 CAB-05.
             02 FILLER PIC X(80) VALUE ALL "-".

           01 ROD-01.
             02 FILLER PIC X(05) VALUE SPACES.
             02 FILLER PIC X(19) VALUE "Total de Clientes: ".
             02 ROD-TOT-CLIE PIC 9(05).
             02 FILLER PIC X(51) VALUE SPACES.

           01 DETALHE.
             02 FILLER PIC X(06) VALUE SPACES.
             02 DET-NOME PIC X(30).
             02 FILLER PIC X(10) VALUE SPACES.
             02 DET-ESTADO PIC X(02).
             02 FILLER PIC X(14) VALUE SPACES.
             02 DET-TELL-PREFIXO PIC 9999.
             02 FILLER PIC X VALUE "-".
             02 DET-TELL-SUFIXO PIC 9999.
             02 FILLER PIC X(09) VALUE SPACES.

       PROCEDURE DIVISION.
       PGM-EX02.
           PERFORM INICIO.
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "SIM".
           PERFORM TERMINO.
           STOP RUN.

       INICIO.
           OPEN INPUT CADCLI1 OUTPUT RELCLI.
           PERFORM LEITURA.

       LEITURA.
           READ CADCLI1 AT END MOVE "SIM" TO FIM-ARQ.

       PRINCIPAL.
           PERFORM GRAVACAO.
           PERFORM LEITURA.
           IF FIM-ARQ EQUAL "SIM"
               PERFORM RODAPE.

       GRAVACAO.  
           IF CT-LIN GREATER THAN 25
               PERFORM CABECALHO.
           IF AAAA-ENT EQUAL 2011 OR AAAA-ENT EQUAL 2010
               PERFORM IMPRIME-DETALHE.

       CABECALHO.
           ADD 1 TO CT-PAG.
           MOVE 1 TO CT-LIN.
           MOVE CT-PAG TO CAB-PAG.
           MOVE SPACES TO REL-CLI.
           WRITE REL-CLI AFTER ADVANCING PAGE.
           WRITE REL-CLI FROM CAB-01 AFTER ADVANCING 1 LINE.
           WRITE REL-CLI FROM CAB-02 AFTER ADVANCING 1 LINES.  
           WRITE REL-CLI FROM CAB-03 AFTER ADVANCING 3 LINES. 
           WRITE REL-CLI FROM CAB-04 AFTER ADVANCING 3 LINES.
           WRITE REL-CLI FROM CAB-05 AFTER ADVANCING 1 LINES.
           MOVE SPACES TO REL-CLI.
           WRITE REL-CLI AFTER ADVANCING 1 LINE.

       RODAPE.
           MOVE CT-CLIE TO ROD-TOT-CLIE.
           WRITE REL-CLI FROM ROD-01 AFTER ADVANCING 3 LINES.

       IMPRIME-DETALHE.
           MOVE NOME-CLIE-ENT TO DET-NOME.
           MOVE ESTADO-ENT TO DET-ESTADO.
           MOVE TELL-PREFIXO TO DET-TELL-PREFIXO.
           MOVE TELL-SUFIXO TO DET-TELL-SUFIXO.
           WRITE REL-CLI FROM DETALHE AFTER ADVANCING 1 LINE.
           ADD 1 TO CT-LIN.
           ADD 1 TO CT-CLIE.

       TERMINO.
           CLOSE CADCLI1 RELCLI.