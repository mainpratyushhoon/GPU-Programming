#include <iostream>
#include<ctime>
#define N 1024

using namespace std;
__global__ void multiplyGPU(int *a,int* b,int *c) {
    int i=blockIdx.x*blockDim.x+threadIdx.x;
    int j=blockIdx.y*blockDim.y+threadIdx.y;
    if(i<N&&j<N){
        int sum=0;
    for(int k=0;k<N;k++){
        sum+=a[i*N+k]*b[k*N+j];
    }
    c[i*N+j]=sum;
}

}
int random(){
    
    int randomNumber = rand() % 10 + 1;
    return randomNumber;
}
void assignMatrix(int A[N*N]){
    for(int i =0;i<N*N;i++){
        A[i]=random();
    }
}
void multiplyCPU(int matrixA[N*N],int matrixB[N*N],int matrixC[N*N]){
    for(int i =0;i<N;i++){
        for(int j=0;j<N;j++){
            for(int k=0;k<N;k++){
                matrixC[i*N + j]+=matrixA[i*N+k]*matrixB[k*N+j];
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
void check(int* a,int* b){
    bool correct = true;
    for (int i = 0; i < N * N; i++) {
        if (a[i] != b[i]) {
            correct = false;
            cout << "Mismatch at index " << i << ": CPU=" << a[i] << ", GPU=" << b[i] << endl;
            break;
        }
    }
    if (correct) cout << "CPU and GPU results match!" << endl;
    else cout << "CPU and GPU results do NOT match!" << endl;
}
int main() {
    //initialization
    cudaEvent_t start,startG,stop,stopG;
    srand(time(0));

    int *A,*B,*C_cpu,*C_gpu;
    int *d_a,*d_b,*d_c;
    A = (int *)malloc(N * N * sizeof(int));
    B = (int *)malloc(N * N * sizeof(int));
    C_cpu = (int *)malloc(N * N * sizeof(int));
    C_gpu = (int *)malloc(N * N * sizeof(int));

    //assigning values to arrays
    assignMatrix(A);
    assignMatrix(B);
    memset(C_cpu, 0, sizeof(int) * N * N);
    memset(C_gpu, 0, sizeof(int) * N * N);

    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start,0);

    //matrix calculation using cpu and time measurement 
    multiplyCPU(A,B,C_cpu);
    cout<<endl;
    
    cudaEventRecord(stop,0);
    cudaEventSynchronize(stop);
    float cpu=0;
    cudaEventElapsedTime(&cpu,start,stop);

    //matrix calculation using gpu and time measurement
    cudaEventCreate(&startG);
    cudaEventCreate(&stopG);
    cudaEventRecord(startG,0);

    dim3 thread(16,16);
    dim3 blocks((N +15)/16,(N+15)/16);

    if(cudaMalloc((void**)&d_a,sizeof(int)*N*N)!=cudaSuccess) cout<<"No allocation of A";
    if(cudaMalloc((void**)&d_b,sizeof(int)*N*N)!=cudaSuccess) cout<<"No allocation of B";
    if(cudaMalloc((void**)&d_c,sizeof(int)*N*N)!=cudaSuccess) cout<<"No allocation of C";
    if(cudaMemcpy(d_a,A,sizeof(int)*N*N,cudaMemcpyHostToDevice)!=cudaSuccess) cout<<"No copy of A";
    if(cudaMemcpy(d_b,B,sizeof(int)*N*N,cudaMemcpyHostToDevice)!=cudaSuccess) cout<<"No copy of B";

    multiplyGPU<<<blocks, thread>>>(d_a,d_b,d_c);
    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) {
        printf("CUDA kernel launch error: %s\n", cudaGetErrorString(err));
    }
    cudaDeviceSynchronize();
    cudaMemcpy(C_gpu,d_c,sizeof(int)*N*N,cudaMemcpyDeviceToHost);

    cudaEventRecord(stopG,0);
    cudaEventSynchronize(stopG);
    float gpu=0;
    cudaEventElapsedTime(&gpu,startG,stopG);

    cout<<"CPU TIME: "<<cpu<<" ms"<<endl<<"GPU TIME: "<<gpu<<" ms"<<endl;
    cudaDeviceSynchronize();

    check(C_cpu,C_gpu);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    free(A);free(B);free(C_cpu);free(C_gpu);
    return 0;
}
