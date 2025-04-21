import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import demo 1.0
import demo.Components
import App 1.0

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

            StatCard { id: usersCard; title: "Users"; value: "-"; color: (AppSettings.theme === "dark" ? "#34495e" : "#e0f7fa") }
            StatCard { id: revenueCard; title: "Revenue"; value: "-"; color: (AppSettings.theme === "dark" ? "#34495e" : "#e0f7fa") }
            StatCard { id: messagesCard; title: "Messages"; value: "-"; color: (AppSettings.theme === "dark" ? "#34495e" : "#e0f7fa") }
            StatCard { id: alertsCard; title: "Alerts"; value: "-"; color: (AppSettings.theme === "dark" ? "#34495e" : "#e0f7fa") }
        }

        RecentTransactions {
            // width: 400
            // padding: 20
            // height: Layout.fillHeight
        }

        // RowLayout {
        //     width: parent.width
        //     // Item {
        //     //     // width: parent.width/6
        //     // }



        //     // Item {
        //     //     width: Layout.fillWidth
        //     // }
        // }
    }

    Component.onCompleted: {
        stateChanged("loading")
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
