#include <iostream>
#include<ctime>
using namespace std;
__global__ void helloFromGPU() {
    printf("Hello from GPU!\n");
}
int main() {
    cudaEvent_t start,stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start,0);
    helloFromGPU<<<1, 1>>>();
    cudaEventRecord(stop,0);
    cudaEventSynchronize(stop);
    float ms=0;
    cudaEventElapsedTime(&ms,start,stop);
    cout<<ms;
    cudaDeviceSynchronize();
    return 0;
}
