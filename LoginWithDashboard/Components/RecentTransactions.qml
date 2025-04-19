import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import demo 1.0

Item {
    width: 400
    height: 400

    // Loader {
    //     id: contentLoader
    //     anchors.fill: parent
    //     sourceComponent: loadTimer.running ? loadingIndicator : listViewComponent
    // }

    // Component {
    //     id: loadingIndicator

    // }

    ListModel {
        id: transactionModel
        ListElement { title: "Payment Received"; amount: 1500; time: "10:32 AM"; type: "credit" }
        ListElement { title: "Subscription Deducted"; amount: -499; time: "9:20 AM"; type: "debit" }
        ListElement { title: "Refund Processed"; amount: 200; time: "Yesterday"; type: "credit" }
    }

    TransactionModel {
        id: transactionModelCPP
        Component.onCompleted: {
            transactionModelCPP.addTransaction(5, "credit", "Payment Received", 1500, "10:32 AM")
            transactionModelCPP.addTransaction(6, "debit", "Subscription Deducted", -600, "9:20 AM")
            transactionModelCPP.addTransaction(7, "debit", "Payment Deducted", -1500, "00:20 AM")
            transactionModelCPP.addTransaction(8, "credit", "Payment Received", 2000, "Yesterday")
            // Delay DB loading by 1.5 seconds
            loadTimer.start()
        }
    }
    Timer {
        id: loadTimer
        interval: 5000 // 1.5 seconds
        repeat: false
        onTriggered: {
            transactionModelCPP.loadTransactionsFromDb()
        }
    }

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
                onCurrentIndexChanged: {
                    switch (currentIndex) {
                    case 0: transactionModelCPP.setFilter(TransactionModel.All); break;
                    case 1: transactionModelCPP.setFilter(TransactionModel.CreditOnly); break;
                    case 2: transactionModelCPP.setFilter(TransactionModel.DebitOnly); break;
                    }
                }
            }
        }

        ListView {
            Layout.fillHeight: true
            // anchors.fill: parent
            Layout.fillWidth: true
            // Layout.preferredHeight: 210  // or any fixed height
            // clip: true
            model: transactionModelCPP
            delegate: SwipeDelegate {
                id: swipeDelegate
                width: parent.width
                height: 50
                contentItem: Row {
                    spacing: 10
                    // padding: 20
                    leftPadding: 20
                    // anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: 8
                        height: 40
                        radius: 4
                        color: type === "credit" ? "green" : "red"
                        anchors.top: parent.top
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

                swipe.right: Item {
                    width: 100
                    height: 50
                    // z: 100
                    anchors.right: parent.right

                    Rectangle {
                        anchors.fill: parent
                        color: "red"
                        radius: 4

                        Text {
                            anchors.centerIn: parent
                            color: "white"
                            text: "Delete"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("Delete clicked on row: " + index)
                                // transactionModelCPP.removeTransaction(index)
                                // swipe.close()
                                deleteAnim.start()
                            }
                        }
                    }
                }

                // Animation before removing
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
