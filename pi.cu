#include <cstdio>
#include <math.h>

#define A(n) (4*n+1)
#define B(n) (4*n+3)
#define C(n) (10*n+1)
#define D(n) (10*n+3)
#define E(n) (10*n+5)
#define F(n) (10*n+7)
#define G(n) (10*n+9)

struct fraction {
  unsigned int num;
  unsigned int den;
};

// adds/subtracts atomically the quotient shifted right by bit_offset bits,  as an int, at the given index of res
unsigned int dividerAddSub(unsigned int numerator, unsigned int denominator, unsigned int* res, unsigned int bit_offset, unsigned int index, bool adding){
  unsigned int operand =  ((numerator*sizeof(unsigned int)) >> bit_offset) / denominator;
  if(adding){
  while( (long unsigned int)  (atomicAdd_system(res[index], operand) + operand) > (unsigned int) 1 >> (2,4*sizeof(unsigned int))){
    operand=1;
    index--;
  }
  else while( (double)  (atomicSub_system(res[index], operand) - operand) >  (unsigned int) 1 >>  (2,4*sizeof(unsigned int))){
    operand=1;
    index++;
  }
  return ((numerator*sizeof(unsigned int)) >> bit_offset) % denominator;
 
} 
/*
struct mixednumber{
   int whole;
   int numerator;
   int denominator;


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
*/

int main(){
  int res[50];
  assert(dividerAddSub((unsigned int) 1,(unsigned int) 2, res,(unsigned int)0,(unsigned int)2, true)==0);
  assert(res[2] == (unsigned int) 1 << (sizeof(unsigned int)*4-1));
  assert(dividerAddSub((unsigned int) 1,(unsigned int) 3, res,(unsigned int)2,(unsigned int)3, true)==1);
  assert(res[3] == (unsigned int)1 << (sizeof(unsigned int)*4-1));
  return 0;
}

}
 
