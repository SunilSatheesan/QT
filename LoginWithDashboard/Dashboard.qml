// Dashboard.qml
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: dashboard
    anchors.fill: parent
    property string username: ""

    Rectangle {
        id: topBar
        height: 50
        width: parent.width
        color: "#1976d2"
        anchors.top: parent.top

        RowLayout {
            anchors.fill: parent
            spacing: 10
            // padding: 10

            Label {
                text: "Dashboard"
                font.pixelSize: 20
                color: "white"
                Layout.alignment: Qt.AlignVCenter
            }

            Item { Layout.fillWidth: true }

            Button {
                text: "Logout"
                onClicked: {
                    stackView.pop() // Go back to login
                }
            }
        }
    }

    // Content Area
    GridLayout {
        id: grid
        columns: 2
        rowSpacing: 20
        columnSpacing: 20
        anchors {
            top: topBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#e0f7fa"
            radius: 8
            border.color: "#00acc1"
            Text {
                anchors.centerIn: parent
                text: "Users: 120"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#fce4ec"
            radius: 8
            border.color: "#ec407a"
            Text {
                anchors.centerIn: parent
                text: "Tasks: 43"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#f3e5f5"
            radius: 8
            border.color: "#ab47bc"
            Text {
                anchors.centerIn: parent
                text: "Messages: 8"
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 100
            color: "#e8f5e9"
            radius: 8
            border.color: "#66bb6a"
            Text {
                anchors.centerIn: parent
                text: "Alerts: 2"
            }
        }
    }

    // Rectangle {
    //     anchors.top: topBar.bottom
    //     anchors.bottom: parent.bottom
    //     color: "#f4f6f8"

    //     ColumnLayout {
    //         anchors.fill: parent
    //         anchors.margins: 20
    //         spacing: 20

    //         // Text {
    //         //     text: "Welcome, " + dashboard.username
    //         //     font.pixelSize: 24
    //         //     Layout.alignment: Qt.AlignHCenter
    //         // }

    //         RowLayout {
    //             Layout.fillWidth: true
    //             spacing: 20

    //             StatCard {
    //                 label: "Logins"
    //                 value: "5"
    //             }
    //             StatCard {
    //                 label: "Messages"
    //                 value: "23"
    //             }
    //             StatCard {
    //                 label: "Notifications"
    //                 value: "3"
    //             }
    //         }

    //         ListView {
    //             Layout.fillWidth: true
    //             Layout.fillHeight: true
    //             model: ["Item A", "Item B", "Item C"]
    //             delegate: Text {
    //                 text: modelData
    //                 font.pixelSize: 16
    //                 padding: 8
    //             }
    //         }
    //     }
// }

// Component.onCompleted: console.log("Dashboard loaded for user:", username)
Component.onCompleted: {
    console.log("Dashboard loaded for user:", username)
    app.width = 800
    app.height = 600
}
}
