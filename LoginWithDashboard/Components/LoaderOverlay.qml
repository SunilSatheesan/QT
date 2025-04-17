import QtQuick 2.15
import QtQuick.Controls

Item {
    id: overlay
    anchors.fill: parent
    visible: false
    z: 1000
    opacity: visible ? 0.8 : 0.0

    Rectangle {
        anchors.fill: parent
        color: "black" // semi-transparent black

        Column {
            anchors.centerIn: parent
            spacing: -5

            CustomBusyIndicator {
                running: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // BusyIndicator {
            //     running: true
            //     width: 40
            //     height: 40
            //     anchors.horizontalCenter: parent.horizontalCenter

            //     // contentItem: Item {
            //     //     implicitWidth: 40
            //     //     implicitHeight: 40

            //     //     Rectangle {
            //     //         width: 40
            //     //         height: 40
            //     //         radius: 20
            //     //         color: "transparent"
            //     //         border.color: "deepskyblue" // 🔹 change this to any color
            //     //         border.width: 4
            //     //         antialiasing: true
            //     //         anchors.centerIn: parent

            //     //         RotationAnimator on rotation {
            //     //             running: parent.running
            //     //             from: 0
            //     //             to: 360
            //     //             duration: 1000
            //     //             loops: Animation.Infinite
            //     //         }
            //     //     }
            //     // }

            //     // anchors.centerIn: parent
            // }

            Text {
                text: "Logging in..."
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                opacity: 1.0
            }
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
}
