pragma Singleton
import QtQml 2.15
import Qt.labs.settings 1.1

QtObject {
    // Property that holds the Settings object
    property Settings settings: Settings {
        id: internalSettings
        category: "UI"
        property string theme: "light"
    }

    // Alias to expose the setting
    property alias theme: internalSettings.theme
}
