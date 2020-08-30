

#include <stdio.h>

__global__
void make_hello(char *str, int *transform_mtx)
{
    str[threadIdx.x] += transform_mtx[threadIdx.x];
}

int main(int argc, char **argv)
{
    printf("Hello from main!\n");

    for (int ii = 0; ii < argc; ii++) {
        printf("argv[%d] = %s\n", ii, argv[ii]);
    }

    char str[16] = "Hello \0\0\0\0\0\0";
    int transform_mtx[16] = {15, 10, 6, 0, -11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

    printf("From CUDA: %s", str);
    char *ad;
    int *bd;
    cudaMalloc((void**)&ad, sizeof(str)); 
    cudaMalloc((void**)&bd, sizeof(transform_mtx)); 
    cudaMemcpy(ad, str, sizeof(str), cudaMemcpyHostToDevice); 
    cudaMemcpy(bd, transform_mtx, sizeof(transform_mtx), cudaMemcpyHostToDevice); 
    
    dim3 dimBlock(16, 1);
    dim3 dimGrid(1, 1);
    make_hello<<<dimGrid, dimBlock>>>(ad, bd);

    cudaMemcpy(str, ad, sizeof(str), cudaMemcpyDeviceToHost); 
    cudaFree(ad);
    cudaFree(bd);
    
    printf("%s\n", str);

    return 0;
}