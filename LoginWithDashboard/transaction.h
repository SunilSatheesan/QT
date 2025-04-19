// Transaction.h
#pragma once
#include <QObject>

class Transaction : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString type READ type CONSTANT)
    Q_PROPERTY(QString description READ description CONSTANT)
    Q_PROPERTY(QString time READ time CONSTANT)
    Q_PROPERTY(double amount READ amount CONSTANT)

public:
    Transaction(QString type, QString description, double amount, QString time)
        : m_type(std::move(type)), m_description(std::move(description)), m_time(std::move(time)), m_amount(amount) {}

    QString type() const { return m_type; }
    QString description() const { return m_description; }
    QString time() const { return m_time; }
    double amount() const { return m_amount; }

private:
    QString m_type;
    QString m_description;
    QString m_time;
    double m_amount;
};
