#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "LoginHandler.h"

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

    engine.loadFromModule("demo", "Main");

    return app.exec();
}
