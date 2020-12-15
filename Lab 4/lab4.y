%{

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>

 extern int liniaCurenta;
 extern int yylex(void);
 int yyparse();
 void show();
 void yyerror(const char* s);
 FILE* yyin;
 
%}

// cuvinte cheie
%token INCLUDE
%token STDIO
%token MAIN
%token INT
%token DOUBLE
%token ID
%token CONST
%token RETURN
%token STRUCT
%token PRINTF
%token SCANF
%token IF
%token ELSE
%token WHILE
%token FOR
%token FORMATTER_DOUBLE
%token FORMATTER_DECIMAL
%token ADDRESS_OPERATOR
%token EQUAL
%token DA
%token NU

%left '+'
%left '-'
%left '/'
%left '*'
%left '%'

%%

program : '#' INCLUDE '<' STDIO '>' INT MAIN '(' ')' '{' lista_declaratii lista_instructiuni RETURN CONST ';' '}'
        ;

lista_declaratii : /* empty */
		 | declaratie ';' lista_declaratii
		 ;

declaratie : tip lista_id
	   | declaratie_struct
	   ;

declaratie_struct : STRUCT '{' lista_declaratii '}' ID
		  ;

tip : INT | DOUBLE
    ;

lista_id : ID 
	 | ID ',' lista_id
	 ;

lista_instructiuni : /* empty */
		   | instructiune lista_instructiuni
		   ;

instructiune : instructiune_atribuire ';'
	     | instructiune_afisare ';'
	     | instructiune_citire ';'
	     | instructiune_conditionala 
	     | instructiune_ciclare
	     ;

instructiune_atribuire : ID '=' expresie
		       ;

expresie : expresie '+' expresie 
	 | expresie '-' expresie 
	 | expresie '*' expresie 
	 | expresie '/' expresie
	 | expresie '%' expresie
	 | ID
	 | CONST
	 ;

instructiune_afisare : PRINTF '(' mesaj ')'
		     | PRINTF '(' formatter ',' ID ')'
		     ;

mesaj : DA
      | NU
      ;

instructiune_citire : SCANF '(' formatter ',' ADDRESS_OPERATOR ID ')'
		    ;

formatter : FORMATTER_DECIMAL
	  | FORMATTER_DOUBLE
	  ;

instructiune_conditionala : IF '(' conditie ')' '{' lista_instructiuni '}'
			  | IF '(' conditie ')' '{' lista_instructiuni '}' ELSE '{' lista_instructiuni '}'
			  ;

instructiune_ciclare : WHILE '(' conditie ')' '{' lista_instructiuni '}'
		     | FOR '(' instructiune_atribuire ';' conditie ';' instructiune_atribuire ')' '{' lista_instructiuni '}'
		     ;

conditie : expresie '<' expresie
	 | expresie '>' expresie
	 | expresie EQUAL expresie
	 ;

%%

int main(int argc, char* argv[]) {
  FILE* f;
  char filename[100];
  printf("Fisier: ");
  scanf("%s", filename);
  f = fopen(filename, "r");
  if (!f) {
   printf("Cannot open file\n");
   return -1;
  }
  yyin = f;
  //if (yylex() == -1) return -1;
  do {
    yyparse();
  } while (!feof(yyin));
  printf("\nAnaliza sintactica a avut loc cu succes!\n");
  show();
}

void yyerror(const char* s) {
  printf("Eroare sintactica la linia %d! Mesaj : %s\n", liniaCurenta, s);
  exit(1);
}
