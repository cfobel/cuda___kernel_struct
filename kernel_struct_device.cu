#include <iostream>
#include <vector>
#include "kernel_struct.hpp"
using namespace std;


class CUDApoint {
public:
    float a, b;
    __device__ void some_other_method() {}
};


template <class T>
__global__ void testKernel(T *data) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    data[i] = i;
}

template <>
__global__ void testKernel<point>(point *p) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    CUDApoint *test = (CUDApoint *)p;
    test[i].a = 1.1 * i;
    test[i].b = 2.2 * i;
}

template <class T>
vector<T> run_kernel(int num_points) {
    // set number of points 
    int gpuBlockSize = 4,
        gpuGridSize  = num_points / gpuBlockSize;

    // allocate memory
    vector<T> cpuPointArray(num_points);
    T *gpuPointArray;
    int mem_size = cpuPointArray.size() * sizeof(T);
    cudaMalloc((void**)&gpuPointArray, mem_size);

    // launch kernel
    testKernel<<<gpuGridSize,gpuBlockSize>>>(gpuPointArray);

    // retrieve the results
    cudaMemcpy(&cpuPointArray[0], gpuPointArray, cpuPointArray.size() * sizeof(T), cudaMemcpyDeviceToHost);
    // deallocate memory
    cudaFree(gpuPointArray);
    return cpuPointArray;
}

vector<int> test_int(int num_points) {
    return run_kernel<int>(num_points);
}

vector<point> test_point(int num_points) {
    return run_kernel<point>(num_points);
}
