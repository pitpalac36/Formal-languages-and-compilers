/* analizor pentru un MLP din C */

%{
   /* definitii accesibile in yylex si main */

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

  void adaugaFIP(int cod);

  void adaugaTS(int codFIP, char simbol[]);

%}

  /* reguli */
id       [a-zA-Z_]+[a-zA-Z_0-9]*
const    0|[1-9]+[0-9]*|\-[1-9]+[0-9]*
%%

"#"  { adaugaFIP(3); }
"include" { adaugaFIP(4); }
"<"  { adaugaFIP(5); }
">"  { adaugaFIP(6); }
"stdio.h"  { adaugaFIP(7); }
"int"  { adaugaFIP(8); }
"main"  { adaugaFIP(9); }
"("  { adaugaFIP(10); }
")"  { adaugaFIP(11); }
"{"  { adaugaFIP(12); }
"}"  { adaugaFIP(13); }
","  { adaugaFIP(14); }
";"  { adaugaFIP(15); }
"="  { adaugaFIP(16); }
"scanf"  { adaugaFIP(17); }
"\"%d\""  { adaugaFIP(18); }
"&"  { adaugaFIP(19); }
"for"  { adaugaFIP(20); }
"/"  { adaugaFIP(21); }
"+"  { adaugaFIP(22); }
"if"  { adaugaFIP(23); }
"%"  { adaugaFIP(24); }
"=="  { adaugaFIP(25); }
"printf"  { adaugaFIP(26); }
"\""  { adaugaFIP(27); }
"else"  { adaugaFIP(28); }
"return"  { adaugaFIP(29); }
"while"  { adaugaFIP(30); }
"-"  { adaugaFIP(31); }
"\"%lf\""  { adaugaFIP(32); }
"double"  { adaugaFIP(33); }

{id} { adaugaTS(1, yytext); }
{const}  { adaugaTS(2, yytext); }
[ \t\n]+   /* whitespace */
.  { printf("%s  token nerecunoscut\n", yytext); }

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
int main()
{
  FILE* f;
  char filename[100];
  printf("Fisier : ");
  scanf("%s", filename);
  f = fopen(filename, "r");
  yyin = f;
  yylex();

  printf("\n====== FIP ======\n");
  for (int i = 0; i < fip.pozCurenta; i++)
    printf("%d ", fip.coduri[i]);

  printf("\n");

  printf("\n====== TS ======\n");
  for (int i = 0; i < ts.pozCurenta; i++)
    printf("simbol : %s   %d    %s\n", ts.elemente[i].simbol, 50 + i, ts.elemente[i].tip);

  return 0;
}
