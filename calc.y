%{

void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>

%}

%union {int num; char str[100];}         /* Yacc definitions */

%start example

%token <num> double_dash_comment
%token <num> multi_line_comment

%token <str> identifier
%token <num> assignment
%token <num> ellipsis
%token <num> range
%token <num> left_version_brackets
%token <num> right_version_brackets
%token <num> left_brace
%token <num> right_brace
%token <num> left_angle
%token <num> right_angle
%token <num> comma
%token <num> dot
%token <num> slash
%token <num> left_parenthesis
%token <num> right_parenthesis
%token <num> left_bracket
%token <num> right_bracket
%token <num> hyphen_minus
%token <num> colon
%token <num> equal
%token <num> quotation_mark
%token <num> apostrophe
%token <num> semicolon
%token <num> at_symbol
%token <num> vertical_bar
%token <num> exclamation_mark
%token <num> caret
%token <num> absent
%token <num> encoded
%token <num> intersection
%token <num> sequence
%token <num> abstract_syntax
%token <num> encoding_control
%token <num> iso646string
%token <num> set
%token <num> all
%token <num> end
%token <num> max
%token <num> settings
%token <num> application
%token <num> enumerated
%token <num> min
%token <num> tok_size
%token <num> automatic
%token <num> except
%token <num> minus_infinity
%token <num> string
%token <num> begin
%token <num> explicit
%token <num> not_a_number
%token <num> syntax
%token <num> bit
%token <num> exports
%token <num> null
%token <num> t61string
%token <num> bmpstring
%token <num> extensibility
%token <num> numericstring
%token <num> tags
%token <num> boolean
%token <num> external
%token <num> tok_object
%token <num> teletexstring
%token <num> by
%token <num> tok_false
%token <num> objectdescriptor
%token <num> time
%token <num> character
%token <num> from
%token <num> octet
%token <num> time_of_day
%token <num> choice
%token <num> generalizedtime
%token <num> of
%token <num> tok_true
%token <num> tok_class
%token <num> generalstring
%token <num> oid_iri
%token <num> type_identifier
%token <num> component
%token <num> graphicstring
%token <num> optional
%token <num> tok_union
%token <num> components
%token <num> ia5string
%token <num> pattern
%token <num> unique
%token <num> constrained
%token <num> pdv
%token <num> universal
%token <num> containing
%token <num> implicit
%token <num> plus_infinity
%token <num> universalstring
%token <num> date
%token <num> implied
%token <num> present
%token <num> utctime
%token <num> date_time
%token <num> imports
%token <num> printablestring
%token <num> utf8string
%token <num> tok_default
%token <num> includes
%token <num> private
%token <num> videotexstring
%token <num> definitions
%token <num> instance
%token <num> real
%token <num> visiblestring
%token <num> duration
%token <num> instructions
%token <num> relative_oid
%token <num> with
%token <num> embedded
%token <num> integer
%token <num> relative_oid_iri




%type <num> module  
%type <num> comment

%%

/* descriptions of expected inputs     corresponding actions (in C) */

module		: comment module     		{;}
			| comment					{;}

comment		: double_dash_comment		{;}
			| multi_line_comment		{;}

example		: identifier assignment identifier {printf("assigning %s to %s.\n",$<str>3,$<str>1); }

%%                     /* C code */

int main (void) {
	return yyparse ( );
}

void yyerror (char *s) {
	fprintf (stderr, "%s\n", s);
} 
