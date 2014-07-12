#ifndef EXIT_IF_H
#define EXIT_IF_H

#include <stdbool.h>

#define EXIT_IF(expression, message) \
    exit_if(__FILE__, __LINE__, expression, #expression, message)

#define PERROR_AND_EXIT() \
    perror_and_exit(__FILE__ ":" PERROR__STRING(__LINE__) ":")
#define PERROR__STRING(n) PERROR___STRING(n)
#define PERROR___STRING(n) #n

extern void exit_if(char *fichier, int ligne, bool condition, 
		    char *code, char *message);
extern char *exit_message;
extern void perror_and_exit(char *localisation);

#endif  /* EXIT_IF_H */
