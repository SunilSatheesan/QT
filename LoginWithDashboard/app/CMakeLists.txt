cmake_minimum_required(VERSION 3.16)


project(appdemo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appdemo
    ${SOURCES}
)

qt_add_resources(SOURCES
    img.qrc
)

qt_add_resources(appdemo "resources"
    PREFIX "/"
    FILES Settings.qml
    FILES img/home.png
    FILES img/home_light.png
)

qt_add_qml_module(appdemo
    URI demo
    VERSION 1.0
    QML_FILES
        Main.qml
        LoginForm.qml
        Dashboard.qml
        SOURCES LoginHandler.h
        SOURCES LoginHandler.cpp
        SOURCES LoginHandler.cpp
        SOURCES main.cpp
        QML_FILES Components/LoaderOverlay.qml
        QML_FILES Components/CustomBusyIndicator.qml
        QML_FILES Components/Toast.qml
        QML_FILES Components/StatCard.qml
        QML_FILES Homepage.qml
        SOURCES mockbackend.h mockbackend.cpp
        QML_FILES Components/LineChartView.qml
        QML_FILES Components/RecentTransactions.qml
        QML_FILES Settings.qml
        SOURCES AppSettingsCpp.h
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appdemo PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appdemo
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appdemo
    PRIVATE Qt6::Quick
    # PRIVATE Qt6::Charts
    PRIVATE Qt6::Sql
    appdemo_model
)

include(GNUInstallDirs)
install(TARGETS appdemo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
