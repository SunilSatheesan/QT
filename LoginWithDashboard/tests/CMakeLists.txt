add_executable(tst_transactionmodel
    testtransactionmodel.cpp
    testtransactionmodel.h
)

target_link_libraries(tst_transactionmodel
    PRIVATE Qt6::Test appdemo_model
)

add_test(NAME tst_transactionmodel COMMAND tst_transactionmodel)
