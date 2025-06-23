#define __NV_CUBIN_HANDLE_STORAGE__ static
#if !defined(__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__)
#define __CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__
#endif
#include "crt/host_runtime.h"
#include "main.fatbin.c"
extern void __device_stub__Z11multiplyGPUPiS_S_(int *, int *, int *);
static void __nv_cudaEntityRegisterCallback(void **);
static void __sti____cudaRegisterAll(void);
#pragma section(".CRT$XCT",read)
__declspec(allocate(".CRT$XCT"))static void (*__dummy_static_init__sti____cudaRegisterAll[])(void) = {__sti____cudaRegisterAll};
void __device_stub__Z11multiplyGPUPiS_S_(
int *__par0, 
int *__par1, 
int *__par2)
{
__cudaLaunchPrologue(3);
__cudaSetupArgSimple(__par0, 0Ui64);
__cudaSetupArgSimple(__par1, 8Ui64);
__cudaSetupArgSimple(__par2, 16Ui64);
__cudaLaunch(((char *)((void ( *)(int *, int *, int *))multiplyGPU)));
}
void multiplyGPU( int *__cuda_0,int *__cuda_1,int *__cuda_2)
{__device_stub__Z11multiplyGPUPiS_S_( __cuda_0,__cuda_1,__cuda_2);
}
#line 1 "main.cudafe1.stub.c"
static void __nv_cudaEntityRegisterCallback(
void **__T0)
{
__nv_dummy_param_ref(__T0);
__nv_save_fatbinhandle_for_managed_rt(__T0);
__cudaRegisterEntry(__T0, ((void ( *)(int *, int *, int *))multiplyGPU), _Z11multiplyGPUPiS_S_, (-1));
}
static void __sti____cudaRegisterAll(void)
{
__cudaRegisterBinary(__nv_cudaEntityRegisterCallback);
}
