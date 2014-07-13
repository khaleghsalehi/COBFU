Welcome to COBFU
================

Brief introduction:

   COBFU is an open source/research based project for Software Security. This project mainly and not limited for source code obfuscation
has been programmed with C/C++, the next view rigor on total sloution for Java/C/C++ plus . Currently COBFU under research and implementation
phase. Source code obfuscation, intuitively, is a the "Defense in Depth" concept in software security, hope to make complexity during reverse
engineering both in Static and Dynamic analyses. obfuscation is not actual definition for software security, indeed, it is providing a security
through obscurity. This is an undeniable fact the authors have a talk with  deep point of view in their works[papers/books/publications]

Simple architecture:

                                  +---------+
       [C/C++ Source code]------> |  COBFU  |-------> [Obfuscated C/C++ code]
                                  +---------+       
                                       \
                                        \
                                         \
                     +-------------------------------------------+
                     | flex(The Fast Lexical Analyzer) parse the |
                     | source code  and obfuscation algorithms   |
                     | apply here, the result is a obfuscated    |
                     |       source code(Spaghetti Code)         |
                     +-------------------------------------------+
                     

How it works:
       you can find out some good and valuable information in attached papers, everything is defined with details.
Methods for source code obfuscation:
1. Layout Transformation
2. Data type Transformation
3. CFG (Control Flow graph) Transformation
       
       


Warning: COBFU for C/C++ is not completed yet, don't use it in your real projects or any operational environment, NOW!
This project started few days ago (21 May 2014), so there is challenges and we hope resolve issues as soon.
if you have any concern to resolve or help us;  please contact us via khaleghsalehi@gmail.com
The main idea for COBFU listed below:
1. Layout transformation
2. Data type transformation
3. CFG (Control Flow graph) transformation

According to attached papers, you can find out some valuable information for design and implement strong obfuscation system.
I am busy on research for CFG best practices, algorithm & implementation now ...

Current issue:
 [1] at CFG chapter , problem in stack returned value in (CFG), uninvited droped last semicolon(;)
 [2] in Layout Transformation. original printf("") functions parser have a problem, other state with format string work correctly, now


Try this source code for current under-develop version:
================================================

#include<stdio.h>
/*
Please enter key manualy in obfuscate source code, this issue wil resole as soon :-) :-P
*/
void main(){
int i,j;

printf("The current value for j is a %d\n",j);
scanf("%d",&j);
i=1;
while(i<=j)
{
  if(i>=0){
      printf("The i value is a %d\n",i);
      printf("The j value is a %d\n",j);
         
  }//End of if
  i++; /* Problem number 1 is here, after obfuscation you must add ; in obfuscate code for i++ */
}/* End of while */
}

How to run[Refrence::https://github.com/ryarnyah/AnalyseC]:
      To compile you need flex:
      Debian/Ubuntu:
      apt-get install flex
      
    How it work:
    $ make
    $ ./gram file.c file1.h <...>
    $ ls
    file.c file.c_ file1.h file1.h_ convert.h gram
    $ # file with '_' is obfuscated
    $ # file convert.h have all obfuscation connections
    $ # to compile 
    $ gcc file.c_ file1.h convert.h -o file
    $ ./file
    
    To test it:
    $ ./gram arithmetique.c
    $ ls
    arithmetique.c.c arithmetique.c_ gram convert.h
    $ gcc arithmetique.c.c_ convert.h -std=c99 -o test
    $ ./test
    Usage : ./a.out [nbr] [nbr]
    





Kind Regards
Khalegh Salehi
Last update
12 Jul 2014, 14:59"







