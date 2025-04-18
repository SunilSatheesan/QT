import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Rectangle {
    id: card
    width: 150
    height: 100
    radius: 12
    color: "#e0f7fa"
    border.color: "#00acc1"
    border.width: 1
    property string title: "Title"
    property string value: "0"
    property url iconSource: ""

    Column {
        anchors.centerIn: parent
        spacing: 6

        Image {
            source: card.iconSource
            width: 24
            height: 24
            visible: card.iconSource !== ""
        }

        Text {
            text: card.title
            font.bold: true
            font.pixelSize: 14
        }

        Text {
            text: card.value
            font.pixelSize: 20
            color: "#00796b"
        }
    }
}
