cmake_minimum_required(VERSION 3.13)
project(calculator)

include_directories(${PROJECT_SOURCE_DIR})

add_library(calculator calculator.cpp)
add_executable(calc calculator.cpp main.cpp)
