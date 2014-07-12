#ifndef INSTANCIER_H
#define INSTANCIER_H

#include <stdlib.h>
#include <stddef.h>

#include "exit_if.h"

#define INSTANCIER(c_ident)    \
    c_ident recv = malloc(sizeof(struct c_ident));\
    EXIT_IF(recv==NULL, "erreur instanciation: " #c_ident)

#endif  /* INSTANCIER_H */
