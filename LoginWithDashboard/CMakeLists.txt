cmake_minimum_required(VERSION 3.16)
project(LoginWithDashboard VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql Test Network)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Modules
add_subdirectory(model)
add_subdirectory(app)
add_subdirectory(tests)

include(GNUInstallDirs)
install(TARGETS appdemo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Packaging
set(CPACK_GENERATOR "WIX")
set(CPACK_PACKAGE_NAME "LoginWithDashboard")
set(CPACK_PACKAGE_VENDOR "YourCompany")
set(CPACK_PACKAGE_VERSION "1.0.0")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "LoginWithDashboard")
set(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/app/img/favicon.ico")
include(CPack)
