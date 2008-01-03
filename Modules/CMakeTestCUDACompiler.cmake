
# This file is used by EnableLanguage in cmGlobalGenerator to
# determine that that selected CUDA compiler can actually compile
# and link the most basic of programs.   If not, a fatal error
# is set and cmake stops processing commands and will not generate
# any makefiles or projects.
IF(NOT CMAKE_CUDA_COMPILER_WORKS)
  MESSAGE(STATUS "Check for working CUDA compiler: ${CMAKE_CUDA_COMPILER}")
  FILE(WRITE ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testCUDACompiler.cu
    "__global__ void test(){}\n"
    "int main(){test<<< 32, 128 >>>(); return 0;}\n")
  TRY_COMPILE(CMAKE_CUDA_COMPILER_WORKS ${CMAKE_BINARY_DIR}
    ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeTmp/testCUDACompiler.cu
    OUTPUT_VARIABLE OUTPUT)
  SET(CUDA_TEST_WAS_RUN 1)
ENDIF(NOT CMAKE_CUDA_COMPILER_WORKS)

IF(NOT CMAKE_CUDA_COMPILER_WORKS)
  MESSAGE(STATUS "Check for working CUDA compiler: ${CMAKE_CUDA_COMPILER} -- broken")
  FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
    "Determining if the CUDA compiler works failed with "
    "the following output:\n${OUTPUT}\n\n")
  MESSAGE(FATAL_ERROR "The CUDA compiler \"${CMAKE_CUDA_COMPILER}\" "
    "is not able to compile a simple test program.\nIt fails "
    "with the following output:\n ${OUTPUT}\n\n"
    "CMake will not be able to correctly generate this project.")
ELSE(NOT CMAKE_CUDA_COMPILER_WORKS)
  IF(CUDA_TEST_WAS_RUN)
    MESSAGE(STATUS "Check for working CUDA compiler: ${CMAKE_CUDA_COMPILER} -- works")
    FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
      "Determining if the CUDA compiler works passed with "
      "the following output:\n${OUTPUT}\n\n")
  ENDIF(CUDA_TEST_WAS_RUN)
  SET(CMAKE_CUDA_COMPILER_WORKS 1 CACHE INTERNAL "")
ENDIF(NOT CMAKE_CUDA_COMPILER_WORKS)
