// an array is generated of all numbers
//
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define N 12345678

int COMPOSITE = 2;
int PRIME = 1;
int UNCLEAR = 0;
int nums[N] = {0};
int indexes[N];
pthread_t threads[N];
pthread_mutex_t mutexes[N];

void* eliminate(int* vargs) {
  int n = *vargs;
  printf("thread created %i; ", n);
  for (int i = 2 * n; i < N; i = i+n) {
    pthread_mutex_lock(&mutexes[i]);
    printf("%i is setting %i as composite; ", n, i);
    nums[i] = COMPOSITE;
    printf("%i has set %i as composite; ", n, i);
    pthread_mutex_unlock(&mutexes[i]);
  }
  return NULL;
}
int main() {
  for (int i = 0; i < N; i++) {
    indexes[i]=i;
  }
  printf("starting");
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
  printf("Done\n");
  for (int i = 2; i < N; i++) {
    pthread_mutex_destroy(&mutexes[i]);
    //pthread_join(threads[i], NULL);
  } 

  for (int i = 0; i < N; i++) {
    if (nums[i] == PRIME) {
      printf("%i", i);
      printf(",");
    }
    /* if (nums[i] == COMPOSITE) {
      printf("%i=COMPOSITE", i);
      printf(",");
    }
    if (nums[i] == UNCLEAR) {
      printf("%i=UNCLEAR", i);
      printf(","); 
    } */
  }
  printf("\n");
  return 1;
}