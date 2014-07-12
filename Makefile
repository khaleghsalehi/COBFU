CC=gcc
CFLAGS=-g -Wall -Werror
LDFLAGS=

OBJS=erreurs.o exit_if.o list_exist.o vecteur.o analyse.o
HEAD=erreurs.h exit_if.h list_exist.h vecteur.h classe.h cons.h instancier.h

all:gram
erreurs.o:erreurs.c
exit_if.o:exit_if.c
list_exist.o:list_exist.c
vecteur.o:vecteur.c
gen:
	lex analyse.l
analyse.o:gen lex.yy.c
gram:$(OBJS) gen
	$(CC) $(OBJS) $(HEAD) -o gram
clean:
	rm -fr $(OBJS) lex.yy.c gram
