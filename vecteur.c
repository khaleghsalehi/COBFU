#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "instancier.h"
#include "erreurs.h"
#include "vecteur.h"

#define NOMBRE_ELEMENTS_PAR_BLOC    3

struct vecteur
{
    void **debut;
    long taille;
    long nombre_elements;
    int mode_bavard;
};

vecteur 
vecteur_faire(void)
{
    INSTANCIER(vecteur);

    recv->debut = calloc(NOMBRE_ELEMENTS_PAR_BLOC, sizeof(void*));
    EXIT_IF(recv->debut==NULL, err_malloc);

    recv->taille = NOMBRE_ELEMENTS_PAR_BLOC;
    recv->nombre_elements = 0;
    recv->mode_bavard = 0;
    return recv;
}

void 
vecteur_defaire(vecteur recv)
{
    free(recv->debut);
    free(recv);
}

void 
vecteur_ecrire(vecteur recv, int indice, void *valeur)
{
    if (indice >= recv->taille)
    {
        int n = indice + (NOMBRE_ELEMENTS_PAR_BLOC 
                          - (indice % NOMBRE_ELEMENTS_PAR_BLOC));

        recv->debut = realloc(recv->debut, n * sizeof(void*));
	memset(recv->debut + recv->taille, 0,
	       (n - recv->taille)*sizeof(void *));
             
        if (recv->mode_bavard)
        {
            fprintf(stderr, ">< vecteur: extension de %ld à %d ><\n",
                    recv->taille, n);
        }
        recv->taille = n;
    }
    recv->debut[indice] = valeur;
    if (recv->nombre_elements < indice+1)
        recv->nombre_elements = indice+1;
}

void *
vecteur_lire(vecteur recv, int indice)
{
    assert(indice >= 0);
    assert(indice<recv->nombre_elements);
    return recv->debut[indice];
}

int 
vecteur_nombre_elements(vecteur recv)
{
    return recv->nombre_elements;
}

void 
vecteur_mode_bavard(vecteur recv, int mode)
{
    recv->mode_bavard = mode;
}
