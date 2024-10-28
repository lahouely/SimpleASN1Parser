%{
#include <string.h>
#include "y.tab.h"

int yywrap_counter = 1;

void yyerror (char *s);
int yylex();
%}

%option stack

NEWLINE	                    [\n\v\f\r]
BLANK	                    [\n\v\f\r\t ]
DIGIT                       [0-9]
NONZERO                     [1-9]
INTEGER                     ({NONZERO}{DIGIT}*)|0
FRACTION                    \.{DIGIT}+
EXPONENT                    [eE][+-]?{DIGIT}+

NUMBER                      [+-]?{INTEGER}
REALNUMBER                  [+-]?{INTEGER}({FRACTION})?({EXPONENT})?|{INTEGER}\.{DIGIT}+({EXPONENT})?.
LOWERIDENTIFIER             [a-z]([a-zA-Z0-9]|(-[a-zA-Z0-9]))*
UPPERIDENTIFIER             [A-Z]([a-zA-Z0-9]|(-[a-zA-Z0-9]))*
FULLUPPERIDENTIFIER         [A-Z]([A-Z0-9]|(-[A-Z0-9]))*
BINARYSTRING                '{BLANK}*([01]{BLANK}*)*'B
HEXADECIMALSTRING           '{BLANK}*([0-9A-F]{BLANK}*)*'H

%x DOUBLE_DASH_COMMENT
%x MULTI_LINE_COMMENT
%x CSTRING

%%

<DOUBLE_DASH_COMMENT>[^-\n]*                { /* ignored - not hyphen nor newline */ ; }
<DOUBLE_DASH_COMMENT>"-"/[^-]               { /* ignored - solo hyphen */ ; }
<DOUBLE_DASH_COMMENT>"--"                   { /* double dash comment ended with a double dash */ yy_pop_state(); }
<DOUBLE_DASH_COMMENT><<EOF>>                { /* double dash comment ended with an EOF */ yy_pop_state(); }
<DOUBLE_DASH_COMMENT>{NEWLINE}              { /* double dash comment ended with a new line */ yy_pop_state(); }

<MULTI_LINE_COMMENT>"/*"	                { /* new embeded multi line comment started */ yy_push_state(MULTI_LINE_COMMENT); }
<MULTI_LINE_COMMENT>[^*/]*                  { /* ignored - not an asterisk nor a slash */ ; }
<MULTI_LINE_COMMENT>"/"/[^*]                { /* ignored - slash not followed by asterisk */ ; }
<MULTI_LINE_COMMENT>"*"/[^/]                { /* ignored - asterisk not followed by slash */ ; }
<MULTI_LINE_COMMENT>"*/"                    { /* multi line comment ended */ yy_pop_state(); }
<MULTI_LINE_COMMENT><<EOF>>                 { /* reached EOF within a multi line comment */ yyerror("reached EOF within a multi line comment.\n"); exit(-1); }

<INITIAL>"--"		                        { /* double dash comment started */ yy_push_state(DOUBLE_DASH_COMMENT); }
<INITIAL>"/*"		                        { /* multi line comment started */ yy_push_state(MULTI_LINE_COMMENT); }
<INITIAL>"::="                              { return assignment; }
<INITIAL>"..."                              { return ellipsis; }
<INITIAL>".."                               { return range; }
<INITIAL>"[["                               { return left_version_brackets; }
<INITIAL>"]]"                               { return right_version_brackets; }
<INITIAL>"{"                                { return left_brace; }
<INITIAL>"}"                                { return right_brace; }
<INITIAL>"<"                                { return left_angle; }
<INITIAL>">"                                { return right_angle; }
<INITIAL>","                                { return comma; }
<INITIAL>"."                                { return dot; }
<INITIAL>"/"                                { return slash; }
<INITIAL>"("                                { return left_parenthesis; }
<INITIAL>")"                                { return right_parenthesis; }
<INITIAL>"["                                { return left_bracket; }
<INITIAL>"]"                                { return right_bracket; }
<INITIAL>"-"                                { return hyphen_minus; }
<INITIAL>":"                                { return colon; }
<INITIAL>"="                                { return equal; }
        /*hello*/
<INITIAL>"'"                                { return apostrophe; }
<INITIAL>";"                                { return semicolon; }
<INITIAL>"@"                                { return at_symbol; }
<INITIAL>"|"                                { return vertical_bar; }
<INITIAL>"!"                                { return exclamation_mark; }
<INITIAL>"^"                                { return caret; }
<INITIAL>"absent"                           { return absent; }
<INITIAL>"encoded"                          { return encoded; }
<INITIAL>"intersection"                     { return intersection; }
<INITIAL>"sequence"                         { return sequence; }
<INITIAL>"abstract-syntax"                  { return abstract_syntax; }
<INITIAL>"encoding-control"                 { return encoding_control; }
<INITIAL>"iso646string"                     { return iso646string; }
<INITIAL>"set"                              { return set; }
<INITIAL>"all"                              { return all; }
<INITIAL>"end"                              { return end; }
<INITIAL>"max"                              { return max; }
<INITIAL>"settings"                         { return settings; }
<INITIAL>"application"                      { return application; }
<INITIAL>"enumerated"                       { return enumerated; }
<INITIAL>"min"                              { return min; }
<INITIAL>"size"                             { return tok_size; }
<INITIAL>"automatic"                        { return automatic; }
<INITIAL>"except"                           { return except; }
<INITIAL>"minus-infinity"                   { return minus_infinity; }
<INITIAL>"string"                           { return string; }
<INITIAL>"begin"                            { return begin; }
<INITIAL>"explicit"                         { return explicit; }
<INITIAL>"not-a-number"                     { return not_a_number; }
<INITIAL>"syntax"                           { return syntax; }
<INITIAL>"bit"                              { return bit; }
<INITIAL>"exports"                          { return exports; }
<INITIAL>"null"                             { return null; }
<INITIAL>"t61string"                        { return t61string; }
<INITIAL>"bmpstring"                        { return bmpstring; }
<INITIAL>"extensibility"                    { return extensibility; }
<INITIAL>"numericstring"                    { return numericstring; }
<INITIAL>"tags"                             { return tags; }
<INITIAL>"boolean"                          { return boolean; }
<INITIAL>"external"                         { return external; }
<INITIAL>"object"                           { return tok_object; }
<INITIAL>"teletexstring"                    { return teletexstring; }
<INITIAL>"by"                               { return by; }
<INITIAL>"false"                            { return tok_false; }
<INITIAL>"objectdescriptor"                 { return objectdescriptor; }
<INITIAL>"time"                             { return time; }
<INITIAL>"character"                        { return character; }
<INITIAL>"from"                             { return from; }
<INITIAL>"octet"                            { return octet; }
<INITIAL>"time-of-day"                      { return time_of_day; }
<INITIAL>"choice"                           { return choice; }
<INITIAL>"generalizedtime"                  { return generalizedtime; }
<INITIAL>"of"                               { return of; }
<INITIAL>"true"                             { return tok_true; }
<INITIAL>"class"                            { return tok_class; }
<INITIAL>"generalstring"                    { return generalstring; }
<INITIAL>"oid-iri"                          { return oid_iri; }
<INITIAL>"type-identifier"                  { return type_identifier; }
<INITIAL>"component"                        { return component; }
<INITIAL>"graphicstring"                    { return graphicstring; }
<INITIAL>"optional"                         { return optional; }
<INITIAL>"union"                            { return tok_union; }
<INITIAL>"components"                       { return components; }
<INITIAL>"ia5string"                        { return ia5string; }
<INITIAL>"pattern"                          { return pattern; }
<INITIAL>"unique"                           { return unique; }
<INITIAL>"constrained"                      { return constrained; }
<INITIAL>"identifier"                       { return identifier; }
<INITIAL>"pdv"                              { return pdv; }
<INITIAL>"universal"                        { return universal; }
<INITIAL>"containing"                       { return containing; }
<INITIAL>"implicit"                         { return implicit; }
<INITIAL>"plus-infinity"                    { return plus_infinity; }
<INITIAL>"universalstring"                  { return universalstring; }
<INITIAL>"date"                             { return date; }
<INITIAL>"implied"                          { return implied; }
<INITIAL>"present"                          { return present; }
<INITIAL>"utctime"                          { return utctime; }
<INITIAL>"date-time"                        { return date_time; }
<INITIAL>"imports"                          { return imports; }
<INITIAL>"printablestring"                  { return printablestring; }
<INITIAL>"utf8string"                       { return utf8string; }
<INITIAL>"default"                          { return tok_default; }
<INITIAL>"includes"                         { return includes; }
<INITIAL>"private"                          { return private; }
<INITIAL>"videotexstring"                   { return videotexstring; }
<INITIAL>"definitions"                      { return definitions; }
<INITIAL>"instance"                         { return instance; }
<INITIAL>"real"                             { return real; }
<INITIAL>"visiblestring"                    { return visiblestring; }
<INITIAL>"duration"                         { return duration; }
<INITIAL>"instructions"                     { return instructions; }
<INITIAL>"relative-oid"                     { return relative_oid; }
<INITIAL>"with"                             { return with; }
<INITIAL>"embedded"                         { return embedded; }
<INITIAL>"integer"                          { return integer; }
<INITIAL>"relative-oid-iri"                 { return relative_oid_iri; }

<INITIAL>{FULLUPPERIDENTIFIER}              {printf("Encoding reference found: %s\n", yytext); }
<INITIAL>{LOWERIDENTIFIER}                  {printf("Identifier or \"Value refrence\" found: %s\n", yytext); }
<INITIAL>{UPPERIDENTIFIER}                  {printf("Type reference, Property or Setting name found: %s\n", yytext); strcpy(yylval.str,yytext);  return identifier; }

<INITIAL>{INTEGER}                          {printf("\"Integer-valued Unicode label\" or Number found: %s\n", yytext); }
<INITIAL>{NUMBER}                           {printf("Number found: %s\n", yytext); }
<INITIAL>{REALNUMBER}                       {printf("Real number found: %s\n", yytext); }
<INITIAL>{BINARYSTRING}                     {printf("Binary string found: %s\n", yytext); }
<INITIAL>{HEXADECIMALSTRING}                {printf("Hexadecimal string found: %s\n", yytext); }
<INITIAL>\"[^\"\n]*\"                       {printf("Cstring found: %s\n", yytext);}

<INITIAL>"-"                                {printf("Ignored single dash\n"); }
<INITIAL><<EOF>>                            {printf("Normal EOF encountered\n"); exit(0); }
<INITIAL>[{BLANK}]+                         {printf("Ignored blank\n"); }
<INITIAL>[^\t\n\v\f\r -]*                   {printf("Ignored unknown token >>>%s<<<\n",yytext); }

%%

int yywrap (void) {return yywrap_counter-->0?1:0;}
