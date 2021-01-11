%{

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>

 extern int liniaCurenta;
 extern int yylex();
 int yyparse();
 void yyerror(const char* s);
 FILE* yyin;

%}

%union {
  char sval[100];
}

// cuvinte cheie
%token INCLUDE
%token STDIO
%token MAIN
%token INT
%token DOUBLE
%token<sval> ID
%token<sval> CONST
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

program : {
	  printf("bits 32\n\n");
	  printf("global start\n\n");
	  printf("extern printf\n");
	  printf("import printf msvcrt.dll\n");
	  printf("extern scanf\n");
	  printf("import scanf msvcrt.dll\n");
	  printf("extern exit\n");
	  printf("import exit msvcrt.dll\n\n");
	  
	  printf("segment data use32 class=data\n");
	  printf("\tformat db \"%%d\", 0\n");
	  printf("\tendl db \`\\n\`, 0\n");
	}
       	'#' INCLUDE '<' STDIO '>' INT MAIN '(' ')' '{' lista_declaratii corp return '}'

corp : {
	  printf("\nsegment code use32 class=code\n");
	  printf("\tstart:\n");
       }
       lista_instructiuni

lista_declaratii : /* empty */
		 | declaratie ';' lista_declaratii

declaratie : tip lista_id

tip : INT

lista_id : ID 
	   { 
	    printf("\t%s dd 0\n", $1);
	   }
	   | ID ',' lista_id 
	   {
	     printf("\t%s dd 0\n", $1); 
	   }

lista_instructiuni : /* empty */
		   | instructiune ';' lista_instructiuni

instructiune : instructiune_atribuire
	     | instructiune_afisare
	     | instructiune_citire

instructiune_atribuire : ID '=' expresie
		       { printf("\t\tmov [%s], eax\n\n", $1); }

expresie : CONST
	 {
	    printf("\t\tmov eax, %s\n", $1);
	 }
	| ID
	 {
	    printf("\t\tmov eax, %s\n", $1);
	 }
	| ID '+' ID
	 {
            printf("\t\tmov eax, [%s]\n", $1);
            printf("\t\tmov edx, [%s]\n", $3);
            printf("\t\tadd eax, edx\n");
         }
        | ID '*' ID
        {
            printf("\t\tmov eax, [%s]\n", $1);
            printf("\t\tmov ebx, [%s]\n", $3);
            printf("\t\tmul ebx\n");
        }
        | ID '-' ID
        {
            printf("\t\tmov eax, [%s]\n", $1);
            printf("\t\tmov edx, [%s]\n", $3);
            printf("\t\tsub eax, ebx\n");
        }
        | CONST '+' ID
        {
            printf("\t\tmov eax, %s\n", $1);
            printf("\t\tmov edx, [%s]\n", $3);
            printf("\t\tadd eax, edx\n");
        }
        | CONST '*' ID
        {
            printf("\t\tmov eax, %s\n", $1);
            printf("\t\tmov ebx, [%s]\n", $3);
            printf("\t\tmul ebx\n");
        }
        | CONST '-' ID
        {
            printf("\t\tmov eax, %s\n", $1);
            printf("\t\tmov edx, [%s]\n", $3);
            printf("\t\tsub eax, ebx\n");
        }

instructiune_afisare : PRINTF '(' formatter ',' ID ')'
		     {
			printf("\t\tpush dword [%s]\n", $5);
			printf("\t\tpush dword format\n");
			printf("\t\tcall [printf]\n");
			printf("\t\tadd esp, 4 * 2\n\n");

			printf("\t\tpush dword endl\n");
			printf("\t\tcall [printf]\n");
			printf("\t\tadd esp, 4\n\n");
		     }

instructiune_citire : SCANF '(' formatter ',' ADDRESS_OPERATOR ID ')'
		    {
			printf("\t\tpush dword %s\n", $6);
			printf("\t\tpush dword format\n");
			printf("\t\tcall [scanf]\n");
			printf("\t\tadd esp, 4 * 2\n\n");
		    }

formatter : FORMATTER_DECIMAL

return : RETURN CONST ';'
       {
	 printf("\t\tpush dword 0\n");
	 printf("\t\tcall [exit]\n");
      }
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
  do {
    yyparse();
  } while (!feof(yyin));
  printf("\nAnaliza sintactica a avut loc cu succes!\n");
}

void yyerror(const char* s) {
  printf("Eroare sintactica la linia %d! Mesaj : %s\n", liniaCurenta, s);
  exit(1);
}
