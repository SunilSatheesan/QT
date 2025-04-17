import QtQuick 2.15
import QtQuick.Controls
// import Components 1.0
// import demo
// import demo.components

Item{
    id: root
    property bool loginInProgress: false
    property real baseX: 0

    implicitHeight: loginBox.height
    implicitWidth: loginBox.width

    Rectangle {
        id: loginBox
        // anchors.centerIn: parent
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 250
        height: 220
        color: "white"
        radius: 10
        border.color: "#cccccc"
        border.width: 5
        opacity: 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 1500
                easing.type: Easing.InOutQuad
            }
        }
        PropertyAnimation {
            id: shakeAnim
            target: loginBox
            property: "x"
            duration: 50
            loops: 6
            easing.type: Easing.InOutQuad
            onRunningChanged: if (!running) loginBox.x = root.baseX
        }
        // Connections {
        //     target: loginHandler
        //     function onLoginFailed() {
        //         console.log("emit")
        //         shakeAnim.restart()
        //     }
        // }

        Column {
            anchors.centerIn: parent
            spacing: 12
            padding: 30

            Text {
                text: "Login"
                font.pixelSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextField {
                id: usernameField
                placeholderText: "Enter your name"
                width: 200
            }

            TextField {
                id: passwordField
                placeholderText: "Enter your password"
                echoMode: TextInput.Password
                width: 200
            }

            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter

                Button {
                    text: "Login"
                    // enabled: !root.loginInProgress
                    onClicked: {
                        console.log("U: " + usernameField.text + " P:" + passwordField.text)
                        loginHandler.login(usernameField.text, passwordField.text)
                        // busyind.visible = true
                        root.loginInProgress = true
                        statusText.visible = false
                    }
                }
                Button {
                    text: "Cancel"
                    onClicked: {
                        root.loginInProgress = false
                        statusText.visible = false
                    }
                }
            }
            Text {
                id: statusText
                height: 30
                text: ""
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            // BusyIndicator {
            //     id: busyind
            //     running: root.loginInProgress
            //     visible: root.loginInProgress
            //     width: 30
            //     height: 30
            //     anchors.horizontalCenter: parent.horizontalCenter
            // }
            Timer {
                id: loginFailTimer
                interval: 1500
                repeat: false
                onTriggered: {
                    root.loginInProgress = false
                    statusText.visible = true
                    // busyind.visible = false
                    shakeAnim.restart()
                    toast.show("Invalid credentials", 3000)
                }
            }
        }

        Connections {
            target: loginHandler

            function onLoginFailed() {
                console.log("LOGIN FAILED!!!!!!!")
                statusText.text = "Login Failed"
                statusText.color = "red"
                shakeAnim.from = loginBox.x - 10
                shakeAnim.to = loginBox.x + 10
                loginFailTimer.start()
            }

            function onLoginSuccess() {
                // busyind.visible = false
                statusText.visible = true
                statusText.color = "green"
                statusText.text = "Login Success!"
                toast.show("login Success", 3000)
                root.loginInProgress = false
                loader.visible = false
                stackView.push("Dashboard.qml", { username: usernameField.text })
            }
        }

        Component.onCompleted: {
            opacity = 1.0
            console.log("Parent width:", parent.width)
            console.log("LoginBox width:", width)
            root.baseX = loginBox.x
        }
    }

    onWidthChanged: {
        loginBox.x = (width - loginBox.width) / 2
        loginBox.y = (height - loginBox.height) / 2
    }

    onHeightChanged: {
        widthChanged()
    }

    Toast {
        id: toast
        // anchors.horizontalCenter: parent.horizontalCenter
        // anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
    }

    LoaderOverlay {
        id: loader
        visible: root.loginInProgress
    }
}
