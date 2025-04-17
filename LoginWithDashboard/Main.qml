import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: app
    visible: true
    width: 360
    height: 300
    title: "Login UI"
    // property real baseX: (app.width - loginBox.width) / 2

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: LoginForm {}
    }
    Component.onCompleted: {
        console.log("Main.qml loaded")
    }
}

