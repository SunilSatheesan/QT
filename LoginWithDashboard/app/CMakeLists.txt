qt_add_executable(appdemo
    main.cpp
    icon.rc
)

qt_add_resources(appdemo "resources"
    PREFIX "/"
    FILES
        Settings.qml
        img/home.png
        img/home_light.png
        img/favicon.ico
)

qt_add_qml_module(appdemo
    URI demo
    VERSION 1.0
    QML_FILES
        Main.qml
        LoginForm.qml
        Dashboard.qml
        Homepage.qml
        Components/LoaderOverlay.qml
        Components/CustomBusyIndicator.qml
        Components/Toast.qml
        Components/StatCard.qml
        Components/LineChartView.qml
        Components/RecentTransactions.qml
    SOURCES
        LoginHandler.cpp LoginHandler.h
        mockbackend.cpp mockbackend.h
		AppSettingsCpp.h
)

target_link_libraries(appdemo
    PRIVATE Qt6::Quick Qt6::Sql appdemo_model
)

set_target_properties(appdemo PROPERTIES
    WIN32_EXECUTABLE TRUE
)
