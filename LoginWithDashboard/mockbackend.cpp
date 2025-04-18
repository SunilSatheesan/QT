#include "MockBackend.h"
#include <QTimer>

MockBackend::MockBackend(QObject *parent) : QObject(parent) {
    m_stats = {
        { "users", 0 },
        { "revenue", "$0" },
        { "messages", 0 },
        { "alerts", 0 }
    };
}

QVariantMap MockBackend::stats() const {
    return m_stats;
}

void MockBackend::fetchStats() {
    // m_stats = {
    //     { "users", 1245 },
    //     { "revenue", "$47K" },
    //     { "messages", 88 },
    //     { "alerts", 3 }
    // };
    // emit statsChanged();
    // Simulate server delay
    QTimer::singleShot(1000, [this]() {
        m_stats = {
            { "users", 1245 },
            { "revenue", "$47K" },
            { "messages", 88 },
            { "alerts", 3 }
        };
        emit statsChanged();
    });
}
