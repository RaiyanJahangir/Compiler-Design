%{
#include<stdio.h>
#define YYSTYPE double
#include<math.h>
int yylex();
FILE *yyin,*yyout;
int yyerror(const char *s)
{
fprintf(yyout,"%s ",s);
}

%}

%token NEWLINE NUMBER LPAREN RPAREN
%left BITWISE_AND
%left LE GE NE 
%left LEFTSHIFT RIGHTSHIFT
%left PLUS MINUS
%left MUL DIV MOD
%left POW
%right INC_OP DEC_OP


%%
stmt : line
| stmt line
;
line : expr NEWLINE    {fprintf(yyout,"Result:%lf\n",$1);}
;
expr : expr PLUS expr  {$$=$1+$3;}
| expr MINUS expr      {$$=$1-$3;}
| expr MUL expr        {$$=$1*$3;}
| expr DIV expr	       {if($3==0) {yyerror("Division by 0 error.");}
			else $$=$1/$3;}
| expr MOD expr        {if($3==0) {yyerror("Mod by O error.");}
			else {int a=(int)$1;
			      int b=(int)$3;
			      $$=a%b;}}
| INC_OP expr	       {$$=$2+1;}
| expr INC_OP          {}
| DEC_OP expr          {$$=$2-1;}
| expr DEC_OP          {}
| expr LEFTSHIFT expr  {int a=(int)$1;
			int b=(int)$3;
			$$=a<<b;}
| expr RIGHTSHIFT expr {int a=(int)$1;
			int b=(int)$3;
			$$=a>>b;}
| expr POW expr        {int a=(int)$1;
			int b=(int)$3;
			$$=ceil(pow(a,b));}
| expr LE expr         {if($1<=$3) fprintf(yyout,"True ");
			else fprintf(yyout,"False ");
			}
| expr GE expr         {if($1>=$3) fprintf(yyout,"True ");
			else fprintf(yyout,"False ");
			}
| expr NE expr         {if($1!=$3) fprintf(yyout,"True ");
			else fprintf(yyout,"False ");
			}
| expr BITWISE_AND expr {int a=(int)$1;
			 int b=(int)$3;
			 $$=a&b;}
| LPAREN expr RPAREN   {$$=$2;}
| NUMBER	       {$$=$1;}
;

%%
void main(){
yyin=fopen("in.txt","r");
yyout=fopen("out.txt","w");
yyparse();
}