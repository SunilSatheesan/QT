// Dashboard.qml
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: dashboard
    anchors.fill: parent
    property string username: ""

    Rectangle {
        anchors.fill: parent
        color: "#f4f6f8"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            Text {
                text: "Welcome, " + dashboard.username
                font.pixelSize: 24
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 20

                StatCard {
                    label: "Logins"
                    value: "5"
                }
                StatCard {
                    label: "Messages"
                    value: "23"
                }
                StatCard {
                    label: "Notifications"
                    value: "3"
                }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: ["Item A", "Item B", "Item C"]
                delegate: Text {
                    text: modelData
                    font.pixelSize: 16
                    padding: 8
                }
            }

            Button {
                text: "Logout"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    stackView.pop() // or go back to Login
                }
            }
        }
    }

    // Component.onCompleted: console.log("Dashboard loaded for user:", username)
    Component.onCompleted: {
        console.log("Dashboard loaded for user:", username)
        app.width = 800
        app.height = 600
    }
}
