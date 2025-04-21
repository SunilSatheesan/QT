// LoginHandler.cpp
#include "LoginHandler.h"
#include <QDebug>

void LoginHandler::login(const QString &username, const QString &password) {
    qDebug() << "Login attempt:" << username << password;

    if (username == "admin" && password == "1234") {
        qDebug() << "Login success!";
        emit loginSuccess();
    } else {
        qCritical() << "Login failed!";
        emit loginFailed();
        // Optional: emit signal to shake UI on failure
    }
}
