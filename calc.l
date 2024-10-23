%{
#include <string.h>
#include "y.tab.h"

int yywrap_counter = 1;

void yyerror (char *s);
int yylex();
%}

%option stack

NEWLINE	               [\n\v\f\r]
BLANK	               [\n\v\f\r\t ]
DIGIT                  [0-9]
NONZERO                [1-9]
INTEGER                ({NONZERO}{DIGIT}*)|0
FRACTION               \.{DIGIT}+
EXPONENT               [eE][+-]?{DIGIT}+

NUMBER                 [+-]?{INTEGER}
REALNUMBER             [+-]?{INTEGER}({FRACTION})?({EXPONENT})?|{INTEGER}\.{DIGIT}+({EXPONENT})?.
LOWERIDENTIFIER        [a-z]([a-zA-Z0-9]|(-[a-zA-Z0-9]))*
UPPERIDENTIFIER        [A-Z]([a-zA-Z0-9]|(-[a-zA-Z0-9]))*
FULLUPPERIDENTIFIER    [A-Z]([A-Z0-9]|(-[A-Z0-9]))*
BINARYSTRING           '{BLANK}*([01]{BLANK}*)*'B
HEXADECIMALSTRING      '{BLANK}*([0-9A-F]{BLANK}*)*'H


%x DOUBLE_DASH_COMMENT
%x MULTI_LINE_COMMENT
%x CSTRING

%%

<DOUBLE_DASH_COMMENT>[^-\n]*        {printf("Eaten up using rule 1 (not hyphen nor newline) : >>>%s<<<\n",yytext); }
<DOUBLE_DASH_COMMENT>"-"/[^-]       {printf("Eaten up using rule 2 (solo hyphen): >>>%s<<<\n",yytext); }
<DOUBLE_DASH_COMMENT>"--"           {printf("Double dash comment ended with a double dash\n");    yy_pop_state(); return double_dash_comment; }
<DOUBLE_DASH_COMMENT><<EOF>>        {printf("Double dash comment ended with a EOF\n");            yy_pop_state(); return double_dash_comment; }
<DOUBLE_DASH_COMMENT>\n             {printf("Double dash comment ended with a new line\n");       yy_pop_state(); return double_dash_comment; }

<MULTI_LINE_COMMENT>"/*"	        {printf("New embeded multi line comment started\n"); yy_push_state(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>[^*/]*          {printf("Eaten up using rule 1 (not an asterisk nor a slash): >>>%s<<<\n",yytext); }
<MULTI_LINE_COMMENT>"/"/[^*]        {printf("Eaten up using rule 2 (slash not followed by asterisk): >>>%s<<<\n",yytext); }
<MULTI_LINE_COMMENT>"*"/[^/]        {printf("Eaten up using rule 3 (asterisk not followed by slash): >>>%s<<<\n",yytext); }
<MULTI_LINE_COMMENT>"*/"            {printf("Multi line comment ended\n");    yy_pop_state(); return multi_line_comment; }
<MULTI_LINE_COMMENT><<EOF>>         {printf("Reached EOF within a multi line comment.\n");        yyerror("reached EOF within a multi line comment.\n"); }



<INITIAL>"--"		                {printf("Double dash comment started\n"); yy_push_state(DOUBLE_DASH_COMMENT); }
<INITIAL>"/*"		                {printf("Multi line comment started\n"); yy_push_state(MULTI_LINE_COMMENT); }
<INITIAL>\"                         {printf("Cstring started\n"); yy_push_state(CSTRING); }
<INITIAL>"::="                      {printf("Assignment token found: %s\n", yytext); }
<INITIAL>".."                       {printf("Range token found: %s\n", yytext); }
<INITIAL>"..."                      {printf("Ellipsis token found: %s\n", yytext); }
<INITIAL>"[["                       {printf("Left version brackets token found: %s\n", yytext); }
<INITIAL>"]]"                       {printf("Right version brackets token found: %s\n", yytext); }

<INITIAL>{FULLUPPERIDENTIFIER}      {printf("Encoding reference found: %s\n", yytext); }
<INITIAL>{LOWERIDENTIFIER}          {printf("Identifier or \"Value refrence\" found: %s\n", yytext); }
<INITIAL>{UPPERIDENTIFIER}          {printf("Type reference, Property or Setting name found: %s\n", yytext); }

<INITIAL>{INTEGER}                  {printf("\"Integer-valued Unicode label\" or Number found: %s\n", yytext); }
<INITIAL>{NUMBER}                   {printf("Number found: %s\n", yytext); }
<INITIAL>{REALNUMBER}               {printf("Real number found: %s\n", yytext); }
<INITIAL>{BINARYSTRING}             {printf("Binary string found: %s\n", yytext); }
<INITIAL>{HEXADECIMALSTRING}        {printf("Hexadecimal string found: %s\n", yytext); }
<INITIAL>\"[^\"\n]*\"               {printf("Cstring found: %s\n", yytext);}

<INITIAL>"-"                        {printf("Ignored single dash\n"); }
<INITIAL><<EOF>>                    {printf("Normal EOF encountered\n"); }
<INITIAL>[{BLANK}]+                 {printf("Ignored blank\n"); }
<INITIAL>[^\t\n\v\f\r -]*           {printf("Ignored unknown token >>>%s<<<\n",yytext); }

%%
int yywrap (void) {return yywrap_counter-->0?1:0;}
