       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX04.
       AUTHOR.         LUIZ HENRIQUE DE SANTANA 
                       GABRIEL GOMES DA CRUZ
                       NICOLE CARVALHO FUKUSHIMA.
       INSTALLATION.   FATEC-SP.
       DATE-WRITTEN.   11/11/2023.
       DATE-COMPILED.
       SECURITY. APENAS O AUTOR PODE MODIFICAR.
      *REMARKS.  LER O ARQUIVO DE ENTRADA CADCLIE, CLASSIFICANDO-O
      *          EM ORDEM ASCENDENTE POR CPF, ALEM DE SEPARAR OS
      *          DADOS POR ESTADO E CIDADE PRIMEIRAMENTE, GERANDO
      *          O RELATORIO DE SAIDA RELGERAL.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       OBJECT-COMPUTER. IBM-PC.
       SOURCE-COMPUTER. IBM-PC.
       SPECIAL-NAMES.   DECIMAL-POINT IS COMMA.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT CADCLIE ASSIGN TO DISK ORGANIZATION IS LINE
           SEQUENTIAL.
       SELECT TRAB ASSIGN TO DISK.
       SELECT RELGERAL ASSIGN TO DISK.

       DATA DIVISION.
       FILE SECTION.
       FD CADCLIE LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "CADCLIE.DAT".
       01 CAD-ENT.
           02 COD-ENT        PIC 9(03).
           02 CPF-ENT        PIC 9(11).
           02 NOME-ENT       PIC X(30).
           02 ESTADO-ENT     PIC X(02).
           02 CIDADE-ENT     PIC X(30).
           02 EMAIL-ENT      PIC X(30).

       SD TRAB.
       01 CAD-TRAB.
         02 COD-TRAB         PIC 9(03).
         02 CPF-TRAB         PIC 9(11).
         02 RED-CPF-TRAB REDEFINES CPF-TRAB.
             03 NUM-CPF-TRAB  PIC 9(09).
             03 DIGT-CPF-TRAB PIC 99.
         02 NOME-TRAB        PIC X(30).
         02 ESTADO-TRAB      PIC X(02).
         02 CIDADE-TRAB      PIC X(30).
         02 EMAIL-TRAB       PIC X(30).

       FD RELGERAL LABEL RECORD ARE OMMITED.
       01 REL-GRL         PIC X(80).

       WORKING-STORAGE SECTION.
       77 FIM-ARQ PIC XXX VALUE "NAO".
       77 CT-LIN PIC 9(02) VALUE 21.
       77 CT-PAG PIC 9(02) VALUE 0.
       77 CT-I PIC 99 VALUE 1.
       77 WCIDADE-REL PIC X(30).

       01 CAB-01.
           02 FILLER PIC X(23) VALUE SPACES.
           02 FILLER PIC X(39) VALUE  
               "RELAÇÃO DE CLIENTES POR ESTADO/CIDADE".
           02 FILLER PIC X(07) VALUE SPACES.
           02 FILLER PIC X(05) VALUE "PAG. ".
           02 VAR-PAG PIC ZZ9.
           02 FILLER PIC X(03) VALUE SPACES.

       01 CAB-02.
           02 FILLER PIC X(08) VALUE "ESTADO: ".
           02 ESTADO-CAB PIC X(19).
           02 FILLER PIC X(53) VALUE SPACES.
         
       01 CAB-03.
           02 FILLER PIC X(08) VALUE "CIDADE: ".
           02 CIDADE-CAB PIC X(30).
           02 FILLER PIC X(42) VALUE SPACES.

       01 CAB-04.
           02 FILLER PIC X(03) VALUE "CPF".
           02 FILLER PIC X(24) VALUE SPACES.
           02 FILLER PIC X(04) VALUE "NOME".
           02 FILLER PIC X(20) VALUE SPACES.
           02 FILLER PIC X(06) VALUE "E-MAIL". 
           02 FILLER PIC X(23) VALUE SPACES.

       01 DETALHE.
           02 CPF-NUM-DET PIC 999.999.999.
           02 FILLER PIC X(01) VALUE "-".
           02 CPF-DIGT-DET PIC 99.
           02 FILLER PIC X(03) VALUE SPACES.
           02 NOME-DET PIC X(30).
           02 FILLER PIC X(03) VALUE SPACES.
           02 EMAIL-DET PIC X(30).

       01 TABELA.
         02 TAB-SIGLAS-ESTADOS.
           03 FILLER PIC X(21) VALUE "ACACRE               ".
           03 FILLER PIC X(21) VALUE "ALALAGOAS            ".
           03 FILLER PIC X(21) VALUE "AMAMAZONAS           ".
           03 FILLER PIC X(21) VALUE "APAMAPA              ".
           03 FILLER PIC X(21) VALUE "BABAHIA              ".
           03 FILLER PIC X(21) VALUE "CECEARA              ".
           03 FILLER PIC X(21) VALUE "DFDISTRITO FEDERAL   ".
           03 FILLER PIC X(21) VALUE "ESESPIRITO SANTO     ".
           03 FILLER PIC X(21) VALUE "GOGOIAS              ".
           03 FILLER PIC X(21) VALUE "MAMARANHAO           ".
           03 FILLER PIC X(21) VALUE "MGMINAS GERAIS       ".
           03 FILLER PIC X(21) VALUE "MSMATO GROSSO DO SUL ".
           03 FILLER PIC X(21) VALUE "MTMATO GROSSO        ".
           03 FILLER PIC X(21) VALUE "PAPARA               ".
           03 FILLER PIC X(21) VALUE "PBPARAIBA            ".
           03 FILLER PIC X(21) VALUE "PEPERNAMBUCO         ".
           03 FILLER PIC X(21) VALUE "PIPIAUI              ".
           03 FILLER PIC X(21) VALUE "PRPARANA             ".
           03 FILLER PIC X(21) VALUE "RJRIO DE JANEIRO     ".
           03 FILLER PIC X(21) VALUE "RNRIO GRANDE DO NORTE".
           03 FILLER PIC X(21) VALUE "RORONDONIA           ".
           03 FILLER PIC X(21) VALUE "RRRORAIMA            ".
           03 FILLER PIC X(21) VALUE "RSRIO GRANDE DO SUL  ".
           03 FILLER PIC X(21) VALUE "SCSANTA CATARINA     ".
           03 FILLER PIC X(21) VALUE "SESERGIPE            ".
           03 FILLER PIC X(21) VALUE "SPSAO PAULO          ".
           03 FILLER PIC X(21) VALUE "TOTOCANTINS          ".

       01 TAB-ESTADOS REDEFINES TABELA OCCURS 27 TIMES.
           02 SIGLA  PIC X(02).
           02 ESTADO PIC X(19).
       
       PROCEDURE DIVISION.
       PGM-EX04.
           SORT TRAB ASCENDING KEY ESTADO-TRAB, CIDADE-TRAB, 
               CPF-TRAB USING CADCLIE OUTPUT PROCEDURE ROT-SAIDA.
           STOP RUN.

       ROT-SAIDA SECTION.
           PERFORM INICIO.
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "SIM".
           PERFORM FIM.
           
       INICIO SECTION.
           OPEN OUTPUT RELGERAL.
           PERFORM LEITURA.
       
       LEITURA SECTION.
           RETURN TRAB AT END MOVE "SIM" TO FIM-ARQ.

       PRINCIPAL SECTION.
           PERFORM IMPRESSAO.
           PERFORM LEITURA.

       IMPRESSAO SECTION.
           IF CT-LIN GREATER THAN 19
               PERFORM CABECALHO.
           
           IF CIDADE-TRAB NOT EQUAL WCIDADE-REL
               MOVE CIDADE-TRAB TO WCIDADE-REL
               PERFORM IMP-CAB-LOCAL.
           PERFORM IMP-DETALHE.

       CABECALHO SECTION.
           ADD 1 TO CT-PAG.
           MOVE CT-PAG TO VAR-PAG.
           MOVE SPACES TO REL-GRL.
           WRITE REL-GRL AFTER ADVANCING PAGE.
           WRITE REL-GRL FROM CAB-01 AFTER ADVANCING 1 LINE.
           MOVE ZEROES TO CT-LIN.

       IMP-CAB-LOCAL SECTION.
           PERFORM BUSCA-ESTADO UNTIL CT-I GREATER THAN 27.
           MOVE 1 TO CT-I.
           MOVE CIDADE-TRAB TO CIDADE-CAB.
           WRITE REL-GRL FROM CAB-02 AFTER ADVANCING 2 LINES.
           WRITE REL-GRL FROM CAB-03 AFTER ADVANCING 2 LINES.
           WRITE REL-GRL FROM CAB-04 AFTER ADVANCING 2 LINES.
       
       BUSCA-ESTADO SECTION.
           IF SIGLA(CT-I) EQUAL ESTADO-TRAB
               MOVE ESTADO(CT-I) TO ESTADO-CAB
               MOVE 99 TO CT-I
           ELSE
               ADD 1 TO CT-I.
               IF CT-I EQUAL 27
                   MOVE "ESTADO INVALIDO    " TO ESTADO-CAB.

       IMP-DETALHE SECTION.
           MOVE NUM-CPF-TRAB TO CPF-NUM-DET.
           MOVE DIGT-CPF-TRAB TO CPF-DIGT-DET.
           MOVE NOME-TRAB TO NOME-DET.
           MOVE EMAIL-TRAB TO EMAIL-DET.
           WRITE REL-GRL FROM DETALHE AFTER ADVANCING 1 LINE.
           ADD 1 TO CT-LIN.
           
       FIM SECTION.
           CLOSE RELGERAL.