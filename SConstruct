import os

env = Environment()
env.Tool('cuda')
obj = env.Object('kernel_struct_device.cu', NVCCFLAGS=['-Xptxas', '-v'], LIBS=['cuda', 'cudart'])
env.Program(['kernel_struct.cpp', obj], LIBS=['cudart'])

ptx = env.Ptx('kernel_struct_device.cu')
