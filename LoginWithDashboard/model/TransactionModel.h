// TransactionModel.h
#pragma once
#include "Transaction.h"
#include <QAbstractListModel>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

class TransactionModel : public QAbstractListModel {
    Q_OBJECT
signals:
    void stateChanged(QString newState);
    void transactionRemoved();
public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        TypeRole,
        DescriptionRole,
        AmountRole,
        TimeRole
    };

    enum TransactionTypeFilter {
        All,
        CreditOnly,
        DebitOnly
    };
    Q_ENUM(TransactionTypeFilter)

    explicit TransactionModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role) const override;

    QHash<int, QByteArray> roleNames() const override ;

    Q_INVOKABLE void addTransaction(int id, const QString &type, const QString &desc, double amount, QString time) ;

    Q_INVOKABLE void removeTransaction(int index) ;

    Q_INVOKABLE void setFilter(TransactionTypeFilter filter);

    QList<Transaction*> filteredTransactions() const ;

    Q_INVOKABLE void loadTransactionsFromDb() ;

    Q_INVOKABLE void loadFromRealApi() ;

    Q_INVOKABLE int transactionCount() ;

    void onApiReply(QNetworkReply *reply) ;

    void clearTransactions() ;
private:
    QList<Transaction*> m_transactions;
    TransactionTypeFilter m_filter = All;
    QNetworkAccessManager m_networkManager;
};
