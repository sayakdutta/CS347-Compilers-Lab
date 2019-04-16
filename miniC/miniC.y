%{
#include <stdio.h>
#include <stdlib.h>
%}


%token INT FLOAT VOID IF ELSE CASE BREAK DEFAULT CONTINUE WHILE FOR RETURN SWITCH LE GE EQUAL NOTEQUAL LSHIFT RSHIFT AND OR PLUSEQUAL MINUSEQUAL MULEQUAL MODEQUAL DIVEQUAL INCREMENT DECREMENT COLON QUESTION DOT LCB RCB LSB RSB LP RP SEMI COMMA ASSIGN LT GT NOT XOR BITAND BITOR PLUS MINUS DIV MUL MOD NUMFLOAT NUMINT id NEWLINE


%%
S:  MIF
    | UIF
    | WHILEEXP LCB S RCB 
;

MIF: IFEXP LCB MIF RCB ELSE LCB MIF RCB
    | BODY     
;

UIF: IFEXP LCB S RCB
    | IFEXP LCB MIF RCB ELSE LCB UIF RCB 
;

IFEXP: IF LP CONDITION1 RP
;

WHILEEXP: WHILE LP CONDITION1 RP
;

CONDITION1: CONDITION2 OR CONDITION1
    | CONDITION2
;  

CONDITION2: EXPR1 AND CONDITION2
    | EXPR1
;

EXPR1: LP CONDITION1 RP
    | EXPR2
;

EXPR2:  EXPR2 PLUS TERM
    | EXPR2 MINUS TERM
    | TERM
;

TERM: TERM MUL FACTOR
    | TERM DIV FACTOR   
    | FACTOR
;

FACTOR: id
    | NUMINT
    | EXPR2
;

FUNC_DECL: FUNC_HEAD BODY
;

FUNC_HEAD: RESULT LP DECL_PLIST RP
;

RES_ID: RESULT id   
;


RESULT: INT
        | FLOAT
        | VOID
;

DECL_PLIST: DECL_PL
            | %empty
;

DECL_PL: DECL_PL COMMA DECL_PARAM | DECL_PARAM
;

DECL_PARAM: T id
;


VAR_DECL: DLIST
        | %empty
;

DLIST:  DLIST SEMI D
        | D
;

D: T L 
;


T:  INT
    | FLOAT
;    


L: ID_ARR
    | L COMMA ID_ARR
;

ID_ARR: id 
    | id BR_DIMLIST
;

BR_DIMLIST: LSB NUMINT RSB
    | LSB NUMINT RSB BR_DIMLIST
;


BODY: LCB VAR_DECL STMT_LIST RCB
;

STMT_LIST: STMT_LIST SEMI STMT
    | STMT
;

STMT: BODY
    | FUNC_CALL
    | ASG
;

ASG: LHS ASSIGN E
;

LHS: id   
;

E: LHS
;

FUNC_CALL: id LP PARAMLIST RP
            
;

PARAMLIST: PLIST 
    | %empty 
;

PLIST: E 
;

%%

int main(int argc, char **argv)
{
  yyparse();
}