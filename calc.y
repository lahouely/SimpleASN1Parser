%{

void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>

%}

%union {int type_default; char* type_char_pointer;}         /* Yacc definitions */

%start module

%token <type_default> double_dash_comment
%token <type_default> multi_line_comment

%type <type_default> module  
%type <type_default> comment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

module		: comment module     		{;}
			| comment					{;}

comment		: double_dash_comment		{;}
			| multi_line_comment		{;}

%%                     /* C code */

int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {
	fprintf (stderr, "%s\n", s);
} 
