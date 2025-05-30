#include "TransactionModel.h"

TransactionModel::TransactionModel(QObject *parent) : QAbstractListModel(parent) {
    emit stateChanged("loading");
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("transactions.db");
    if (!db.open()) {
        qWarning() << "Failed to open DB";
    }
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS transactions ("
               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
               "type TEXT,"
               "description TEXT,"
               "amount REAL,"
               "time TEXT)");

}

int TransactionModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return filteredTransactions().size();
}

QVariant TransactionModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return {};

    const auto txn = filteredTransactions().at(index.row());
    switch (role) {
    case IdRole: return txn->id();
    case TypeRole: return txn->type();
    case DescriptionRole: return txn->description();
    case AmountRole: return txn->amount();
    case TimeRole: return txn->time();
    default: return {};
    }
}

QHash<int, QByteArray> TransactionModel::roleNames() const {
    return {
        { IdRole, "id"},
        { TypeRole, "type" },
        { DescriptionRole, "description" },
        { AmountRole, "amount" },
        { TimeRole, "time" }
    };
}

Q_INVOKABLE void TransactionModel::addTransaction(int id, const QString &type, const QString &desc, double amount, QString time) {
    // QSqlQuery query;
    // query.prepare("INSERT INTO transactions (id, type, description, amount, time) "
    //               "VALUES (?, ?, ?, ?, ?)");
    // query.addBindValue(id);
    // query.addBindValue(type);
    // query.addBindValue(desc);
    // query.addBindValue(amount);
    // query.addBindValue(time);
    // query.exec();

    // if (!query.exec()) {
    //     qWarning() << "Failed to insert: " << query.lastError().text();
    // }

    // loadTransactionsFromDb();

    beginInsertRows(QModelIndex(), m_transactions.size(), m_transactions.size());
    m_transactions.append(new Transaction(id, type, desc, amount, time));
    endInsertRows();
}

Q_INVOKABLE void TransactionModel::removeTransaction(int index) {
    if (index < 0 || index >= m_transactions.size())
        return;

    Transaction* txn = m_transactions.at(index);
    QSqlQuery query;
    query.prepare("DELETE FROM transactions WHERE id = :id");
    query.bindValue(":id", txn->id());
    // query.bindValue(":description", txn->description());
    // query.bindValue(":amount", txn->amount());
    // query.bindValue(":time", txn->time());
    if (!query.exec()) {
        qWarning() << "Failed to delete: " << query.lastError().text();
    }

    beginRemoveRows(QModelIndex(), index, index);
    m_transactions.removeAt(index);
    delete txn;
    endRemoveRows();

    emit transactionRemoved();
}

Q_INVOKABLE void TransactionModel::setFilter(TransactionTypeFilter filter)
{
    if (m_filter == filter)
        return;

    beginResetModel();
    m_filter = filter;
    endResetModel();
}

QList<Transaction*> TransactionModel::filteredTransactions() const {
    if (m_filter == All)
        return m_transactions;

    QList<Transaction*> result;
    for (const auto &txn : m_transactions) {
        if ((m_filter == CreditOnly && txn->type() == "credit") ||
            (m_filter == DebitOnly && txn->type() == "debit")) {
            result.append(txn);
        }
    }
    return result;
}

Q_INVOKABLE void TransactionModel::loadTransactionsFromDb() {
    QSqlQuery query("SELECT id, type, description, amount, time FROM transactions ORDER BY id");

    if (!query.exec()) {
        qWarning() << "Failed to fetch transactions:" << query.lastError();
        return;
    }

    beginResetModel();
    qDeleteAll(m_transactions);
    m_transactions.clear();

    while (query.next()) {
        int id = query.value("id").toInt();
        QString type = query.value("type").toString();
        QString desc = query.value("description").toString();
        double amount = query.value("amount").toDouble();
        QString time = query.value("time").toString();

        qDebug() << id << type ;

        m_transactions.append(new Transaction(id, type, desc, amount, time));
    }
    endResetModel();
}

Q_INVOKABLE void TransactionModel::loadFromRealApi() {
    QUrl url("http://10.130.162.175:81/transactions.json");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    QNetworkReply *reply = m_networkManager.get(request);
    connect(reply, &QNetworkReply::finished, this, [this, reply]() {
        onApiReply(reply);
    });
}

Q_INVOKABLE int TransactionModel::transactionCount() {
    return m_transactions.size();
}

void TransactionModel::onApiReply(QNetworkReply *reply) {
    if (reply->error() != QNetworkReply::NoError) {
        qWarning() << "API error:" << reply->errorString();
        emit stateChanged("error");
        reply->deleteLater();
        return;
    }

    const QByteArray data = reply->readAll();
    if (data.isEmpty()){
        emit stateChanged("empty");
        return;
    }

    // qDebug() << "onApiReply" << data;
    const QJsonDocument doc = QJsonDocument::fromJson(data);
    // qDebug() << doc.toJson();
    const QJsonArray array = doc.array();
    // qDebug() << array ;
    // qDebug() << array.toVariantList() ;

    beginResetModel();
    m_transactions.clear();

    for (const QJsonValue &val : array) {
        QJsonObject obj = val.toObject();
        int id = obj["id"].toInt();
        QString type = obj["type"].toString();
        QString desc = obj["description"].toString();
        double amount = obj["amount"].toDouble();
        QString time = obj["time"].toString();

        m_transactions.append(new Transaction(id, type, desc, amount, time));
    }

    endResetModel();
    reply->deleteLater();
    emit stateChanged("loaded");
}

void TransactionModel::clearTransactions() {
    beginResetModel();
    qDeleteAll(m_transactions);
    m_transactions.clear();
    endResetModel();
    emit transactionRemoved();
}

