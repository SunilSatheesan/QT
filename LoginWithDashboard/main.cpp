#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "LoginHandler.h"
#include "mockbackend.h"

int main(int argc, char *argv[])
{
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

    engine.loadFromModule("demo", "Main");

    return app.exec();
}
