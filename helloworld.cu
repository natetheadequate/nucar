#include <cstdio>

__global__ void sayHi(){
  printf("Hi\n");
}
__global__ void greet(char* a){
  printf("%s from gpu block %i \n", a, blockIdx.x);
}
#define N 7
int main(){
  printf("Hello World!\n");
  sayHi<<<1,1>>>();
  char* cudaA;
  char greeting[] = "Hello";
  cudaMalloc((void **) &cudaA,strlen(greeting)*sizeof(char));
  cudaMemcpy(cudaA,greeting,strlen(greeting)*sizeof(char),cudaMemcpyHostToDevice);
  greet<<<N,1>>>(cudaA);
  cudaFree(cudaA);
  return 0;
}
