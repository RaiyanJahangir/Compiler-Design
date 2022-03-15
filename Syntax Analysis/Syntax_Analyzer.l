%option noyywrap
%{ #include<stdio.h>
#include "simple cal.tab.h"
%}

WS [ \t]+
DIGITS [0-9]+
NUMBER {DIGITS}(\.{DIGITS})?
%%
{WS} {}
[\n] {return NEWLINE;}
\+ {return PLUS;}
\- {return MINUS;}
"*" {return MUL;}
"/" {return DIV;}
"(" {return LPAREN;}
")" {return RPAREN;}
"++" {return INC_OP;}
"--" {return DEC_OP;}
"<<" {return LEFTSHIFT;}
">>" {return RIGHTSHIFT;}
"%" {return MOD;}
"**" {return POW;}
"<=" {return LE;}
">=" {return GE;}
"!=" {return NE;}
"&" {return BITWISE_AND;}
"exit" {exit(0);}
{NUMBER} {sscanf(yytext, "%lf", &yylval); return NUMBER;}
. {printf("unrecognized character");}
%%