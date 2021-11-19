// an array is generated of all numbers
//
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>

#define N 1000

int COMPOSITE = 2;
int PRIME = 1;
int UNCLEAR = 0;
int nums[N] = {0};
int indexes[N];
pthread_t threads[N];
pthread_mutex_t mutexes[N];
int deathrow[N]={0};

void* eliminate(int* vargs) {
  int n = *vargs;
  if(deathrow[n]==1){
      return NULL;
  }
  printf("thread created %i; ", n);
  for (int i = 2 * n; i < N; i = i+n) {
    pthread_mutex_lock(&mutexes[i]);
    printf("%i is setting %i as composite; ", n, i);
    nums[i] = COMPOSITE;
    deathrow[i]==1;
    printf("%i has set %i as composite; ", n, i);
    pthread_mutex_unlock(&mutexes[i]);
  }
  return NULL;
}
int main() {
  for (int i = 0; i < N; i++) {
    indexes[i]=i;
  }
  struct timeval start1raw;
  struct timeval end1raw;
  struct timeval start2raw;
  struct timeval end2raw;
  gettimeofday(&start1raw,NULL);
  for (int i = 2; i < N; i++) {
    pthread_mutex_lock(&mutexes[i]);
    printf("main loop %i; ", i);
    if (nums[i] == UNCLEAR) {
      nums[i] = PRIME;
      printf("%i was set to Prime in main loop; ", i);
      pthread_mutex_unlock(&mutexes[i]);
      printf("creating thread %i; ", i);
      pthread_create(&threads[i], NULL, (void * (*)(void *)) &eliminate,  &indexes[i]);
    } else {
      printf("main loop unclocked; ");
      pthread_mutex_unlock(&mutexes[i]);
    }
  }
   
  gettimeofday(&end1raw,NULL);
  long thread1startu=start1raw.tv_usec;
  long threadtime=end1raw.tv_sec-start1raw.tv_sec;
  long threadutime=end1raw.tv_usec-start1raw.tv_usec;
  for (int i = 2; i < N; i++) {
    pthread_mutex_destroy(&mutexes[i]);
    //pthread_join(threads[i], NULL);
  } 
  for (int i = 0; i < N; i++) {
    if (nums[i] == PRIME) {
      printf("%i", i);
      printf(",");
    }
  }
  printf("\n");
  for(int i=0; i<N; i++){
      nums[i]=0;
  }
  char n;
  sleep(1);
  gettimeofday(&start2raw,NULL);
  for (int i = 2; i < N; i++) {
    if (nums[i] == UNCLEAR) {
      nums[i] = PRIME;
      for(int j = 2 * i; j < N; j = i+j){
          nums[j] = COMPOSITE;
          }
    }
  }
  gettimeofday(&end2raw,NULL);
  long notthreadstime=end2raw.tv_sec-start2raw.tv_sec;
  long notthreadsutime=end2raw.tv_usec-start2raw.tv_usec;
  for (int i = 0; i < N; i++) {
    if (nums[i] == PRIME) {
      printf("%i", i);
      printf(",");
    }
  }
  printf("\n%i:\n",N);
  printf("Not-Threads done in %lds %ldus \n", notthreadstime,notthreadsutime);
  printf("Threads done in %lds %ldus \n",threadtime,threadutime);
  return 1;
}