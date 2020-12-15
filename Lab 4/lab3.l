/* analizor pentru un MLP din C */

%{
   /* definitii accesibile in yylex si main */
  #include "lab4.tab.h"
  #include <string.h>

  struct Element {
    int cod;
    char simbol[20];
    char tip[20]; 
  };

  struct TS {
    struct Element elemente[50];
    int pozCurenta;
    int codCurent;
  };

  struct FIP {
    int coduri[1000];
    int pozCurenta;
  };

  struct TS ts = {.pozCurenta = 0, .codCurent = 50 };
  struct FIP fip = {.pozCurenta = 0 };
  int liniaCurenta = 1;
  void adaugaFIP(int cod);

  void adaugaTS(int codFIP, char simbol[]);

%}

  /* reguli */
id       [a-zA-Z_]+[a-zA-Z_0-9]*
const    0|[1-9]+[0-9]*|\-[1-9]+[0-9]*
%%

"#"  { adaugaFIP(3); printf("token: %s\n", " # "); return '#'; }
"include" { adaugaFIP(4); printf("token: %s\n", "include"); return INCLUDE; }
"<"  { adaugaFIP(5); printf("token: %s\n", "<"); return '<'; }
">"  { adaugaFIP(6); printf("token: %s\n", ">"); return '>'; }
"stdio.h"  { adaugaFIP(7); printf("token: %s\n", "stdio.h"); return STDIO; }
"int"  { adaugaFIP(8); printf("token: %s\n", "int"); return INT; }
"main"  { adaugaFIP(9); printf("token: %s\n", "main"); return MAIN; }
"("  { adaugaFIP(10); printf("token: %s\n", "("); return '('; }
")"  { adaugaFIP(11); printf("token: %s\n", ")"); return ')'; }
"{"  { adaugaFIP(12); printf("token: %s\n", "{"); return '{'; }
"}"  { adaugaFIP(13); printf("token: %s\n", "}"); return '}'; }
","  { adaugaFIP(14); printf("token: %s\n", ","); return ','; }
";"  { adaugaFIP(15); printf("token: %s\n", ";"); return ';'; }
"="  { adaugaFIP(16); printf("token: %s\n", "="); return '='; }
"scanf"  { adaugaFIP(17); printf("token: %s\n", "scanf"); return SCANF; }
"\"%d\""  { adaugaFIP(18); printf("token: %s\n", "\"%d\""); return FORMATTER_DECIMAL; }
"&"  { adaugaFIP(19); printf("token: %s\n", "&"); return ADDRESS_OPERATOR; }
"for"  { adaugaFIP(20); printf("token: %s\n", "for"); return FOR; }
"/"  { adaugaFIP(21); printf("token: %s\n", "/"); return '/'; }
"+"  { adaugaFIP(22); printf("token: %s\n", "+"); return '+'; }
"if"  { adaugaFIP(23); printf("token: %s\n", "if"); return IF; }
"%"  { adaugaFIP(24); printf("token: %s\n", "%"); return '%'; }
"=="  { adaugaFIP(25); printf("token: %s\n", "=="); return EQUAL; }
"printf"  { adaugaFIP(26); printf("token: %s\n", "printf"); return PRINTF; }
"\""  { adaugaFIP(27); printf("token: %s\n", "\""); return "\""; }
"else"  { adaugaFIP(28); printf("token: %s\n", "else"); return ELSE; }
"return" { adaugaFIP(29); printf("token: %s\n", yytext); return RETURN; }
"while"  { adaugaFIP(30); printf("token: %s\n", "while"); return WHILE; }
"-"  { adaugaFIP(31); printf("token: %s\n", "-"); return '-'; }
"\"%lf\"" { adaugaFIP(32); printf("token: %s\n", "\"%lf\""); return FORMATTER_DOUBLE; }
"double"  { adaugaFIP(33); printf("token: %s\n", "double"); return DOUBLE; }
"\"da\"" { adaugaFIP(34); printf("token de tip mesaj: %s\n", yytext); return DA; }
"\"nu\"" { adaugaFIP(35); printf("token de tip mesaj: %s\n", yytext); return NU; }

{id} { adaugaTS(1, yytext); printf("token de tip id: %s\n", yytext); return ID; }
{const}  { adaugaTS(2, yytext); printf("token de tip const: %s\n", yytext); return CONST; }
[ \t]  /* whitespace */
[\n]  { liniaCurenta++; printf("NEW LINE\n"); }
.  {printf("%s  token nerecunoscut la linia %d!!\n", yytext, liniaCurenta); return -1; }

%%

void adaugaFIP(int cod) {
  fip.coduri[fip.pozCurenta] = cod;
  fip.pozCurenta++;
 }

void adaugaTS(int codFIP, char simbol[]) {
  adaugaFIP(codFIP);
  for(int i = 0; i < ts.pozCurenta; i++) {
    if (strcmp(ts.elemente[i].simbol, simbol) == 0) return;
   }
  char tip[20];
  ts.elemente[ts.pozCurenta].cod = ts.codCurent;
  strcpy(ts.elemente[ts.pozCurenta].simbol, simbol);
  if (codFIP == 1)
    strcpy(tip, "identificator");
  else strcpy(tip, "constanta");
  strcpy(ts.elemente[ts.pozCurenta].tip, tip);
  ts.codCurent++;
  ts.pozCurenta++;
 }

int yywrap() {}
void show()
{
  printf("\n====== FIP ======\n");
  for (int i = 0; i < fip.pozCurenta; i++)
    printf("%d ", fip.coduri[i]);
  
  printf("\n");

  printf("\n====== TS ======\n");
  for (int i = 0; i < ts.pozCurenta; i++)
    printf("simbol : %s   %d    %s\n", ts.elemente[i].simbol, 50 + i, ts.elemente[i].tip);
}
