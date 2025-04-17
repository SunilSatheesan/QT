// Toast.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: toast
    width: parent ? parent.width : 300
    height: 50
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    visible: false
    opacity: 0.0
    z: 9999

    property alias message: toastText.text

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#323232"
        opacity: 0.9
    }

    Text {
        id: toastText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 16
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }

    function show(msg, duration = 2000) {
        message = msg
        visible = true
        opacity = 1.0
        Qt.callLater(() => {
            Qt.createQmlObject('import QtQuick 2.0; Timer { interval: ' + duration + '; running: true; repeat: false; onTriggered: { toast.opacity = 0.0; toast.visible = false } }', toast, "ToastTimer")
        })
    }
}
