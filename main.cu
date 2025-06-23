#include <iostream>
#include<ctime>
#define N 289

using namespace std;
__global__ void multiplyGPU(int *a,int* b,int *c) {
    int i=blockIdx.x*blockDim.x+threadIdx.x;
    int j=blockIdx.y*blockDim.y+threadIdx.y;
    if(i<N&&j<N){long long sum=0;
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
    cudaEvent_t start,startG,stop,stopG;
    srand(time(0));
    int matrixA[N][N];
    int matrixB[N][N];
    int matrixC[N][N]={0};
    int *d_a,*d_b,*d_c;

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
    //printMatrix(matrixC);
    
    cudaEventRecord(stop,0);
    cudaEventSynchronize(stop);
    float cpu=0;
    cudaEventElapsedTime(&cpu,start,stop);

    cudaEventCreate(&startG);
    cudaEventCreate(&stopG);
    cudaEventRecord(startG,0);
    dim3 thread(16,16);
    dim3 blocks((N +15)/16,(N+15)/16);
    if(cudaMalloc((void**)&d_a,sizeof(int)*N*N)!=cudaSuccess) cout<<"No allocation of A";
    if(cudaMalloc((void**)&d_b,sizeof(int)*N*N)!=cudaSuccess) cout<<"No allocation of B";
    if(cudaMalloc((void**)&d_c,sizeof(int)*N*N)!=cudaSuccess) cout<<"No allocation of C";
    if(cudaMemcpy(d_a,matrixA,sizeof(int)*N*N,cudaMemcpyHostToDevice)!=cudaSuccess) cout<<"No copy of A";
    if(cudaMemcpy(d_b,matrixB,sizeof(int)*N*N,cudaMemcpyHostToDevice)!=cudaSuccess) cout<<"No copy of B";
    multiplyGPU<<<blocks, thread>>>(d_a,d_b,d_c);
    cudaError_t err = cudaGetLastError();
if (err != cudaSuccess) {
    printf("CUDA kernel launch error: %s\n", cudaGetErrorString(err));
}

    cudaMemcpy(matrixC,d_c,sizeof(int)*N*N,cudaMemcpyDeviceToHost);
    cudaEventRecord(stopG,0);
    cudaEventSynchronize(stopG);
    float gpu=0;
    cudaEventElapsedTime(&gpu,startG,stopG);
    
    //printMatrix(matrixC);
    cout<<"CPU TIME: "<<cpu<<" ms"<<endl<<"GPU TIME: "<<gpu<<" ms"<<endl;
    cudaDeviceSynchronize();
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    return 0;
}
