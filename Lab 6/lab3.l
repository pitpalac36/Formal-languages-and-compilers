/* analizor pentru un MLP din C */

%{
   /* definitii accesibile in yylex si main */
  #include "lab4.tab.h"
  #include <string.h>
  int liniaCurenta = 1;
%}

%option noyywrap
  /* reguli */
id       [a-zA-Z_]+[a-zA-Z_0-9]*
const    0|[1-9]+[0-9]*|\-[1-9]+[0-9]*
%%

"#"  { return '#'; }
"include" { return INCLUDE; }
"<"  { return '<'; }
">"  { return '>'; }
"stdio.h"  { return STDIO; }
"int"  { return INT; }
"main"  { return MAIN; }
"("  { return '('; }
")"  { return ')'; }
"{"  { return '{'; }
"}"  { return '}'; }
","  { return ','; }
";"  { return ';'; }
"="  { return '='; }
"scanf"  { return SCANF; }
"\"%d\""  { return FORMATTER_DECIMAL; }
"&"  { return ADDRESS_OPERATOR; }
"for"  { return FOR; }
"/"  { return '/'; }
"+"  { return '+'; }
"if"  { return IF; }
"%"  { return '%'; }
"=="  { return EQUAL; }
"printf"  { return PRINTF; }
"\""  { return "\""; }
"else"  { return ELSE; }
"return" { return RETURN; }
"while"  { return WHILE; }
"-"  { return '-'; }
"\"%lf\"" { return FORMATTER_DOUBLE; }
"double"  { return DOUBLE; }
"\"da\"" { return DA; }
"\"nu\"" { return NU; }
"*" { return '*'; }
{id} { memset(yylval.sval, 0, sizeof(yylval.sval)); strncpy(yylval.sval, yytext, strlen(yytext)); return ID; }
{const}  { memset(yylval.sval, 0, sizeof(yylval.sval)); strncpy(yylval.sval, yytext, strlen(yytext)); return CONST; }
[ \t]  /* whitespace */
[\n]  { liniaCurenta++; }
.  {printf("%s  token nerecunoscut la linia %d!!\n", yytext, liniaCurenta); return -1; }

%%
