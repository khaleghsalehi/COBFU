#include <stdio.h>
#include <time.h>
#include <string.h>
#include <stdlib.h>
#include "list_exist.h"
#include "vecteur.h"
#include "cons.h"
#include "erreurs.h"
#include "exit_if.h"

list_exist create()
{
  srand(time(NULL));
  return vecteur_faire();
}

static cons * is_in(list_exist list, char * key, int n)
{
  int i = 0;
  for(i = 0; i < vecteur_nombre_elements(list); i++)
    {
      cons * tmp = vecteur_lire(list, i);
      switch(n)
	{
	case 0:
	  {
	    if(!strcmp(tmp->first, key))
	      return tmp;
	    break;
	  }
	case 1:
	  {
	    if(!strcmp(tmp->second, key))
	      return tmp;
	    break;
	  }
	}
    }
  return NULL;
}

// On suppose a<b
int rand_a_b(int a, int b){
  return rand()%(b-a) +a;
}

static cons * generate_cons(list_exist list, char * s)
{
  int sizeOfS = strlen(s);
  char * next = malloc(sizeof(char)*(sizeOfS + 1));
  cons * res = malloc(sizeof(*res));
  EXIT_IF(next == NULL, err_malloc);
  EXIT_IF(res == NULL, err_malloc);
  memset(next, 0, sizeof(char)*(sizeOfS + 1));
  int i = 0;
  do
    {
      for(i = 0; i < sizeOfS; i++)
	{
	  next[i] = (char) rand_a_b('A', 'Z');
	}
    }
  while(is_in(list, next, 1) != NULL);
  res->first = s;
  res->second = next;
  res->toSave = 1;
  return res;
}

cons * get_from_key(list_exist list, char * key, int isAuto, int byPass)
{
  cons * res = is_in(list, key, 0);
  if(res == NULL)
    {
      char question = 'y';
      if(!isAuto && strlen(key) > 3)
	{
	  printf("Do you want to obfuscate %s?(y/n)\n", key);
	  question = getchar();
	  while(getchar() != '\n');
	}
      if(question == 'n' || strlen(key) < 3)
	{
	  char *sec = malloc(sizeof(*sec)*(strlen(key)+1));
	  EXIT_IF(sec == NULL, err_malloc);
	  memcpy(sec, key, sizeof(*sec)*(strlen(key)+1));
	  res = malloc(sizeof(*res));
	  res->first = key;
	  res->second = sec;
	  byPass = 1;
	}
	else
	{
	  res = generate_cons(list, key);
	}
      res->toSave = !byPass;
      vecteur_ecrire(list, vecteur_nombre_elements(list), res);
    }
  else if(byPass)
    {
      res->toSave = !byPass;
    }
  return res;
}

void delete(list_exist list)
{
  int i = 0;
  for(i = 0; i < vecteur_nombre_elements(list); i++)
    {
      cons * tmp = vecteur_lire(list, i);
      free(tmp->first);
      free(tmp->second);
      free(tmp);
    }
  
  vecteur_defaire(list);
}


void saveToFile(list_exist list, char * filename)
{
  FILE * file = fopen(filename, "w");
  int i = 0;
  int fileSize = vecteur_nombre_elements(list);
  fprintf(file, "#ifndef H_CONVERT\n#define H_CONVERT\n\n"); 
  for(i = 0; i < fileSize; i++)
    {
      cons * tmp = vecteur_lire(list, i);
      if(tmp->toSave)
	fprintf(file, "#define %s %s \n", tmp->second, tmp->first);
    }
  fprintf(file, "#endif\n");
  fclose(file);
}
