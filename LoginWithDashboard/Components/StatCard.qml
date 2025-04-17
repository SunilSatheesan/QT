// components/StatCard.qml
import QtQuick 2.15
import QtQuick.Controls

Rectangle {
    id: card
    width: 120
    height: 80
    radius: 10
    color: "white"
    border.color: "#ccc"
    border.width: 1

    property string label: ""
    property string value: ""

    Column {
        anchors.centerIn: parent
        spacing: 5

        Text {
            text: card.value
            font.pixelSize: 20
            font.bold: true
        }

        Text {
            text: card.label
            font.pixelSize: 14
            color: "#666"
        }
    }
}
