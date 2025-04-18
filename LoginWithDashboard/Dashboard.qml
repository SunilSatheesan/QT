import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import demo 1.0

Item {
    width: 800
    height: 500

    Component.onCompleted: {
        app.height = 500
        app.width = 800
        contentLoader.source = "Homepage.qml"
    }

    // Sidebar data
    ListModel {
        id: sidebarModel
        ListElement { name: "Home" }
        ListElement { name: "Profile" }
        ListElement { name: "Settings" }
        ListElement { name: "Logout" }
    }

    RowLayout {
        anchors.fill: parent

        // Sidebar
        Rectangle {
            width: 180
            color: "#333"
            Layout.fillHeight: true

            ListView {
                id: sidebar
                anchors.fill: parent
                model: sidebarModel
                delegate: Rectangle {
                    width: parent.width
                    height: 50
                    color: ListView.isCurrentItem ? "#555" : "transparent"
                    border.color: "white"
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: name
                        color: "white"
                        font.pixelSize: 16
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            sidebar.currentIndex = index
                            console.log("Selected:", name)
                            switch (name) {
                            case "Home":
                                contentLoader.source = "Homepage.qml"
                                console.log("Loading:", contentLoader.source)
                                break
                            case "Profile":
                                contentLoader.source = "ProfilePage.qml"
                                break
                            case "Settings":
                                contentLoader.source = "SettingsPage.qml"
                                break
                            case "Logout":
                                app.width = 360
                                app.height = 300
                                stackView.pop()
                                break
                            }
                            // emit signal or update main view content
                        }
                    }
                }
            }
        }

        // Main content area
        Rectangle {
            color: "white"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 4
            border.color: "#ccc"

            Loader {
                id: contentLoader
                anchors.fill: parent
            }
        }
    }
}
