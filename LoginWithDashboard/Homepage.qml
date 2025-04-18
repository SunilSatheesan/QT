import QtQuick 2.15
import QtQuick.Controls
import demo 1.0

Item {
    width: 800
    height: 500

    Component.onCompleted: {
        backendData.fetchStats()
        // onStatsChanged: {
        //     usersCard.value = backendData.stats["users"]
        //     revenueCard.value = backendData.stats["revenue"]
        //     messagesCard.value = backendData.stats["messages"]
        //     alertsCard.value = backendData.stats["alerts"]
        // }
    }

    // MockBackend {
    //     id: mockBackend
    //     onStatsChanged: {
    //         usersCard.value = stats["users"]
    //         revenueCard.value = stats["revenue"]
    //         messagesCard.value = stats["messages"]
    //         alertsCard.value = stats["alerts"]
    //     }
    //     Component.onCompleted: {
    //         fetchStats()
    //     }
    // }

    Flow {
        anchors.fill: parent
        spacing: 16
        padding: 20

        StatCard { id: usersCard; title: "Users"; value: "-" }
        StatCard { id: revenueCard; title: "Revenue"; value: "-" }
        StatCard { id: messagesCard; title: "Messages"; value: "-" }
        StatCard { id: alertsCard; title: "Alerts"; value: "-" }
    }

    Connections {
        target: backendData
        function onStatsChanged() {
            usersCard.value = backendData.stats["users"]
            revenueCard.value = backendData.stats["revenue"]
            messagesCard.value = backendData.stats["messages"]
            alertsCard.value = backendData.stats["alerts"]
        }
    }
}
