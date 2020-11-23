lab 1 -> designing my own mini programming language derived from C; 
         making a lexical analizer in Java using regular expressions for identifying constants and literals; testing it on some programs written in my mini programming language
         
lab 2 -> rewriting lab 1 so that it uses final state machines instead of regular expressions for identifying constants and literals; it also outputs the mass of tranzitions,
         the initial state, final states and the alphabet
         
lab 3 -> writing a flex specification in order to obtain a lexical analizer for my mini programming language; 
instructions:

    flex lab3.l
    
    gcc lex.yy.c
    
    ./a.out
