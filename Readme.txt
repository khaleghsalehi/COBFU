CORFU
=====
Warning: COBFU for C/C++ is not completed yet, dont use it in your real projects or any operational environment, NOW!
This project started afew days ago (21 May 2014), so there is challenges and we hope resolve issues as soon.
if you have any concern to resolve or help me please contact me via khaleghsalehi@gmail.com
The main idea for COBFU listed below:
1. Layout obfuscation
2. Data type obfuscation
3. CFG (Control Flow graph) obfuscation

According to attached papers, you can find out some valuable information for design and implement strong obfuscation system.
I am busy on research for CFG best practices, algorithm & implementation now ...

Current issue:
 [1] at CFG chapter , problem in stack returned value in (CFG), uninvited droped last semicolon(;)
 [2] in Layout Transformation. original printf("") functions parser have a problem, other state with format string work correctly, now

Kind Regards
Khalegh Salehi
12 Jul 2014




Try this source code:
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
  i++; // Problem number 1 is here, after obfuscation you must add ; in obfuscate code for i++
}// End of while
}








