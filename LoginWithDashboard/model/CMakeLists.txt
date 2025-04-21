project(appdemo_model VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_library(appdemo_model STATIC
    transactionmodel.h
    transaction.h
    transactionmodel.cpp
    transaction.cpp
)

#target_include_directories(appdemo_model PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(appdemo_model
    PUBLIC Qt6::Core Qt6::Sql Qt6::Network
)
