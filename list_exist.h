#ifndef H_LIST_EXIST
#define H_LIST_EXIST
#include "vecteur.h"
#include "cons.h"

typedef vecteur list_exist;

extern list_exist create();
extern cons * get_from_key(list_exist list, char * key, int isAuto, int byPass);
extern void delete(list_exist list);
extern void saveToFile(list_exist list, char * filename);

#endif

