# - Find CUDA
# Find the NVIDIA CUDA includes and libraries
#
# This module defines
#  CUDA_FOUND
#  CUDA_LIBRARIES
#  CUDA_INCLUDE_DIR
#

FIND_PATH(CUDA_INSTALL_PREFIX bin/nvcc
  $ENV{CUDA_INSTALL_PREFIX}
  /usr/local/cuda
  /usr/lib/cuda
  /usr/shared/cuda
  /opt/cuda
)

FIND_PATH(CUDA_INCLUDE_DIR cuda_runtime.h
  ${CUDA_INSTALL_PREFIX}/include
  /usr/local/include/cuda
  /usr/include/cuda
)

FIND_LIBRARY(CUDA_LIBRARY NAMES cuda
  PATHS
  ${CUDA_INSTALL_PREFIX}/lib64
  ${CUDA_INSTALL_PREFIX}/lib
  /usr/local/lib64
  /usr/local/lib
  /usr/lib64
  /usr/lib
)

FIND_LIBRARY(CUDA_RUNTIME_LIBRARY NAMES cudart
  PATHS
  ${CUDA_INSTALL_PREFIX}/lib64
  ${CUDA_INSTALL_PREFIX}/lib
  /usr/local/lib64
  /usr/local/lib
  /usr/lib64
  /usr/lib
)

IF(CUDA_LIBRARY AND CUDA_RUNTIME_LIBRARY AND CUDA_INCLUDE_DIR)
  SET(CUDA_LIBRARIES ${CUDA_LIBRARY} ${CUDA_RUNTIME_LIBRARY})
  SET(CUDA_FOUND "YES")
ELSE(CUDA_LIBRARY AND CUDA_RUNTIME_LIBRARY AND CUDA_INCLUDE_DIR)
  SET(CUDA_FOUND "NO")
ENDIF(CUDA_LIBRARY AND CUDA_RUNTIME_LIBRARY AND CUDA_INCLUDE_DIR)

IF(CUDA_FOUND)
  IF(NOT CUDA_FIND_QUIETLY)
    MESSAGE(STATUS "Found NVIDIA CUDA: ${CUDA_LIBRARIES}")
  ENDIF(NOT CUDA_FIND_QUIETLY)
ELSE(CUDA_FOUND)
  IF(CUDA_FIND_REQUIRED)
    MESSAGE(FATAL_ERROR "Could not find NVIDIA CUDA library")
  ENDIF(CUDA_FIND_REQUIRED)
ENDIF(CUDA_FOUND)

MARK_AS_ADVANCED(
  CUDA_LIBRARY
  CUDA_RUNTIME_LIBRARY
  CUDA_INCLUDE_DIR
  CUDA_INSTALL_PREFIX
)
