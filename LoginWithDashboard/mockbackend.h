#pragma once
#include <QObject>
#include <QVariantMap>

class MockBackend : public QObject {
    Q_OBJECT
    Q_PROPERTY(QVariantMap stats READ stats NOTIFY statsChanged)

public:
    explicit MockBackend(QObject *parent = nullptr);

    QVariantMap stats() const;

    Q_INVOKABLE void fetchStats(); // Simulate server call

signals:
    void statsChanged();

private:
    QVariantMap m_stats;
};
