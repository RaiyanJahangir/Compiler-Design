%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex(void);
int t_count = 1;
char * str;
int i;

float value[10000];


void yyerror(char *s)
{
	fprintf(stderr,"%s\n",s);
	return;
}

char* getTemp(int i)
{
    char *ret = (char*) malloc(15);
    sprintf(ret, "t%d", i);
	return ret;
}

int idx(char *s)
{
	int len = strlen(s);
	char dd[10000];
	for ( i = 1; i < len; i++)
		dd[i - 1] = s[i];
	return atoi(dd);
}



%}

%union {  
	//double dval;
	char cvar[5]; }
%token <cvar> DOUBLE
%token <cvar> NAME
%token '\n'

%type <cvar> expr
%type <cvar> term

%right '='
%left '+' '-'
%left '*' 
%left '/'
%left '(' ')'


%%
program:
	line program{}
	| line	{}
	;
line:
	expr 	'\n' 		{	
					t_count =1;	
					printf("\t ");
					int id = idx($1);
					printf(" %f\n",value[id]);
				}
	| NAME '=' expr '\n' 	{				
					t_count-=1;
					str = getTemp(t_count);
					strcpy($3,str);
					printf("%s = %s ",$1,$3);
					int id = idx($1);
					float val;
					if($3[0]=='t') val = value[idx($3)];
					else val = atof($3);
								
					value[id] = val;
					printf(" %f\n",val);
					t_count=1;
				}
	;
expr:
	expr '+' expr 		{ 
					str = getTemp(t_count);
					strcpy($$,str);
					printf("%s = %s + %s ",$$,$1,$3);
					t_count++;
					int id = idx($$);
					float val1;
					if($1[0]=='t') val1 = value[idx($1)];
					else val1 = atof($1);

					float val2;
					if($3[0]=='t') val2 = value[idx($3)];
					else val2 = atof($3);
								
					value[id] = val1+val2;
					//printf("%f\n",arr[id]);
					printf("%s=%f\n",$$,value[id]);
					
				}
	| expr '-' expr 	{ 
	
					strcpy($$,getTemp(t_count));
					printf("%s = %s - %s ",$$,$1,$3);
					t_count++;
					int id = idx($$);
					float val1;
					if($1[0]=='t') val1 = value[idx($1)];
					else val1 = atof($1);

					float val2;
					if($3[0]=='t') val2 = value[idx($3)];
					else val2 = atof($3);
								
					value[id] = val1-val2;
					//printf("%f\n",arr[id]);
					printf("%s=%f\n",$$,value[id]);
				}
	
	| expr '*' expr 	{ 
					strcpy($$,getTemp(t_count));
					printf("%s = %s * %s ",$$,$1,$3);
					t_count++;
					int id = idx($$);
					float val1;
					if($1[0]=='t') val1 = value[idx($1)];
					else val1 = atof($1);

					float val2;
					if($3[0]=='t') val2 = value[idx($3)];
					else val2 = atof($3);
								
					value[id] = val1*val2;
					//printf("%f\n",arr[id]);
					printf("%s=%f\n",$$,value[id]);
				}
	| expr '/' expr 	{ 
					strcpy($$,getTemp(t_count));
					printf("%s = %s / %s ",$$,$1,$3);
					t_count++;
					int id = idx($$);
					float val1;
					if($1[0]=='t') val1 = value[idx($1)];
					else val1 = atof($1);

					float val2;
					if($3[0]=='t') val2 = value[idx($3)];
					else val2 = atof($3);
								
					value[id] = val1/val2;
					//printf("%f\n",arr[id]);
					printf("%s=%f\n",$$,value[id]);
				}
	| term 			{ 				
					strcpy($$, $1);
					//$$=$1;
								
				}
	| '(' expr ')' 		{
					strcpy($$,getTemp(t_count));
					t_count++;
					printf("%s = (%s) ",$$,$2);
					int id = idx($$);
					float val;
					if($2[0]=='t') val = value[idx($2)];
					else val = atof($2);
								
					value[id] = val;
					printf(" %f\n",val);
					
				}
	;
term:
	
	NAME 			{ 
								
					strcpy($$,$1);
				}
	| DOUBLE 		{ 	
					strcpy($$,$1);
				}
	;
%%


int main(void)
{
	yyparse();
	return 0;
}