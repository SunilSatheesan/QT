// CustomBusyIndicator.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Item {
    id: spinner
    width: 40
    height: 40
    property color arcColor: "#e91e63"
    property bool running: true

    // Main rotation group
    Item {
        id: spinnerCore
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        transform: Rotation {
            id: rot
            origin.x: width / 2
            origin.y: height / 2
            angle: 0
            NumberAnimation on angle {
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
                running: spinner.running
                easing.type: Easing.Linear
            }
        }

        // Trail segments (faded, thinner)
        Repeater {
            model: 4
            delegate: Shape {
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
                opacity: 1.0 - index * 0.25

                transform: Rotation {
                    origin.x: width / 2
                    origin.y: height / 2
                    angle: -index * 10 // trail offset
                }

                ShapePath {
                    strokeColor: spinner.arcColor
                    strokeWidth: 4 - index // decreasing width
                    capStyle: ShapePath.RoundCap
                    fillColor: "transparent"

                    startX: width / 2 + 10
                    startY: height / 2

                    PathArc {
                        x: width / 2 - 10
                        y: height / 2
                        radiusX: 10
                        radiusY: 10
                        useLargeArc: false
                        direction: PathArc.Clockwise
                    }
                }
            }
        }
    }
}
