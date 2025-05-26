#include <iostream>
#include<ctime>
using namespace std;
__global__ void helloFromGPU() {
    printf("Hello from GPU!\n");
}
int random(){
    
    int randomNumber = rand() % 100 + 1;
    return randomNumber;
}
int main() {
    //initialization
    cudaEvent_t start,stop;
    srand(time(0));
    int matrixA[3][3];
    int matrixB[3][3];
    int matrixC[3][3]={0};
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    //assigning random values to matrix
    for(int i =0;i<3;i++){
        for(int j=0;j<3;j++) matrixA[i][j]=random();
    }
    for(int i =0;i<3;i++){
        for(int j=0;j<3;j++) matrixB[i][j]=random();
    }

    //matrix calculation using cpu and time measurement
    cudaEventRecord(start,0);
    for(int i =0;i<3;i++){
        for(int j=0;j<3;j++){
            for(int k=0;k<3;k++){
                matrixC[i][j]+=matrixA[i][k]*matrixB[k][j];
            }
        };
    }
    cout<<endl;
    for(int i =0;i<3;i++){
        for(int j=0;j<3;j++) cout<<matrixC[i][j]<<" ";
        cout<<endl;
    }
    //helloFromGPU<<<1, 1>>>();
    cudaEventRecord(stop,0);
    cudaEventSynchronize(stop);
    float cpu=0;
    cudaEventElapsedTime(&cpu,start,stop);
    cout<<cpu;
    cudaDeviceSynchronize();
    return 0;
}
