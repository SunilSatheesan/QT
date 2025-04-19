// TransactionModel.h
#pragma once
#include <QAbstractListModel>
#include "Transaction.h"

class TransactionModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum Roles {
        TypeRole = Qt::UserRole + 1,
        DescriptionRole,
        AmountRole,
        TimeRole
    };

    explicit TransactionModel(QObject *parent = nullptr) : QAbstractListModel(parent) {}

    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
        Q_UNUSED(parent)
        return m_transactions.size();
    }

    QVariant data(const QModelIndex &index, int role) const override {
        if (!index.isValid()) return {};

        const Transaction *t = m_transactions.at(index.row());
        switch (role) {
        case TypeRole: return t->type();
        case DescriptionRole: return t->description();
        case AmountRole: return t->amount();
        case TimeRole: return t->time();
        default: return {};
        }
    }

    QHash<int, QByteArray> roleNames() const override {
        return {
            { TypeRole, "type" },
            { DescriptionRole, "description" },
            { AmountRole, "amount" },
            { TimeRole, "time" }
        };
    }

    Q_INVOKABLE void addTransaction(const QString &type, const QString &desc, double amount, QString time) {
        beginInsertRows(QModelIndex(), m_transactions.size(), m_transactions.size());
        m_transactions.append(new Transaction(type, desc, amount, time));
        endInsertRows();
    }

    Q_INVOKABLE void removeTransaction(int index) {
        if (index < 0 || index >= m_transactions.size())
            return;

        beginRemoveRows(QModelIndex(), index, index);
        m_transactions.removeAt(index);
        endRemoveRows();
    }

private:
    QList<Transaction*> m_transactions;
};
