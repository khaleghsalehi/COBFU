#ifndef VECTEUR_H
#define VECTEUR_H

#include "classe.h"

CLASSE(vecteur);

extern vecteur vecteur_faire(void);
extern void vecteur_defaire(vecteur);
extern void vecteur_ecrire(vecteur, int, void *);
extern void *vecteur_lire(vecteur, int);
extern int vecteur_nombre_elements(vecteur);
extern void vecteur_mode_bavard(vecteur, int);

#endif  /* VECTEUR_H */
