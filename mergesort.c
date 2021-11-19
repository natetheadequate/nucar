#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N 10

int* merge(int* A, int l, int r, int e){
    int lA[r-l];
    for(int i=l;i<r;i++){
        lA[i-l]=A[i];
    }
    int rA[e-r];
    for(int i=r;i<e;i++){
        rA[i-r]=A[i];
    }
    for(int li=0,ri=0,i=l;i<=e;i++){
        if(ri<e-r && (li>r-l-1 || rA[ri]<lA[li])){
            A[i]=rA[ri];
            ri++;
        }else{
            A[i]=lA[li];
            li++;
        }
    }
    for(int i=0;i<N;i++){
        if(i==l){
            printf("L");
        }
        if(i==r){
            printf("R");
        }
        if(i==e){
            printf("E");
        }
        printf("%i,",A[i]);
    }
    printf("\n");
}

int* mergesort(int* A, int l, int r, int e){
    if(r-l>1){
        mergesort(A,l,(l+r-1)/2,r-1);
        mergesort(A,r,(e+r)/2,e);
        merge(A,l,r,e);
    }
}

int main(){
    int A[N];
    srand(time(NULL));
    for(int i=0;i<N;i++){
        A[i]=((int) rand()) % 20;
    }
    for(int i=0;i<N;i++){
        printf("%i,",A[i]);
    }
    printf("\n");
    struct timeval start1raw;
    struct timeval end1raw;
    struct timeval start2raw;
    struct timeval end2raw;
    gettimeofday(&start1raw, NULL);
    mergesort(A,0,(N-1)/2,N-1);
    for(int i=0;i<N;i++){
        printf("%i,",A[i]);
    }

}
