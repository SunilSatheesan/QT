#include "testtransactionmodel.h"

void TestTransactionModel::initTestCase()
{
    model.clearTransactions();
    qDebug() << "Starting tests";
}

void TestTransactionModel::cleanupTestCase()
{
    qDebug() << "Tests end";
}

void TestTransactionModel::testAddTransaction()
{
    int init_size = model.rowCount();
    model.addTransaction(1, "credit", "Add", 100.0, "Today");
    QCOMPARE(model.rowCount(), init_size + 1);
    QModelIndex idx = model.index(init_size);
    QVERIFY(idx.isValid());
    QCOMPARE(model.data(idx, TransactionModel::IdRole), 1);
    QCOMPARE(model.data(idx, TransactionModel::TypeRole), "credit");
    QCOMPARE(model.data(idx, TransactionModel::DescriptionRole), "Add");
    QCOMPARE(model.data(idx, TransactionModel::AmountRole), 100.0);
    QCOMPARE(model.data(idx, TransactionModel::TimeRole), "Today");
}

void TestTransactionModel::testRemoveTransaction()
{

}

QTEST_MAIN(TestTransactionModel)
