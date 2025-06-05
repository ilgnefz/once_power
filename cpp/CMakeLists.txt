cmake_minimum_required(VERSION 3.10)

# 项目名称（任意）
project(example)

# 添加C++源文件（按需添加更多文件）
add_library(example SHARED example.cpp)

# 设置C++标准（建议C++17）
set_target_properties(example PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED ON)