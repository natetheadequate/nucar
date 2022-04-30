#include <stdio.h>

struct hexdigit{
  unsigned int a:1;
  unsigned int b:1;
  unsigned int c:1;
  unsigned int d:1;
  unsigned int e:1;
  unsigned int f:1;
  unsigned int g:1;
  unsigned int h:1;
  unsigned int i:1;
  unsigned int j:1;
  unsigned int k:1;
  unsigned int l:1;
  unsigned int m:1;
  unsigned int n:1;
  unsigned int o:1;
  unsigned int p:1;
  unsigned int q:1;
  unsigned int r:1;
  unsigned int s:
} doh;

int main(){
  doh.a=1;
  doh.b=1;
  doh.c=1;
  doh.d=1;
  printf("%i", sizeof(doh));
  printf("%i", doh.a);
  return 0;
}  
