import QtQuick 2.15
import QtQuick.Controls

Item {
    width: 800
    height: 500

    Rectangle {
        height: parent.height
        width: parent.width
        color: "lightblue"

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Home Page"
        }
    }
}
