#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "LoginHandler.h"
#include "mockbackend.h"
#include "TransactionModel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("Demo");
    QCoreApplication::setApplicationName("appDemo");
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    LoginHandler handler;
    engine.rootContext()->setContextProperty("loginHandler", &handler);
    // MockBackend backendData;
    // engine.rootContext()->setContextProperty("backendData", &backendData);
    qmlRegisterType<MockBackend>("demo", 1, 0, "MockBackend");
    qmlRegisterType<TransactionModel>("demo", 1, 0, "TransactionModel");

    engine.loadFromModule("demo", "Main");

    return app.exec();
}
