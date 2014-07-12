/*

     This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
     This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>
***************************************************************************
COBFU, C/C++ obfuscator
Authors & contribute :
	Ryarbyah{
		 Main Authors: 	
		 https://github.com/ryarnyah/AnalyseC
		 C Obfuscator; http://not2do4programing.wordpress.com/
	}
	Khalegh{
		 Continues:
		 https://github.com/khaleghsalehi/COBFU
		 Khalegh Salehi 
        	 Email:khaleghsalehi@gmail.com
	}
Note:	
	[+] Add \ to break the line in c source code			 
*/
D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*
EXCLUDE		"fprintf"|"memcpy"|"exit"|"malloc"|"free"|"calloc"|"realloc"|"assert"|"memset"|"longjmp"|"setjmp"|"strcmp"|"strncmp"|"strcpy"|"strncpy"|"rand"|"srand"|"time"|"strlen"|"NULL"|"stdin"|"stderr"|"EXIT_SUCCESS"|"EXIT_FAILURE"|"main"|"argc"|"argv"|"atoi"|"atof"|"strtol"|"true"|"false"|"bool"|"ssize_t"|"size_t"|"O_RDONLY"|"SEEK_END"|"SEEK_SET"|"O_WRONLY"|"O_TRUNC"|"O_CREAT"|"DEBUG"|"__FILE__"|"__FUNCTION__"|"__LINE__"|"write"|"read"|"close"|"lseek"|"seek"|"perror"|"open"

%{
#include <stdio.h>
#include <stdlib.h>
#include "cons.h"
#include <time.h>
#include "list_exist.h"
#include <string.h>
char *parse_akolad();
//char *parse_parantez();
void parse_while();
void count();
void comment();
void newprintf();
void newscanf();
void changedigit();
static list_exist list;
static FILE * currentFile = NULL;
static int isAuto = 1;
static int byPass = 0;
//define global variable for parse_akolad
char buff11[1000];
char polbuff11[1000];
%}

%%
"while"                 { parse_while();}
"/*"			{ comment();}
"printf"                { newprintf();}
"scanf"                 { newscanf();}
"auto"			{ fprintf(currentFile, "%s", yytext); }
"size_t"		{ fprintf(currentFile, "%s", yytext); }
"off_t"			{ fprintf(currentFile, "%s", yytext); }
"break"			{ fprintf(currentFile, "%s", yytext); }
"case"			{ fprintf(currentFile, "%s", yytext); }
"char"			{ fprintf(currentFile, "%s", yytext); }
"const"			{ fprintf(currentFile, "%s", yytext); }
"continue"		{ fprintf(currentFile, "%s", yytext); }
"default"		{ fprintf(currentFile, "%s", yytext); }
"do"			{ fprintf(currentFile, "%s", yytext); }
"double"		{ fprintf(currentFile, "%s", yytext); }
"else"			{ fprintf(currentFile, "%s", yytext); }
"enum"			{ fprintf(currentFile, "%s", yytext); }
"extern"		{ fprintf(currentFile, "%s", yytext); }
"float"			{ fprintf(currentFile, "%s", yytext); }
"for"			{ fprintf(currentFile, "%s", yytext); }
"goto"			{ fprintf(currentFile, "%s", yytext); }
"if"			{ fprintf(currentFile, "%s", yytext); }
"int"			{ fprintf(currentFile, "%s", yytext); }
"long"			{ fprintf(currentFile, "%s", yytext); }
"register"		{ fprintf(currentFile, "%s", yytext); }
"return"		{ fprintf(currentFile, "%s", yytext); }
"short"			{ fprintf(currentFile, "%s", yytext); }
"signed"		{ fprintf(currentFile, "%s", yytext); }
"sizeof"		{ fprintf(currentFile, "%s", yytext); }
"static"		{ fprintf(currentFile, "%s", yytext); }
"struct"		{ fprintf(currentFile, "%s", yytext); }
"switch"		{ fprintf(currentFile, "%s", yytext); }
"typedef"		{ fprintf(currentFile, "%s", yytext); }
"union"			{ fprintf(currentFile, "%s", yytext); }
"unsigned"		{ fprintf(currentFile, "%s", yytext); }
"void"			{ fprintf(currentFile, "%s", yytext); }
"volatile"		{ fprintf(currentFile, "%s", yytext); }
{EXCLUDE}		{ fprintf(currentFile, "%s", yytext); }
{L}({L}|{D})*		{ char * reso = malloc(sizeof(char)*(strlen(yytext) + 1)); memcpy(reso, yytext, sizeof(char)*(strlen(yytext) + 1));cons * res = get_from_key(list, reso, isAuto, byPass); fprintf(currentFile, "%s", res->second); if(byPass==1)byPass=0;}
#"define"|"ifdef"|"ifndef" {fprintf(currentFile, "%s", yytext);byPass=1;}
#{L}({L}|{D})* {fprintf(currentFile, "%s", yytext);}
\<{L}({L}|{D}|\/)*".h"\> {fprintf(currentFile, "%s", yytext);}

0[xX]{H}+{IS}?          { fprintf(currentFile, "%s", yytext); }
0{D}+{IS}?              { fprintf(currentFile, "%s", yytext); }
{D}+{IS}?               { changedigit(); }
'(\\.|[^\\'])+'         { fprintf(currentFile, "%s", "Digit yytext"); }

{D}+{E}{FS}?            { changedigit(); }
{D}*"."{D}+({E})?{FS}?  { changedigit(); }
{D}+"."{D}*({E})?{FS}?  { changedigit(); }
\"(\\.|[^\\"])*\"       { fprintf(currentFile, "%s", yytext); }
">>="			{ fprintf(currentFile, "%s", yytext); }
"<<="			{ fprintf(currentFile, "%s", yytext); }
"+="			{ fprintf(currentFile, "%s", yytext); }
"-="			{ fprintf(currentFile, "%s", yytext); }
"*="			{ fprintf(currentFile, "%s", yytext); }
"/="			{ fprintf(currentFile, "%s", yytext); }
"%="			{ fprintf(currentFile, "%s", yytext); }
"&="			{ fprintf(currentFile, "%s", yytext); }
"^="			{ fprintf(currentFile, "%s", yytext); }
"|="			{ fprintf(currentFile, "%s", yytext); }
">>"			{ fprintf(currentFile, "%s", yytext); }
"<<"			{ fprintf(currentFile, "%s", yytext); }
"++"			{ fprintf(currentFile, "%s", yytext); }
"--"			{ fprintf(currentFile, "%s", yytext); }
"->"			{ fprintf(currentFile, "%s", yytext); }
"&&"			{ fprintf(currentFile, "%s", yytext); }
"||"			{ fprintf(currentFile, "%s", yytext); }
"<="			{ fprintf(currentFile, "%s", yytext); }
">="			{ fprintf(currentFile, "%s", yytext); }
"=="			{ fprintf(currentFile, "%s", yytext); }
"!="			{ fprintf(currentFile, "%s", yytext); }
";"			{ fprintf(currentFile, "%s", yytext); }
"{"			{ fprintf(currentFile, "%s", yytext); }
"}"			{ fprintf(currentFile, "%s", yytext); }
","			{ fprintf(currentFile, "%s", yytext); }
":"			{ fprintf(currentFile, "%s", yytext); }
"="			{ fprintf(currentFile, "%s", yytext); }
"("			{ fprintf(currentFile, "%s", yytext); }
")"			{ fprintf(currentFile, "%s", yytext); }
"["			{ fprintf(currentFile, "%s", yytext); }
"]"			{ fprintf(currentFile, "%s", yytext); }
"."			{ fprintf(currentFile, "%s", yytext); }
"&"			{ fprintf(currentFile, "%s", yytext); }
"!"			{ fprintf(currentFile, "%s", yytext); }
"~"			{ fprintf(currentFile, "%s", yytext); }
"-"			{ fprintf(currentFile, "%s", yytext); }
"+"			{ fprintf(currentFile, "%s", yytext); }
"*"			{ fprintf(currentFile, "%s", yytext); }
"/"			{ fprintf(currentFile, "%s", yytext); }
"%"			{ fprintf(currentFile, "%s", yytext); }
"<"			{ fprintf(currentFile, "%s", yytext); }
">"			{ fprintf(currentFile, "%s", yytext); }
"^"			{ fprintf(currentFile, "%s", yytext); }
"|"			{ fprintf(currentFile, "%s", yytext); }
"?"			{ fprintf(currentFile, "%s", yytext); }
[\t\n]  		{ fprintf(currentFile, "%s", ""); }
[ \v\f]                 { fprintf(currentFile, "%s", yytext); }
.			{ /* ignore bad characters */ fprintf(currentFile, "%s", yytext); }

%%

int yywrap()
{
 return 1;
}

//zx
void parse_while()
{
int i,arg;
char ako[1]="";
char swname[100]="";
for(i=0;i<=1000;i++)
{
	buff11[i]='\0';
	polbuff11[i]='\0';
}

/**/
/*Creat random name for switch case var*/
char charset[] = "0123456789"
                 "abcdefghijklmnopqrstuvwxyz"
                 "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
char prefix[]="_";
swname[0]=prefix[0];
swname[1]=prefix[0];
i=2;
    while (i<=8) {
        size_t index = (double) rand() / RAND_MAX * (sizeof charset - 1);
        swname[i] =charset[index];
        i++;
    }
    swname[11] ='\0';

for(i=0;i<10;i++)
printf("%c",swname[i]);
/* End name generation */
printf("\n\n");




parse_akolad();
arg=0;
i=0;
strcpy(ako,"{");



// TEMP for test, remove here

i=0;
printf("\n------------------------\n");
for(i=0;i<=15;i++)
	printf("[%d][%c]-",i,polbuff11[i]);
printf("\n------------------------\n");



//TEMP for test
i=0;
while(polbuff11[i]!=ako[0])
{
		printf("%c",polbuff11[i]);
		i++;
		arg++;
}
//
//printf("Index is a -> %d\n",k);
//




fprintf(currentFile,"%s","__OoOoOl1l1l=1;\nwhile(__OoOoOl1l1l!=0){\nswitch(__OoOoOl1l1l)\n{\ncase 1:{__OoOoOl1l1l=2;break;}\ncase 2:\n{");
fprintf(currentFile,"%s","\n\tif");
                       for (i=0;i<=arg-1;i++)
				fprintf(currentFile,"%c",polbuff11[i]);
fprintf(currentFile,"%s","\n\t\t{__OoOoOl1l1l=3;break;}");
fprintf(currentFile,"%s","\n\tif(!"); 
			for(i=0;i<=arg-1;i++)
                        	fprintf(currentFile,"%c",polbuff11[i]);
fprintf(currentFile,"%s" ,")\n\t\t{__OoOoOl1l1l=0;break;}\nbreak;}\ncase 3:\n{\n");


			i=arg+1;
			while(polbuff11[i]!='\0')
//			for (i=arg+1;i<1000;i++)
			{
						fprintf(currentFile,"%c",polbuff11[i]);
						i++;
			}

fprintf(currentFile,"%s","\n\n__OoOoOl1l1l=2;break;}\n}"); // check for removed {, remember
}// End of parse while function.








char *parse_akolad()
{
        char c1;
        while((c1 = input()) !='}')  
        {
		sprintf(buff11,"%c",c1);
		strcat(polbuff11,buff11);		
		parse_akolad();
		return 0;
	}
		strcat(polbuff11,"}");
return polbuff11;
}





/******************************** 
	Remove the comments by //
*********************************/
/*
 How to use gcc preprocessors to remove all comment in c source code 
 gcc -fpreprocessed -dD -E test.c
*/
 
/*Comment by myself*/
void comment()
{
	char c, c1;

loop:
	while ((c = input()) != '*' && c != 0)
		;//putchar(c);

	if ((c1 = input()) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}

	if (c != 0)
		;//putchar(c1);
}
/********************************************
********************************************/
void changedigit()
{
float  rp1,rp2,digit;
int rndx;
//float poldigit;
//int poldigit,rndx,rp1,rp2,digit;

//zz
		srand(time(NULL));
		rndx=rand()%10000000+1;
                printf("%d",rndx);
               	digit=atoi(yytext);
		rp1=(digit)-rndx;
       	        rp2=(digit-rp1)+rndx;          
  //     	        poldigit=(rp1+rp2-rndx);
		fprintf(currentFile, "((((%f)+(%f))-((%d))))",rp1,rp2,rndx); // the prantez help to complex exprestion
	//	fprintf(currentFile, "%f+%f-%d",rp1,rp2,rndx); // the prantez help to complex exprestion


}
/********************************************
********************************************/
/*
	START scanf FUNCTION
        
*/
void newscanf()
{
   char c,c1;
   int  code,code2;
   char binstr[1000]="";
   char repo[1000]="",hexrepo[1000]="";
   while ((c=input())!='(' && c !=0)
   unput(c);
   while ((c1=input()) !=',' && c!=0){             
                code=(int)c1;
                if(code==92){ // Find Slash character 
                                         sprintf(hexrepo,"%s","\\");
                                         strcat(repo,hexrepo);
                                         c1=input();//Next
                                         sprintf(hexrepo,"%c",c1);
                                         strcat(repo,hexrepo); 
					 continue;}
                //zz

                if(code==37){ // Find % character & figureout printf format string 
                                         sprintf(hexrepo,"%s","\%");
                                         strcat(repo,hexrepo);
                                         c1=input();//Next 
                                         code2=(int)c1;
                                         while (((int)code2!=100) && ((int)code2!=99) && ((int)code2!=102) && ((int)code2!=115) && ((int)code2!=105) )
                                                {
                                                 sprintf(hexrepo,"%c",c1);
                                                 strcat(repo,hexrepo);
                                                 c1=input();
                                                 code2=(int)c1;
                                                 //continue;
                                                }  
                                         if ( code2==105 || code2==99 || code2==102 || code2==115 || code2==100 )
                                                {
                                                 sprintf(hexrepo,"%c",c1);
                                                 strcat(repo,hexrepo);
                                  //               c1=input();
                                                 continue;
						}

			  } // End of % checkup
     
              if(code!=34){ // Ignore " character 
                                 	sprintf(hexrepo,"\\x%x", c1);
	                                strcat(repo,hexrepo);
                                        } 
  } // End of while II            

sprintf(binstr, "%s%s%s", "scanf(\"",repo,"\",");
fprintf(currentFile, "%s", binstr);   		
printf("%s",yytext);
printf("\n");
}

/*
	END Scanf FUNCTION   
 
*/

/********************************************
********************************************/




/*
	START PRINTF FUNCTION
        printf([message/format specific],variable)
        printf(" [%[Dig].[Dig]f,d,i,c,s,[a-z][A-Z][0-9][!@#$%^&*()_+]",v1,v2,..,v(n-1),v(n))
        Where v1,v2,..,v(n-1),v(n-2) must be changed and replaced.          
 
        
*/



/***********************************

Orginal syntax : 
		printf("[Printf format type/message]",var1,var2,...varn);
So:
		printf(part I,Part II)			
Obfuscation details:
		while(c1=input!=')')
			buff=buff+c1; // buff is a string contain all string befor last ) in printf(.....)
		// Part I	
		index=find-last-str-postion(buff,");
		messagebuff="printf('") 
		for(i=0;i<=index,i++)
			messagebuff=messagebuff+buff[i]
		for(i=0;i<len(messagebuff;i++)
			{
				if(messgebuff[i]<>"\") 
					write(hex(messagebuff[i]));
				else // format type string...
					{
						
						while(messagebuff[i]<> d,s,o,... )
							{
								write(messagebuff[i];
								i++;	 // For example \3.33f
							}	
							write(mesaagebuff[i++?]; / for example \n --> n
					}	
			}
	      for(i=index;i<=len(buff);i++) // write Part II
			write(buff[i]);
	 	write(")");			
This approach have a problem during parsing becuase this example parsing not completely for example printf(" my name is a(a) ",.....
when parsing parse until a) and drop esle... 

************************************/



void newprintf()
{
   char c,c1;
   int  i,code,code2;
   char binstr[1000]="";
   char repo[1000]="",hexrepo[1000]="";
/* 
   CHECK FOR SIMPLE printf, work such as simple echo
   Example:
            printf("Hello World")  
*/


/*
  CHECK FOR ADVANCED printf, 
  Example:
          printf("\n\n%d%3.1f",i,j);     
*/
   for(i=0;i<100;i++)
        printf("%c",yytext[i]);	
   while ((c=input())!='(' && c !=0)
   unput(c);
   while ((c1=input()) !=',' && c!=0){             
                code=(int)c1;
                if(code==92){ // Find Slash character 
                                         sprintf(hexrepo,"%s","\\");
                                         strcat(repo,hexrepo);
                                         c1=input();//Next
                                         sprintf(hexrepo,"%c",c1);
                                         strcat(repo,hexrepo); 
					 continue;}
                //zz

                if(code==37){ // Find % character & figureout printf format string 
                                         sprintf(hexrepo,"%s","\%");
                                         strcat(repo,hexrepo);
                                         c1=input();//Next 
                                         code2=(int)c1;
                                         while (((int)code2!=100) && ((int)code2!=99) && ((int)code2!=102) && ((int)code2!=115) && ((int)code2!=105) )
                                                {
                                                 sprintf(hexrepo,"%c",c1);
                                                 strcat(repo,hexrepo);
                                                 c1=input();
                                                 code2=(int)c1;
                                                 //continue;
                                                }  
                                         if ( code2==105 || code2==99 || code2==102 || code2==115 || code2==100 )
                                                {
                                                 sprintf(hexrepo,"%c",c1);
                                                 strcat(repo,hexrepo);
                                  //               c1=input();
                                                 continue;
						}

			  } // End of % checkup
     
              if(code!=34){ // Ignore " character 
                                 	sprintf(hexrepo,"\\x%x", c1);
	                                strcat(repo,hexrepo);
                                        } 
  } // End of while II            

sprintf(binstr, "%s%s%s", "printf(\"",repo,"\",");
fprintf(currentFile, "%s", binstr);   		
printf("%s",yytext);
printf("\n");
}

/*
	END PRINTF FUNCTION   
 
*/



int column = 0;

void count()
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}

static void usage(char * s)
{
  fprintf(stderr, "Usage: %s [-m(manuel)] <fichier a obfusquer>\n", s);
  exit(1);
}

int main(int argc, char **argv)
{


  if(argc < 2)
    usage(argv[0]);
  list = create();
  int i = 1;
  if(strlen(argv[1]) == 2 && argv[1][1] == 'm')
  {
    isAuto = 0;
    i = 2;
    printf("is not auto");
  }
  for(; i < argc; i++)
  {
    char tmp[strlen(argv[i]) + 2];
    memcpy(tmp, argv[i], sizeof(char)*(strlen(argv[i])));
    tmp[strlen(argv[i])] = '_';
    tmp[strlen(argv[i]) + 1] = '\0';
    currentFile = fopen(tmp, "w");
    if(currentFile == NULL)
    {
	perror("fopen");
	return 1;
    }
    yyin = fopen(argv[i], "r");
    if(yyin == NULL)
    {
	perror("fopen");
	return 1;
    }
    fprintf(currentFile, "#include \"convert.h\"\n");		
	    yylex();
    fclose(currentFile);
    fclose(yyin);
    currentFile = NULL;
    yyin = NULL;
  }
  saveToFile(list, "convert.h");
  delete(list);
  return 0;
}
