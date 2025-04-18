#include "MockBackend.h"
#include <QTimer>
#include <cstdlib>
#include <ctime>
#include <QDebug>

MockBackend::MockBackend(QObject *parent) : QObject(parent) {
    m_stats = {
        { "users", 0 },
        { "revenue", "$0" },
        { "messages", 0 },
        { "alerts", 0 }
    };

    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, [this]() {
        static int counter = 1;
        srand(time(0));
        int randomNum = rand() % 100;
        fetchStats((double)randomNum/100);
    });
    timer->start(2000);
}

QVariantMap MockBackend::stats() const {
    return m_stats;
}

void MockBackend::fetchStats(double rand) {
    // m_stats = {
    //     { "users", 1245 },
    //     { "revenue", "$47K" },
    //     { "messages", 88 },
    //     { "alerts", 3 }
    // };
    // emit statsChanged();
    // Simulate server delay
    qDebug() << rand ;
    QTimer::singleShot(1000, [=]() {
        m_stats = {
                   { "users", static_cast<int>(1245 * rand) },
            { "revenue", "$47K" },
            { "messages", static_cast<int>(88 * rand) },
            { "alerts", static_cast<int>(3 * rand) }
        };
        emit statsChanged();
    });
}
