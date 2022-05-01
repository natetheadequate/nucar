#include <cstdio>
#include <math.h>

struct mixednumber{
   int whole;
   int numerator;
   int denominator;
};:ww

__global__ mixednumber divideBase2(int numerator, int denominator){
    struct mixednumber ret = { 
}

__global__ truncadd((void  addends, char* result 

__device__ int modpow(int n, int a, int mod){
  if(a==0){
    return 1;
  }
  return (n*pow(n, a-1)) % mod;
}

__global__ void neobellard(int i, float* result){
   
}
__global__ void bellard(int i, float* result){
  float seq=(pow(2,5) / (-4*i+1))- (1 / (4*i+3))+ (pow(2, 8) / (10 * i +1)) - (pow(2, 6) / (10*i+3)) - (pow(2, 2) / (10*i +5)) - (4/ 10*i+7) + (1 / (10*i+9));
  atomicAdd(result,pow(-1,i)*seq /(pow(2, 10*i)));
  return;
}

int main(int _, char **argv){
  int N=atoi(argv[1]);
  if(N<=0){
    printf("Invalid argument for number of digits to calculate \n");
    return 1;
  }
  if(N>1000){
    printf("I don't want to use that much resources for this. Pick a smaller number");
    return 1;
  }
  printf("Calculating %i digits of pi: \n",N);
  float* cudaResult;
  cudaMalloc(&cudaResult, sizeof(float));
  bellard<<<1,N>>>(5,cudaResult);
  cudaDeviceSynchronize();
  float result;
  cudaMemcpy(&result, cudaResult, sizeof(float), cudaMemcpyDeviceToHost);
  cudaDeviceSynchronize();
  printf("%f \n", result*pow(2.0,-6.0));
  return 0;
}
 
