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
        contentArea.loadPage("Homepage.qml")
    }

    // Sidebar data
    ListModel {
        id: sidebarModel
        ListElement { name: "Home"; icon: "home.png" }
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
                    property bool hovered: false
                    color: hovered ? "#3d566e" :  (ListView.isCurrentItem ? "#34495e" : "transparent")

                    Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 12

                        Image {
                            source: icon
                            width: 20
                            height: 20
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            text: name
                            color: "white"
                            font.pixelSize: 16
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: hovered = true
                        onExited: hovered = false
                        onClicked: {
                            sidebar.currentIndex = index
                            switch (name) {
                            case "Home":
                                contentArea.loadPage("Homepage.qml")
                                break
                            case "Profile":
                                contentArea.loadPage("qrc:/demo/Components/ProfilePage.qml")
                                break
                            case "Settings":
                                contentArea.loadPage("qrc:/demo/Components/SettingsPage.qml")
                                break
                            case "Logout":
                                app.height = 300
                                app.width = 360
                                stackView.pop()
                                break
                            }
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

            Item {
                id: contentArea
                anchors.fill: parent
                property string currentPage: ""

                Loader {
                    id: contentLoader
                    anchors.fill: parent
                    asynchronous: true
                    active: false // let us control timing
                    onLoaded: {
                        fadeIn.restart()
                    }
                }

                SequentialAnimation {
                    id: fadeIn
                    PropertyAnimation {
                        target: contentLoader.item
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 300
                    }
                }

                function loadPage(pageUrl) {
                    contentLoader.active = false
                    contentLoader.setSource("")
                    contentLoader.source = pageUrl
                    contentLoader.active = true
                }
            }

        }

        // LineChartView {
        //     // width: 400
        //     // height: 300
        // }
    }
}
