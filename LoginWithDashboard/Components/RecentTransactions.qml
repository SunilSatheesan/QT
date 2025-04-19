import QtQuick 2.15
import QtQml.StateMachine 1.15
import QtQuick.Controls
import QtQuick.Layouts
import demo 1.0
import QtQuick.Effects
import QtQuick.LocalStorage
import Qt.labs.settings

Item {
    width: 400
    height: 200

    StateMachine {
        id: machine
        property string state: "loading"
        initialState: loadingState

        State { id: loadingState }
        State { id: loadedState }
        State { id: errorState }
        State { id: emptyState }

        running: true
    }

    Loader {
        anchors.fill: parent
        sourceComponent: {
            switch (machine.state) {
            case "loading": return loadingIndicator
            case "error": return errorView
            case "empty": return emptyView
            case "loaded": return transactionListView
            }
        }
    }

    Component {
        id: loadingIndicator
        LoaderOverlay {
            textToShow: "Loading..."
            // opacity: 0.5
            visible: machine.state == "loading"
        }
    }

    Component {
        id: errorView
        Rectangle {
            anchors.fill: parent
            Text { anchors.centerIn: parent; text: "Failed to load." }
        }
    }

    Component {
        id: emptyView
        Rectangle {
            anchors.fill: parent
            Text { anchors.centerIn: parent; text: "No transactions yet." }
        }
    }

    ListModel {
        id: transactionModel
        ListElement { title: "Payment Received"; amount: 1500; time: "10:32 AM"; type: "credit" }
        ListElement { title: "Subscription Deducted"; amount: -499; time: "9:20 AM"; type: "debit" }
        ListElement { title: "Refund Processed"; amount: 200; time: "Yesterday"; type: "credit" }
    }

    TransactionModel {
        id: transactionModelCPP
        Component.onCompleted: {
            // transactionModelCPP.addTransaction(5, "credit", "Payment Received", 1500, "10:32 AM")
            // transactionModelCPP.addTransaction(6, "debit", "Subscription Deducted", -600, "9:20 AM")
            // transactionModelCPP.addTransaction(7, "debit", "Payment Deducted", -1500, "00:20 AM")
            // transactionModelCPP.addTransaction(8, "credit", "Payment Received", 2000, "Yesterday")
            // Delay DB loading by 1.5 seconds
            loadTimer.start()
            // transactionModelCPP.loadFromRealApi()
        }
    }
    Timer {
        id: loadTimer
        interval: 5000 // 1.5 seconds
        repeat: false
        onTriggered: {
            // transactionModelCPP.loadTransactionsFromDb()
            transactionModelCPP.loadFromRealApi()
        }
    }

    Component {
        id: transactionListView
        ColumnLayout {
            id: listViewComponent
            width: parent.width
            height: parent.height
            // width: 400
            // height: 300

            RowLayout {
                Text {
                    // z: 100
                    visible: loadTimer.running
                    // anchors.centerIn: parent
                    text: "Loading..."
                    font.pixelSize: 20
                }
                Item {
                    Layout.fillWidth: true
                }

                ComboBox {
                    id: filterBox
                    width: 150
                    leftPadding: 20
                    // z: 100
                    model: ["All", "Credit", "Debit"]
                    property bool filterInitialized: false
                    currentIndex: settingsStorage.filterIndex
                    onCurrentIndexChanged: {
                        switch (currentIndex) {
                        case 0: transactionModelCPP.setFilter(TransactionModel.All); break;
                        case 1: transactionModelCPP.setFilter(TransactionModel.CreditOnly); break;
                        case 2: transactionModelCPP.setFilter(TransactionModel.DebitOnly); break;
                        }
                        settingsStorage.filterIndex = currentIndex
                        console.log(currentIndex)
                        // if (filterInitialized)
                        //     setSetting("filter", filterBox.currentIndex)
                    }
                    Component.onCompleted: {
                        // initSettings()
                        // const saved = getSetting("filter", 0)
                        // console.log(saved)
                        // filterBox.currentIndex = saved
                        // filterInitialized = true
                    }

                    Settings {
                        id: settingsStorage
                        property int filterIndex: 0
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                ListView {
                    // Layout.fillHeight: true
                    // // anchors.fill: parent
                    // Layout.fillWidth: true
                    // Layout.preferredHeight: 210  // or any fixed height
                    clip: true
                    width: parent.width
                    height: contentHeight
                    // anchors.top: parent.top
                    // anchors.left: parent.left
                    // anchors.right: parent.right
                    // height: parent.height
                    model: transactionModelCPP
                    delegate: SwipeDelegate {
                        id: swipeDelegate
                        width: parent.width
                        height: 60

                        background: Item {
                            width: parent.width
                            height: parent.height

                            Rectangle {
                                id: cardContent
                                width: parent.width
                                height: parent.height
                                color: swipeDelegate.hovered ? "#f8f8f8" : "white"
                                radius: 8

                                Row {
                                    spacing: 10
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20

                                    Rectangle {
                                        width: 8
                                        height: 40
                                        radius: 4
                                        color: type === "credit" ? "green" : "red"
                                    }

                                    Column {
                                        width: 200
                                        spacing: 2
                                        Text {
                                            text: description
                                            font.bold: true
                                            color: "#333"
                                        }
                                        Text {
                                            text: time
                                            font.pixelSize: 12
                                            color: "#777"
                                        }
                                    }

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: (amount >= 0 ? "+" : "") + amount + " ₹"
                                        color: amount >= 0 ? "green" : "red"
                                        font.bold: true
                                    }
                                }

                                // MouseArea {
                                //     anchors.fill: parent
                                //     hoverEnabled: true
                                //     onEntered: swipeDelegate.hovered = true
                                //     onExited: swipeDelegate.hovered = false
                                // }
                            }
                            MultiEffect {
                                anchors.fill: cardContent
                                source: cardContent
                                shadowEnabled: true
                                shadowColor: "#33000000"
                                shadowBlur: 0.6
                                shadowHorizontalOffset: 0
                                shadowVerticalOffset: 2
                            }
                        }

                        swipe.right: Item {
                            width: 100
                            height: 50
                            anchors.right: parent.right

                            Rectangle {
                                anchors.fill: parent
                                color: "red"
                                radius: 8

                                Text {
                                    anchors.centerIn: parent
                                    color: "white"
                                    text: "Delete"
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        deleteAnim.start()
                                    }
                                }
                            }
                        }

                        SequentialAnimation {
                            id: deleteAnim
                            PropertyAnimation { target: swipeDelegate; property: "opacity"; to: 0; duration: 200 }
                            PropertyAnimation { target: swipeDelegate; property: "height"; to: 0; duration: 200 }
                            ScriptAction {
                                script: {
                                    transactionModelCPP.removeTransaction(index)
                                    swipeDelegate.opacity = 1
                                    swipeDelegate.height = contentItem.implicitHeight
                                }
                            }
                        }
                    }
                    // delegate: Rectangle {
                    //     width: parent.width
                    //     height: 60
                    //     color: "transparent"


                    // }
                }
            }
        }
    }

    Connections {
        target: transactionModelCPP
        function onStateChanged(newState) {
            console.log(newState)
            machine.state = newState
        }

        function onTransactionRemoved() {
            console.log("removed...")
            if (transactionModelCPP.transactionCount() == 0) {
                machine.state = "empty"
            }
        }
    }

    function getDatabase() {
        return LocalStorage.openDatabaseSync("MyApp", "1.0", "App Settings", 100);
    }

    function initSettings() {
        let db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value INTEGER)');
        });
    }

    function setSetting(key, value) {
        console.log(key + " - " + value)
        let db = getDatabase();
        db.transaction(function(tx) {
            tx.executeSql('INSERT OR REPLACE INTO settings(key, value) VALUES(?, ?)', [key, value]);
        });
    }

    function getSetting(key, defaultValue) {
        let db = getDatabase();
        let result = defaultValue;
        db.transaction(function(tx) {
            let rs = tx.executeSql('SELECT value FROM settings WHERE key=?', [key]);
            if (rs.rows.length > 0)
                result = rs.rows.item(0).value;
        });
        return result;
    }
}
