#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QObject>
#include <QSettings>

class AppSettings : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(int filterIndex READ filterIndex WRITE setFilterIndex NOTIFY filterIndexChanged)

public:
    explicit AppSettings(QObject *parent = nullptr)
        : QObject(parent),
        m_settings("Demo", "MyApp") {}

    QString theme() const {
        return m_settings.value("theme", "light").toString();
    }

    int filterIndex() const {
        return m_settings.value("filterIndex", 0).toInt();
    }

    void setTheme(const QString &value) {
        if (value != theme()) {
            m_settings.setValue("theme", value);
            emit themeChanged();
        }
    }

    void setFilterIndex(const int &value) {
        if (value != filterIndex()) {
            m_settings.setValue("filterIndex", value);
            emit filterIndexChanged();
        }
    }

signals:
    void themeChanged();
    void filterIndexChanged();

private:
    QSettings m_settings;
};

#endif // APPSETTINGS_H
