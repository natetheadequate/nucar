// an array is generated of all numbers
//
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define N 12345678

int COMPOSITE = 2;
int PRIME = 1;
int UNCLEAR = 0;
int nums[N] = {0};

int main() {
  printf("starting");
  for (int i = 2; i < N; i++) {
    if (nums[i] == UNCLEAR) {
      nums[i] = PRIME;
      for(int j = 2 * i; j < N; j = i+j){
          nums[j] = COMPOSITE;
          }
    }
  }
  for (int i = 0; i < N; i++) {
    if (nums[i] == PRIME) {
      printf("%i,", i);
    }
  }
  printf("\n");
  return 1;
}