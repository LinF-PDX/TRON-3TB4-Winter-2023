#include "system.h"
#include <stdio.h>
#define BASE SDRAM_CONTROLLER_0_BASE
#define MAXNUM_WORDS   SDRAM_CONTROLLER_0_SPAN/2
//64MB=67108864 Byte (SDRAM_SPAN)

int main() {
    int i;
    int char_err_num=0, short_err_num=0, int_err_num=0;
    char * char_ptr;
    char aChar;
    short *short_ptr;
    short aShort;
    int *int_ptr;
    int aInt;
    int charsize, shortsize, intsize;
    charsize=sizeof(aChar);
    shortsize=sizeof(aShort);
    intsize=sizeof(aInt);
    printf("sizeof char, short, int respectively: %d, %d, %d\n", charsize, shortsize, intsize);

    //Character test
    printf("\n Writing chars.....\n");
    for (i=0; i<MAXNUM_WORDS*2; i++) {
        *(char*)(BASE+i)=i%128;
    }
    printf("\n Testing chars.....\n");
    for (i=0; i<MAXNUM_WORDS*2; i++) {
        if (* (char*)(BASE+i)!=i%128){
                char_err_num++;
            }
    }
    printf("The total numbers of error in char is : %i\n" ,char_err_num);

    //Short test
    printf(" \n Writing short......\n");
    for (i=0; i<MAXNUM_WORDS; i++) {
        *(short*)(BASE+i*2)=i%32767; 
    }
    printf(" \n Testing short......\n");
    for (i=0; i<MAXNUM_WORDS; i++) {
        if (* (short*)(BASE+i*2)!=i%32767){
                short_err_num++;
            }
    }
    printf("The total numbers of error in short is : %i\n" ,short_err_num);

    //Integer test
    printf(" \n Writing integer......\n");
    for (i=0; i<MAXNUM_WORDS/2; i++) {
        *(int*)(BASE+i*4)=i; 
    }
    printf(" \n Testing integer......\n");
    for (i=0; i<MAXNUM_WORDS/2; i++) {
        if (* (int*)(BASE+i*4)!=i){
                int_err_num++;
        }
    }
    printf("Testing Int: the total numbers of error in int is : %i\n" ,int_err_num);
  return 0;
}
