/* recognize tokens for the calculator and print them out */
%{
# include "mainsSQL.tab.h"
%}

%%
SELECT                          {  return SELECT;}
PROJECT                         {  return PROJECT;}
CARTESIAN_PRODUCT               {  return CARTESIAN_PRODUCT;}
EQUI_JOIN                       {  return EQUI_JOIN;}
"<="                            {  return LE;}
">="                            {  return RE;}
"!="                            {  return NOT_EQUAL;} 
"<"                             {  return LA;}
">"                             {  return RA;} 
"="                             {  return EQUAL;}             
"AND"                           {  return AND;}
"OR"                            {  return OR;}
"NOT"                           {    return NOT;}
,                               {  return COMMA;}
\.                              {  return DOT;}
'[A-Za-z_][0-9A-Za-z_]*'        {  return QUOTED_STRING;}
[(]                             {  return LP;}
[)]                             {  return RP;}
[A-Za-z_][0-9A-Za-z_]*          {  return ID; }
[0-9]+                          {  return INT; }
\n                              {  yylineno++; return NEWLINE; }
[ \t]                           {/* ignore whitespace */ }
.                               {printf("Unknown character %c\n", *yytext);}
%%