#include <iostream>
#include<ctime>
#define N 3
using namespace std;
__global__ void helloFromGPU() {
    printf("Hello from GPU!\n");
}
int random(){
    
    int randomNumber = rand() % 100 + 1;
    return randomNumber;
}
void assignMatrix(int A[N][N]){
    for(int i =0;i<N;i++){
        for(int j=0;j<N;j++) A[i][j]=random();
    }
}
void multiplyCPU(int matrixA[N][N],int matrixB[N][N],int matrixC[N][N]){
    for(int i =0;i<N;i++){
        for(int j=0;j<N;j++){
            for(int k=0;k<N;k++){
                matrixC[i][j]+=matrixA[i][k]*matrixB[k][j];
            }
        };
    }
}
void printMatrix(int matrixA[N][N]){
    for(int i =0;i<N;i++){
        for(int j=0;j<N;j++) cout<<matrixA[i][j]<<" ";
        cout<<endl;
    }
    cout<<endl;
}
int main() {
    //initialization
    cudaEvent_t start,stop;
    srand(time(0));
    int matrixA[N][N];
    int matrixB[N][N];
    int matrixC[N][N]={0};
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    //assigning random values to matrix
    assignMatrix(matrixA);
    //printMatrix(matrixA);
    assignMatrix(matrixB);
    //printMatrix(matrixB);
    //matrix calculation using cpu and time measurement
    cudaEventRecord(start,0);
    multiplyCPU(matrixA,matrixB,matrixC);
    cout<<endl;
    printMatrix(matrixC);
    //helloFromGPU<<<1, 1>>>();
    cudaEventRecord(stop,0);
    cudaEventSynchronize(stop);
    float cpu=0;
    cudaEventElapsedTime(&cpu,start,stop);
    cout<<cpu;
    cudaDeviceSynchronize();
    return 0;
}
