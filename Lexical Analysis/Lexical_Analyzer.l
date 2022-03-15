%option noyywrap

%{
#include<stdio.h>
int line=0;
%}

digit [0-9]+
newline [\n]
delim [ \t\r]
ws {delim}+
letter [_A-Za-z]
id {letter}+({letter}|{digit})*
number {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
complex_num (({number}[+-]{number}?i)|([+-]?{number}?i))
arithmetic_operator [\+\-\*\%]
relational_operator (<|<=|>=|>|!=|==)
increment_operator (\+\+)
assignment_operator [=]
location_operator [&]
keyword (int|main|while|printf|scanf|for|if|break)
parenthesis [()]
curly [{}]
separator [,;:]
comment (((\/\/)[^\n\r]*[\n\r])|((\/\*).*(\*\/)))
literals (\".*\")

%%
{keyword} {fprintf(yyout,"<Keyword, %s> Line number = %d \n",yytext,line+1);}

{complex_num} {fprintf(yyout,"<Complex Number, %s> Line number= %d \n",yytext,line+1);}

{newline} {line++; fprintf(yyout,"\n\n");}

{ws} {}

{id} {fprintf(yyout,"<Identifier , %s >  Line number = %d \n",yytext,line+1);}

{arithmetic_operator} {fprintf(yyout,"<Arithmetic Operator , %s >   Line number = %d\n",yytext,line+1);}

{relational_operator} {fprintf(yyout,"<Relational Operator , %s >  Line number = %d\n",yytext,line+1);}

{increment_operator} {fprintf(yyout,"<Increment Operator, %s >  Line number = %d\n",yytext,line+1);}

{assignment_operator} {fprintf(yyout,"<Assignment Operator , %s >  Line number = %d\n",yytext,line+1);}

{location_operator} {fprintf(yyout,"<Location Operator , %s >  Line number = %d\n",yytext,line+1);}

{number} {fprintf(yyout,"<Number , %s >   Line number = %d\n",yytext,line+1);}

{parenthesis} {fprintf(yyout,"<Parenthesis , %s >  Line number = %d\n",yytext,line+1);}

{curly} {fprintf(yyout,"<Curly , %s >  Line number =  %d\n" ,yytext,line+1);}

{separator} {fprintf(yyout,"<Separator , %s >   Line number =  %d\n",yytext,line+1);}

{literals} {fprintf(yyout,"<Literal , %s >  Line number = %d\n",yytext,line+1);}

{comment} {line++; fprintf(yyout,"\n\n");}

%%
int main() {
	yyin=fopen("input.txt","r");
	yyout=fopen("output.txt","w");
	yylex();
	fprintf(yyout,"\nTotal Line number= %d\n",++line);	
}
