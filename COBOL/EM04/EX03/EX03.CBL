       IDENTIFICATION DIVISION.
       PROGRAM-ID.     EX03.
       AUTHOR.         LUIZ HENRIQUE DE SANTANA
                       GABRIEL GOMES DA CRUZ.
       INSTALLATION.   FATEC-SP.
       DATE-WRITTEN.   24/11/2023.
       DATE-COMPILED.
       SECURITY.       APENAS O AUTOR PODE MODIFICA-LO.
      *REMARKS.        FAZER O BALANCE-LINE, GERANDO UM ARQUIVO
      *                ATUALIZADO E DOIS RELATORIOS, UM COM AS
      *                MERCADORIAS E OUTRO COM OS ERROS.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADMERC ASSIGN TO DISK ORGANIZATION 
               IS LINE SEQUENTIAL.
           SELECT MOVMERC ASSIGN TO DISK ORGANIZATION 
               IS LINE SEQUENTIAL.
           SELECT ATUMERC ASSIGN TO DISK ORGANIZATION 
               IS LINE SEQUENTIAL.
           SELECT RELERRO ASSIGN TO DISK.
           SELECT RELMERC ASSIGN TO DISK.

       DATA DIVISION.
       FILE SECTION.

       FD CADMERC LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "CADMERC.DAT".
       01 REG-CADMERC.
           02 COD-MERC-CADMERC         PIC 9(03).
           02 DESCRICAO-CADMERC        PIC X(30).
           02 ESTOQ-MIN-CADMERC        PIC 9(03).
           02 QNTD-ESTOQ-CADMERC       PIC 9(03).
           02 PRECO-UNIT-CADMERC       PIC 9(04)V9(02).
      
       FD MOVMERC LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "MOVMERC.DAT".
       01 REG-MOVMERC.
           02 COD-MERC-MOVMERC         PIC 9(03).
           02 DESCRICAO-MOVMERC        PIC X(30).
           02 ESTOQ-MIN-MOVMERC        PIC 9(03).
           02 QNTD-ESTOQ-MOVMERC       PIC 9(03).
           02 PRECO-UNIT-MOVMERC       PIC 9(04)V9(02).
           02 TP-ATUALIZACAO-MOVMERC   PIC X(01).
      
       FD ATUMERC LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "ATUMERC.DAT".
       01 REG-ATUMERC.
         02 COD-MERC-ATUMERC           PIC 9(03).
         02 DESCRICAO-ATUMERC          PIC X(30).
         02 ESTOQ-MIN-ATUMERC          PIC 9(03).
         02 QNTD-ESTOQ-ATUMERC         PIC 9(03).
         02 PRECO-UNIT-ATUMERC         PIC 9(04)V9(02).
      
       FD RELERRO LABEL RECORD IS OMITTED.
       01 REL-ERRO                     PIC X(80).

       FD RELMERC LABEL RECORD IS OMITTED.
       01 REL-MERC                     PIC X(80).

       WORKING-STORAGE SECTION.
       77 CH-CADMERC                   PIC X(04) VALUE SPACES.
       77 CH-MOVMERC                   PIC X(04) VALUE SPACES.
       77 CT-PAG-RELERRO               PIC 9(03) VALUE ZEROS.
       77 CT-LIN-RELERRO               PIC 9(02) VALUE 41.
       77 CT-PAG-RELMERC               PIC 9(03) VALUE ZEROS.
       77 CT-LIN-RELMERC               PIC 9(02) VALUE 41.

       01 CAB-01-RELERRO.
           02 FILLER PIC X(27) VALUE SPACES.
           02 FILLER PIC X(24) VALUE "RELAÇÃO DE MERCADORIAS".
           02 FILLER PIC X(15) VALUE SPACES.
           02 FILLER PIC X(05) VALUE "PAG. ".
           02 VAR-PAG-RELERRO PIC ZZ9.
           02 FILLER PIC X(06) VALUE SPACES.

       01 CAB-02-RELERRO.
           02 FILLER PIC X(29) VALUE SPACES.
           02 FILLER PIC X(22) VALUE "ERROS DE ATUALIZAÇÃO".
           02 FILLER PIC X(29) VALUE SPACES.

       01 CAB-03-RELERRO.
           02 FILLER PIC X(03) VALUE SPACES.
           02 FILLER PIC X(06) VALUE "CODIGO".
           02 FILLER PIC X(09) VALUE SPACES.
           02 FILLER PIC X(11) VALUE "DESCRIÇÃO".
           02 FILLER PIC X(25) VALUE SPACES.
           02 FILLER PIC X(08) VALUE "MENSAGEM".
           02 FILLER PIC X(18) VALUE SPACES.

       01 DETALHE-RELERRO.
           02 FILLER PIC X(04) VALUE SPACES.
           02 COD-DET-ERRO PIC 9(03).
           02 FILLER PIC X(04) VALUE SPACES.
           02 DESC-DET-ERRO PIC X(30).
           02 FILLER PIC X(01) VALUE SPACES.
           02 MSG-DET-ERRO PIC X(35).
           02 FILLER PIC X(01) VALUE SPACES.

       01 CAB-01-RELMERC.
           02 FILLER PIC X(27) VALUE SPACES.
           02 FILLER PIC X(24) VALUE "RELAÇÃO DE MERCADORIAS".
           02 FILLER PIC X(15) VALUE SPACES.
           02 FILLER PIC X(05) VALUE "PAG. ".
           02 VAR-PAG-RELMERC PIC ZZ9.
           02 FILLER PIC X(06) VALUE SPACES.

       01 CAB-02-RELMERC.
           02 FILLER PIC X(32) VALUE SPACES.
           02 FILLER PIC X(16) VALUE "ESTOQUE CRÍTICO".
           02 FILLER PIC X(31) VALUE SPACES.

       01 CAB-03-RELMERC.
           02 FILLER PIC X(02) VALUE SPACES.
           02 FILLER PIC X(06) VALUE "CODIGO".
           02 FILLER PIC X(09) VALUE SPACES.
           02 FILLER PIC X(11) VALUE "DESCRIÇÃO".
           02 FILLER PIC X(13) VALUE SPACES.
           02 FILLER PIC X(07) VALUE "ESTOQUE".
           02 FILLER PIC X(05) VALUE SPACES.
           02 FILLER PIC X(10) VALUE "QUANTIDADE".
           02 FILLER PIC X(06) VALUE SPACES.
           02 FILLER PIC X(06) VALUE "PREÇO".
           02 FILLER PIC X(05) VALUE SPACES.

       01 CAB-04-RELMERC.
           02 FILLER PIC X(39) VALUE SPACES.
           02 FILLER PIC X(07) VALUE "MÍNIMO".
           02 FILLER PIC X(08) VALUE SPACES.
           02 FILLER PIC X(07) VALUE "ESTOQUE".
           02 FILLER PIC X(06) VALUE SPACES.
           02 FILLER PIC X(09) VALUE "UNITÁRIO".
           02 FILLER PIC X(04) VALUE SPACES.

       01 DETALHE-RELMERC.
           02 FILLER PIC X(03) VALUE SPACES.
           02 COD-DET-MERC PIC 9(03).
           02 FILLER PIC X(02) VALUE SPACES.
           02 DESC-DET-MERC PIC X(30).
           02 FILLER PIC X(06) VALUE SPACES.
           02 ESTOQ-MIN-DET-MERC PIC 999.
           02 FILLER PIC X(09) VALUE SPACES.
           02 QNTD-ESTOQ-DET-MERC PIC 999.
           02 FILLER PIC X(09) VALUE SPACES.
           02 PRECO-UNIT-DET-MERC PIC Z.Z99,99.
           02 FILLER PIC X(04) VALUE SPACES.

       PROCEDURE DIVISION.
       PGM-EX03.
           PERFORM INICIO.
           PERFORM PRINCIPAL UNTIL CH-CADMERC EQUAL HIGH-VALUES 
                               AND CH-MOVMERC EQUAL HIGH-VALUES.
           PERFORM TERMINO.
           STOP RUN.

      *================================================================*

       INICIO.
           OPEN INPUT  CADMERC MOVMERC 
                OUTPUT ATUMERC RELERRO RELMERC.
           PERFORM LER-CADMERC.
           PERFORM LER-MOVMERC.

      *================================================================*

       LER-CADMERC.
           READ CADMERC AT END MOVE HIGH-VALUES TO CH-CADMERC.
           IF CH-CADMERC EQUAL HIGH-VALUES
              NEXT SENTENCE
           ELSE
              MOVE COD-MERC-CADMERC TO CH-CADMERC.
      
       LER-MOVMERC.
           READ MOVMERC AT END MOVE HIGH-VALUES TO CH-MOVMERC.
           IF CH-MOVMERC EQUAL HIGH-VALUES
              NEXT SENTENCE
           ELSE
              MOVE COD-MERC-MOVMERC TO CH-MOVMERC.

      *================================================================*

       PRINCIPAL.
           PERFORM VERIFICA-CABECALHO.
           
           IF CH-CADMERC EQUAL CH-MOVMERC
               PERFORM CADMERC-IGUAL-MOVMERC
               PERFORM LER-CADMERC
               PERFORM LER-MOVMERC
           ELSE
               IF CH-CADMERC LESS CH-MOVMERC
                   PERFORM CADMERC-MENOR
                   PERFORM LER-CADMERC
               ELSE 
                   PERFORM MOVMERC-MENOR
                   PERFORM LER-MOVMERC
               END-IF
           END-IF.

      *================================================================*
      *        1 - Inclusao;   2 - Alteracao;  3 - Exclusao.

       CADMERC-IGUAL-MOVMERC.
           EVALUATE TRUE
             WHEN TP-ATUALIZACAO-MOVMERC EQUAL '1'
               MOVE "INCLUSÃO DE REG. JÁ EXISTENTE" TO MSG-DET-ERRO
               PERFORM IMP-DET-RELERRO
               PERFORM GRAVAR-CADMERC-ATUMERC

             WHEN TP-ATUALIZACAO-MOVMERC EQUAL '2'
               PERFORM GRAVAR-MOVMERC-ATUMERC

             WHEN TP-ATUALIZACAO-MOVMERC EQUAL '3'
               NEXT SENTENCE
           END-EVALUATE.

       CADMERC-MENOR.
           PERFORM GRAVAR-CADMERC-ATUMERC.

       MOVMERC-MENOR.
           EVALUATE TRUE
             WHEN TP-ATUALIZACAO-MOVMERC EQUAL '1'
               PERFORM GRAVAR-MOVMERC-ATUMERC

             WHEN TP-ATUALIZACAO-MOVMERC EQUAL '2'
               MOVE "ALTERAÇÃO DE REG. NÃO EXISTENTE" TO MSG-DET-ERRO
               PERFORM IMP-DET-RELERRO

             WHEN TP-ATUALIZACAO-MOVMERC EQUAL '3'
               MOVE "EXCLUSAO DE REG. NÃO EXISTENTE" TO MSG-DET-ERRO
               PERFORM IMP-DET-RELERRO
           END-EVALUATE.
       
      *================================================================*

       GRAVAR-CADMERC-ATUMERC.
           MOVE COD-MERC-CADMERC   TO COD-MERC-ATUMERC.          
           MOVE DESCRICAO-CADMERC  TO DESCRICAO-ATUMERC.
           MOVE ESTOQ-MIN-CADMERC  TO ESTOQ-MIN-ATUMERC.
           MOVE QNTD-ESTOQ-CADMERC TO QNTD-ESTOQ-ATUMERC.
           MOVE PRECO-UNIT-CADMERC TO PRECO-UNIT-ATUMERC.
           WRITE REG-ATUMERC.
           PERFORM IMP-DET-RELMERC.
           
       GRAVAR-MOVMERC-ATUMERC.
           MOVE COD-MERC-MOVMERC   TO COD-MERC-ATUMERC.          
           MOVE DESCRICAO-MOVMERC  TO DESCRICAO-ATUMERC.
           MOVE ESTOQ-MIN-MOVMERC  TO ESTOQ-MIN-ATUMERC.
           MOVE QNTD-ESTOQ-MOVMERC TO QNTD-ESTOQ-ATUMERC.
           MOVE PRECO-UNIT-MOVMERC TO PRECO-UNIT-ATUMERC.
           WRITE REG-ATUMERC.      
           PERFORM IMP-DET-RELMERC.     
               
      *================================================================*

       IMP-DET-RELERRO.
           MOVE COD-MERC-MOVMERC  TO COD-DET-ERRO.
           MOVE DESCRICAO-MOVMERC TO DESC-DET-ERRO.
           WRITE REL-ERRO FROM DETALHE-RELERRO AFTER
               ADVANCING 1 LINE.
           ADD 1 TO CT-LIN-RELERRO.

       IMP-DET-RELMERC.
           IF QNTD-ESTOQ-ATUMERC NOT GREATER THAN ESTOQ-MIN-ATUMERC
              MOVE COD-MERC-ATUMERC   TO COD-DET-MERC          
              MOVE DESCRICAO-ATUMERC  TO DESC-DET-MERC
              MOVE ESTOQ-MIN-ATUMERC  TO ESTOQ-MIN-DET-MERC
              MOVE QNTD-ESTOQ-ATUMERC TO QNTD-ESTOQ-DET-MERC
              MOVE PRECO-UNIT-ATUMERC TO PRECO-UNIT-DET-MERC 
              WRITE REL-MERC FROM DETALHE-RELMERC AFTER
                  ADVANCING 1 LINE
              ADD 1 TO CT-LIN-RELMERC.

      *================================================================*
       
       VERIFICA-CABECALHO.
           IF CT-LIN-RELERRO GREATER THAN 40
              PERFORM CABECALHO-RELERRO.

           IF CT-LIN-RELMERC GREATER THAN 40
              PERFORM CABECALHO-RELMERC.

       CABECALHO-RELERRO.
           ADD 1 TO CT-PAG-RELERRO.
           MOVE CT-PAG-RELERRO TO VAR-PAG-RELERRO.
           MOVE SPACES TO REL-ERRO.

           WRITE REL-ERRO AFTER ADVANCING PAGE.
           WRITE REL-ERRO FROM CAB-01-RELERRO
                 AFTER ADVANCING 1 LINE.
           WRITE REL-ERRO FROM CAB-02-RELERRO
                 AFTER ADVANCING 2 LINES.
           WRITE REL-ERRO FROM CAB-03-RELERRO
                 AFTER ADVANCING 2 LINES.
           MOVE SPACES TO REL-ERRO.
           WRITE REL-ERRO AFTER ADVANCING 1 LINE.

           MOVE ZEROES TO CT-LIN-RELERRO.

       CABECALHO-RELMERC.
           ADD 1 TO CT-PAG-RELMERC.
           MOVE CT-PAG-RELMERC TO VAR-PAG-RELMERC.
           
           MOVE SPACES TO REL-MERC.
           WRITE REL-MERC AFTER ADVANCING PAGE.
           WRITE REL-MERC FROM CAB-01-RELMERC
                 AFTER ADVANCING 1 LINE.
           WRITE REL-MERC FROM CAB-02-RELMERC
                 AFTER ADVANCING 2 LINES.
           WRITE REL-MERC FROM CAB-03-RELMERC
                 AFTER ADVANCING 2 LINES.
           WRITE REL-MERC FROM CAB-04-RELMERC
                 AFTER ADVANCING 1 LINE.
           MOVE SPACES TO REL-MERC.
           WRITE REL-MERC AFTER ADVANCING 1 LINE.

           MOVE ZEROES TO CT-LIN-RELMERC.

      *================================================================*

       TERMINO.
              CLOSE CADMERC MOVMERC ATUMERC RELERRO RELMERC.