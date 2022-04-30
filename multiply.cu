#include <cstdio>

#include "dotproductmatrices.c"
// should define matrices A and B, where A is an array of N arrays of length M, and B is an array of M arrays of length P

__global__ void multiplyVec(int* A, int* B, int* result){
  printf("oh");
  for(int i=0; i<threadIdx.x*20;i++){
    printf("%i", *A);
  }
  result[threadIdx.x] = A[threadIdx.x] * B[threadIdx.x];
  printf("hi");
  return;
}

__global__ void sayHi(int* A, int* B, int* result){
  printf("yo");
  return;
}

__global__ void dotproduct(int* A, int* B, int N, int* result){
  int* C;
  printf("%i", N);
  printf("Hi");
  printf("%i", A[0]);
  cudaMalloc((void **) &C,N*sizeof(int));
  multiplyVec<<<1, N>>>(A, B, C);
  cudaDeviceSynchronize();
  int sum=0;
  for (int i=0; i<N; i++){
    sum+=C[i];
    printf("Sum %i.  ", sum);
  }
  printf("Computation complete: %i. \n", sum);
  *result=sum;
  return;
}
int main(){
  // take row of A
  // take corresponding column of B
  // take
  printf("A=[");
  for(int i=0; i<sizeof(A)/sizeof(A[0]); i++){
    printf("%i, ", A[i]);
  }
  printf("]\nB=[");
  for(int i=0; i<sizeof(B)/sizeof(B[0]); i++){
   printf("%i, ",B[i]);
  }
  printf("]\nAnswer should be %i.", ans);

  int* cudaResult;
  int result;
  int* cudaA;
  int* cudaB;
  cudaMalloc( (void **) &cudaA, 5*sizeof(int));
  cudaMalloc( (void **) &cudaB, 5*sizeof(int));
  cudaMalloc( (void **) &cudaResult, sizeof(int));
  cudaMemcpy(cudaA, (int *) A, 5*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(cudaB, (int *) B, 5*sizeof(int), cudaMemcpyHostToDevice);
  dotproduct<<<1, 1>>>((int *) cudaA, (int *) cudaB, 5, cudaResult);
  cudaDeviceSynchronize();
  cudaMemcpy(&result, cudaResult, sizeof(int), cudaMemcpyDeviceToHost);
  cudaDeviceSynchronize();
  printf("%i\n",result);
  return 0;
}
