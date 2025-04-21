#ifndef TESTTRANSACTIONMODEL_H
#define TESTTRANSACTIONMODEL_H

#include <QObject>
#include <QtTest/QTest>
#include "TransactionModel.h"

class TestTransactionModel : public QObject {
    Q_OBJECT

private slots:
    void initTestCase();     // Before all tests
    void cleanupTestCase();  // After all tests

    void testAddTransaction();
    void testRemoveTransaction();
    // void testClearTransactions();
    // void testRowCount();
    // void testFilterCredit();
    // void testFilterDebit();
    // void testDataRetrieval();
    // Add DB-related tests if needed

private:
    TransactionModel model;
};
// #include "test_transactionmodel.moc"

#endif // TESTTRANSACTIONMODEL_H
