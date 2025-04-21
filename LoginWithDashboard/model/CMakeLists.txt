add_library(appdemo_model STATIC
    transactionmodel.h
    transaction.h
)

target_include_directories(appdemo_model PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(appdemo_model
    PUBLIC Qt6::Core Qt6::Sql Qt6::Network
)
