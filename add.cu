#include <cstdio>

__global__ void sayHi(){
  printf("Hi\n");
}
__global__ void addIntVector(int* a, int* b, int* c){
  printf("hello from gpu block %i", blockIdx.x);
  c[blockIdx.x]=a[blockIdx.x]+b[blockIdx.x];
}
#define N 7
int main(){
  printf("Hello World!\n");
  sayHi<<<N,1>>>();
  //int a[N]= {1,3,5, 9, 11, 13, 15};
  //int b[N]= {0,2,4,6, 8, 10, 12};
  //int c[N]={201,2,3,4,5,6,7};
  int a[N], b[N], c[N];
  for(int i=0; i<N; i++){
    a[i]=2*i;
    b[i]=i;
  }
  int* cudaA;
  int *cudaB;
  int *cudaC;
  cudaMalloc((void **) &cudaA,N*sizeof(int));
  cudaMalloc((void **) &cudaB,N*sizeof(int));
  cudaMalloc((void **) &cudaC,N*sizeof(int));
  cudaMemcpy(cudaA,a,N*sizeof(int),cudaMemcpyHostToDevice);
  printf("oh boy\n");
  cudaMemcpy(cudaB,b,N*sizeof(int),cudaMemcpyHostToDevice);
  addIntVector<<<N,1>>>(cudaA,cudaB,cudaC);
  cudaDeviceSynchronize();
  printf("whew\n");
  cudaMemcpy(c,cudaC,N*sizeof(int),cudaMemcpyDeviceToHost);
  printf("%i", cudaGetLastError());
  printf("waitwut\n");
  for(int i=0;i<N;i++){
    printf("%i,", c[i]);
  }
  printf("\n");
  cudaFree(cudaC);
  cudaFree(cudaA);
  cudaFree(cudaB);
  return 0;
}
