import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import demo 1.0
import App 1.0

Item {
    id: dashboardItem
    property string theme: "light"
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
        ListElement {
            name: "Home"
            // icon: AppSettings.theme === "dark" ? "qrc:/img/home_light.png" : "qrc:/img/home.png"
            iconLight: "qrc:/img/home.png"
            iconDark: "qrc:/img/home_light.png"
        }
        ListElement { name: "Profile" }
        ListElement { name: "Settings" }
        ListElement { name: "Logout" }
    }

    RowLayout {
        anchors.fill: parent

        // Sidebar
        Rectangle {
            width: 180
            color: AppSettings.theme === "dark" ? "#333" : "white"
            Layout.fillHeight: true

            ListView {
                id: sidebar
                anchors.fill: parent
                model: sidebarModel
                delegate: Rectangle {
                    width: parent.width
                    height: 50
                    property bool hovered: false
                    color: hovered ? (AppSettings.theme === "dark" ? "#3d566e" : "#f8f8f8") :
                                     (ListView.isCurrentItem ? (AppSettings.theme === "dark" ? "#34495e" : "lightblue") : "transparent")

                    Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 12

                        Image {
                            source: AppSettings.theme === "dark" ? iconDark : iconLight
                            width: 20
                            height: 20
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            text: name
                            color: AppSettings.theme === "dark" ? "white" : "black"
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

            Row {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Dark Theme"
                    color: AppSettings.theme === "dark" ? "white" : "black"
                    // background {
                    //     color: "white"
                    // }
                }
                Switch {
                    checked: AppSettings.theme === "dark"
                    onCheckedChanged: AppSettings.theme = checked ? "dark" : "light"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }

        // Main content area
        Rectangle {
            color: AppSettings.theme === "dark" ? "#333" : "white"
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
