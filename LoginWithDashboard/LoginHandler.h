#ifndef LOGINHANDLER_H
#define LOGINHANDLER_H

// LoginHandler.h
#pragma once
#include <QObject>

class LoginHandler : public QObject {
    Q_OBJECT
public:
    Q_INVOKABLE void login(const QString &username, const QString &password);
signals:
    void loginFailed();
    void loginSuccess();
};

#endif // LOGINHANDLER_H
