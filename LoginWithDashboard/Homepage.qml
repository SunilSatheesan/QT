import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import demo 1.0
import demo.Components

Item {
    width: 800
    height: 500

    // Component.onCompleted: {
    //     backendData.fetchStats()
    //     // onStatsChanged: {
    //     //     usersCard.value = backendData.stats["users"]
    //     //     revenueCard.value = backendData.stats["revenue"]
    //     //     messagesCard.value = backendData.stats["messages"]
    //     //     alertsCard.value = backendData.stats["alerts"]
    //     // }
    // }

    MockBackend {
        id: mockBackend
        onStatsChanged: {
            usersCard.value = stats["users"]
            revenueCard.value = stats["revenue"]
            messagesCard.value = stats["messages"]
            alertsCard.value = stats["alerts"]
        }
        Component.onCompleted: {
            fetchStats()
        }
    }

    ColumnLayout {
        width: parent.width
        height: parent.height

        Flow {
            // anchors.fill: parent
            spacing: 16
            padding: 20
            width: parent.width

            StatCard { id: usersCard; title: "Users"; value: "-" }
            StatCard { id: revenueCard; title: "Revenue"; value: "-" }
            StatCard { id: messagesCard; title: "Messages"; value: "-" }
            StatCard { id: alertsCard; title: "Alerts"; value: "-" }
        }

        RowLayout {
            width: parent.width
            Item {
                // width: parent.width/6
            }

            RecentTransactions {
                // width: 400
                // padding: 20
                // height: Layout.fillHeight
            }

            Item {
                width: Layout.fillWidth
            }
        }
    }



    // Connections {
    //     target: backendData
    //     function onStatsChanged() {
    //         usersCard.value = backendData.stats["users"]
    //         revenueCard.value = backendData.stats["revenue"]
    //         messagesCard.value = backendData.stats["messages"]
    //         alertsCard.value = backendData.stats["alerts"]
    //     }
    // }
}
