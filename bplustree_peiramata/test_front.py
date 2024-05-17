import ctypes

lib = ctypes.CDLL('./square.so')

print(lib.square(5))  # 25